package com.hospital.controller;

import java.security.SecureRandom;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hospital.security.CaptchaService;
import com.hospital.service.MailService;
import com.hospital.service.ReferralService;
import com.hospital.service.UserService;
import com.hospital.util.SHA512Util;
import com.hospital.vo.PartnerHospitalVO;
import com.hospital.vo.UserVO;

@Controller
@RequestMapping("/referral")
public class ReferralAuthController {

    @Autowired
    private UserService userService;
    @Autowired
    private ReferralService referralService;
    @Autowired
    private CaptchaService captchaService;

    @Value("${captcha.v3.siteKey}")
    private String captchaV3SiteKey;

    @Value("${captcha.v2.siteKey}")
    private String captchaV2SiteKey;

    @PostConstruct
    public void init() {
        System.out.println("✅ ReferralAuthController 등록됨");
    }

    // 🔸 로그인/회원가입 통합 화면 진입
    @GetMapping("/auth.do")
    public String showAuthPage(HttpSession session, Model model) {
        List<PartnerHospitalVO> hospitalList = referralService.getAllPartnerHospitals();
        model.addAttribute("hospitalList", hospitalList);

        Boolean requireCaptcha = (Boolean) session.getAttribute("requireCaptcha");
        model.addAttribute("requireCaptcha", requireCaptcha != null && requireCaptcha);
        model.addAttribute("captchaV3SiteKey", captchaV3SiteKey);
        model.addAttribute("captchaV2SiteKey", captchaV2SiteKey);

        System.out.println("captchaV3SiteKey = " + captchaV3SiteKey);
        return "referral/referral_auth";
    }

    @PostMapping("/signup.do")
    public String processSignup(@ModelAttribute UserVO userVO, RedirectAttributes redirectAttributes) {
        try {
            // 🔐 비밀번호 SHA-512로 암호화
            String encPwd = SHA512Util.encrypt(userVO.getPassword());
            userVO.setPassword(encPwd);

            userVO.setRole("coop");
            userVO.setApproved(false); // 승인 대기 상태
            referralService.registerCoopUser(userVO);

            redirectAttributes.addFlashAttribute("signupSuccess", "회원가입이 완료되었습니다. 관리자의 승인을 기다려주세요.");
            return "redirect:/referral/auth.do";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("signupError", "회원가입 중 오류가 발생했습니다.");
            return "redirect:/referral/auth.do";
        }
    }

