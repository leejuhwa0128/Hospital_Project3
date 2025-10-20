package com.hospital.controller;

/* =========================
 * UserController
 * -------------------------
 * - 관계자/환자 로그인, 회원가입(대기 등록)
 * - 카카오 로그인(환자 전용)
 * - 마이페이지/프로필 조회·수정
 * - 협진/의사용 대시보드 분기
 * 
 * [보안/정책 요약]
 * - users 로그인: ID(평문) + PW(SHA-512 해시)
 * - admins 로그인: ID(SHA-512) + PW(SHA-512)
 * - pending_users: 가입 대기/거절 사유 확인
 * - 카카오 OAuth: state=patient 만 허용
 * ========================= */

import java.io.*;
import java.net.*;
import java.util.*;

import javax.servlet.http.*;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hospital.service.UserService;
import com.hospital.util.SHA512Util;
import com.hospital.service.AdminService;
import com.hospital.service.PatientService;
import com.hospital.service.ReferralService;
import com.hospital.vo.*;

@Controller
@RequestMapping("/user")
public class UserController {

   /* =========================
    * 1) 의존성 주입
    * ========================= */
   @Autowired private UserService userService;
   @Autowired private PatientService patientService;
   @Autowired private AdminService adminService;
   @Autowired private ReferralService referralService;

   /* =========================
    * 2) 환자 마이페이지 (세션 가드)
    * - 세션에 PatientVO 타입의 loginUser 가 있어야 접근 가능
    * - 환영 문구용 이름을 모델에 전달
    * View: /WEB-INF/jsp/user/patient_mypage.jsp
    * ========================= */
   @GetMapping("/patientPage.do")  // URL 정확히 일치
   public String showPatientPage(HttpSession session, Model model) {
       Object loginUser = session.getAttribute("loginUser");
       if (loginUser == null || !(loginUser instanceof PatientVO)) {
           return "redirect:/loginSelector.do";
       }
       model.addAttribute("loginSuccessName", ((PatientVO) loginUser).getPatientName());
       return "user/patient_page";
   }

   /* =========================
    * 3) 공통 마이페이지 분기
    * - (과거 구조 호환) 환자면 user/mypage.jsp 반환
    * - 그 외는 관계자용 페이지로 분기
    * ========================= */
   @GetMapping("/mypage.do")
   public String myPage(HttpSession session) {
      Object loginUser = session.getAttribute("loginUser");
      if (loginUser != null && loginUser.getClass().getSimpleName().equals("PatientVO")) {
         return "user/mypage.jsp";
      }
      return "redirect:/user/user_page.jsp";
   }

   /* =========================
    * 4) 회원 유형/기관 선택 화면
    * - 병원/부서 목록을 모델에 담아 폼에 바인딩
    * View: /WEB-INF/jsp/user/selectForm.jsp
    * ========================= */
   @GetMapping("/selectForm.do")
   public String userSelectForm(Model model) {
      model.addAttribute("hospitalList", userService.getAllHospitals());
      model.addAttribute("deptList", userService.getAllDepartments());
      return "user/selectForm";
   }

