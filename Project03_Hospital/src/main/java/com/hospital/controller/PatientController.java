package com.hospital.controller;

import java.io.*;
import java.net.*;
import java.util.*;
import java.util.Objects;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hospital.service.PatientService;
import com.hospital.util.SHA512Util;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.PatientVO;

@Controller
@RequestMapping("/patient")
public class PatientController {

	@Autowired
	private PatientService patientService;

	// ✅ 일반 회원가입
	@PostMapping("/signup.do")
	public String signup(@ModelAttribute PatientVO vo, HttpSession session) {
		try {
			// 비회원 예약 내역이 있는지 확인
			PatientVO existing = patientService.findNonMemberPatient(vo.getPatientName(), vo.getPatientRrn());

			// 비밀번호 암호화
			vo.setPatientPassword(SHA512Util.encrypt(vo.getPatientPassword()));

			if (existing != null) {
				// 비회원 → 회원 전환
				existing.setPatientUserId(vo.getPatientUserId());
				existing.setPatientPassword(vo.getPatientPassword());
				existing.setPatientGender(vo.getPatientGender());
				existing.setPatientEmail(vo.getPatientEmail());

				patientService.updatePatientToMember(existing);
				session.setAttribute("signupSuccessName", existing.getPatientName());
				return "redirect:/patient/selectForm.do?signup=true";
			} else {
				// 신규 회원가입
				boolean success = patientService.registerPatient(vo);
				if (success) {
					session.setAttribute("signupSuccessName", vo.getPatientName());
					return "redirect:/patient/selectForm.do?signup=true";
				} else {
					session.setAttribute("signupError", "회원가입 실패. 다시 시도해주세요.");
					return "redirect:/patient/selectForm.do";
				}
			}

		} catch (DuplicateKeyException e) {
			session.setAttribute("signupError", e.getMessage());
			return "redirect:/patient/selectForm.do";
		}
	}

	// ✅ 일반 로그인
	@PostMapping("/login.do")
	public String login(@ModelAttribute PatientVO vo, HttpSession session) {
		// 비밀번호 암호화 후 로그인 시도
		vo.setPatientPassword(SHA512Util.encrypt(vo.getPatientPassword()));

		PatientVO loginUser = patientService.login(vo);
		if (loginUser != null) {
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("loginSuccessName", loginUser.getPatientName());
			return "redirect:/resources/index.jsp";
		} else {
			return "redirect:/patient/selectForm.do?error=1";
		}
	}

	@GetMapping("/selectForm.do")
	public String patientSelectForm() {
		return "patient/selectForm";
	}