    @PostMapping("/login2.do")
    public String login(@ModelAttribute UserVO vo,
                        @RequestParam(name = "recaptcha_v3", required = false) String v3token,
                        @RequestParam(name = "g-recaptcha-response", required = false) String v2token,
                        HttpServletRequest request,
                        HttpSession session,
                        RedirectAttributes redirectAttr) {

        System.out.println(">> /referral/login2.do 진입"); // ①

        Boolean requireCaptcha = (Boolean) session.getAttribute("requireCaptcha");
        System.out.println("   requireCaptcha(session) = " + requireCaptcha); // ②

        if (requireCaptcha != null && requireCaptcha) {
            // ⭐ v2 토큰 누락 즉시 차단(문구 표시)
            if (v2token == null || v2token.trim().isEmpty()) {
                session.setAttribute("loginError", "보안 확인(체크박스)을 완료해주세요."); // ⭐
                return "redirect:/referral/auth.do"; // ⭐
            }

            boolean ok = captchaService.verifyV2(v2token, clientIp(request));
            System.out.println("   v2 verify = " + ok + ", v2token null? " + (v2token == null)); // ③
            if (!ok) {
                session.setAttribute("loginError", "보안 확인 실패. 체크박스 인증 후 다시 시도하세요."); // ⭐
                return "redirect:/referral/auth.do"; // ⭐
            }
        } else {
            CaptchaService.V3Result r = captchaService.verifyV3(v3token, clientIp(request), "login");
            System.out.println("   v3 ok=" + r.ok + ", score=" + r.score + ", action=" + r.action); // ④
            if (!r.ok) {
                session.setAttribute("requireCaptcha", true);
                session.setAttribute("loginError", "추가 보안 확인이 필요합니다. 체크박스 인증 후 로그인하세요."); // ⭐
                return "redirect:/referral/auth.do";
            }
        }

        String encPwd = SHA512Util.encrypt(vo.getPassword());
        vo.setPassword(encPwd);
        UserVO loginUser = userService.login(vo);
        System.out.println("   userService.login -> " + (loginUser != null)); // ⑤

        if (loginUser != null) {
            System.out.println("로그인 성공, requireCaptcha=" + session.getAttribute("requireCaptcha"));
            session.removeAttribute("loginFailCount");
            session.removeAttribute("requireCaptcha");
            session.setAttribute("loginUser", loginUser);

            // ✅ 이름 표시용 (userName → name → userId)
            String displayName =
                (loginUser.getUserId()!=null && !loginUser.getUserId().trim().isEmpty()) ? loginUser.getUserId().trim() :
                (loginUser.getName()!=null     && !loginUser.getName().trim().isEmpty())     ? loginUser.getName().trim() :
                loginUser.getName();
            session.setAttribute("loginSuccessName", loginUser.getName());  // 🔹 여기 추가

            return "redirect:/referral/main.do";
        }

        Integer failCount = (Integer) session.getAttribute("loginFailCount");
        failCount = (failCount == null ? 0 : failCount) + 1;
        session.setAttribute("loginFailCount", failCount);
        if (failCount >= 3) session.setAttribute("requireCaptcha", true);
        System.out.println("   로그인 실패, failCount=" + failCount); // ⑦

        // ⭐ 실패 문구를 세션에 저장 (JSP는 sessionScope로 읽음)
        session.setAttribute("loginError", "아이디 또는 패스워드를 확인해 주세요."); // ⭐

        return "redirect:/referral/auth.do";
    }

    private String clientIp(HttpServletRequest req) {
        String ip = req.getHeader("X-Forwarded-For");
        if (ip != null && !ip.trim().isEmpty()) {
            return ip.split(",")[0].trim();
        }
        return req.getRemoteAddr();
    }

    @GetMapping("/logout.do")
    public String logout(HttpSession session,
                         @RequestParam(required = false, defaultValue = "/referral/auth.do") String returnUrl) {
        session.removeAttribute("loginUser"); // ✅ 세션 사용자 삭제
        session.removeAttribute("loginSuccessName");
        return "redirect:" + returnUrl;
    }

    @GetMapping(value = "/checkId.do", produces = "application/json")
    @ResponseBody
    public Map<String, Boolean> checkDuplicateId(@RequestParam("userId") String userId) {
        boolean exists = referralService.isUserIdTaken(userId);
        Map<String, Boolean> result = new HashMap<>();
        result.put("exists", exists);
        return result;
    }
    
    //ID PW 찾기
 // 🔹 아이디 찾기 (폼)
    @GetMapping("/findId.do")
    public String findIdForm() {
        return "referral/find_id"; // /WEB-INF/jsp/referral/find_id.jsp 로 매핑될 것(뷰리졸버 기준)
    }

    // 🔹 아이디 찾기 (처리)
    @PostMapping("/findId.do")
    public String findId(
            @RequestParam("name") String name,
            @RequestParam(value = "phone", required = false) String phone,
            @RequestParam(value = "email", required = false) String email,
            Model model) {

        boolean noName  = (name == null  || name.trim().isEmpty());
        boolean noPhone = (phone == null || phone.trim().isEmpty());
        boolean noEmail = (email == null || email.trim().isEmpty());

        if (noName || (noPhone && noEmail)) {
            model.addAttribute("error", "이름과 휴대폰번호 또는 이메일을 입력해 주세요.");
            return "referral/find_id";
        }

        String phoneDigits = null;
        if (!noPhone) {
            // 하이픈/공백 등 제거하여 숫자만 비교
            phoneDigits = phone.replaceAll("\\D", "");
        }

        // ✅ 서비스 호출 (존재해야 함)
        String foundUserId = userService.findUserId(
                name.trim(),
                noPhone ? null : phone.trim(),
                noEmail ? null : email.trim(),
                phoneDigits
        );

        if (foundUserId == null) {
            model.addAttribute("notFound", true);
        } else {
            model.addAttribute("foundId", maskUserId(foundUserId));
        }
        return "referral/find_id";
    }

