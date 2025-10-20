package com.hospital.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.hospital.service.DoctorScheduleService;
import com.hospital.service.DoctorService;
import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.ReservationVO;

@Controller
@RequestMapping("/admin")
public class DoctorController {

	@Autowired
	private DoctorService doctorService;

	@Autowired
	private DoctorScheduleService doctorScheduleService;

	// 한 페이지에 보여줄 개수 (원하면 섹션별로 다르게 둬도 됩니다)
	private static final int SCHEDULE_PAGE_SIZE = 5;
	private static final int RECORD_PAGE_SIZE = 5;
	private static final int RESERVATION_PAGE_SIZE = 5;
	
	// 블록당 표시할 페이지 개수
	private static final int PAGE_BLOCK = 10;

	// 의사 목록
	@GetMapping("/doctorList.do")
	public String doctorList(Model model) {
		List<DoctorVO> list = doctorService.getAllDoctors();
		List<DepartmentVO> deptList = doctorService.getAllDepartments();
		model.addAttribute("doctorList", list);
		model.addAttribute("deptList", deptList);
		return "admin/admin_doctor_manage";
	}

	// 과별 의사 목록
	@ResponseBody
	@GetMapping(value = "/getDoctorsByDept.do", produces = "application/json; charset=UTF-8")
	public List<DoctorVO> getDoctorsByDept(@RequestParam("deptId") String deptId) {
		return doctorService.getDoctorsByDept(deptId);
	}

	// 검색
	@GetMapping("/doctorSearch.do")
	public String searchDoctors(@RequestParam("keyword") String keyword, Model model) {
		List<DoctorVO> list = doctorService.searchDoctors(keyword);
		List<DepartmentVO> deptList = doctorService.getAllDepartments();
		model.addAttribute("doctorList", list);
		model.addAttribute("deptList", deptList);
		return "admin/admin_doctor_manage";
	}

	// 의사 수정
	@PostMapping("/updateDoctor.do")
	public String updateDoctor(DoctorVO doctor) {
		doctorService.updateDoctor(doctor);
		return "redirect:/admin/doctorList.do";
	}

	// 의사 삭제
	@PostMapping("/deleteDoctor.do")
	public String deleteDoctor(@RequestParam("doctorId") String doctorId) {
		doctorService.deleteDoctor(doctorId);
		return "redirect:/admin/doctorList.do";
	}

	// 의사 수정 폼
	@GetMapping("/editDoctorForm.do")
	public String editDoctorForm(@RequestParam("doctorId") String doctorId, Model model) {
		DoctorVO doctor = doctorService.getDoctorById(doctorId);
		List<DepartmentVO> deptList = doctorService.getAllDepartments();
		model.addAttribute("doctor", doctor);
		model.addAttribute("deptList", deptList);
		return "admin/edit_doctor_form";
	}

	// 진료과 변경
	@PostMapping("/updateDoctorDept.do")
	public String updateDoctorDept(@ModelAttribute DoctorVO doctor) {
		doctorService.updateDoctorDept(doctor);
		return "redirect:/admin/doctorList.do";
	}

	// 의사 상세 (서버측 페이징)
	@GetMapping("/doctorDetail.do")
	public String viewDoctorDetail(
	        @RequestParam("doctorId") String doctorId,
	        @RequestParam(value = "sPage", defaultValue = "1") int sPage,
	        @RequestParam(value = "rPage", defaultValue = "1") int rPage,
	        @RequestParam(value = "vPage", defaultValue = "1") int vPage,
	        Model model) {

	    DoctorVO doctor = doctorService.getDoctorById(doctorId);

	    List<DoctorScheduleVO> schedules    = safeList(doctorScheduleService.getSchedulesByDoctorId(doctorId));
	    List<MedicalRecordVO>  records      = safeList(doctorService.getRecordsByDoctorId(doctorId));
	    List<ReservationVO>    reservations = safeList(doctorService.getReservationsByDoctorId(doctorId));

	    Paging<DoctorScheduleVO> schPaging = paginate(schedules,    sPage, SCHEDULE_PAGE_SIZE);
	    Paging<MedicalRecordVO>  recPaging = paginate(records,      rPage, RECORD_PAGE_SIZE);
	    Paging<ReservationVO>    resPaging = paginate(reservations, vPage, RESERVATION_PAGE_SIZE);

	    model.addAttribute("doctor", doctor);

	    // 데이터 + 현재 페이지/전체 페이지
	    model.addAttribute("schedules",             schPaging.pageItems);
	    model.addAttribute("schedulePage",          schPaging.page);
	    model.addAttribute("scheduleTotalPages",    schPaging.totalPages);

	    model.addAttribute("records",               recPaging.pageItems);
	    model.addAttribute("recordPage",            recPaging.page);
	    model.addAttribute("recordTotalPages",      recPaging.totalPages);

	    model.addAttribute("reservations",          resPaging.pageItems);
	    model.addAttribute("reservationPage",       resPaging.page);
	    model.addAttribute("reservationTotalPages", resPaging.totalPages);

	    // ====== 여기 추가: 블록 계산 (10개씩) ======
	    int sBlockStart = ((schPaging.page - 1) / PAGE_BLOCK) * PAGE_BLOCK + 1;
	    int sBlockEnd   = Math.min(sBlockStart + PAGE_BLOCK - 1, schPaging.totalPages);
	    model.addAttribute("scheduleBlockStart", sBlockStart);
	    model.addAttribute("scheduleBlockEnd",   sBlockEnd);
	    model.addAttribute("scheduleHasPrev",    sBlockStart > 1);
	    model.addAttribute("scheduleHasNext",    sBlockEnd   < schPaging.totalPages);

	    int rBlockStart = ((recPaging.page - 1) / PAGE_BLOCK) * PAGE_BLOCK + 1;
	    int rBlockEnd   = Math.min(rBlockStart + PAGE_BLOCK - 1, recPaging.totalPages);
	    model.addAttribute("recordBlockStart", rBlockStart);
	    model.addAttribute("recordBlockEnd",   rBlockEnd);
	    model.addAttribute("recordHasPrev",    rBlockStart > 1);
	    model.addAttribute("recordHasNext",    rBlockEnd   < recPaging.totalPages);

	    int vBlockStart = ((resPaging.page - 1) / PAGE_BLOCK) * PAGE_BLOCK + 1;
	    int vBlockEnd   = Math.min(vBlockStart + PAGE_BLOCK - 1, resPaging.totalPages);
	    model.addAttribute("reservationBlockStart", vBlockStart);
	    model.addAttribute("reservationBlockEnd",   vBlockEnd);
	    model.addAttribute("reservationHasPrev",    vBlockStart > 1);
	    model.addAttribute("reservationHasNext",    vBlockEnd   < resPaging.totalPages);
	    // =========================================

	    return "admin/doctor_detail";
	}

