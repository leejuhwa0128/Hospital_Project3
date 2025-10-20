package com.hospital.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.hospital.service.CounselFormService;
import com.hospital.vo.CounselFormVO;

import java.util.List;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/reservationCounsel")
public class CounselFormController {

	@Autowired
	private CounselFormService counselFormService;

	// 상담 신청 처리
	@PostMapping("/submit.do")
	public String submitCounsel(@ModelAttribute CounselFormVO counsel) {
		counselFormService.insertCounsel(counsel);
		return "redirect:/reservation/counsel.do?success=true";
	}

	// (관리자용) 상담 신청 목록
	@GetMapping("/list.do")
	public String listCounsel(Model model, HttpSession session) {
		if (session.getAttribute("loginAdmin") == null) {
			return "redirect:/resources/index.jsp";
		}

		List<CounselFormVO> counselList = counselFormService.getAllCounsel();
		model.addAttribute("counselList", counselList);
		return "admin_board/patient_counsel_list";
	}

	// (관리자용) 상담 상태 업데이트
	@PostMapping("/updateStatus.do")
	public String updateStatus(@RequestParam("counselId") int counselId, @RequestParam("status") String status,
			HttpSession session) {
		if (session.getAttribute("loginAdmin") == null) {
			return "redirect:/resources/index.jsp";
		}

		counselFormService.updateStatus(counselId, status);
		return "redirect:/reservationCounsel/list.do";
	}
}
