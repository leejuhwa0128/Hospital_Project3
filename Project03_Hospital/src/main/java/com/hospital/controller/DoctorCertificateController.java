package com.hospital.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.hospital.service.Doctor2Service;
import com.hospital.service.Record2Service;
import com.hospital.service.RecordService;
import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.QuestionnaireVO;
import com.hospital.vo.ReservationVO;
import com.hospital.vo.UserVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DoctorCertificateController {

	@Autowired
	private Doctor2Service doctor2Service; 
    
    @Autowired
    private Record2Service record2Service;
    
    @GetMapping("/doctor_certificates.do")
    public String doctorCertificates(Model model, HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        if (loginUser == null || !"doctor".equals(loginUser.getRole())) {
            return "redirect:/loginForm.do";
        }

        String doctorId = loginUser.getUserId();
        List<ReservationVO> patientList = doctor2Service.getTodayPatientsByDoctorId(doctorId);

        // ✅ 각 예약에 기록 존재 여부 세팅
        for (ReservationVO vo : patientList) {
            MedicalRecordVO record = record2Service.getRecordByReservationId(vo.getReservationId());
            vo.setHasRecord(record != null);
        }

        model.addAttribute("patientList", patientList);
       
        return "doctor/doctor_certificates"; // JSP: /WEB-INF/jsp/doctor/doctor_certificates.jsp
    }

    
    @RequestMapping("/certificates.do")
    public String redirectToCertificates() {
        return "redirect:/doctor_certificates.do";
    }
    
    @GetMapping("/writeCertificate.do")
    public String writeCertificateForm(@RequestParam("reservationId") int reservationId, Model model) {
    	ReservationVO reservation = doctor2Service.getReservationById(reservationId);
        QuestionnaireVO questionnaire = record2Service.getQuestionnaireByReservationId(reservationId);

        model.addAttribute("reservation", reservation);
        model.addAttribute("questionnaire", questionnaire);

        return "doctor/doctor_certificates_write";
    }
    
    @GetMapping("/past_certificates.do")
    public String showPastCertificates(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        if (loginUser == null || !"doctor".equals(loginUser.getRole())) {
            return "redirect:/loginForm.do";
        }

        String doctorId = loginUser.getUserId();
        List<MedicalRecordVO> pastRecords = record2Service.getRecordsByDoctorId(doctorId);

        model.addAttribute("recordList", pastRecords);
        return "doctor/doctor_past_certificates"; // 👉 JSP 경로: /WEB-INF/views/doctor/past_certificates.jsp
    }
    
}