   /* =========================
    * 5) 관계자 로그인 처리
    * - 1차: users(ID 평문, PW SHA-512) 인증
    *   · 성공 시: 세션(loginUser, loginSuccessName) 저장 + 역할별 라우팅
    * - 2차: admins(ID SHA-512, PW SHA-512) 인증
    *   · 성공 시: 세션(loginAdmin) 저장 + 관리자 메인
    * - 3차: pending_users(가입 대기/거절) 조회
    *   · 상태/사유를 모델에 담아 안내 페이지로
    * - 모두 실패: selectForm로 리다이렉트(+세션 메시지)
    * ========================= */
   @PostMapping("/login.do")
   public String login(@ModelAttribute UserVO vo, HttpSession session, Model model) {
      String plainId = vo.getUserId();                         // 관계자 ID는 평문 비교
      String encPwd  = SHA512Util.encrypt(vo.getPassword());   // 비밀번호 해시
      vo.setPassword(encPwd);

      // (1) users 로그인
      UserVO loginUser = userService.login(vo);
      if (loginUser != null) {
         session.setAttribute("loginUser", loginUser);
         session.setAttribute("loginSuccessName", loginUser.getName());
         switch (loginUser.getRole()) {
            case "doctor":
            case "nurse":
            case "coop":
               return "redirect:/resources/index.jsp";
         }
      }

      // (2) admins 로그인 (ID + PW 모두 해시)
      String encId = SHA512Util.encrypt(plainId);
      AdminVO admin = adminService.login(encId, encPwd);
      System.out.println("암호화된 adminId: " + encId);
      System.out.println("암호화된 password: " + encPwd);
      if (admin != null) {
         session.setAttribute("loginAdmin", admin);
         return "admin/admin_main";
      }

      // (3) 가입 대기/거절 상태 조회
      PendingUserVO pending = userService.findPendingUser(plainId, encPwd); // ID 평문, PW 해시
      if (pending != null) {
         model.addAttribute("message", "현재 가입 상태: " + pending.getStatus());
         model.addAttribute("userId", plainId);
         if ("거절".equals(pending.getStatus())) {
            model.addAttribute("rejectReason", pending.getRejectReason());
         }
         return "user/rejected_reason";
      }

      // (4) 실패 공통 처리
      session.setAttribute("loginError", "아이디 또는 비밀번호가 잘못되었습니다.");
      return "redirect:/user/selectForm.do";
   }

   /* =========================
    * 6) 관계자 회원가입(대기 등록)
    * - 입력값으로 UserVO 구성, PW 해시
    * - doctor/coop 역할별 병원/부서 매핑
    * - pending_users에 등록 후 selectForm로 리다이렉트
    * ========================= */
   @PostMapping("/signup.do")
   public String signup(HttpServletRequest request, HttpSession session, Model model) {
      try {
         UserVO vo = new UserVO();
         // 기본 정보
         vo.setUserId(request.getParameter("userId"));
         vo.setPassword(SHA512Util.encrypt(request.getParameter("password")));
         vo.setName(request.getParameter("name"));
         vo.setRrn(request.getParameter("rrn1") + request.getParameter("rrn2"));
         vo.setGender(request.getParameter("gender"));
         vo.setPhone("010" + request.getParameter("phone1") + request.getParameter("phone2"));
         vo.setEmail(request.getParameter("emailPrefix") + "@" + request.getParameter("emailDomain"));
         vo.setRole(request.getParameter("role"));
         // 역할별 필드
         if ("doctor".equals(vo.getRole())) {
            vo.setHospitalId(1); // 기본 병원 ID 고정(정책에 맞게 조정 가능)
            vo.setDeptId(request.getParameter("deptId"));
         } else if ("coop".equals(vo.getRole())) {
            vo.setHospitalId(Integer.parseInt(request.getParameter("hospitalId")));
            vo.setDeptId(null);
         }
         // 대기 등록
         userService.insertPendingUser(vo);

         session.setAttribute("signupMessage", "🎉 회원가입 신청이 완료되었습니다.\n24시간 이내 승인됩니다.");
         return "redirect:/user/selectForm.do";

      } catch (Exception e) {
         e.printStackTrace();
         model.addAttribute("signupError", "회원가입 중 오류가 발생했습니다.");
         return "user/selectForm";
      }
   }

   /* =========================
    * 7) 대기자 상태/사유 확인
    * - userId로 pending_users 조회
    * - 거절 사유 포함 안내 페이지로 이동
    * ========================= */
   @GetMapping("/checkStatus.do")
   public String checkSignupStatus(@RequestParam("userId") String userId, Model model) {
      model.addAttribute("user", userService.getPendingUserById(userId));
      return "user/rejected_reason";
   }

