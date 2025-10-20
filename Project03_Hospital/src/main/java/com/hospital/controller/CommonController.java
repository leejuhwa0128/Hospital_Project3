package com.hospital.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hospital.service.PatientService;
import com.hospital.vo.PatientVO;

@Controller

public class CommonController {
	@Autowired
	private PatientService patientService;

	@GetMapping("/loginSelector.do")
	public String loginSelector() {
		return "common/login_selector"; // /WEB-INF/jsp/common/login_selector.jsp
	}
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
	    session.invalidate(); // 세션 전체 삭제 (loginUser 포함)
	    return "redirect:/loginSelector.do"; // 로그인 페이지로 이동 (또는 메인으로)
	}
	@GetMapping("/delete_patient.do")
	public String deletePatient(HttpSession session) {
	    PatientVO loginUser = (PatientVO) session.getAttribute("loginUser");

	    if (loginUser != null) {
	        patientService.logdeletePatient(loginUser.getPatientUserId()); // DB 삭제
	        session.invalidate(); // 세션 종료
	        return "redirect:/login.do"; // 로그인 페이지로 이동
	    }

	    return "redirect:/"; // 비정상 접근 시
	}

}