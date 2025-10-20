package com.hospital.controller;

import com.hospital.service.ReservationService;
import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.PatientVO;
import com.hospital.vo.ReservationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;
import org.springframework.dao.DuplicateKeyException;
/**
 * 예약 + (부서/의사/스케줄) JSON API를 한 컨트롤러에 통합
 */
@Controller
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    /* =====================[ 관리자 기능 - 유지 ]===================== */
    @RequestMapping("/admin/updateStatus.do")
    public String updateStatus(@RequestParam("reservationId") int reservationId,
                               @RequestParam("status") String status,
                               @RequestParam("doctorId") String doctorId) {
        reservationService.updateReservationStatus(reservationId, status);
        return "redirect:/admin/doctorDetail.do?doctorId=" + doctorId;
    }

    /* ================[ 환자 예약 기능 API (기존) ]================== */

    /** 1) 진료과 목록 */
    @GetMapping("/doctors/api/departments.do")
    @ResponseBody
    public List<DepartmentVO> getDepartments() {
        return reservationService.getDepartments();
    }

    /** 2) 진료과별 의사 목록 */
    @GetMapping("/doctors/api/doctors.do")
    @ResponseBody
    public List<DoctorVO> getDoctors(@RequestParam String deptId) {
        return reservationService.getDoctorsByDept(deptId);
    }

    /** 3) 의사별 스케줄(오늘 이후) + 예약된 schedule_id 목록 */
    @GetMapping("/doctors/api/doctor-schedules.do")
    @ResponseBody
    public Map<String, Object> getDoctorSchedules(@RequestParam String doctorId) {
        List<DoctorScheduleVO> list = reservationService.getSchedulesByDoctorFromToday(doctorId);

        Map<String, List<Map<String, Object>>> scheduleMap = new LinkedHashMap<String, List<Map<String, Object>>>();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        for (DoctorScheduleVO v : list) {
            String key = df.format(v.getScheduleDate());
            if (!scheduleMap.containsKey(key)) {
                scheduleMap.put(key, new ArrayList<Map<String, Object>>());
            }
            Map<String, Object> row = new HashMap<String, Object>();
            row.put("id", v.getScheduleId());
            row.put("doctorId", v.getDoctorId());
            row.put("time", v.getScheduleTime()); // "HH:mm"
            row.put("note", v.getNote() == null ? "" : v.getNote());
            scheduleMap.get(key).add(row);
        }

        List<Long> reservedIds = reservationService.getReservedScheduleIdsByDoctor(doctorId);
        Map<String, Object> resp = new HashMap<String, Object>();
        resp.put("scheduleMap", scheduleMap);
        resp.put("reservedIds", reservedIds);
        return resp;
    }

    /* ================[ 모달/칩 UI용 JSON API (추가) ]================== */
    /** 부서 이름 자동완성 (검색어 포함) */
    @GetMapping("/api/departments/search.do")
    @ResponseBody
    public List<Map<String, Object>> searchDepartments(@RequestParam("q") String q) {
        return reservationService.searchDepartmentsByName(q); // result: [{deptId, name}, ...]
    }

    /** 부서별 의사 자동완성 (이름 like 검색) - 🔹 기존 */
    @GetMapping("/api/doctors/byDept.do")
    @ResponseBody
    public List<Map<String, Object>> getDoctorsByDeptForSuggest(@RequestParam("deptId") String deptId,
                                                                @RequestParam(value = "q", required = false) String q) {
        return reservationService.getDoctorsByDeptForSuggest(deptId, q); // [{doctorId, doctorName}, ...]
    }

    /* 표준 키 추출 헬퍼 */
    private static String firstNonEmpty(Map<String, Object> m, String... keys) {
        for (String k : keys) {
            Object v = m.get(k);
            if (v != null) {
                String s = String.valueOf(v).trim();
                if (!s.isEmpty()) return s;
            }
        }
        return null;
    }

    // ✅ 부서 선택 시 해당 부서의 모든 의사 목록 반환(표준화)
    @GetMapping("/api/doctors/listByDept.do")
    @ResponseBody
    public List<Map<String, Object>> getDoctorsListByDept(@RequestParam("deptId") String deptId) {
        List<Map<String, Object>> raw = reservationService.getDoctorsListByDept(deptId);

        List<Map<String, Object>> out = new ArrayList<>();
        if (raw != null) {
            for (Map<String, Object> r : raw) {
                String id = firstNonEmpty(r, "doctorId", "DOCTOR_ID", "doctor_id", "id", "ID", "user_id", "USER_ID");
                String nm = firstNonEmpty(r, "name", "NAME", "doctorName", "DOCTORNAME", "DOCTOR_NAME", "displayName", "DISPLAY_NAME");
                if (id == null) continue; // id 없으면 스킵
                Map<String, Object> row = new HashMap<>();
                row.put("doctorId", id);
                row.put("name", (nm != null ? nm : id)); // 이름 없으면 id로 대체표시
                out.add(row);
            }
        }
        return out;
    }

    // ✅ 의사 단건: {doctorId, name}로 표준화해서 반환
    @GetMapping("/api/doctors/byId.do")
    @ResponseBody
    public Map<String, Object> getDoctorById(@RequestParam("doctorId") String doctorId) {
        Map<String, Object> raw = reservationService.getDoctorNameByIdForSuggest(doctorId);

        Map<String, Object> out = new HashMap<>();
        out.put("doctorId", doctorId);

        if (raw != null) {
            String id = firstNonEmpty(raw, "doctorId", "DOCTOR_ID", "doctor_id", "id", "ID", "user_id", "USER_ID");
            if (id != null) out.put("doctorId", id);

            String nm = firstNonEmpty(raw, "name", "NAME", "doctorName", "DOCTORNAME", "DOCTOR_NAME", "displayName", "DISPLAY_NAME");
            out.put("name", (nm != null ? nm : out.get("doctorId")));
        } else {
            out.put("name", doctorId); // 폴백
        }
        return out;
    }

    /** 의사 스케줄: 날짜 목록(문자열 yyyy-MM-dd) */
    @GetMapping("/api/schedules/dates.do")
    @ResponseBody
    public List<String> getScheduleDates(@RequestParam("doctorId") String doctorId) {
        return reservationService.getScheduleDatesByDoctor(doctorId);
    }

    /** 의사 스케줄: 특정 날짜의 시간 목록([{timeSlot,time}, ...]) */
    @GetMapping("/api/schedules/times.do")
    @ResponseBody
    public List<Map<String, String>> getScheduleTimes(@RequestParam("doctorId") String doctorId,
                                                      @RequestParam("date") String date) {
        return reservationService.getScheduleTimesByDoctorAndDate(doctorId, date);
    }

    // ✅ 추가 : 날짜만 반환하는 API (달력 가능 날짜 표시용)
    @GetMapping("/api/doctors/availableDates.do")
    @ResponseBody
    public List<String> getAvailableDates(@RequestParam("doctorId") String doctorId) {
        return reservationService.getScheduleDatesByDoctor(doctorId);
    }

    // ✅ 추가 : 특정 날짜의 예약 가능 시간 목록 API
    @GetMapping("/api/doctors/availableTimes.do")
    @ResponseBody
    public List<String> getAvailableTimes(@RequestParam("doctorId") String doctorId,
                                          @RequestParam("date") String date) {
        return reservationService.getAvailableTimesByDoctorAndDate(doctorId, date);
    }

    /* ================[ 예약 저장 ]================== */
    @PostMapping("/doctors/reservation/save.do")
    public String saveReservation(
            @RequestParam String doctorId,
            @RequestParam Integer scheduleId,
            @RequestParam String reservationDate,   // "yyyy-MM-dd"
            @RequestParam String reservationTime,   // "HH:mm"
            @RequestParam(required = false) String department,
            @RequestParam(required = false) String deptId,
            HttpSession session,
            RedirectAttributes ra) {

        Object login = session.getAttribute("loginUser");
        Integer guestPatientNo = (Integer) session.getAttribute("guestPatientNo");

        if (login == null && guestPatientNo == null) {
            ra.addFlashAttribute("msg", "로그인 또는 비회원 정보를 입력해 주세요.");
            return "redirect:/reservation/guest-start.do";
        }

        // ✅ 환자번호 결정: 로그인 우선, 없으면 비회원 세션 사용
        int patientNo = (login instanceof com.hospital.vo.PatientVO)
                ? ((com.hospital.vo.PatientVO) login).getPatientNo()
                : guestPatientNo.intValue();

        if ((department == null || department.trim().isEmpty()) && deptId != null) {
            String found = reservationService.getDepartmentNameById(deptId);
            department = (found != null) ? found : deptId;
        }

        if (reservationService.isScheduleTaken(scheduleId)) {
            ra.addFlashAttribute("msg", "이미 예약된 시간입니다. 다른 시간을 선택해 주세요.");
            return "redirect:/reservation.do";
        }

        ReservationVO vo = new ReservationVO();
        vo.setPatientNo(patientNo);
        vo.setDepartment(department);
        vo.setDoctorId(doctorId);
        try {
            vo.setReservationDate(java.sql.Date.valueOf(reservationDate));
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("msg", "예약 날짜 형식이 올바르지 않습니다.");
            return "redirect:/reservation.do";
        }
        vo.setScheduleTime(reservationTime);
        vo.setScheduleId(scheduleId.intValue());
        // 상태명
        vo.setStatus("대기");

        int rows = reservationService.createReservation(vo);
        if (rows <= 0) {
            ra.addFlashAttribute("msg", "예약 저장에 실패했습니다. 다시 시도해 주세요.");
            return "redirect:/reservation.do";
        }
        int newId = vo.getReservationId();
        session.setAttribute("lastReservationId", newId); // ✅ 백업
        ra.addFlashAttribute("reservationId", newId);
        ra.addFlashAttribute("msg", "예약이 완료되었습니다.");
        return "redirect:/reservation/complete.do?rid=" + newId; // ✅ 쿼리스트링으로 전달
    }

    @GetMapping("/reservation/complete.do")
    public String complete(@RequestParam(value = "rid", required = false) Integer rid,
                           HttpSession session,
                           Model model,
                           RedirectAttributes ra) {

        // ✅ rid 누락 시 세션에서 복구 (백업값)
        if (rid == null) {
            Object saved = session.getAttribute("lastReservationId");
            if (saved instanceof Integer) rid = (Integer) saved;
        }
        if (rid == null) {
            ra.addFlashAttribute("error", "잘못된 접근입니다. (예약번호 없음)");
            return "redirect:/reservation/my.do";
        }

        // (기존) 로그인/게스트에서 patientNo 확보
        Integer patientNo = null;
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser instanceof com.hospital.vo.PatientVO) {
            patientNo = ((com.hospital.vo.PatientVO) loginUser).getPatientNo();
        } else if (session.getAttribute("guestPatientNo") != null) {
            patientNo = (Integer) session.getAttribute("guestPatientNo");
        }
        if (patientNo == null) {
            ra.addFlashAttribute("error", "로그인이 만료되었거나 게스트 정보가 없습니다.");
            return "redirect:/reservation/my.do";
        }

        ReservationVO reservation = reservationService.getReservationForComplete(rid, patientNo);
        if (reservation == null) {
            ra.addFlashAttribute("error", "해당 예약을 찾을 수 없습니다.");
            return "redirect:/reservation/my.do";
        }

        model.addAttribute("reservation", reservation);
        return "/patient/reservation-complete"; // ✅ JSP 파일명이 reservation_complete.jsp라면 이렇게
        // return "reservation-complete"; // JSP가 하이픈 파일명이라면 이걸로 유지
    }

    /* ================[ 회원/비회원 공통: 환자번호 조회 & 리다이렉트 헬퍼 ]================== */

    // ✅ 로그인 환자 또는 비회원(guestPatientNo) 중 하나라도 있으면 환자번호 반환
    private Integer getSessionPatientNo(HttpSession session){
        Object u = session.getAttribute("loginUser");
        if (u instanceof com.hospital.vo.PatientVO) {
            return ((com.hospital.vo.PatientVO) u).getPatientNo();
        }
        Object g = session.getAttribute("guestPatientNo");
        if (g instanceof Integer) {
            return (Integer) g;
        }
        return null;
    }

    // ✅ 목록으로 돌아갈 때 로그인/게스트에 따라 분기 (게스트는 전용 목록으로)
    private String redirectBackToList(HttpSession session){
        Object u = session.getAttribute("loginUser");
        if (u instanceof com.hospital.vo.PatientVO) {
            return "redirect:/reservation/my.do";
        }
        if (session.getAttribute("guestPatientNo") != null) {
            return "redirect:/reservation/guest/list.do";
        }
        return "redirect:/reservation/guest-start.do";
    }

    /* ================[ 예약 내역/변경/취소/삭제 ]================== */

    /** 목록 (회원 전용) — 항상 '대기'만 */
    @GetMapping("/reservation/my.do")
    public String myList(@RequestParam(required = false) String status,
                         HttpSession session, Model model) {
        Object u = session.getAttribute("loginUser");
        if (!(u instanceof com.hospital.vo.PatientVO)) {
            return "redirect:/loginSelector.do";
        }
        int patientNo = ((com.hospital.vo.PatientVO) u).getPatientNo();

        final String desiredStatus = "대기";
        List<ReservationVO> list = reservationService.getMyList(patientNo, desiredStatus);

        model.addAttribute("list", list);
        model.addAttribute("status", desiredStatus);
        model.addAttribute("guestMode", false);
        return "patient/reservation_list";
    }

    /** 비회원 전용 목록 — 항상 '대기'만 */
    @GetMapping("/reservation/guest/list.do")
    public String guestList(@RequestParam(required = false) String status,
                            HttpSession session, Model model) {

        // 회원이면 회원 목록으로 리다이렉트 (거기서도 '대기'만 표시)
        Object login = session.getAttribute("loginUser");
        if (login instanceof com.hospital.vo.PatientVO) {
            return "redirect:/reservation/my.do";
        }

        Integer guestNo = (Integer) session.getAttribute("guestPatientNo");
        if (guestNo == null) {
            return "redirect:/reservation/guest-start.do";
        }

        final String desiredStatus = "대기";
        List<ReservationVO> list = reservationService.getMyList(guestNo, desiredStatus);

        model.addAttribute("list", list);
        model.addAttribute("status", desiredStatus);
        model.addAttribute("guestMode", true);
        model.addAttribute("guestName", session.getAttribute("guestPatientName"));
        return "patient/reservation_list";
    }


    /** 수정 (모달/칩 UI에서 넘어옴) */
    @PostMapping("/reservation/{id}/update.do")
    public String update(@PathVariable("id") long id,
                         @RequestParam String department,          // 표시용 명칭 (혹은 deptId를 쓰면 더 명확)
                         @RequestParam String doctorId,
                         @RequestParam String reservationDate,     // yyyy-MM-dd
                         @RequestParam String scheduleTime,        // HH:mm
                         @RequestParam(required=false) Long scheduleId,
                         HttpSession session, RedirectAttributes ra){
        Integer patientNo = getSessionPatientNo(session);
        if (patientNo == null) return "redirect:/reservation/guest-start.do";

        // scheduleId가 비어 있으면 doctorId+date+time으로 찾기(권장)
        if (scheduleId == null) {
            Long found = reservationService.findScheduleIdByDoctorDateTime(doctorId, reservationDate, scheduleTime);
            if (found != null) scheduleId = found;
        }

        boolean ok = reservationService.updateMyReservation(
                patientNo, id, department, doctorId, reservationDate, scheduleTime, scheduleId, "대기");
        ra.addFlashAttribute(ok ? "msg" : "error", ok ? "수정되었습니다." : "수정 실패");
        return redirectBackToList(session);
    }

    /** 취소(상태 변경) */
    @PostMapping("/reservation/{id}/cancel.do")
    public String cancel(@PathVariable("id") long id,
                         HttpSession session, RedirectAttributes ra){
        Integer patientNo = getSessionPatientNo(session);
        if (patientNo == null) return "redirect:/reservation/guest-start.do";
        boolean ok = reservationService.cancelMyReservation(patientNo, id);
        ra.addFlashAttribute(ok ? "msg" : "error", ok ? "취소되었습니다." : "취소할 수 없습니다.");
        return redirectBackToList(session);
    }

    

    @GetMapping("/api/ping.do")
    @ResponseBody
    public Map<String,Object> ping(){
        Map<String,Object> m = new HashMap<>();
        m.put("ok", true);
        m.put("now", new java.util.Date());
        return m;
    }

    /* ===================== 비회원: 이름+주민번호 제출 -> 환자 생성/재사용 -> 예약/목록으로 ===================== */
    @GetMapping("/reservation/guest-start.do")
    public String guestStartForm() {
        return "patient/guest_start";
    }

    @PostMapping("/reservation/guest-start.do")
    public String guestStartSubmit(@RequestParam("name") String name,
                                   @RequestParam("rrn") String rrn,
                                   @RequestParam(value="mode", required=false, defaultValue="book") String mode,
                                   HttpSession session,
                                   RedirectAttributes ra,
                                   org.springframework.ui.Model model) {

        // 0) RRN 정규화(하이픈/공백 제거) + 형식검사
        final String cleanRrn = (rrn == null) ? "" : rrn.replaceAll("[^0-9]", "");
        if (!cleanRrn.matches("^\\d{13}$")) {
            ra.addFlashAttribute("error", "주민번호는 13자리 숫자여야 합니다.");
            return "redirect:/reservation/guest-start.do";
        }
        final String cleanName = (name == null) ? "" : name.trim();
        if (cleanName.isEmpty()) {
            ra.addFlashAttribute("error", "이름을 입력해 주세요.");
            return "redirect:/reservation/guest-start.do";
        }

        try {
            // 1) 해당 RRN이 정회원이면 즉시 차단
            int regCnt = reservationService.countRegisteredByRrn(cleanRrn);
            if (regCnt > 0) {
                ra.addFlashAttribute("error", "이미 가입되어있는 회원입니다.");
                return "redirect:/reservation/guest-start.do";
            }

            // 2) 해당 RRN이 기존(게스트)으로 존재하면 이름 일치 확인
            PatientVO existing = reservationService.findPatientByRrn(cleanRrn);
            if (existing != null) {
                if (!cleanName.equals(existing.getPatientName())) {
                    ra.addFlashAttribute("error", "이름과 주민등록번호가 일치하지 않습니다. 정보를 정확히 입력해 주세요.");
                    return "redirect:/reservation/guest-start.do";
                }
                // (이름 일치) → 기존 게스트 재사용
                session.setAttribute("guestPatientNo",   existing.getPatientNo());
                session.setAttribute("guestPatientName", existing.getPatientName());
            } else {
                // 3) 신규 게스트 생성 경로(기존 로직 그대로)
                PatientVO guest = reservationService.getOrCreateGuestPatient(cleanName, cleanRrn);
                session.setAttribute("guestPatientNo",   guest.getPatientNo());
                session.setAttribute("guestPatientName", guest.getPatientName());
            }

        } catch (IllegalStateException e) {
            // (방어) 서비스에서 정회원 감지 시
            ra.addFlashAttribute("error", e.getMessage()); // "이미 가입되어있는 회원입니다."
            return "redirect:/reservation/guest-start.do";
        } catch (DuplicateKeyException e) {
            // (방어) 유니크 위반 등
            ra.addFlashAttribute("error", "이미 가입되어있는 회원입니다.");
            return "redirect:/reservation/guest-start.do";
        }

        return "list".equalsIgnoreCase(mode)
                ? "redirect:/reservation/guest/list.do"
                : "redirect:/reservation.do";
    }

    /* ===================== 예약 화면 게이트: 회원 또는 게스트만 통과 ===================== */
    @GetMapping("/reservation.do")
    public String reservationPage(HttpSession session, HttpServletRequest request) {
        Object u = session.getAttribute("loginUser");
        Object g = session.getAttribute("guestPatientNo");
        
        System.out.println("[RESV] " + request.getMethod() + " " + request.getRequestURI()
        + "@" + System.identityHashCode(request)
        + " loginUser=" + (u==null? "null" : u.getClass().getName())
        + ", guestPatientNo=" + (g==null? "null" : (g + " (" + g.getClass().getName() + ")")));
        
        // 1) 로그인 환자면 통과
        if (u instanceof com.hospital.vo.PatientVO) {
            return "patient/reservation";
        }
        // 2) 비회원 게스트 세션이 있으면 통과
        if (g instanceof Integer) {
            return "patient/reservation";
        }
        // 3) 아무 세션도 없으면 막기
        return "redirect:/reservation/guest-start.do";
    }
    
    @PostMapping("/questionnaire/start.do")
    public String questionnaireStart(
            @RequestParam("deptId")          String deptId,
            @RequestParam("doctorId")        String doctorId,
            @RequestParam("scheduleId")      String scheduleId,
            @RequestParam("reservationDate") String reservationDate,
            @RequestParam("reservationTime") String reservationTime,
            @RequestParam(value="status", required=false, defaultValue="BOOKED") String status,
            org.springframework.ui.Model model) {

        model.addAttribute("deptId", deptId);
        model.addAttribute("doctorId", doctorId);
        model.addAttribute("scheduleId", scheduleId);
        model.addAttribute("reservationDate", reservationDate);
        model.addAttribute("reservationTime", reservationTime);
        model.addAttribute("status", status);
        return "patient/questionnaire_start";
    }

    @PostMapping("/questionnaire/save-and-reserve.do")
    public String saveQuestionnaireAndReserve(
            HttpSession session,
            @RequestParam(value="department", required=false) String department, // 부서명(문자열)
            @RequestParam(value="deptId",     required=false) String deptId,    // 선택적
            @RequestParam("doctorId")         String doctorId,
            @RequestParam("scheduleId")       Long scheduleId,
            @RequestParam("reservationDate")  String reservationDate,            // yyyy-MM-dd
            @RequestParam("reservationTime")  String reservationTime,            // HH:mm
            @RequestParam(value="status", required=false, defaultValue="대기") String status,
            @RequestParam("content")          String content,
            RedirectAttributes ra) {

        // 0) 환자번호 확보 (로그인 > 비회원 세션)
        Integer patientNo = null;
        Object login = session.getAttribute("loginUser");
        if (login instanceof com.hospital.vo.PatientVO) {
            patientNo = ((com.hospital.vo.PatientVO) login).getPatientNo();
        } else {
            Object g = session.getAttribute("guestPatientNo");
            if (g instanceof Integer) patientNo = (Integer) g;
        }
        if (patientNo == null) {
            ra.addFlashAttribute("error", "세션이 만료되었습니다. 다시 진행해 주세요.");
            return "redirect:/reservation/guest-start.do";
        }

        // 1) 부서명 보완 (없으면 doctorId → USERS, 그래도 없으면 deptId → DEPARTMENTS)
        if (department == null || department.trim().isEmpty()) {
            String deptName = reservationService.findDepartmentNameByDoctorId(doctorId);
            if (deptName == null && deptId != null) {
                deptName = reservationService.findDepartmentNameByDeptId(deptId);
            }
            department = (deptName != null) ? deptName : "";
        }

        // 2) 문진표 + 예약 저장 (Service 시그니처와 순서/타입 일치)
        long reservationId = reservationService.saveQuestionnaireAndReserve(
                patientNo,            // Integer
                department,           // String (DEPARTMENT 컬럼)
                doctorId,             // String
                scheduleId,           // Long
                reservationDate,      // String "yyyy-MM-dd"
                reservationTime,      // String "HH:mm"
                status,               // "BOOKED" 등
                content               // CLOB
        );

        ra.addFlashAttribute("msg", "문진표와 예약이 저장되었습니다. (예약번호: " + reservationId + ")");
        ra.addFlashAttribute("reservationId", reservationId);
        session.setAttribute("lastReservationId", (int) reservationId); // ✅ 백업
        return "redirect:/reservation/complete.do?rid=" + reservationId; // ✅ 쿼리스트링으로 전달
    }

    @PostMapping("/reservation/{reservationId}/delete.do")
    public String softCancel(@PathVariable("reservationId") long reservationId,
                             HttpSession session,
                             RedirectAttributes ra) {
        try {
            reservationService.cancelReservation(reservationId); // ✔ 상태만 '취소'로
            ra.addFlashAttribute("msg", "예약이 취소되었습니다.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "취소 중 오류: " + e.getMessage());
        }
        return redirectBackToList(session); // ✔ 회원: /reservation/my.do, 게스트: /reservation/guest/list.do
    }

    
    
}
