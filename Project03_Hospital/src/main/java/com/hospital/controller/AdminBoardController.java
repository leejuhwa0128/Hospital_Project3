package com.hospital.controller;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.hospital.service.EventService;
import com.hospital.service.FaqService;
import com.hospital.service.FeedbackService;
import com.hospital.service.MedicalNoticeService;
import com.hospital.service.NoticeService;
import com.hospital.service.PraiseService;
import com.hospital.service.UserActivityLogService;
import com.hospital.vo.AdminVO;
import com.hospital.vo.EventVO;
import com.hospital.vo.FaqVO;
import com.hospital.vo.FeedbackVO;
import com.hospital.vo.MedicalNoticeVO;
import com.hospital.vo.NoticeVO;
import com.hospital.vo.PraiseVO;
import com.hospital.vo.UserActivityLogVO;
import com.hospital.vo.UserVO;

@Controller
@RequestMapping("/admin_board")
public class AdminBoardController {

	@Autowired
	private EventService eventService;

	@Autowired
	private PraiseService praiseService;

	@Autowired
	private FeedbackService feedbackService;

	@Autowired
	private NoticeService noticeService;

	@Autowired
	private MedicalNoticeService medicalNoticeService;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sdf.setLenient(false);
		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(sdf, true));
	}

	// ========================== 언론보도 관리 =========================

	// 목록 페이지
	@GetMapping("/pressManage.do")
	public String pressManage(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		int pageSize = 10;
		int offset = (page - 1) * pageSize;

		int totalCount = eventService.countEventsByCategory("언론");
		List<EventVO> list = eventService.getEventsByCategoryWithPaging("언론", offset, pageSize);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		model.addAttribute("events", list);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);

		return "admin_board/press_manage"; // → /WEB-INF/jsp/admin/press_manage.jsp
	}

	// 상세보기
	@GetMapping("/press_view.do")
	public String viewPress(@RequestParam("eventId") int eventId, Model model) {
		EventVO event = eventService.getEventByIdInfo(eventId);
		model.addAttribute("event", event);
		return "admin_board/press_view"; // /WEB-INF/jsp/admin/press_view.jsp
	}

	// 등록 폼
	@GetMapping("/press_writeForm.do")
	public String showPressWriteForm(Model model) {
		model.addAttribute("category", "언론");
		return "admin_board/press_write";
	}

	@PostMapping("/press_write.do")
	public String insertPress(@ModelAttribute EventVO eventVO, @RequestParam("thumbnailFile") MultipartFile file,
			HttpSession session) {

		if (!file.isEmpty()) {
			String uploadPath = session.getServletContext().getRealPath("/press/");
			String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

			try {
				file.transferTo(new java.io.File(uploadPath + fileName));
				eventVO.setThumbnailPath("/press/" + fileName); // DB에 경로 저장
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			eventVO.setThumbnailPath("/press/default-thumb.png"); // 기본 이미지
		}

		// DB Insert 실행
		eventService.insertEventInfo(eventVO);

		// 로그 기록
		UserActivityLogVO log = new UserActivityLogVO();

		if (session.getAttribute("loginAdmin") != null) {
			AdminVO admin = (AdminVO) session.getAttribute("loginAdmin");
			log.setUserId(admin.getName());
			log.setUserType("admin");
		} else if (session.getAttribute("loginUser") != null) {
			UserVO user = (UserVO) session.getAttribute("loginUser");
			log.setUserId(user.getUserId());
			log.setUserType("user");
		} else {
			// 로그인 정보 없으면 로그 기록 안함
			return "redirect:/admin_board/pressManage.do";
		}

		log.setAction("Press Created");
		log.setTargetTable("EVENTS");
		log.setTargetId(0);

		logService.logActivity(log);

		return "redirect:/admin_board/pressManage.do";
	}

	// 수정 폼
	@GetMapping("/press_editForm.do")
	public String showPressEditForm(@RequestParam("eventId") int eventId, Model model) {
		EventVO event = eventService.getEventByIdInfo(eventId);
		model.addAttribute("event", event);
		return "admin_board/press_edit";
	}

	// 수정 처리
	@PostMapping("/press_update.do")
	public String updatePress(@ModelAttribute EventVO eventVO, @RequestParam("thumbnailFile") MultipartFile file,
			HttpSession session) {

		if (!file.isEmpty()) {
			String uploadPath = session.getServletContext().getRealPath("/press/");
			String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

			try {
				file.transferTo(new java.io.File(uploadPath + fileName));
				eventVO.setThumbnailPath("/press/" + fileName);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// 파일이 비어 있으면 기존 썸네일 유지 (eventVO.thumbnailPath는 그대로 유지됨)

		eventService.updateEventInfo(eventVO);

		// 로그 기록
		UserActivityLogVO log = new UserActivityLogVO();

		if (session.getAttribute("loginAdmin") != null) {
			AdminVO admin = (AdminVO) session.getAttribute("loginAdmin");
			log.setUserId(admin.getName());
			log.setUserType("admin");
		} else if (session.getAttribute("loginUser") != null) {
			UserVO user = (UserVO) session.getAttribute("loginUser");
			log.setUserId(user.getUserId());
			log.setUserType("user");
		} else {
			// 비로그인 시 로그 남기지 않음
			return "redirect:/admin_board/pressManage.do";
		}

		log.setAction("Press Updated");
		log.setTargetTable("EVENTS");
		log.setTargetId(eventVO.getEventId()); // 수정할 때는 반드시 ID가 있음

		logService.logActivity(log);

		return "redirect:/admin_board/pressManage.do";
	}

	// 삭제 처리
	@PostMapping("/press_delete.do")
	public String deletePress(@RequestParam("eventId") int eventId, HttpSession session) {
		eventService.deleteEventInfo(eventId);

		// 로그 기록
		UserActivityLogVO log = new UserActivityLogVO();

		if (session.getAttribute("loginAdmin") != null) {
			AdminVO admin = (AdminVO) session.getAttribute("loginAdmin");
			log.setUserId(admin.getName());
			log.setUserType("admin");
		} else if (session.getAttribute("loginUser") != null) {
			UserVO user = (UserVO) session.getAttribute("loginUser");
			log.setUserId(user.getUserId());
			log.setUserType("user");
		} else {
			// 비로그인 시 로그 남기지 않음
			return "redirect:/admin_board/pressManage.do";
		}

		log.setAction("Press Deleted");
		log.setTargetTable("EVENTS");
		log.setTargetId(eventId); // 삭제는 URL에서 받은 ID를 그대로 TargetId로

		logService.logActivity(log);

		return "redirect:/admin_board/pressManage.do";
	}

	// ========================== 채용 관리 =========================

	@GetMapping("/recruitManage.do")
	public String recruitManage(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "job", required = false) String job, Model model) {
		int pageSize = 10;
		int offset = (page - 1) * pageSize;

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("offset", offset);
		paramMap.put("pageSize", pageSize);

		if (job != null && !job.trim().isEmpty() && !"all".equals(job)) {
			paramMap.put("subCategory", job);
		}

		String subCategory = (String) paramMap.get("subCategory");
		int totalCount = eventService.countRecruit(subCategory);

		List<EventVO> events = eventService.getRecruitPage(paramMap);

		model.addAttribute("events", events);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("page", page);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("job", job); // 현재 필터 유지
		return "admin_board/recruit_manage";
	}

	// 상세보기
	@GetMapping("/recruit_view.do")
	public String viewRecruit(@RequestParam("eventId") int eventId, Model model) {
		EventVO event = eventService.getEventByIdInfo(eventId);
		model.addAttribute("event", event);
		return "admin_board/recruit_view"; // /WEB-INF/jsp/admin/press_view.jsp
	}

	// 등록 폼
	@GetMapping("/recruit_writeForm.do")
	public String showRecruitWriteForm(Model model) {
		model.addAttribute("category", "채용");
		return "admin_board/recruit_write";
	}

	// 등록 처리
	@PostMapping("/recruit_write.do")
	public String insertRecruit(@ModelAttribute EventVO eventVO) {
		eventService.insertEventInfo(eventVO);
		return "redirect:/admin_board/recruitManage.do"; // ✅ 올바른 경로
	}

	// 수정 폼
	@GetMapping("/recruit_editForm.do")
	public String showRecruitEditForm(@RequestParam("eventId") int eventId, Model model) {
		EventVO event = eventService.getEventByIdInfo(eventId);
		model.addAttribute("event", event);
		return "admin_board/recruit_edit";
	}

	// 수정 처리
	@PostMapping("/recruit_update.do")
	public String updateRecruit(@ModelAttribute EventVO eventVO) {
		eventService.updateEventInfo(eventVO);
		return "redirect:/admin_board/recruitManage.do";
	}

	// 삭제 처리
	@GetMapping("/recruit_delete.do")
	public String deleteRecruit(@RequestParam("eventId") int eventId) {
		eventService.deleteEventInfo(eventId);
		return "redirect:/admin_board/recruitManage.do";
	}

	// ========================== 소식 관리 =========================

	@GetMapping("/newsManage.do")
	public String manageNews(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		int size = 10;
		int offset = (page - 1) * size;
		List<EventVO> list = eventService.getEventsByCategoryWithPaging("소식", offset, size);
		model.addAttribute("events", list);
		return "admin_board/news_manage";
	}

	// 상세보기
	@GetMapping("/news_view.do")
	public String viewNews(@RequestParam("eventId") int eventId, Model model) {
		EventVO event = eventService.getEventByIdInfo(eventId);
		model.addAttribute("event", event);
		return "admin_board/news_view"; // /WEB-INF/jsp/admin/press_view.jsp
	}

	// 등록 폼
	@GetMapping("/news_writeForm.do")
	public String showNewsWriteForm(Model model) {
		model.addAttribute("category", "소식");
		return "admin_board/news_write";
	}

	// 등록 처리
	@PostMapping("/news_write.do")
	public String insertNews(@ModelAttribute EventVO eventVO) {
		eventService.insertEventInfo(eventVO);
		return "redirect:/admin_board/newsManage.do";
	}

	// 수정 폼
	@GetMapping("/news_editForm.do")
	public String showNewsEditForm(@RequestParam("eventId") int eventId, Model model) {
		EventVO event = eventService.getEventByIdInfo(eventId);
		model.addAttribute("event", event);
		return "admin_board/news_edit";
	}

	// 수정 처리
	@PostMapping("/news_update.do")
	public String updateNews(@ModelAttribute EventVO eventVO) {
		eventService.updateEventInfo(eventVO);
		return "redirect:/admin_board/newsManage.do";
	}

	// 삭제 처리
	@GetMapping("/news_delete.do")
	public String deleteNews(@RequestParam("eventId") int eventId) {
		eventService.deleteEventInfo(eventId);
		return "redirect:/admin_board/newsManage.do";
	}

	// ========================== FAQ 관리 =========================

	@Autowired
	private FaqService faqService;

	@GetMapping("/faqManage.do")
	public String faqManage(Model model, @RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "category", required = false) String category,
			@RequestParam(value = "keyword", required = false) String keyword) {

		int pageSize = 10;
		int offset = (page - 1) * pageSize;

		Map<String, Object> param = new HashMap<>();
		param.put("category", category);
		param.put("keyword", keyword);
		param.put("start", offset);
		param.put("pageSize", pageSize); // ← 여기를 "pageSize"로 수정

		int totalCount = faqService.getFaqCount(param);
		List<FaqVO> faqList = faqService.getFaqList(param);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		model.addAttribute("faqList", faqList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("category", category);
		model.addAttribute("keyword", keyword);

		return "admin_board/faq_manage";
	}

	@GetMapping("/faq_view.do")
	public String faqView(@RequestParam("faqId") int id, Model model) {
		FaqVO faq = faqService.getFaqById(id);
		model.addAttribute("faq", faq);
		return "admin_board/faq_view";
	}

	@GetMapping("/faq_writeForm.do")
	public String faqWriteForm() {
		return "admin_board/faq_write";
	}

	@PostMapping("/faq_write.do")
	public String faqWrite(@ModelAttribute FaqVO faq) {
		faqService.insertFaq(faq);
		return "redirect:/admin_board/faqManage.do";
	}

	@GetMapping("/faq_editForm.do")
	public String faqEditForm(@RequestParam("faqId") int id, Model model) {
		FaqVO faq = faqService.getFaqById(id);
		model.addAttribute("faq", faq);
		return "admin_board/faq_edit";
	}

	@PostMapping("/faq_update.do")
	public String faqUpdate(@ModelAttribute FaqVO faq) {
		faqService.updateFaq(faq);
		return "redirect:/admin_board/faqManage.do";
	}

	@GetMapping("/faq_delete.do")
	public String faqDelete(@RequestParam("faqId") int id) {
		faqService.deleteFaq(id);
		return "redirect:/admin_board/faqManage.do";
	}

	// ========================== 고객의 소리 관리 =========================

	@GetMapping("/feedbackManage.do")
	public String feedbackManage(@RequestParam(defaultValue = "1") int page,
			@RequestParam(required = false) String category, @RequestParam(required = false) String status,
			Model model) {

		int pageSize = 10;
		int offset = (page - 1) * pageSize;

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("start", offset + 1);
		paramMap.put("end", offset + pageSize);
		paramMap.put("category", category);
		paramMap.put("status", status);

		List<FeedbackVO> feedbackList = feedbackService.getFeedbackList(paramMap);
		int totalCount = feedbackService.getTotalCount(paramMap);
		int totalPages = Math.max(1, (int) Math.ceil((double) totalCount / pageSize));

		for (int i = 0; i < feedbackList.size(); i++) {
			feedbackList.get(i).setRowNumber(offset + i + 1);
		}

		model.addAttribute("feedbackList", feedbackList);
		model.addAttribute("currentPage", page); // ← JSP에서 사용
		model.addAttribute("totalPages", totalPages); // ← JSP에서 사용
		model.addAttribute("category", category);
		model.addAttribute("status", status);

		return "admin_board/feedback_manage";
	}

	// 상세 보기 + 답변 작성 폼 (feedback_view.jsp)
	@GetMapping("/feedbackView.do")
	public String feedbackView(@RequestParam("feedbackId") int id, Model model) {
		FeedbackVO vo = feedbackService.getFeedback(id);
		if (vo == null)
			return "redirect:/admin_board/feedbackManage.do";
		model.addAttribute("feedback", vo);
		return "admin_board/feedback_view";
	}

	// 답변 수정 폼 (feedback_edit.jsp)
	@GetMapping("/editReplyForm.do")
	public String editReplyForm(@RequestParam("feedbackId") int id, Model model) {
		FeedbackVO vo = feedbackService.getFeedback(id);
		if (vo == null)
			return "redirect:/admin_board/feedbackManage.do";
		model.addAttribute("feedback", vo);
		return "admin_board/feedback_edit";
	}

	// 답변 등록/수정 처리
	@PostMapping("/editReply.do")
	public String editReply(@RequestParam("feedbackId") int id, @RequestParam("reply") String reply,
			HttpSession session) {

		AdminVO admin = (AdminVO) session.getAttribute("loginAdmin");
		String repliedBy = (admin != null) ? admin.getName() : "관리자"; // ✅ NAME으로 변경 (100자 제한 이내)

		FeedbackVO vo = new FeedbackVO();
		vo.setFeedbackId(id);
		vo.setReply(reply);
		vo.setRepliedBy(repliedBy);

		feedbackService.replyFeedback(vo);
		return "redirect:/admin_board/feedbackManage.do";
	}

	// 답변 삭제
	@GetMapping("/deleteReply.do")
	public String deleteReply(@RequestParam("feedbackId") int id) {
		feedbackService.clearReply(id);
		return "redirect:/admin_board/feedbackManage.do";
	}

	// ========================== 칭찬 릴레이 관리 =========================

	@GetMapping("/praise_view.do")
	public String viewPraise(@RequestParam("praiseId") int praiseId, Model model) {
		PraiseVO praise = praiseService.getPraiseDetail(praiseId);
		model.addAttribute("praise", praise);
		return "admin_board/praise_view"; // → /WEB-INF/jsp/admin/praise_view.jsp
	}

	@GetMapping("/praiseManage.do")
	public String praiseManage(@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int pageSize, Model model) {

		int totalCount = praiseService.getPraiseCount();
		int totalPages = Math.max(1, (int) Math.ceil((double) totalCount / pageSize));

		// ROWNUM 페이징은 1-base
		int startRow = (page - 1) * pageSize + 1;
		int endRow = page * pageSize;

		List<PraiseVO> praiseList = praiseService.getPraiseList(startRow, endRow);

		model.addAttribute("praiseList", praiseList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("currentPage", page);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totalPages", totalPages);
		// JSP가 pageCount를 쓰는 경우 대비
		model.addAttribute("pageCount", totalPages);

		return "admin_board/praise_manage";
	}

	@GetMapping("/praise_delete.do")
	public String deletePraise(@RequestParam("praiseId") int praiseId) {
		praiseService.deletePraise(praiseId);
		return "redirect:/admin_board/praiseManage.do";
	}

	// ========================== 강좌 및 행사 관리 =========================

	@GetMapping("/lectureManage.do")
	public String manageLecture(@RequestParam(value = "category", required = false) String category, Model model) {
		List<String> allowedCategories = Arrays.asList("강좌", "교육", "행사", "기타");
		List<EventVO> list;

		if (category != null && allowedCategories.contains(category)) {
			list = eventService.getEventsByCategoryWithPaging(category, 0, 100);
			model.addAttribute("currentCategory", category);
		} else {
			list = eventService.getFilteredEvents(allowedCategories, 0, 100);
			model.addAttribute("currentCategory", "전체");
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		list = list.stream().peek(event -> {
			if (event.getStartDate() != null)
				event.setStartDateStr(sdf.format(event.getStartDate()));
			if (event.getEndDate() != null)
				event.setEndDateStr(sdf.format(event.getEndDate()));
			if (event.getEventDate() != null)
				event.setEventDateStr(sdf.format(event.getEventDate()));
			if (event.getCreatedAt() != null)
				event.setCreatedAtStr(sdf.format(event.getCreatedAt()));
		}).collect(Collectors.toList());

		model.addAttribute("lectureList", list);
		return "admin_board/lecture_manage";
	}

	@GetMapping("/lecture_view.do")
	public String viewLecture(@RequestParam int eventId, Model model) {
		EventVO event = eventService.getEventByIdInfo(eventId);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (event.getStartDate() != null)
			event.setStartDateStr(sdf.format(event.getStartDate()));
		if (event.getEndDate() != null)
			event.setEndDateStr(sdf.format(event.getEndDate()));
		if (event.getEventDate() != null)
			event.setEventDateStr(sdf.format(event.getEventDate()));
		if (event.getCreatedAt() != null)
			event.setCreatedAtStr(sdf.format(event.getCreatedAt()));

		model.addAttribute("event", event);
		return "admin_board/lecture_view";
	}

	// 등록 폼
	@GetMapping("/lecture_writeForm.do")
	public String showLectureWriteForm(Model model) {
		EventVO event = new EventVO();

		// 오늘 날짜로 초기값 설정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(new java.util.Date());

		event.setStartDateStr(today);
		event.setEndDateStr(today);
		event.setEventDateStr(today);
		event.setCreatedAtStr(today);

		model.addAttribute("event", event);
		return "admin_board/lecture_write";
	}

	// 등록 처리
	@PostMapping("/lecture_write.do")
	public String insertLecture(@ModelAttribute EventVO event) {
		event.setStatus("게시"); // 상태 기본값
		eventService.insertLectureEvent(event);
		return "redirect:/admin_board/lectureManage.do";
	}

	@GetMapping("/lecture_editForm.do")
	public String showLectureEditForm(@RequestParam int eventId, Model model) {
		EventVO event = eventService.getEventByIdInfo(eventId);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (event.getStartDate() != null)
			event.setStartDateStr(sdf.format(event.getStartDate()));
		if (event.getEndDate() != null)
			event.setEndDateStr(sdf.format(event.getEndDate()));
		if (event.getEventDate() != null)
			event.setEventDateStr(sdf.format(event.getEventDate()));
		if (event.getCreatedAt() != null)
			event.setCreatedAtStr(sdf.format(event.getCreatedAt()));

		model.addAttribute("event", event);
		return "admin_board/lecture_edit";
	}

	@PostMapping("/lecture_edit.do")
	public String updateLecture(@ModelAttribute EventVO event) {
		eventService.updateEventInfo(event);
		return "redirect:/admin_board/lectureManage.do";
	}

	@GetMapping("/lecture_delete.do")
	public String deleteLecture(@RequestParam int eventId) {
		eventService.deleteEventInfo(eventId);
		return "redirect:/admin_board/lectureManage.do";
	}

	// ========================== 공지사항 관리 =========================

	// 관리자용 공지사항 관리 기능 (목록, 상세, 등록, 수정, 삭제)
	@GetMapping("/noticeManage.do")
	public String manageNotice(Model model) {
		List<NoticeVO> noticeList = noticeService.getAllNotices();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		noticeList = noticeList.stream().peek(n -> {
			if (n.getCreatedAt() != null)
				n.setCreatedAtStr(sdf.format(n.getCreatedAt()));
		}).collect(Collectors.toList());

		model.addAttribute("noticeList", noticeList);
		return "admin_board/notice_manage";
	}

	@GetMapping("/notice_view.do")
	public String viewNotice(@RequestParam("noticeId") int noticeId, Model model) {
		NoticeVO notice = noticeService.getNoticeById(noticeId);
		if (notice.getCreatedAt() != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			notice.setCreatedAtStr(sdf.format(notice.getCreatedAt()));
		}
		model.addAttribute("notice", notice);
		return "admin_board/notice_view";
	}

	@GetMapping("/notice_writeForm.do")
	public String showNoticeWriteForm() {
		return "admin_board/notice_write";
	}

	@PostMapping("/notice_write.do")
	public String insertNotice(@ModelAttribute NoticeVO noticeVO, HttpSession session) {
		AdminVO admin = (AdminVO) session.getAttribute("loginAdmin");
		if (admin != null) {
			noticeVO.setCreatedBy(admin.getAdminId());
		} else {
			noticeVO.setCreatedBy("admin");
		}
		noticeService.insertNotice(noticeVO);
		return "redirect:/admin_board/noticeManage.do";
	}

	@GetMapping("/notice_editForm.do")
	public String showNoticeEditForm(@RequestParam("noticeId") int noticeId, Model model) {
		NoticeVO notice = noticeService.getNoticeById(noticeId);
		model.addAttribute("notice", notice);
		return "admin_board/notice_edit";
	}

	@PostMapping("/notice_update.do")
	public String updateNotice(@ModelAttribute NoticeVO noticeVO) {
		noticeService.updateNotice(noticeVO);
		return "redirect:/admin_board/noticeManage.do";
	}

	@GetMapping("/notice_delete.do")
	public String deleteNotice(@RequestParam("noticeId") int noticeId) {
		noticeService.deleteNotice(noticeId);
		return "redirect:/admin_board/noticeManage.do";
	}

	// ========================== 의료진 공지사항 =========================

	// 의료진 공지사항 목록
	@GetMapping("/medicalNoticeManage.do")
	public String medicalNoticeManage(Model model) {
		List<MedicalNoticeVO> notices = medicalNoticeService.getAllMedicalNotices();
		model.addAttribute("notices", notices);
		return "admin_board/medical_notice_manage";
	}

	// 의료진 공지사항 상세보기
	@GetMapping("/medicalNoticeView.do")
	public String medicalNoticeView(@RequestParam int noticeId, Model model) {
		MedicalNoticeVO notice = medicalNoticeService.getMedicalNoticeById(noticeId);
		model.addAttribute("notice", notice);
		return "admin_board/medical_notice_view";
	}

	// 의료진 공지사항 작성 폼
	@GetMapping("/medicalNoticeWriteForm.do")
	public String medicalNoticeWriteForm() {
		return "admin_board/medical_notice_write";
	}

	// 의료진 공지사항 작성 처리
	@PostMapping("/medicalNoticeWrite.do")
	public String medicalNoticeWrite(MedicalNoticeVO vo, @SessionAttribute("loginAdmin") AdminVO admin) {
		vo.setCreatedBy(admin.getAdminId()); // DB에는 ID 저장
		medicalNoticeService.insertMedicalNotice(vo);
		return "redirect:/admin_board/medicalNoticeManage.do";
	}

	// 의료진 공지사항 수정 폼
	@GetMapping("/medicalNoticeEditForm.do")
	public String medicalNoticeEditForm(@RequestParam int noticeId, Model model) {
		MedicalNoticeVO notice = medicalNoticeService.getMedicalNoticeById(noticeId);
		model.addAttribute("notice", notice);
		return "admin_board/medical_notice_edit";
	}

	// 의료진 공지사항 수정 처리
	@PostMapping("/medicalNoticeEdit.do")
	public String medicalNoticeEdit(@ModelAttribute MedicalNoticeVO vo) {
		medicalNoticeService.updateMedicalNotice(vo);
		return "redirect:/admin_board/medicalNoticeManage.do";
	}

	// 의료진 공지사항 삭제 처리
	@PostMapping("/medicalNoticeDelete.do")
	public String medicalNoticeDelete(@RequestParam int noticeId) {
		medicalNoticeService.deleteMedicalNotice(noticeId);
		return "redirect:/admin_board/medicalNoticeManage.do";
	}

	// ========================== 유저 활동 로그 =========================

	@Autowired
	private UserActivityLogService logService;

	@GetMapping("/activityLogs.do")
	public String showActivityLogs(Model model) {
		List<UserActivityLogVO> logList = logService.getAllLogs();
		model.addAttribute("logList", logList);
		return "admin_board/activity_logs";
	}

}
