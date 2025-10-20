package com.hospital.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hospital.service.AdminService;
import com.hospital.service.DoctorService;
import com.hospital.service.EventService;
import com.hospital.service.PatientService;
import com.hospital.service.RecordService;
import com.hospital.service.ReferralService;
import com.hospital.service.ReservationService;
import com.hospital.service.UserActivityLogService;
import com.hospital.service.UserService;
import com.hospital.util.SHA512Util;
import com.hospital.util.TimeUtil;
import com.hospital.vo.AdminVO;
import com.hospital.vo.BoardStatVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.EventVO;
import com.hospital.vo.FeedbackVO;
import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.PatientVO;
import com.hospital.vo.PendingUserVO;
import com.hospital.vo.ReferralRequestVO;
import com.hospital.vo.ReservationVO;
import com.hospital.vo.UserActivityLogVO;
import com.hospital.vo.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private PatientService patientService;

	@Autowired
	private UserService userService;

	@Autowired
	private ReservationService reservationService;

	@Autowired
	private RecordService recordService;

	@Autowired
	private DoctorService doctorService;

	@Autowired
	private AdminService adminService;

	@Autowired
	private ReferralService referralService;

	@Autowired
	private EventService eventService;

	@Autowired
	private UserActivityLogService logService;

	// 대쉬보드 전체 출력 정리
	@GetMapping("/dashboard.do")
	   public String showDashboard(Model model, HttpSession session) {
	      AdminVO loginAdmin = (AdminVO) session.getAttribute("loginAdmin");
	      if (loginAdmin == null) {
	         return "redirect:/admin/logoutSession.do";
	      }
	      try {
	         // 기본 통계
	         model.addAttribute("patientCount", patientService.countPatients());
	         model.addAttribute("doctorCount", doctorService.countDoctors());
	         model.addAttribute("pendingCount", userService.countPendingUsers());
	         model.addAttribute("pendingDoctors", userService.countPendingUsersByRole("doctor"));
	         model.addAttribute("pendingNurses", userService.countPendingUsersByRole("nurse"));
	         model.addAttribute("pendingCoops", userService.countPendingUsersByRole("coop"));
	         model.addAttribute("todayReservationCount", reservationService.countTodayReservations());

	         // 진료 의뢰 회신률
	         int totalReferrals = adminService.getTotalReferralCount();
	         int repliedReferrals = adminService.getRepliedReferralCount();
	         double replyRate = (totalReferrals > 0) ? ((double) repliedReferrals / totalReferrals) * 100 : 0;
	         model.addAttribute("referralReplyRate", Math.round(replyRate));
	         model.addAttribute("repliedReferrals", repliedReferrals);
	         model.addAttribute("totalReferrals", totalReferrals);

	         // 피드백 상태별 건수 및 리스트
	         int received = adminService.countFeedbackByStatus("접수");
	         int completed = adminService.countFeedbackByStatus("답변완료");
	         int total = received + completed;
	         int feedbackRate = (total > 0) ? (int) ((completed * 100.0) / total) : 0;

	         model.addAttribute("feedbackReceived", received);
	         model.addAttribute("feedbackCompleted", completed);
	         model.addAttribute("feedbackRate", feedbackRate);

	         List<FeedbackVO> receivedList = adminService.getRecentFeedbacksByStatus("접수");
	         List<FeedbackVO> repliedList = adminService.getRecentFeedbacksByStatus("답변완료");
	         List<FeedbackVO> pendingList = adminService.getRecentFeedbacksByStatus("미처리");

	         for (FeedbackVO fb : receivedList) {
	            fb.setRelativeTime(TimeUtil.formatRelativeTime(fb.getCreatedAt()));
	         }
	         for (FeedbackVO fb : repliedList) {
	            fb.setRelativeTime(TimeUtil.formatRelativeTime(fb.getCreatedAt()));
	         }
	         for (FeedbackVO fb : pendingList) {
	            fb.setRelativeTime(TimeUtil.formatRelativeTime(fb.getCreatedAt()));
	         }

	         model.addAttribute("receivedList", receivedList);
	         model.addAttribute("repliedList", repliedList);
	         model.addAttribute("pendingList", pendingList);

	         // 최근 7일 예약 추이 (누락 날짜는 0으로 처리)
	         List<ReservationVO> rawStats = adminService.getReservationStatsLast7Days();

	         // 1. 최근 7일 날짜 목록 생성
	         DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	         LocalDate today = LocalDate.now();
	         List<String> last7Dates = new ArrayList<>();
	         for (int i = 6; i >= 0; i--) {
	             last7Dates.add(today.minusDays(i).format(formatter));
	         }

	         // 2. 기존 결과를 Map으로 변환
	         Map<String, Integer> statMap = new HashMap<>();
	         for (ReservationVO stat : rawStats) {
	             statMap.put(stat.getResvDate(), stat.getResvCount());
	         }

	         // 3. 날짜 기준으로 채워진 리스트 생성
	         List<ReservationVO> paddedStats = new ArrayList<>();
	         for (String date : last7Dates) {
	             ReservationVO vo = new ReservationVO();
	             vo.setResvDate(date);
	             vo.setResvCount(statMap.getOrDefault(date, 0));
	             paddedStats.add(vo);
	         }

	         model.addAttribute("reservationStats", paddedStats);

	         // 게시판 통계 (링크는 JSP에서 처리)
	         List<BoardStatVO> stats = adminService.getBoardPostStats();

	         // 기타 제거
	         List<BoardStatVO> filteredStats = stats.stream()
	               .filter(stat -> stat.getCategory() != null && !"기타".equals(stat.getCategory()))
	               .collect(Collectors.toList());

	         model.addAttribute("boardStats", filteredStats);

	      } catch (Exception e) {
	         System.out.println("대시보드 오류: " + e.getMessage());
	      }
	      return "admin/admin_dashboard";
	   }
	// 환자 전체 목록 조회
	@GetMapping("/patientList.do")
	public String patientList(Model model, HttpSession session) {
		AdminVO loginAdmin = (AdminVO) session.getAttribute("loginAdmin");
		if (loginAdmin == null) {
			return "redirect:/admin/logoutSession.do"; // ← 변경
		}
		List<PatientVO> list = patientService.getAllPatients();
		model.addAttribute("patientList", list);
		return "admin/admin_patient_manage";
	}

	// 환자 검색
	@GetMapping("/patientSearch.do")
	public String searchPatients(@RequestParam("keyword") String keyword, Model model) {
		List<PatientVO> patients = patientService.searchPatients(keyword);
		model.addAttribute("patientList", patients);
		return "admin/admin_patient_manage";
	}

	// ✅ 관리자 강제 삭제(확인/비번검증 없음) → 비회원 형태로 축소
	@PostMapping("/adminForceDelete.do")
	public String adminForceDelete(@RequestParam("patientNo") int patientNo, HttpSession session,
			RedirectAttributes ra) {
		AdminVO admin = (AdminVO) session.getAttribute("loginAdmin");
		if (admin == null) {
			return "redirect:/admin/logoutSession.do";
		}
		boolean ok = patientService.stripToGuest(patientNo);
		ra.addFlashAttribute(ok ? "msg" : "error", ok ? "삭제(익명화) 완료" : "대상 없음");
		return "redirect:/admin/patientList.do";
	}

	// 환자 상세
	@GetMapping("/patientDetail.do")
	public String viewPatientDetail(@RequestParam("patientNo") int patientNo, Model model) {
		PatientVO patient = patientService.getPatientByNo(patientNo);
		model.addAttribute("patient", patient);
		return "admin/patient_detail";
	}

	// 예약 내역 조회
	@GetMapping("/patientReservations.do")
	public String viewPatientReservations(@RequestParam("patientNo") int patientNo, Model model) {
		List<ReservationVO> reservationList = reservationService.getReservationsByPatientNo(patientNo);
		model.addAttribute("reservationList", reservationList);
		return "admin/patient_reservations"; // JSP 이름
	}

	// 진료 기록 조회
	@GetMapping("/patientRecords.do")
	public String viewPatientRecords(@RequestParam("patientNo") int patientNo, Model model) {
		List<MedicalRecordVO> recordList = recordService.getRecordsByPatientNo(patientNo);
		model.addAttribute("recordList", recordList);
		return "admin/patient_records"; // JSP 이름
	}

	// 승인 대기 목록
	@GetMapping("/pendingAll.do")
	public String showAllPendingUsers(Model model) {
		List<PendingUserVO> list = userService.getAllPendingUsers();
		model.addAttribute("pendingUsers", list);
		model.addAttribute("showFilterButtons", true); // 필터 버튼 보이기
		return "admin/pending_list";
	}

	@GetMapping("/pendingList.do")
	public String showPendingOnly(Model model) {
		List<PendingUserVO> list = userService.getPendingUserList();
		model.addAttribute("pendingUsers", list);
		model.addAttribute("showFilterButtons", false); // 필터 버튼 숨기기
		return "admin/pending_list";
	}

	@GetMapping("/pendingFilter.do")
	public String filterPendingUsers(@RequestParam(required = false) String status, Model model) {
		List<PendingUserVO> list;

		if (status == null || status.isEmpty()) {
			list = userService.getAllPendingUsers(); // 전체
		} else {
			list = userService.getPendingUsersByStatus(status); // 상태별 조회
		}
		model.addAttribute("pendingUsers", list);
		model.addAttribute("showFilterButtons", true); // ✅ 여기 추가!
		return "admin/pending_list";
	}

	// 가입 승인 처리
	@PostMapping("/approveUser.do")
	public String approveUser(@RequestParam String userId, HttpSession session, RedirectAttributes ra) {
		AdminVO admin = (AdminVO) session.getAttribute("loginAdmin");
		if (admin == null) {
			return "redirect:/admin/logoutSession.do";
		}
		String adminIdHash = admin.getAdminId(); // 세션에 해시 저장되어 있어야 FK 일치
		boolean ok = adminService.approveUser(userId, adminIdHash);
		ra.addFlashAttribute(ok ? "msg" : "error", ok ? "승인 완료" : "대상 없음/이미 승인됨");
		return "redirect:/admin/pendingList.do";
	}

	// 가입 반려 처리
	@PostMapping("/rejectUser.do")
	public String rejectUser(@RequestParam("userId") String userId,
			@RequestParam(value = "rejectReason", required = false) String rejectReason, HttpSession session,
			RedirectAttributes ra) {
		AdminVO admin = (AdminVO) session.getAttribute("loginAdmin");
		if (admin == null) {
			return "redirect:/admin/logoutSession.do";
		}
		String adminIdHash = admin.getAdminId(); // 세션에 해시가 들어있어야 FK 통과
		String reason = (rejectReason == null || rejectReason.trim().isEmpty()) ? "사유 미입력" : rejectReason.trim();

		System.out.println("[rejectUser] userId=" + userId + ", adminIdHash=" + adminIdHash + ", reason=" + reason);
		int n = adminService.rejectUser(userId, reason, adminIdHash);
		System.out.println("[rejectUser] updated rows = " + n);

		ra.addFlashAttribute(n > 0 ? "msg" : "error", n > 0 ? "반려 처리" : "대상 없음/이미 승인됨");
		return "redirect:/admin/pendingList.do";
	}

	// ✅ 되돌리기(반려→대기)
	@PostMapping("/undoStatus.do")
	public String undoPendingStatus(@RequestParam("userId") String userId, RedirectAttributes ra) {
		int n = adminService.undoPendingStatus(userId);
		ra.addFlashAttribute(n > 0 ? "msg" : "error", n > 0 ? "대기상태로 복구" : "대상 없음");
		return "redirect:/admin/pendingAll.do";
	}

	@GetMapping("/searchPendingUsers.do")
	public String searchPendingUsers(@RequestParam("keyword") String keyword, Model model) {
		List<PendingUserVO> result = userService.searchPendingUsers(keyword);
		model.addAttribute("pendingUsers", result);
		model.addAttribute("showFilterButtons", true); // 검색 결과도 필터 보이게
		return "admin/pending_list";
	}

	@GetMapping("/coopList.do")
	public String showCoopUsers(Model model, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int size) {
		int total = userService.getCoopUserCount();
		int start = (page - 1) * size;

		List<UserVO> coopUsers = userService.getPagedCoopUsers(start, size);

		int totalPages = (int) Math.ceil((double) total / size);

		model.addAttribute("coopUsers", coopUsers);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);

		return "admin/coop_user_list";
	}

	@GetMapping("/searchCoopUsers.do")
	public String searchCoopUsers(@RequestParam("keyword") String keyword, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "5") int size, Model model) {
		int total = userService.countSearchCoopUsers(keyword);
		int start = (page - 1) * size;
		List<UserVO> coopUsers = userService.searchPagedCoopUsers(keyword, start, size);
		int totalPages = (int) Math.ceil((double) total / size);

		model.addAttribute("coopUsers", coopUsers);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("keyword", keyword); // 검색어 유지

		return "admin/coop_user_list";
	}

	@PostMapping("/deleteCoopUser.do")
	public String deleteCoopUser(@RequestParam("userId") String userId) {
		userService.deleteUserById(userId);
		return "redirect:/admin/coopList.do";
	}

	@GetMapping("/coopDetail.do")
	public String viewCoopUserDetail(@RequestParam("userId") String userId, Model model) {
		UserVO user = userService.getUserById(userId);
		model.addAttribute("coopUser", user);
		return "admin/coop_user_detail"; // JSP 파일명
	}

	// 전체 협진 목록 확인
	@GetMapping("/allReferrals.do")
	public String viewAllReferrals(@RequestParam(value = "status", required = false) String status,
			@RequestParam(value = "sort", defaultValue = "created_at") String sort,
			@RequestParam(value = "order", defaultValue = "desc") String order, Model model, HttpSession session) {

		AdminVO loginAdmin = (AdminVO) session.getAttribute("loginAdmin");
		if (loginAdmin == null) {
			return "redirect:/admin/logoutSession.do"; // ← 변경
		}

		List<ReferralRequestVO> referrals = referralService.getReferralsSorted(status, sort, order);

		model.addAttribute("referrals", referrals);
		model.addAttribute("status", status);
		model.addAttribute("sort", sort);
		model.addAttribute("order", order);

		return "admin/coop_all_list";
	}

	// 협진 검색
	@GetMapping("/searchReferrals.do")
	public String searchReferrals(@RequestParam("keyword") String keyword, Model model, HttpSession session) {
		AdminVO loginAdmin = (AdminVO) session.getAttribute("loginAdmin");
		if (loginAdmin == null) {
			return "redirect:/admin/logoutSession.do";
		}

		List<ReferralRequestVO> referrals = referralService.getReferralsByKeyword(keyword);
		model.addAttribute("referrals", referrals);
		model.addAttribute("keyword", keyword);
		return "admin/coop_all_list";
	}

	// 협진 목록 엑셀 추가
	@GetMapping("/exportReferralsExcel.do")
	public void exportReferralsExcel(HttpServletResponse response) throws IOException {
		List<ReferralRequestVO> referrals = referralService.getAllReferrals();

		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("협진내역");

		String[] headers = { "요청 ID", "의뢰자 ID", "병원명", "협력의 이름", "환자명", "연락처", "진료과", "담당의사", "희망일", "상태", "요청일" };

		Row headerRow = sheet.createRow(0);
		for (int i = 0; i < headers.length; i++) {
			headerRow.createCell(i).setCellValue(headers[i]);
		}

		int rowNum = 1;
		for (ReferralRequestVO r : referrals) {
			Row row = sheet.createRow(rowNum++);
			row.createCell(0).setCellValue(r.getRequestId());
			row.createCell(1).setCellValue(r.getUserId());
			row.createCell(2).setCellValue(r.getHospitalName() != null ? r.getHospitalName() : "");
			row.createCell(3).setCellValue(r.getUserName() != null ? r.getUserName() : "");
			row.createCell(4).setCellValue(r.getPatientName());
			row.createCell(5).setCellValue(r.getContact());
			row.createCell(6).setCellValue(r.getDepartment());
			row.createCell(7).setCellValue(r.getDoctorId());
			row.createCell(8).setCellValue(
					r.getHopeDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(r.getHopeDate()) : "");
			row.createCell(9).setCellValue(r.getStatus());
			row.createCell(10).setCellValue(
					r.getCreatedAt() != null ? new SimpleDateFormat("yyyy-MM-dd").format(r.getCreatedAt()) : "");
		}

		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=referral_list.xlsx");

		workbook.write(response.getOutputStream());
		workbook.close();
	}

	@GetMapping("/register.do")
	public String showAdminRegisterForm(HttpSession session) {
		AdminVO loginAdmin = (AdminVO) session.getAttribute("loginAdmin");
		if (loginAdmin == null) {
			return "redirect:/admin/logoutSession.do";
		}
		return "admin/admin_register";
	}

	@PostMapping("/register.do")
	public String registerAdmin(@ModelAttribute AdminVO vo, Model model, HttpSession session) {
		AdminVO loginAdmin = (AdminVO) session.getAttribute("loginAdmin");
		if (loginAdmin == null) {
			return "redirect:/user/selectForm.do";
		}

		// 암호화
		vo.setAdminId(SHA512Util.encrypt(vo.getAdminId()));
		vo.setPassword(SHA512Util.encrypt(vo.getPassword()));

		try {
			adminService.insertAdmin(vo);
			model.addAttribute("success", "관리자 등록 완료");
		} catch (Exception e) {
			model.addAttribute("error", "등록 실패: " + e.getMessage());
		}

		return "admin/admin_register";
	}

	@GetMapping("/logoutSession.do")
	public void logoutSession(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException {
		if (session != null)
			session.invalidate();

		String url = request.getContextPath() + "/main.do"; // ← 두 번째 이미지 페이지
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write("<script>try{top.location.replace('" + url + "');}catch(e){window.location.href='"
				+ url + "';}</script>");
	}

	@GetMapping("/boardManage.do")
	public String showBoardManagePage() {
		return "admin/board_manage"; // ← JSP 경로
	}

	// 유저 역할 수정
	@PostMapping("/updateUserRole.do")
	public String updateUserRole(@RequestParam String userId, @RequestParam String role) {
		adminService.updateUserRole(userId, role);
		return "redirect:/admin/permission.do";
	}

	@GetMapping("/permission.do")
	public String showPermissionPage(Model model) {
		List<UserVO> userList = adminService.getAllUsers();
		model.addAttribute("userList", userList);
		return "admin/permission";
	}

	@GetMapping("/reservationCalendar.do")
	public String showReservationCalendar(@RequestParam(required = false) String month, Model model) {
		if (month == null) {
			month = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));
		}
		List<ReservationVO> summaryList = adminService.getReservationSummaryByDateRange();
		model.addAttribute("summaryList", summaryList);
		model.addAttribute("month", month);
		return "admin/reservation_calendar";
	}

	@GetMapping("/reservations/viewByDate.do")
	public String showReservationsByDate(@RequestParam String date, Model model) {
		List<ReservationVO> list = adminService.getReservationsByDate(date);
		model.addAttribute("date", date);
		model.addAttribute("reservationList", list);
		return "admin/reservations_by_date";
	}

	@PostMapping("/cancelReservation.do")
	public String cancelReservation(@RequestParam("reservationId") int reservationId,
			@RequestParam("date") String date) {
		reservationService.updateReservationStatus(reservationId, "취소");
		return "redirect:/admin/reservations/viewByDate.do?date=" + date;
	}

	@GetMapping("/reservations/exportExcel.do")
	public void exportReservationsToExcel(@RequestParam String date, HttpServletResponse response) throws IOException {
		List<ReservationVO> list = adminService.getReservationsByDate(date);

		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("예약목록_" + date);
		Row headerRow = sheet.createRow(0);

		// ✅ 헤더에 "시간대" 컬럼 추가
		String[] headers = { "시간대", "시간", "환자명", "연락처", "의사명", "진료과", "상태" };
		for (int i = 0; i < headers.length; i++) {
			Cell cell = headerRow.createCell(i);
			cell.setCellValue(headers[i]);
		}

		int rowNum = 1;
		for (ReservationVO res : list) {
			Row row = sheet.createRow(rowNum++);

			// ✅ 오전/오후 판단 (시간 문자열 기준)
			String timeStr = res.getScheduleTime(); // 예: "09:30:00"
			String amPm = "오후";
			try {
				int hour = Integer.parseInt(timeStr.substring(0, 2));
				if (hour < 12) {
					amPm = "오전";
				}
			} catch (Exception e) {
				amPm = "-";
			}

			row.createCell(0).setCellValue(amPm); // 시간대
			row.createCell(1).setCellValue(timeStr); // 시간
			row.createCell(2).setCellValue(res.getPatientName());
			row.createCell(3).setCellValue(res.getPatientPhone());
			row.createCell(4).setCellValue(res.getDoctorName());
			row.createCell(5).setCellValue(res.getDepartmentName());
			row.createCell(6).setCellValue(res.getStatus());
		}

		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=reservations_" + date + ".xlsx");

		workbook.write(response.getOutputStream());
		workbook.close();
	}

	// 언론보도 관리
	@GetMapping("/pressManage.do")
	public String pressManage(Model model) {
		List<EventVO> pressList = eventService.getEventsByCategory("언론");
		model.addAttribute("pressList", pressList);
		return "admin/press_manage"; // /WEB-INF/jsp/admin/press_manage.jsp
	}

	// 대시보드 헬퍼 메소드
	private String getUrlByCategory(String category) {
		switch (category) {
		case "언론보도":
			return "pressManage.do";
		case "채용공고":
			return "recruitManage.do";
		case "병원소식":
			return "newsManage.do";
		case "공지사항":
			return "noticeManage.do";
		case "강좌/행사":
			return "eventManage.do";
		case "FAQ":
			return "faqManage.do";
		case "고객의 소리":
			return "feedbackManage.do";
		case "칭찬 릴레이":
			return "praiseManage.do";
		default:
			return "#";
		}
	}

}
