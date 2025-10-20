package com.hospital.controller;

import com.hospital.service.Doctor2ScheduleService;
import com.hospital.service.DoctorScheduleService;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.UserVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

import java.util.List;
import java.text.SimpleDateFormat;
import java.util.Locale;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/doctor/schedule")  // ✅ 컨트롤러 공통 prefix
public class Doctor2ScheduleController {

    @Autowired
    private Doctor2ScheduleService doctor2ScheduleService;

    // ✅ 날짜 기준 스케줄 조회 → /doctor/schedule/list.do
    @GetMapping("/list.do")
    public List<DoctorScheduleVO> getScheduleList(
            @RequestParam String date,
            HttpSession session,
            HttpServletResponse response) throws IOException {

        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        if (loginUser == null || !"doctor".equals(loginUser.getRole())) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("의사만 조회 가능");
            return null;
        }

        String doctorId = loginUser.getUserId();

        return doctor2ScheduleService.getSchedulesByDateAndDoctor(date, doctorId);
    }

    // ✅ 스케줄 저장 → /doctor/schedule/save.do
    @PostMapping("/save.do")
    public void saveSchedule(
            @RequestParam String date,
            @RequestParam String timeSlot,
            @RequestParam String scheduleTime,
            @RequestParam(required = false) String note,
            HttpSession session,
            HttpServletResponse response) throws IOException {

        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        if (loginUser == null || !"doctor".equals(loginUser.getRole())) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("의사만 저장할 수 있음");
            return;
        }

        String doctorId = loginUser.getUserId();

        DoctorScheduleVO vo = new DoctorScheduleVO();
        vo.setDoctorId(doctorId);

        try {
            // ✅ 날짜 파싱 처리 추가
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy", Locale.KOREA);
            java.util.Date parsed = sdf.parse(date);
            vo.setScheduleDate(new java.sql.Date(parsed.getTime()));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("날짜 형식이 잘못되었습니다.");
            return;
        }

        vo.setTimeSlot(timeSlot);
        vo.setScheduleTime(scheduleTime);
        vo.setNote(note);

        doctor2ScheduleService.saveSchedule(vo);
    }
}