    // 🔹 유저ID 마스킹 유틸 (예: ab****12 형태)
    private String maskUserId(String userId) {
        if (userId == null || userId.length() < 4) return "****";
        int keepHead = Math.min(2, userId.length() / 2);
        int keepTail = 2;
        String head = userId.substring(0, keepHead);
        String tail = userId.substring(userId.length() - keepTail);
        String stars = new String(new char[Math.max(1, userId.length() - keepHead - keepTail)]).replace("\0", "*");
        return head + stars + tail;
    }
    @Autowired
    private MailService mailService; 
    
    @GetMapping("/findPw.do")
    public String findPwForm() {
    	System.out.println(">> GET /referral/findPw.do hit");
        return "referral/find_pw"; // /WEB-INF/jsp/referral/find_pw.jsp
    }

    // 🔹 비밀번호 찾기 처리: 아이디+이름+이메일 확인 후 임시 비번 발송
    @PostMapping("/findPw.do")
    public String findPw(
            @RequestParam("userId") String userId,
            @RequestParam("name")   String name,
            @RequestParam("email")  String email,
            Model model,
            RedirectAttributes ra) {

        if (userId==null || userId.trim().isEmpty()
         || name==null   || name.trim().isEmpty()
         || email==null  || email.trim().isEmpty()) {
            model.addAttribute("error", "아이디, 이름, 이메일을 모두 입력해 주세요.");
            return "referral/find_pw";
        }

        boolean ok = userService.verifyUserIdentity(userId.trim(), name.trim(), email.trim());
        if (!ok) {
            model.addAttribute("notFound", true); // 일치하는 회원 없음
            return "referral/find_pw";
        }

        // 임시 비밀번호 생성
        String tempPw = generateTempPassword(10);
        String encPw  = SHA512Util.encrypt(tempPw);

        // 비밀번호 업데이트
        userService.updatePassword(userId.trim(), encPw);

        // 메일 발송
        String subject = "[MEDIPRIME] 임시 비밀번호 안내";
        String body =
        	    new StringBuilder()
        	    .append(name).append("님,\n\n")
        	    .append("안녕하세요. MEDIPRIME 협진센터입니다.\n\n")
        	    .append("요청하신 계정의 임시 비밀번호를 아래와 같이 안내드립니다.\n")
        	    .append("로그인 후 반드시 비밀번호를 변경해 주세요.\n\n")
        	    .append("▶ 계정 ID: ").append(userId).append("\n")
        	    .append("▶ 임시 비밀번호: ").append(tempPw).append("\n\n")
        	    .append("본 메일을 요청하지 않으신 경우, 보안을 위해 고객센터로 즉시 문의해 주시기 바랍니다.\n\n")
        	    .append("감사합니다.\n")
        	    .append("MEDIPRIME 협진센터 드림")
        	    .toString();

        mailService.sendText(email.trim(), subject, body);

        model.addAttribute("sent", true); // 성공 메시지 표시용
        return "referral/find_pw";
    }

    private String generateTempPassword(int len) {
        final String ALPHA = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789!@#$%";
        SecureRandom r = new SecureRandom();
        StringBuilder sb = new StringBuilder(len);
        for (int i=0; i<len; i++) sb.append(ALPHA.charAt(r.nextInt(ALPHA.length())));
        return sb.toString();
    }
}