   /* =========================
    * 8) 카카오 로그인 (환자 전용)
    * - state != patient 차단
    * - OAuth 토큰 → 사용자 정보(email/nickname) 획득
    * - 환자 미존재 시 소셜 신규 등록(임시 ID/주민번호/기타 성별)
    * - 세션(loginUser) 저장 후 인덱스로 이동
    * [주의] redirect_uri 는 카카오 개발자 콘솔 설정과 정확히 일치해야 함
    * ========================= */
   @GetMapping("/kakaoLogin.do")
   public String kakaoLogin(@RequestParam("code") String code, HttpSession session) throws Exception {

       // ✅ 1. 카카오 토큰, 사용자 정보 추출
       String accessToken = getAccessToken(code);
       Map<String, Object> userInfo = getUserInfo(accessToken);

       String email = (String) userInfo.get("email");
       String nickname = (String) userInfo.get("nickname");

       System.out.println("✅ 카카오 로그인 시도 - email: " + email + ", nickname: " + nickname);

       // ✅ 2. 기존 사용자 확인
       PatientVO patient = patientService.findPatientByEmail(email);
       if (patient == null) {
           System.out.println("🆕 신규 환자, DB 등록 시도");
           patient = new PatientVO();

           // 랜덤 유저 ID 생성
           String uuid = UUID.randomUUID().toString().replace("-", "");
           String randomId = uuid.substring(0, 8);
           patient.setPatientUserId("kakao_" + randomId);

           // 기본 정보 설정
           patient.setPatientName(nickname);   // ← 이름 저장
           patient.setPatientEmail(email);
           patient.setPatientPassword("");     // 비밀번호 없음
           patient.setPatientGender("기타");

           // 가짜 주민등록번호 생성 (예: 9999991234567)
           String fakeRrn = "999999" + (new Random().nextInt(900000) + 100000);
           patient.setPatientRrn(fakeRrn);

           try {
               patientService.insertSocialPatient(patient);
               System.out.println("✅ 카카오 회원가입 DB 성공");

               // ✅ 최초 회원가입한 경우 안내 팝업 띄우기 위해 플래그 세션 저장
               session.setAttribute("kakaoSignup", true);

           } catch (Exception e) {
               System.out.println("❌ 카카오 회원가입 실패: " + e.getMessage());
               return "redirect:/loginSelector.do";
           }
       } else {
           System.out.println("🔁 기존 환자 로그인 성공");
           // 기존 회원의 이름이 비어있으면 닉네임으로 보완
           if (patient.getPatientName() == null || patient.getPatientName().trim().isEmpty()) {
               patient.setPatientName(nickname);
           }
       }

       // ✅ 3. 세션 저장 (표시 이름 함께 저장)
       session.setAttribute("loginUser", patient);

       // 표시 이름 우선순위: DB patientName → 카카오 nickname → "사용자"
       String displayName = (patient.getPatientName() != null && !patient.getPatientName().trim().isEmpty())
               ? patient.getPatientName().trim()
               : (nickname != null && !nickname.trim().isEmpty() ? nickname.trim() : "사용자");

       session.setAttribute("loginSuccessName", displayName);

       // ✅ 4. 메인 페이지로 이동
       return "redirect:/main.do";
   }



   /* =========================
    * (헬퍼) 카카오 OAuth 토큰 발급
    * - POST https://kauth.kakao.com/oauth/token
    * - grant_type=authorization_code, client_id, redirect_uri, code
    * [주의] redirect_uri 가 카카오 앱 설정과 동일해야 함
    * ========================= */
   private String getAccessToken(String code) throws Exception {
      URL url = new URL("https://kauth.kakao.com/oauth/token");
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("POST");
      conn.setDoOutput(true);

      String data = "grant_type=authorization_code" + "&client_id=8439ac1e9e2f3cf860f6ab16dbcd581a"
            + "&redirect_uri=http://localhost:18080/user/kakaoLogin.do" + "&code=" + code;

      BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
      bw.write(data);
      bw.flush();

      BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
      StringBuilder sb = new StringBuilder();
      String line;
      while ((line = br.readLine()) != null)
         sb.append(line);

      JSONObject json = new JSONObject(sb.toString());
      return json.getString("access_token");
   }


   /* =========================
    * (헬퍼) 카카오 사용자 정보 조회
    * - GET https://kapi.kakao.com/v2/user/me
    * - email(없으면 대체값), nickname 추출
    * ========================= */
   private Map<String, Object> getUserInfo(String accessToken) throws Exception {
      URL url = new URL("https://kapi.kakao.com/v2/user/me");
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("GET");
      conn.setRequestProperty("Authorization", "Bearer " + accessToken);

      BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
      StringBuilder sb = new StringBuilder();
      String line;
      while ((line = br.readLine()) != null)
         sb.append(line);

      JSONObject json = new JSONObject(sb.toString());
      JSONObject kakaoAccount = json.getJSONObject("kakao_account");
      JSONObject profile = kakaoAccount.getJSONObject("profile");

      String email = kakaoAccount.has("email") ? kakaoAccount.getString("email") : "noemail@kakao.com";
      String nickname = profile.getString("nickname");

      Map<String, Object> result = new HashMap<>();
      result.put("email", email);
      result.put("nickname", nickname);
      return result;
   }