	@GetMapping("/kakaoLogin.do")
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session) throws Exception {
		String accessToken = getAccessToken(code);
		Map<String, Object> userInfo = getUserInfo(accessToken);

		String email = (String) userInfo.get("email");
		String nickname = (String) userInfo.get("nickname");

		PatientVO patient = patientService.findPatientByEmail(email);
		if (patient == null) {
			// 신규 환자 등록
			patient = new PatientVO();
			patient.setPatientUserId("kakao_" + UUID.randomUUID().toString().substring(0, 8));
			patient.setPatientName(nickname);
			patient.setPatientEmail(email);
			patient.setPatientPassword(""); // 소셜 로그인 비밀번호 없음
			patient.setPatientRrn("999999-" + (new Random().nextInt(900000) + 100000));

			patientService.insertSocialPatient(patient);
		}

		session.setAttribute("loginUser", patient);
		session.setAttribute("loginSuccessName", patient.getPatientName());
		return "redirect:/resources/index.jsp";
	}

	private String getAccessToken(String code) throws Exception {
		URL url = new URL("https://kauth.kakao.com/oauth/token");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setDoOutput(true);

		String data = "grant_type=authorization_code" + "&client_id=8439ac1e9e2f3cf860f6ab16dbcd581a"
				+ "&redirect_uri=http://localhost:8080/patient/kakaoLogin.do" + "&code=" + code;

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

		Map<String, Object> result = new HashMap<>();
		result.put("email", kakaoAccount.getString("email"));
		result.put("nickname", profile.getString("nickname"));
		return result;
	}

	@PostMapping("/delete.do")
	public String deletePatient(HttpSession session) {
		PatientVO loginUser = (PatientVO) session.getAttribute("loginUser");
		if (loginUser != null) {
			patientService.deletePatient(loginUser.getPatientNo());
			session.invalidate();
		}
		return "redirect:/main.do?deleted=1";
	}

	@RequestMapping("/editPatientForm.do")
	public String showEditForm(HttpSession session, Model model) {
		PatientVO loginUser = (PatientVO) session.getAttribute("loginUser");
		if (loginUser == null)
			return "redirect:/login.do";

		model.addAttribute("loginUser", loginUser);
		return "/user/edit_patient_form";
	}

	@PostMapping("/updatePatient.do")
	public String updatePatient(@RequestParam("patientNo") int patientNo,
	                            @RequestParam("patientUserId") String patientUserId,
	                            @RequestParam("patientEmail") String patientEmail,
	                            @RequestParam("patientPhone") String patientPhone,
	                            @RequestParam("patientGender") String patientGender,
	                            @RequestParam(value = "currentPassword", required = false) String currentPassword,
	                            @RequestParam(value = "newPassword", required = false) String newPassword,
	                            HttpSession session,
	                            RedirectAttributes redirectAttr) {

	    PatientVO loginUser = (PatientVO) session.getAttribute("loginUser");

	    if (loginUser == null) {
	        redirectAttr.addFlashAttribute("errorMsg", "로그인이 만료되었습니다.");
	        return "redirect:/login";
	    }

	    // NPE 방지: null-safe 비교
	    boolean emailChanged = !Objects.equals(loginUser.getPatientEmail(), patientEmail);
	    boolean phoneChanged = !Objects.equals(loginUser.getPatientPhone(), patientPhone);
	    boolean genderChanged = !Objects.equals(loginUser.getPatientGender(), patientGender);

	    boolean wantsToChangePassword = (currentPassword != null && !currentPassword.trim().isEmpty())
	                                  || (newPassword != null && !newPassword.trim().isEmpty());

	    if (wantsToChangePassword) {
	        if (currentPassword == null || newPassword == null ||
	            currentPassword.trim().isEmpty() || newPassword.trim().isEmpty()) {
	            redirectAttr.addFlashAttribute("errorMsg", "비밀번호 변경 시 모든 항목을 입력해주세요.");
	            return "redirect:/patient/editPatientForm.do";
	        }

	        if (!Objects.equals(loginUser.getPatientPassword(), SHA512Util.encrypt(currentPassword))) {
	            redirectAttr.addFlashAttribute("errorMsg", "현재 비밀번호가 일치하지 않습니다.");
	            return "redirect:/patient/editPatientForm.do";
	        }

	        if (Objects.equals(loginUser.getPatientPassword(), SHA512Util.encrypt(newPassword))) {
	            redirectAttr.addFlashAttribute("errorMsg", "기존 비밀번호와 다른 새 비밀번호를 입력해주세요.");
	            return "redirect:/patient/editPatientForm.do";
	        }
	    }

	    if (!emailChanged && !phoneChanged && !genderChanged && !wantsToChangePassword) {
	        redirectAttr.addFlashAttribute("errorMsg", "변경된 정보가 없습니다.");
	        return "redirect:/patient/editPatientForm.do";
	    }

	    // 변경 사항 저장
	    PatientVO vo = new PatientVO();
	    vo.setPatientNo(patientNo);
	    vo.setPatientUserId(patientUserId);
	    vo.setPatientEmail(patientEmail);
	    vo.setPatientPhone(patientPhone);
	    vo.setPatientGender(patientGender);

	    if (wantsToChangePassword) {
	        vo.setPatientPassword(SHA512Util.encrypt(newPassword));
	    } else {
	        vo.setPatientPassword(loginUser.getPatientPassword());
	    }

	    patientService.updatePatientInfoAndPassword(vo);

	    // 세션 갱신
	    PatientVO updatedUser = patientService.getPatientById(patientUserId);
	    session.setAttribute("loginUser", updatedUser);

	    return "redirect:/user/patientPage.do";
	}


	@GetMapping("/findIdForm.do")
	public String showFindIdForm() {
		return "patient/find_id_form";
	}

	@PostMapping("/findId.do")
	public String findId(@RequestParam String patientName, @RequestParam String patientPhone, Model model) {
		String id = patientService.findPatientId(patientName, patientPhone);
		model.addAttribute("foundId", id);
		return "patient/find_id_result";
	}

	@GetMapping("/findPwForm.do")
	public String showFindPwForm() {
		return "patient/find_pw_form";
	}

	@PostMapping("/findPw.do")
	public String findPw(@RequestParam String patientUserId, @RequestParam String patientRrn, Model model) {
		String tempPw = patientService.findTempPassword(patientUserId, patientRrn);
		model.addAttribute("tempPw", tempPw);
		return "patient/find_pw_result";
	}

	// PatientController.java

	@GetMapping("/checkId.do")
	@ResponseBody
	public String checkId(@RequestParam("userId") String userId) {
		boolean duplicated = patientService.isUserIdDuplicated(userId);
		return duplicated ? "true" : "false";
	}

	@GetMapping("/checkEmail.do")
	@ResponseBody
	public String checkEmail(@RequestParam("email") String email) {
		boolean duplicated = patientService.isEmailDuplicated(email);
		return duplicated ? "true" : "false";
	}

	@ResponseBody
	@GetMapping("/checkRrn.do")
	public String checkRrn(@RequestParam("rrn") String rrn) {
		return patientService.isRrnDuplicated(rrn) ? "duplicated" : "available";
	}

	@ResponseBody
	@GetMapping("/checkPhone.do")
	public String checkPhone(@RequestParam("phone") String phone) {
		return patientService.isPhoneDuplicated(phone) ? "duplicated" : "available";
	}
	
	// ✅ 본인 탈퇴 (비번 확인 후 비회원 형태로 축소)
	@PostMapping("/withdraw.do")
	public String withdraw(@RequestParam("currentPassword") String currentPassword,
	                       HttpSession session,
	                       RedirectAttributes ra) {
	    PatientVO loginUser = (PatientVO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "redirect:/patient/selectForm.do";
	    }

	    // 비밀번호 확인
	    String enc = SHA512Util.encrypt(currentPassword);
	    if (!enc.equals(loginUser.getPatientPassword())) {
	        ra.addFlashAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
	        return "redirect:/user/patientPage.do";
	    }

	    boolean ok = patientService.stripToGuest(loginUser.getPatientNo());
	    session.invalidate();
	    return "redirect:/main.do?withdraw=" + (ok ? "1" : "0");
	}


}
