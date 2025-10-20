package com.hospital.controller;

import com.hospital.service.Doctor2ScheduleService;
import com.hospital.service.Doctor2Service;
import com.hospital.service.UserService;
import com.hospital.util.SHA512Util;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.UserVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;



@Controller
public class Doctor2Controller {

	@Autowired
	private Doctor2ScheduleService doctor2ScheduleService;
	@Autowired
	private UserService userService;
	@Autowired
    private Doctor2Service doctor2Service;
	
	
	
	// 의료진 메인
	@RequestMapping("/doctor_main.do")
	public String doctor_Main(HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null || !"doctor".equals(loginUser.getRole())) {
			return "redirect:/user/loginForm.do"; // 로그인 X 또는 doctor 아님
		}

		return "/user/doctor_page";
	}

	// 의료진 스케쥴
	@RequestMapping("/doctor_schedule.do")
	public String doctor_schedule(HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null || !"doctor".equals(loginUser.getRole())) {
			return "redirect:/user/loginForm.do";
		}

		return "doctor/doctor_schedule";
	}
	

	// 의료진 정보 수정
	@RequestMapping("/doctor_mypage.do")
	public String doctorMypage(HttpSession session, Model model) {
	    UserVO loginUser = (UserVO) session.getAttribute("loginUser");

	    if (loginUser == null || !"doctor".equals(loginUser.getRole())) {
	        return "redirect:/login.do";
	    }

	    // 유저 정보
	    UserVO userVO = userService.getUserById(loginUser.getUserId());

	    // 의사 프로필 정보
	    DoctorVO doctorInfoVO = doctor2Service.getDoctorById(loginUser.getUserId());

	    model.addAttribute("user", userVO);                // 사용자 정보
	    model.addAttribute("doctorInfo", doctorInfoVO);    // 의사 프로필 정보

	    return "doctor/doctor_mypage";
	}

	@PostMapping("/saveSchedule.do")
	public void saveSchedule(@RequestParam("date") String dateStr, @RequestParam("scheduleTime") String scheduleTime,
			@RequestParam("timeSlot") String timeSlot, HttpServletResponse response, HttpSession session)
			throws IOException {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null || !"doctor".equals(loginUser.getRole())) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.getWriter().write("의사만 등록 가능");
			return;
		}

		String doctorId = loginUser.getUserId();

		Date scheduleDate;
		try {
			java.util.Date parsed = new SimpleDateFormat("MM/dd/yyyy").parse(dateStr);
			scheduleDate = new Date(parsed.getTime());
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("날짜 변환 실패");
			return;
		}

		// note는 현재 null 처리
		int result = doctor2ScheduleService.registerSchedule(doctorId, scheduleDate, timeSlot, scheduleTime, null);

		if (result > 0) {
			response.getWriter().write("success");
		} else {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("fail");
		}
	}

	@PostMapping("/deleteSchedule.do")
	@ResponseBody
	public int deleteSchedule(@RequestParam String date, @RequestParam("scheduleType") String scheduleType,
			HttpSession session, HttpServletResponse response) throws IOException {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null || !"doctor".equals(loginUser.getRole())) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.getWriter().write("의사만 삭제 가능");
			return 0;
		}

		String doctorId = loginUser.getUserId();
		return doctor2ScheduleService.deleteScheduleByDateTime(date, scheduleType, doctorId);

	}

	@PostMapping("/update_doctor_info.do")
	public String updateDoctorInfo(HttpServletRequest request, Model model) {
	    String userId = request.getParameter("userId");
	    String currentPassword = request.getParameter("currentPassword");
	    String newPassword = request.getParameter("newPassword");
	    String phone = request.getParameter("phone");
	    String email = request.getParameter("email");
	    String bio = request.getParameter("bio");

	    UserVO dbUser = userService.getUserById(userId);

	    // 🔒 SHA-512로 기존 비밀번호 비교
	    String hashedCurrent = SHA512Util.encrypt(currentPassword == null ? "" : currentPassword);
	    if (!hashedCurrent.equals(dbUser.getPassword())) {
	        model.addAttribute("msg", "기존 비밀번호가 일치하지 않습니다.");
	        model.addAttribute("user", dbUser);
	        model.addAttribute("doctorInfo", doctor2Service.getDoctorById(userId));
	        return "doctor/doctor_mypage";
	    }

	    // 🔒 새 비밀번호가 있으면 SHA-512로 저장
	    if (newPassword != null && !newPassword.trim().isEmpty()) {
	        dbUser.setPassword(SHA512Util.encrypt(newPassword));
	    }

	    dbUser.setPhone(phone);
	    dbUser.setEmail(email);
	    userService.updateUser(dbUser);

	    doctor2Service.updateDoctorProfile(userId, bio);

	    model.addAttribute("msg", "정보가 성공적으로 수정되었습니다.");
	    model.addAttribute("user", dbUser);
	    model.addAttribute("doctorInfo", doctor2Service.getDoctorById(userId));

	    return "doctor/doctor_mypage";
	}
	
	
	


}