   /* =========================
    * 9) 협진의 마이페이지
    * View: /WEB-INF/jsp/user/coop_page.jsp
    * ========================= */
   @GetMapping("/coopPage.do")
   public ModelAndView showCoopPage() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("user/coop_page");
      return mav;
   }

   /* =========================
    * 10) 의사 대시보드
    * View: /WEB-INF/jsp/user/doctor_page.jsp
    * ========================= */
   @GetMapping("doctorPage.do")
   public String showDashboard() {
       return "user/doctor_page";
   }

   /* =========================
    * 11) 프로필 수정 화면
    * - 로그인 사용자 공통 정보 + 병원/부서 셀렉트 데이터 주입
    * View: /WEB-INF/jsp/user/profile_edit.jsp
    * ========================= */
   @GetMapping("/profileEdit.do")
   public String profileEdit(HttpSession session, Model model) {
      UserVO loginUser = (UserVO) session.getAttribute("loginUser");
      if (loginUser == null) return "redirect:/loginSelector.do";

      // 병원/부서 목록(협진/공통)
      model.addAttribute("hospitalList", referralService.getAllPartnerHospitals());
      model.addAttribute("departmentList", userService.selectDepartments());

      model.addAttribute("loginUser", loginUser);
      return "user/profile_edit";
   }

   /* =========================
    * 12) 프로필 수정 저장
    * - 공용 필드(name/phone/email/hospitalId/deptId) 업데이트
    * - 비밀번호 변경: (옵션) current → 검증, new/confirm 일치 → SHA-512 해시 저장
    * - 저장 후 역할별 대시보드로 이동(doctor/coop)
    * ========================= */
   @PostMapping("/updateProfile.do")
   public String updateProfile(@ModelAttribute UserVO form,
                        @RequestParam(value="currentPassword", required=false) String currentPassword,
                        @RequestParam(value="newPassword", required=false) String newPassword,
                        @RequestParam(value="confirmPassword", required=false) String confirmPassword,
                        HttpSession session,
                        RedirectAttributes ra) {

      UserVO loginUser = (UserVO) session.getAttribute("loginUser");
      if (loginUser == null) return "redirect:/loginSelector.do";

      // (1) 공용 필드 업데이트
      loginUser.setName(form.getName());
      loginUser.setPhone(form.getPhone());
      loginUser.setEmail(form.getEmail());
      loginUser.setHospitalId(form.getHospitalId());
      loginUser.setDeptId(form.getDeptId());

      // (2) 비밀번호 변경(옵션)
      if (newPassword != null && !newPassword.isEmpty()) {

         // 2-1) 현재 비밀번호 검증(입력되었을 때만)
         if (currentPassword != null && !currentPassword.isEmpty()) {
            String encCurrent = SHA512Util.encrypt(currentPassword);
            if (!encCurrent.equals(loginUser.getPassword())) {
               ra.addFlashAttribute("msg", "현재 비밀번호가 일치하지 않습니다.");
               return "redirect:/user/profileEdit.do";
            }
         }

         // 2-2) 새 비번 = 확인 비번 체크
         if (!newPassword.equals(confirmPassword)) {
            ra.addFlashAttribute("msg", "새 비밀번호 확인이 일치하지 않습니다.");
            return "redirect:/user/profileEdit.do";
         }

         // 2-3) 해시 저장
         String encNew = SHA512Util.encrypt(newPassword);
         loginUser.setPassword(encNew);
      }
      // 새 비번 미입력 시 기존 해시 유지

      // (3) 저장
      userService.updateProfile(loginUser);

      // (4) 후처리/리다이렉트
      session.setAttribute("loginSuccessName", loginUser.getName());
      String role = loginUser.getRole();
      return "redirect:/user/" + ("doctor".equals(role) ? "doctorPage.do" : "coopPage.do");
   }
   
   
}
