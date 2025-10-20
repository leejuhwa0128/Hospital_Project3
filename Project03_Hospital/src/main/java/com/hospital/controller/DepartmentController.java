package com.hospital.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List; 
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hospital.service.DepartmentService;
import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /* ===========================
     *  의료진 소개 (doctorMain.jsp)
     * =========================== */

    // 의료진 소개 메인 
    @GetMapping("/doctor/main.do")
    public String doctorMain(Model model) {
        List<DepartmentVO> depts = departmentService.getAllDepartments();
        List<DoctorVO> allDoctors = departmentService.getDoctors(null, null, 1000, 0); // 전체 목록

        model.addAttribute("departments", depts);
        model.addAttribute("doctorList", allDoctors); // 전체 목록 바로 세팅
        model.addAttribute("page", 1);
        model.addAttribute("totalPages", 1); // 또는 계산해도 됨

        return "department/doctorMain";
    }

    // 검색/목록
    @GetMapping("/doctor/list.do")
    public String doctorList(
            @RequestParam(value = "deptId", required = false) String deptId,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "12") int size,
            Model model) {

        // ✅ null/빈문자 정리 (MyBatis LIKE 바인딩 NPE 방지)
        String did = (deptId != null && !deptId.trim().isEmpty()) ? deptId.trim() : null;
        String kw  = (keyword != null && !keyword.trim().isEmpty()) ? keyword.trim() : null;

        int safeSize = (size <= 0) ? 12 : size;
        int safePage = (page <= 0) ? 1 : page;
        int offset   = (safePage - 1) * safeSize;

        int total = departmentService.countDoctors(did, kw);
        int totalPages = (int)Math.ceil(total / (double)safeSize);

        List<DoctorVO> list = departmentService.getDoctors(did, kw, safeSize, offset);
        List<DepartmentVO> depts = departmentService.getAllDepartments();

        model.addAttribute("departments", depts);
        model.addAttribute("doctorList", list);
        model.addAttribute("page", safePage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("paramDeptId", did);
        model.addAttribute("paramKeyword", kw);

        return "department/doctorMain";
    }
    
    /* ===========================
     *  의료진 상세 (doctorDetail.jsp)
     *  - 주간 날짜 + 스케줄 조회
     *  - 버튼 라벨은 진료과명 사용
     *  - '의료진 소개' → '학력'은 JSP에서 표시
     * =========================== */
    @GetMapping("/doctor/detail.do")
    public String detail(@RequestParam(value="id", required=false) String id,
                         @RequestParam(value="doctorId", required=false) String doctorId,
                         @RequestParam(value="d", required=false) @DateTimeFormat(pattern="yyyy-MM-dd") LocalDate base,
                         Model model) {

        String targetId = (doctorId != null && !doctorId.isEmpty()) ? doctorId : id;
        if (targetId == null || targetId.isEmpty()) {
            throw new IllegalArgumentException("doctorId (or id) is required");
        }

        DoctorVO doctor = departmentService.getDoctorById(targetId);
        model.addAttribute("doctor", doctor);

        ZoneId zone = ZoneId.of("Asia/Seoul");
        LocalDate today = (base != null) ? base : LocalDate.now(zone);

        // 주 시작(수요일 기준) 계산
        DayOfWeek START_DOW = DayOfWeek.WEDNESDAY;
        int diff = (7 + today.getDayOfWeek().getValue() - START_DOW.getValue()) % 7;
        LocalDate start = today.minusDays(diff);
        LocalDate end   = start.plusDays(6);

        // JSP가 문자열 yyyy-MM-dd를 기대하므로 String 리스트로 준비
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        List<String> weekDates = new ArrayList<>();
        for (LocalDate d = start; !d.isAfter(end); d = d.plusDays(1)) {
            weekDates.add(d.format(fmt));
        }
        model.addAttribute("weekDates", weekDates);
        model.addAttribute("prevDate", start.minusWeeks(1).format(fmt));
        model.addAttribute("nextDate", start.plusWeeks(1).format(fmt));

        // 스케줄 조회 (DB는 Date 타입으로 between)
        Map<String, Object> param = new HashMap<>();
        param.put("doctorId", targetId);
        param.put("startDate", java.sql.Date.valueOf(start));
        param.put("endDate",   java.sql.Date.valueOf(end));

        List<DoctorScheduleVO> schedules = departmentService.findSchedulesInRange(param);
        model.addAttribute("scheduleList", schedules); // JSP가 사용하는 이름으로!

        return "department/doctorDetail";
    }



    /* ===========================
     *  진료과 소개 (departmentMain.jsp)
     * =========================== */

    // 메인 진입
    @GetMapping("/department/main.do")
    public String departmentMain(
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

        List<DepartmentVO> list = (keyword == null || keyword.trim().isEmpty())
                ? departmentService.getAllDepartments()
                : departmentService.searchDepartments(keyword.trim());

        model.addAttribute("departments", list);
        model.addAttribute("keyword", (keyword != null && !keyword.trim().isEmpty()) ? keyword.trim() : null);
        return "department/departmentMain";
    }

    // 검색 전용 엔드포인트(같은 JSP로 렌더)
    @GetMapping("/department/list.do")
    public String departmentList(
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

        List<DepartmentVO> list = (keyword == null || keyword.trim().isEmpty())
                ? departmentService.getAllDepartments()
                : departmentService.searchDepartments(keyword.trim());

        model.addAttribute("departments", list);
        model.addAttribute("keyword", (keyword != null && !keyword.trim().isEmpty()) ? keyword.trim() : null);
        return "department/departmentMain";
    }

    /* =========================
     * 진료과 상세 페이지
     * ========================= */
    @GetMapping("/department/detail.do")
    public String departmentDetail(@RequestParam("deptId") String deptId, Model model) {
        // 진료과 정보
        DepartmentVO department = departmentService.getDepartmentById(deptId);
        model.addAttribute("department", department);

        // 해당 진료과 의료진
        List<DoctorVO> doctors = departmentService.getDoctorsByDeptId(deptId);
        model.addAttribute("doctors", doctors);

        return "department/departmentDetail";
    }
}
