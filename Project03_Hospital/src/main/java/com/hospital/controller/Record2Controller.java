package com.hospital.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hospital.service.Doctor2Service;
import com.hospital.service.Record2Service;
import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.ReservationVO;
import com.hospital.vo.UserVO;

@Controller
public class Record2Controller {

	@Autowired
	private Record2Service record2Service;

	
	
	@Autowired
	private Doctor2Service doctor2Service;

	@PostMapping("/saveCertificate.do")
	public String saveCertificate(@ModelAttribute MedicalRecordVO recordVO, HttpSession session,
	                              RedirectAttributes redirectAttributes) {
	    UserVO loginUser = (UserVO) session.getAttribute("loginUser");

	    // ✅ 로그인 확인
	    if (loginUser == null) {
	        redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
	        return "redirect:/user/loginForm.do";
	    }

	    // ✅ 의사 ID 세팅
	    recordVO.setDoctorId(loginUser.getUserId());
	    // ✅ 예약번호 확보 (폼에 hidden으로 넘어와야 함)
	           int reservationId = recordVO.getReservationId();
	            if (reservationId <= 0) {
	                redirectAttributes.addFlashAttribute("errorMessage", "예약 번호가 없습니다.");
	                return "redirect:/user/doctor_page.do";
	            }
	    

	    // ✅ 진료기록 저장
	    record2Service.saveMedicalRecord(recordVO);

	    // ✅ 예약 상태를 '작성 완료'로 변경
	    doctor2Service.updateStatusToCompleted(reservationId);


	    redirectAttributes.addFlashAttribute("recordSaved", true);
	    return "redirect:/doctor_certificates.do"; 

	}

	// ✅ 진단서 JSON 응답 (모달용)
	@GetMapping(value = "/getMedicalRecord.do", produces = "application/json")
	@ResponseBody
	public MedicalRecordVO getMedicalRecord(@RequestParam("reservationId") int reservationId) {
		        MedicalRecordVO vo = record2Service.getRecordByReservationId(reservationId);
		        if (vo == null) {
		          vo = new MedicalRecordVO();
		            vo.setReservationId(reservationId);
		        }
		        ReservationVO rsv = doctor2Service.getReservationById(reservationId);
		        if (rsv != null) {
		            vo.setPatientName(rsv.getPatientName());
		        }
		        return vo;
		     }

}
