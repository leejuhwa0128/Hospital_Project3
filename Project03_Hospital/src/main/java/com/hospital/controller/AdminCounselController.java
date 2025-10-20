package com.hospital.controller;

import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hospital.service.CounselFormService;
import com.hospital.vo.CounselFormVO;

@Controller
public class AdminCounselController {

	@Autowired
	private CounselFormService counselFormService;

	// 상담 목록 + 상태 필터
    @GetMapping("/admin/counselList.do")
    public String counselList(@RequestParam(value = "status", required = false) String status,
                              Model model, HttpSession session) {

        List<CounselFormVO> list = counselFormService.getAllCounsel();

        // 빠른예약 제외 + 상태 필터
        List<CounselFormVO> filtered = list.stream()
            .filter(vo -> !"빠른예약".equals(vo.getSubject()))
            .filter(vo -> (status == null || status.isEmpty()) || status.equals(vo.getStatus()))
            .collect(Collectors.toList());

        model.addAttribute("counsels", filtered);      // ← JSP에서 사용
        model.addAttribute("activeStatus", status);    // ← (옵션) 활성 칩 표시용
        return "admin/counsel_list";
    }

	// 상담 상세 조회
	@GetMapping("/admin/counsel/detail.do")
	public String viewCounselDetail(@RequestParam("counselId") int counselId, Model model) {
		CounselFormVO counsel = counselFormService.getCounselById(counselId);

		// ✅ 빠른예약이면 목록으로 redirect
		if ("빠른예약".equals(counsel.getSubject())) {
			return "redirect:/admin/counselList.do";
		}

		model.addAttribute("counsel", counsel);
		return "admin/counsel_detail";
	}

	@PostMapping("/admin/counsel/updateStatus.do")
	public String updateCounselStatus(@RequestParam("counselId") int counselId, @RequestParam("status") String status) {
		CounselFormVO vo = counselFormService.getCounselById(counselId);
		counselFormService.updateStatus(counselId, status);

		// ✅ subject에 따라 리다이렉트 분기
		if ("빠른예약".equals(vo.getSubject())) {
			return "redirect:/admin/fastReservationList.do";
		} else {
			return "redirect:/admin/counsel/detail.do?counselId=" + counselId;
		}
	}

	// ✅ 빠른예약 목록 조회 추가
	@GetMapping("/admin/fastReservationList.do")
	public String fastReservationList(@RequestParam(value = "status", required = false) String status,
	                                  Model model) {
	    List<CounselFormVO> list = counselFormService.getFastReservations();

	    // status 필터링
	    List<CounselFormVO> filtered = list.stream()
	        .filter(vo -> (status == null || status.isEmpty()) || status.equals(vo.getStatus()))
	        .collect(Collectors.toList());

	    model.addAttribute("fastList", filtered);
	    model.addAttribute("activeStatus", status);  // JSP에서 active 칩 표시용
	    return "admin/counsel_fast";
	}


}