	// 스케줄 삭제
	@PostMapping("/deleteSchedule.do")
	public String deleteSchedule(@RequestParam int scheduleId,
	                             @RequestParam String doctorId,
	                             @RequestParam(defaultValue = "1") int sPage,
	                             @RequestParam(defaultValue = "1") int rPage,
	                             @RequestParam(defaultValue = "1") int vPage,
	                             @RequestParam(defaultValue = "false") boolean force) {
	    doctorScheduleService.deleteSchedule(scheduleId, force); // ✅ force 값 전달
	    return "redirect:/admin/doctorDetail.do?doctorId=" + doctorId +
	           "&sPage=" + sPage + "&rPage=" + rPage + "&vPage=" + vPage + "#schedule";
	}

	// 스케줄 수정 처리
	@PostMapping("/updateSchedule.do")
	public String updateSchedule(@ModelAttribute DoctorScheduleVO schedule,
	                             @RequestParam(defaultValue = "1") int sPage,
	                             @RequestParam(defaultValue = "1") int rPage,
	                             @RequestParam(defaultValue = "1") int vPage) {
	    doctorScheduleService.updateSchedule(schedule);
	    return "redirect:/admin/doctorDetail.do?doctorId=" + schedule.getDoctorId() +
	           "&sPage=" + sPage + "&rPage=" + rPage + "&vPage=" + vPage + "#schedule";
	}

	// 스케줄 수정 폼 이동
	@GetMapping("/updateScheduleForm.do")
	public String updateScheduleForm(@RequestParam("scheduleId") int scheduleId, Model model) {
		DoctorScheduleVO schedule = doctorScheduleService.getScheduleById(scheduleId);
		model.addAttribute("schedule", schedule);
		model.addAttribute("mode", "update");
		return "admin/schedule_form";
	}

	// 스케줄 등록 폼 이동
	@GetMapping("/insertScheduleForm.do")
	public String insertScheduleForm(@RequestParam("doctorId") String doctorId, Model model) {
		DoctorScheduleVO schedule = new DoctorScheduleVO();
		schedule.setDoctorId(doctorId);
		model.addAttribute("schedule", schedule);
		model.addAttribute("mode", "insert");
		return "admin/schedule_form";
	}

	// 스케줄 등록 처리
	@PostMapping("/insertSchedule.do")
	public String insertSchedule(@ModelAttribute DoctorScheduleVO schedule,
	                             @RequestParam(defaultValue = "1") int sPage,
	                             @RequestParam(defaultValue = "1") int rPage,
	                             @RequestParam(defaultValue = "1") int vPage) {
	    doctorScheduleService.insertSchedule(schedule);
	    return "redirect:/admin/doctorDetail.do?doctorId=" + schedule.getDoctorId() +
	           "&sPage=" + sPage + "&rPage=" + rPage + "&vPage=" + vPage + "#schedule";
	}
	
	// 목록(JSON) - 날짜 기준
	@ResponseBody
	@GetMapping(value = "/schedule/list.do", produces = "application/json; charset=UTF-8")
	public List<DoctorScheduleVO> listSchedulesByDate(@RequestParam String doctorId,
	                                                  @RequestParam String date) {
	    // date: "yyyy-MM-dd"
	    return doctorScheduleService.getSchedulesByDoctorAndDate(doctorId, date);
	}

	// --------------------------------------------------------------------
	// 유틸
	private static <T> List<T> safeList(List<T> list) {
		return (list == null) ? Collections.emptyList() : list;
	}

	private static final class Paging<T> {
		final int page;
		final int totalPages;
		final List<T> pageItems;

		Paging(int page, int totalPages, List<T> items) {
			this.page = page;
			this.totalPages = totalPages;
			this.pageItems = items;
		}
	}

	private static <T> Paging<T> paginate(List<T> all, int page, int size) {
		if (size <= 0)
			size = 10;
		int total = all.size();
		int totalPages = (total == 0) ? 1 : (int) Math.ceil(total / (double) size);
		if (page < 1)
			page = 1;
		if (page > totalPages)
			page = totalPages;

		int from = (page - 1) * size;
		int to = Math.min(from + size, total);
		List<T> items = (from >= to) ? Collections.emptyList() : all.subList(from, to);

		return new Paging<>(page, totalPages, items);
	}
}
