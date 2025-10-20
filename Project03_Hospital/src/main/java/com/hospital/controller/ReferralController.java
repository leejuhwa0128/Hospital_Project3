package com.hospital.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hospital.service.DoctorService;
import com.hospital.service.NoticeService;
import com.hospital.service.ReferralService;
import com.hospital.util.SHA512Util;
import com.hospital.vo.AdminVO;
import com.hospital.vo.PartnerHospitalVO;
import com.hospital.vo.ReferralCommentVO;
import com.hospital.vo.ReferralNoticeVO;
import com.hospital.vo.ReferralReplyVO;
import com.hospital.vo.ReferralRequestVO;
import com.hospital.vo.UserVO;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/referral")
public class ReferralController {

	@Autowired
	private ReferralService referralService;

	@Autowired
	private NoticeService noticeService;

	@GetMapping("/main.do")
	public String showReferralMainPage(Model model) {
		model.addAttribute("latestNotices", referralService.getLatestForAll(3)); // 센터 공지 3건
		model.addAttribute("latestHospitalNotices", noticeService.getLatest(3)); // 병원 공지 3건

		return "referral/referral_main";
	}

	@GetMapping("/greeting.do")
	public String showReferralGreetingPage() {
		return "referral/01_referral_greeting";
	}

	@GetMapping("/history.do")
	public String showReferralHistoryPage() {
		return "referral/01_referral_history";
	}

	// ✅ 02. 협진 요청 관련
	@GetMapping("/referral.do")
	public String showReferralPage() {
		return "referral/02_referral_referral";
	}

	@GetMapping("/doctor.do")
	public String showReferralDoctorPage(Model model) {
		List<UserVO> coopDoctors = referralService.getAllCoopDoctors();
		model.addAttribute("coopDoctors", coopDoctors);
		return "referral/02_referral_doctor";
	}

	// ✅ 03. 공지사항
	@GetMapping("/hospital_notice.do")
	public String showHospitalInfoPage() {
		return "hospital_info/03_notice";
	}

	// ✅ 04. 협진 현황
	@GetMapping("/referral_overview.do")
	public String showReferralOverViewPage() {
		return "referral/04_referral_overview";
	}

	@GetMapping("/referral_status.do")
	public String showReferralStatusPage(Model model) {
		List<PartnerHospitalVO> list = referralService.getAllPartnerHospitals();
		model.addAttribute("hospitalList", list);
		return "referral/04_referral_status";
	}

	// ✅ 05. 진료과 정보
	@GetMapping("/referral_DepartmentInfo.do")
	public String showReferralDepartmentPage(Model model) {
		return "referral/05_referral_DepartmentInfo";
	}

	// ✅ 기타 (협진 의사 목록 페이지 중복 대응)
	@GetMapping("/referral_doctor.do")
	public String showCoopDoctors(Model model) {
		List<UserVO> coopDoctors = referralService.getAllCoopDoctors();
		model.addAttribute("coopDoctors", coopDoctors);
		return "referral/referral_doctor";
	}

