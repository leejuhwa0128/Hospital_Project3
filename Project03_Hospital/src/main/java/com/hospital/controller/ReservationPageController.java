package com.hospital.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.hospital.service.CounselFormService;
import com.hospital.vo.CounselFormVO;

@Controller
public class ReservationPageController {

	@Autowired
	private CounselFormService counselService;

	// 예약/진료 안내
	@GetMapping("/reservation/guide.do")
	public String reservationGuide() {
		return "reservation/reservationGuide";
	}

	// 예약/진료 상담
	@GetMapping("/reservation/counsel.do")
	public String reservationCounsel() {
		return "reservation/reservationCounsel";
	}

	// 예약/진료 상담 확인
	@PostMapping("/reservation/counsel/submit.do")
	public String submitCounsel(@ModelAttribute CounselFormVO form) {
		counselService.insertCounsel(form);
		return "redirect:/reservation/counsel.do?success=true";
	}

	@GetMapping("/reservation/fast.do")
	public String fastReservationPage() {
		return "reservation/reservation_fast"; // /WEB-INF/views/reservation_fast.jsp
	}

	@PostMapping("/reservation/fast/submit.do")
	public String submitFastReservation(HttpServletRequest request, HttpSession session) {
		String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-"
				+ request.getParameter("phone3");

		String agree = request.getParameter("agree");
		if (!"yes".equals(agree)) {
			return "redirect:/reservation/fast.do?error=agree";
		}

		CounselFormVO vo = new CounselFormVO();
		vo.setPatientName("빠른예약");
		vo.setPhone(phone);
		vo.setEmail("fast@reservation");
		vo.setSubject("빠른예약");
		vo.setMessage("빠른예약으로 접수된 요청입니다.");
		vo.setStatus("대기");

		counselService.insertCounsel(vo);

		session.setAttribute("fastSuccess", true);
		return "redirect:/reservation/fast.do";
	}

	@GetMapping("/reservation/counsel/list.do")
	public String myCounselList(HttpSession session, Model model) {
		Object loginUser = session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/login.do";
		}

		String email = ((com.hospital.vo.PatientVO) loginUser).getPatientEmail(); // 세션에서 이메일 꺼냄
		model.addAttribute("counselList", counselService.selectByEmail(email));
		return "reservation/reservationConsel_list"; // JSP 파일 경로
	}

}