	// 진료의뢰 신청현황
	@GetMapping("/status")
	public String redirectReferralStatus(HttpSession session, Model model) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			// 로그인 후 다시 돌아올 목적지 저장
			session.setAttribute("afterLoginRedirect", "/referral/status.do");
			// 반드시 auth.do로 리다이렉트 (뷰 이름 직접 리턴 금지)
			return "redirect:/referral/auth.do?mode=login";
		}

		List<ReferralRequestVO> requests = referralService.getReferralRequestsByUser(loginUser.getUserId());
		model.addAttribute("requests", requests);

		return "referral/02_referral_status";
	}

	@GetMapping("/02_referral_status_board.do")
	public String showReferralRequestDetail(@RequestParam("requestId") int requestId, Model model) {
		// 1. requestId에 해당하는 의뢰 상세 조회
		ReferralRequestVO request = referralService.getReferralRequestById(requestId);

		// 2. 모델에 담아서 JSP로 전달
		model.addAttribute("request", request);

		// 3. 상세보기 JSP 페이지로 이동
		return "referral/02_referral_status_board";
	}

	@PostMapping("/insertReply.do")
	public String insertReply(@RequestParam("requestId") int requestId, @RequestParam("replyContent") String content,
			@RequestParam("actionType") String actionType, HttpSession session) {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		// 필수 데이터 추출
		String userName = loginUser.getName();
		int hospitalId = loginUser.getHospitalId();

		// 상태 결정
		String status = actionType.equals("거절") ? "거절" : "완료";

		// 1. 회신 저장
		ReferralReplyVO reply = new ReferralReplyVO();
		reply.setRequestId(requestId);
		reply.setResponderName(userName);
		reply.setReplyContent(content);
		reply.setReplyDate(new Date());
		reply.setStatus(status);
		reply.setHospitalId(hospitalId);
		reply.setAttachmentPath(null); // 첨부 없음

		referralService.insertReply(reply); // 회신 저장

		// 2. 요청 상태도 업데이트
		referralService.updateRequestStatus(requestId, status); // "완료" 또는 "거절"

		return "redirect:/referral/status.do";
	}

	@GetMapping("/02_referral_status_history.do")
	public String showReferralReplyPage(@RequestParam("requestId") int requestId,
			@RequestParam(value = "msg", required = false) String msg, Model model) {

		ReferralRequestVO request = referralService.getReferralRequestById(requestId);
		ReferralReplyVO reply = referralService.getReplyByRequestId(requestId);
		List<ReferralCommentVO> comments = referralService.getCommentsByRequestId(requestId);

		model.addAttribute("request", request);
		model.addAttribute("reply", reply);
		model.addAttribute("comments", comments);
		if (msg != null && !msg.isEmpty()) {
			model.addAttribute("msg", msg); // JSP에서 그대로 사용 가능
		}

		return "referral/02_referral_status_history";
	}

	@PostMapping("/insertComment.do")
	public String insertReferralComment(@ModelAttribute ReferralCommentVO commentVO, HttpSession session,
			RedirectAttributes redirectAttributes) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "referral/referral_auth";
		}

		// ✅ 디버깅 로그
		System.out.println("댓글 입력 확인: " + commentVO.getCommentText());

		commentVO.setDoctorId(loginUser.getUserId());
		referralService.addReferralComment(commentVO);
		redirectAttributes.addAttribute("requestId", commentVO.getRequestId());
		return "redirect:/referral/02_referral_status_history.do";
	}

	@PostMapping("/updateComment.do")
	public String updateComment(@ModelAttribute ReferralCommentVO comment, HttpSession session, RedirectAttributes ra) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null)
			return "referral/referral_auth";

		comment.setDoctorId(loginUser.getUserId());
		boolean success = referralService.updateComment(comment);

		ra.addAttribute("requestId", comment.getRequestId());
		ra.addAttribute("msg", success ? "수정되었습니다." : "수정 권한이 없습니다.");
		return "redirect:/referral/02_referral_status_history.do";
	}

	@GetMapping("/deleteComment.do")
	public String deleteComment(@RequestParam int commentId, @RequestParam int requestId, HttpSession session,
			RedirectAttributes ra) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null)
			return "referral/referral_auth";

		boolean success = referralService.deleteComment(commentId, loginUser.getUserId());

		ra.addAttribute("requestId", requestId);
		ra.addAttribute("msg", success ? "삭제했습니다." : "삭제 권한이 없습니다.");
		return "redirect:/referral/02_referral_status_history.do";
	}

	@GetMapping("/status.do")
	public String showReferralStatusByUserId(Model model, HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			// 로그인 후 돌아올 목적지 저장
			session.setAttribute("afterLoginRedirect", "/referral/status.do");
			return "redirect:/referral/auth.do?mode=login";
		}

		if (!"coop".equals(loginUser.getRole())) {
			model.addAttribute("unauthorized", true);
			return "referral/02_referral_status"; // JSP에서 접근 제한 처리
		}

		String userId = loginUser.getUserId();
		List<ReferralRequestVO> requests = referralService.getReferralRequestsByUser(userId);
		model.addAttribute("requests", requests);

		return "referral/02_referral_status";
	}

	@GetMapping("/statusAll.do")
	public String showReferralStatusAllByHospital(Model model, HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			session.setAttribute("afterLoginRedirect", "/referral/statusAll.do");
			return "redirect:/referral/auth.do?mode=login";
		}

		if (!"coop".equals(loginUser.getRole())) {
			model.addAttribute("unauthorized", true);
			return "referral/02_referral_status_all";
		}

		int hospitalId = loginUser.getHospitalId();
		List<ReferralRequestVO> requests = referralService.selectRequestsByHospitalId(hospitalId);
		model.addAttribute("requests", requests);

		return "referral/02_referral_status_all";
	}

	@GetMapping("/personinfo.do")
	public String showpersoninfoPage() {
		return "referral/personal_information";
	}

	@GetMapping("/terms.do")
	public String showTerms() {
		return "referral/terms";
	}

	@Autowired
	private DoctorService doctorService;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	// 협진 전체 조회
	@GetMapping("/coopLog.do")
	public String showAllReferrals(Model model, HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		model.addAttribute("loginUser", loginUser);
		if (loginUser == null || !"admin".equals(loginUser.getRole())) {
			return "redirect:/common/login_selector.jsp";
		}

		List<ReferralRequestVO> referrals = referralService.getAllReferrals();
		model.addAttribute("referrals", referrals);
		return "admin/referral_list";
	}

	// 상태별 필터링
	@GetMapping("/filterCoopLog.do")
	public String filterReferrals(@RequestParam(value = "status", required = false) String status, Model model) {
		List<ReferralRequestVO> referrals;

		if (status == null || status.isEmpty()) {
			referrals = referralService.getAllReferrals(); // 전체 조회
		} else {
			referrals = referralService.getReferralsByStatus(status);
		}

		model.addAttribute("referrals", referrals);
		return "admin/referral_list";
	}

	// 협진 상세보기
	@GetMapping("/referralDetail.do")
	public String viewReferralDetail(@RequestParam("requestId") int requestId, Model model) {
		ReferralRequestVO referral = referralService.getReferralById(requestId);
		model.addAttribute("referral", referral);
		return "admin/referral_detail";
	}

	// 협진 상태 업데이트
	@PostMapping("/updateReferralStatus.do")
	public String updateReferralStatus(@RequestParam("requestId") int requestId, @RequestParam("status") String status,
			RedirectAttributes ra) {
		referralService.updateReferralStatus(requestId, status);
		ra.addFlashAttribute("msg", "상태를 변경했습니다.");
		return "redirect:/referral/referralDetail.do?requestId=" + requestId; // ✅ 상세로 복귀
	}

	// 협진 요청 등록 폼 이동
	@GetMapping("/referralForm.do")
	public String showReferralForm(@RequestParam(value = "coopUserId", required = false) String coopUserId,
			@RequestParam(value = "coopHospitalId", required = false) Integer coopHospitalId, Model model,
			HttpSession session) {

		Object sessionUser = session.getAttribute("loginUser");
		if (sessionUser == null) {
			sessionUser = session.getAttribute("loginAdmin");
		}

		UserVO loginUser;

		if (sessionUser instanceof UserVO) {
			loginUser = (UserVO) sessionUser;
		} else if (sessionUser instanceof AdminVO) {
			AdminVO admin = (AdminVO) sessionUser;
			loginUser = new UserVO();
			loginUser.setUserId(admin.getAdminId());
			loginUser.setName(admin.getName());
			loginUser.setRole("admin");
			loginUser.setHospitalId(0);
		} else {
			return "redirect:/common/login_selector.jsp";
		}

		if (!("admin".equals(loginUser.getRole()) || "coop".equals(loginUser.getRole()))) {
			return "redirect:/common/login_selector.jsp";
		}

		if ("admin".equals(loginUser.getRole())) {
			model.addAttribute("coopUserId", coopUserId);
			model.addAttribute("coopHospitalId", coopHospitalId);
		}

		model.addAttribute("deptList", doctorService.getAllDepartments());
		model.addAttribute("loginUser", loginUser);
		return "admin/referral_form";
	}

	// 협진 요청 등록 처리
	@PostMapping("/submit.do")
	public String submitReferral(ReferralRequestVO vo,
			@RequestParam(value = "coopUserId", required = false) String coopUserId,
			@RequestParam(value = "coopHospitalId", required = false) Integer coopHospitalId, HttpSession session,
			Model model) {

		Object loginObj = session.getAttribute("loginUser");
		if (loginObj == null) {
			loginObj = session.getAttribute("loginAdmin");
		}

		UserVO loginUser = null;

		if (loginObj instanceof UserVO) {
			loginUser = (UserVO) loginObj;
		} else if (loginObj instanceof AdminVO) {
			AdminVO admin = (AdminVO) loginObj;
			loginUser = new UserVO();
			loginUser.setUserId(admin.getAdminId());
			loginUser.setRole("admin");
			loginUser.setHospitalId(0); // 관리자에게 병원 ID는 의미 없음
		}

		// 로그인 및 권한 체크
		if (loginUser == null || !("coop".equals(loginUser.getRole()) || "admin".equals(loginUser.getRole()))) {
			return "redirect:/common/login_selector.jsp";
		}

		// 관리자 → 협력 사용자 정보 필요
		if ("admin".equals(loginUser.getRole())) {
			if (coopUserId == null || coopHospitalId == null) {
				model.addAttribute("error", "협력 사용자 정보가 누락되었습니다.");
				model.addAttribute("deptList", doctorService.getAllDepartments());
				return "admin/referral_form";
			}
			vo.setUserId(coopUserId);
			vo.setHospitalId(coopHospitalId);
		} else {
			// 협력 사용자 → 본인 정보 사용
			if (loginUser.getUserId() == null || loginUser.getHospitalId() == null) {
				model.addAttribute("error", "로그인 사용자 정보가 누락되었습니다.");
				return "redirect:/common/login_selector.jsp";
			}
			vo.setUserId(loginUser.getUserId());
			vo.setHospitalId(loginUser.getHospitalId());
		}

		// 등록
		vo.setStatus("접수");
		referralService.insertReferral(vo);
		model.addAttribute("message", "협진 요청이 성공적으로 등록되었습니다.");

		// ✅ 등록 후 리다이렉트 경로 분기
		if ("admin".equals(loginUser.getRole())) {
			return "redirect:/referral/myReferrals.do?userId=" + vo.getUserId() + "&hospitalId=" + vo.getHospitalId();
		} else {
			return "redirect:/coop/coop_main.jsp";
		}
	}

	// 협력의사의 내 협진 목록
	@GetMapping("/myReferrals.do")
	public String viewReferralsByUser(@RequestParam("userId") String userId,
			@RequestParam(value = "hospitalId", required = false) Integer hospitalId, Model model) {
		List<ReferralRequestVO> referrals = referralService.getReferralsByUserId(userId);
		model.addAttribute("referrals", referrals);
		model.addAttribute("coopUserId", userId); // 🔽 등록 폼으로 넘길 ID
		model.addAttribute("coopHospitalId", hospitalId); // 🔽 등록 폼으로 넘길 병원 ID

		return "admin/referral_list";
	}

	@GetMapping("/noticeDetail.do")
	public String showNoticeDetail(@RequestParam("noticeId") int noticeId, Model model, HttpSession session,
			RedirectAttributes redirectAttributes) {

		// 1. 공지사항 조회
		ReferralNoticeVO notice = referralService.getNoticeById(noticeId);
		if (notice == null) {
			redirectAttributes.addFlashAttribute("errorMsg", "존재하지 않는 공지입니다.");
			return "redirect:/referral/referral_notice.do";
		}

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		String targetRole = notice.getTargetRole(); // 예: "all", "doctor", "coop,doctor"

		// ✅ 로그인하지 않은 경우: all만 허용
		if (loginUser == null) {
			if (!"all".equalsIgnoreCase(targetRole)) {
				redirectAttributes.addFlashAttribute("accessDenied", true); // ✅ Flash
				return "redirect:/referral/referral_notice.do";
			}
		}
		// ✅ 로그인한 경우: userRole이 targetRole 포함 시 허용
		else {
			String userRole = loginUser.getRole(); // 예: doctor, coop
			boolean authorized = false;

			if ("all".equalsIgnoreCase(targetRole)) {
				authorized = true;
			} else {
				// 쉼표로 구분된 다중 권한 체크
				String[] allowedRoles = targetRole.split(",");
				for (String role : allowedRoles) {
					if (role.trim().equalsIgnoreCase(userRole)) {
						authorized = true;
						break;
					}
				}
			}

			if (!authorized) {
				redirectAttributes.addFlashAttribute("accessDenied", true); // ✅ Flash
				return "redirect:/referral/referral_notice.do";
			}
		}

		// 3. 통과 시 상세 페이지로 이동
		model.addAttribute("notice", notice);
		model.addAttribute("loginUser", loginUser);
		return "referral/03_referral_notice_detail";
	}

	@GetMapping("/editNoticeForm.do")
	public String showEditNoticeForm(@RequestParam("noticeId") long noticeId, HttpSession session,
			HttpServletRequest request, Model model, RedirectAttributes ra) throws UnsupportedEncodingException {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			// 로그인 후 다시 돌아오도록 returnUrl 세팅
			String ctx = request.getContextPath(); // e.g. /mediprime
			String uri = request.getRequestURI(); // e.g. /mediprime/referral/editNoticeForm.do
			String path = uri.substring(ctx.length()); // e.g. /referral/editNoticeForm.do
			String qs = request.getQueryString(); // e.g. noticeId=4
			String returnUrl = path + (qs != null ? "?" + qs : "");
			return "redirect:/referral/auth.do?returnUrl=" + URLEncoder.encode(returnUrl, "UTF-8");
		}

		// 작성자 본인만 접근 가능
		ReferralNoticeVO original = referralService.getNoticeById((int) noticeId);
		if (original == null || !loginUser.getUserId().equals(original.getCreatedBy())) {
			ra.addFlashAttribute("msg", "수정 권한이 없습니다.");
			return "redirect:/referral/referral_notice.do";
		}

		model.addAttribute("notice", original);
		model.addAttribute("loginUser", loginUser);
		return "referral/03_referral_notice_edit"; // /WEB-INF/jsp/referral/03_referral_notice_edit.jsp
	}

	@PostMapping("/updateNotice.do")
	public String updateNotice(@ModelAttribute ReferralNoticeVO form, @RequestParam String password,
			HttpSession session, Model model) throws UnsupportedEncodingException {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			String back = URLEncoder.encode("/referral/editNoticeForm.do?noticeId=" + form.getNoticeId(), "UTF-8");
			return "redirect:/referral/auth.do?redirect=" + back;
		}

		// 작성자 본인 여부 체크
		ReferralNoticeVO original = referralService.getNoticeById(form.getNoticeId());
		if (original == null || !original.getCreatedBy().equals(loginUser.getUserId())) {
			return "redirect:/referral/referral_notice.do";
		}

		// 🔐 비밀번호 검증: UserVO에 저장된 해시와 입력값 비교
		if (!matchesUserPassword(loginUser, password)) {
			model.addAttribute("passwordError", true); // JSP에서 모달 표시
			model.addAttribute("notice", form); // 입력값 유지
			return "referral/03_referral_notice_edit";
		}

		// 수정 수행
		referralService.updateNotice(form);
		return "redirect:/referral/noticeDetail.do?noticeId=" + form.getNoticeId();
	}

	/** UserVO의 저장된 비밀번호(해시 또는 평문)와 입력 비밀번호 비교 */
	private boolean matchesUserPassword(UserVO user, String rawPw) {
		if (user == null || rawPw == null)
			return false;

		// UserVO에 저장된 비밀번호(해시) 가져오기
		String stored = user.getPassword(); // ← 필드명이 다르면 getPw(), getPasswd() 등으로 변경
		if (stored == null || stored.isEmpty())
			return false;

		// 1) SHA-512 해시로 저장된 경우(권장): util로 암호화 후 비교
		try {
			String enc = SHA512Util.encrypt(rawPw);
			return stored.equalsIgnoreCase(enc);
		} catch (Exception e) {
			// encrypt 예외 시 안전하게 false
			return false;
		}

		// 2) 만약 평문으로 저장되어 있다면(권장 X): 아래처럼 대체
		// return stored.equals(rawPw);
	}

	@PostMapping("/deleteNotice.do")
	public String deleteNotice(@RequestParam("noticeId") long noticeId, HttpSession session, RedirectAttributes ra,
			HttpServletRequest request) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			// 로그인 안되어 있으면 로그인/공지목록으로
			ra.addFlashAttribute("msg", "로그인 후 이용해주세요.");
			return "redirect:" + request.getContextPath() + "/referral/referral_notice.do";
		}

		String userId = loginUser.getUserId();

		boolean ok = referralService.deleteNotice(noticeId, userId);
		if (ok) {
			ra.addFlashAttribute("msg", "삭제되었습니다.");
		} else {
			ra.addFlashAttribute("msg", "삭제 권한이 없거나 이미 삭제되었습니다.");
		}
		return "redirect:" + request.getContextPath() + "/referral/referral_notice.do";
	}

	// 공지사항 작성 폼 이동
	@GetMapping("/createNoticeForm.do")
	public String showCreateNoticeForm(HttpSession session, HttpServletRequest request, Model model)
			throws UnsupportedEncodingException {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			// 현재 요청 경로에서 컨텍스트 경로를 제거한 뒤 returnUrl 로 전달
			String ctx = request.getContextPath(); // e.g. /mediprime
			String uri = request.getRequestURI(); // e.g. /mediprime/referral/createNoticeForm.do
			String path = uri.substring(ctx.length()); // e.g. /referral/createNoticeForm.do
			String qs = request.getQueryString(); // e.g. null or a=b
			String returnUrl = path + (qs != null ? "?" + qs : ""); // e.g. /referral/createNoticeForm.do

			String encoded = URLEncoder.encode(returnUrl, "UTF-8");
			return "redirect:/referral/auth.do?returnUrl=" + encoded;
		}

		model.addAttribute("loginUser", loginUser);
		model.addAttribute("notice", new ReferralNoticeVO());
		return "referral/03_referral_notice_create";
	}

	@PostMapping("/insertNotice.do")
	public String insertNotice(@ModelAttribute ReferralNoticeVO notice, HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/referral/referral_notice.do";
		}

		// ⛳ Date 변환
		notice.setCreatedAt(new java.sql.Date(new Date().getTime()));
		notice.setCreatedBy(loginUser.getUserId());

		referralService.insertNotice(notice);

		return "redirect:/referral/referral_notice.do";
	}

	@GetMapping("/referral_notice.do")
	public String noticeList(HttpSession session, Model model) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		List<ReferralNoticeVO> notices;

		if (loginUser == null) {
			notices = referralService.getNoticesForAll(); // 🔹 target_role = 'all'
		} else {
			notices = referralService.getNoticesForUserRole(loginUser.getRole()); // 🔹 해당 역할 포함
		}

		model.addAttribute("notices", notices);
		model.addAttribute("loginUser", loginUser); // ✅ JSP에서 권한 표시 등에 활용

		return "referral/03_referral_notice"; // JSP
	}

	@GetMapping(value = "/partners/locations.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<PartnerHospitalVO> partnerLocations() {
		return referralService.getPartnerLocations();
	}
}
