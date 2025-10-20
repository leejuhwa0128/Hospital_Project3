package com.hospital.controller;

import java.util.*;
import javax.servlet.http.HttpSession;

import com.hospital.service.FeedbackService;
import com.hospital.vo.FeedbackVO;
import com.hospital.vo.UserVO;
import com.hospital.vo.PatientVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/03_feedback")
public class FeedbackController {

	@Autowired
	private FeedbackService feedbackService;

	/** 1. 피드백 목록 */
	@GetMapping("/list.do")
	public String list(@RequestParam(defaultValue = "1") int page, @RequestParam(required = false) String category,
			Model model) {
		int pageSize = 10;
		int offset = (page - 1) * pageSize;

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("start", offset + 1);
		paramMap.put("end", offset + pageSize);
		paramMap.put("category", category);

		List<FeedbackVO> feedbackList = feedbackService.getFeedbackList(paramMap);
		int totalCount = feedbackService.getTotalCount(paramMap); // ✅ Map 기반으로 수정

		int totalPage = Math.max(1, (int) Math.ceil((double) totalCount / pageSize));

		for (int i = 0; i < feedbackList.size(); i++) {
			feedbackList.get(i).setRowNumber(offset + i + 1);
		}

		model.addAttribute("feedbackList", feedbackList);
		model.addAttribute("page", page);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("category", category);

		return "user_service/03_feedbackList";
	}

	/** 2. 작성 폼 이동 */
	@GetMapping("/write.do")
	public String writeForm(HttpSession session) {
		Object user = session.getAttribute("loginUser");
		if (!(user instanceof PatientVO))
			return "redirect:/user/selectForm.do";
		return "user_service/03_feedbackForm";
	}

	/** 3. 피드백 등록 */
	@PostMapping("/write.do")
	public String writeFeedback(FeedbackVO vo, HttpSession session) {
		Object user = session.getAttribute("loginUser");
		if (!(user instanceof PatientVO))
			return "redirect:/user/selectForm.do";

		PatientVO patient = (PatientVO) user;
		vo.setPatientUserId(patient.getPatientUserId());
		vo.setPatientName(patient.getPatientName());
		feedbackService.insertFeedback(vo);
		return "redirect:/03_feedback/list.do";
	}

	/** 4. 비밀번호 확인 페이지 */
	@GetMapping("/checkPassword.do")
	public String checkPasswordPage(@RequestParam("feedbackId") int id, @RequestParam(required = false) String mode,
			Model model) {
		model.addAttribute("feedbackId", id);
		model.addAttribute("mode", mode);
		return "user_service/03_feedbackPwcheck";
	}

	/** 5. 비밀번호 확인 처리 */
	@PostMapping("/passwordCheck.do")
	public String passwordCheck(@RequestParam("feedbackId") int id, @RequestParam("writerPw") String inputPw,
			@RequestParam(required = false) String mode, HttpSession session, RedirectAttributes ra, Model model) {
		FeedbackVO vo = feedbackService.getFeedback(id);

		if (vo != null && inputPw.equals(vo.getWriterPw())) {
			// ✅ 세션에 이 피드백 ID에 대해 인증됨 표시
			session.setAttribute("feedbackAccess:" + id, true);

			if ("view".equals(mode)) {
				return "redirect:/03_feedback/detail.do?id=" + id;
			} else if ("edit".equals(mode)) {
				return "redirect:/03_feedback/edit.do?id=" + id;
			} else if ("delete".equals(mode)) {
				feedbackService.deleteFeedback(id);
				return "redirect:/03_feedback/list.do";
			}
		}

		model.addAttribute("error", "비밀번호가 틀렸습니다.");
		model.addAttribute("feedbackId", id);
		model.addAttribute("mode", mode);
		return "user_service/03_feedbackPwcheck";
	}

	/** 6. 상세보기 (관리자만 바로 접근 가능, 그 외엔 비밀번호 확인) */
	@GetMapping("/detail.do")
	public String detail(@RequestParam("id") int id, HttpSession session, Model model) {
		FeedbackVO vo = feedbackService.getFeedback(id);

		if (vo == null) {
			return "redirect:/03_feedback/list.do";
		}

		Object user = session.getAttribute("loginUser");

		// ✅ 관리자면 바로 통과
		if (user instanceof UserVO) {
			UserVO u = (UserVO) user;
			if ("admin".equals(u.getRole())) {
				model.addAttribute("feedback", vo);
				return "user_service/03_feedbackDetail";
			}
		}

		// ✅ 세션에서 이 피드백에 대한 접근 인증 여부 확인
		Boolean accessed = (Boolean) session.getAttribute("feedbackAccess:" + id);
		if (accessed != null && accessed) {
			// 한번 접근 허용한 후엔 세션에서 제거
			session.removeAttribute("feedbackAccess:" + id);
			model.addAttribute("feedback", vo);
			return "user_service/03_feedbackDetail";
		}

		// 그 외엔 비밀번호 확인 페이지로
		return "redirect:/03_feedback/checkPassword.do?feedbackId=" + id + "&mode=view";
	}

	/** 7. 수정 폼 (비밀번호 확인 후 진입됨) */
	@GetMapping("/edit.do")
	public String editForm(@RequestParam("id") int id, Model model) {
		FeedbackVO vo = feedbackService.getFeedback(id);
		model.addAttribute("feedback", vo);
		return "user_service/03_feedbackEditform";
	}

	/** 8. 수정 처리 */
	@PostMapping("/edit.do")
	public String edit(@ModelAttribute FeedbackVO vo) {
		feedbackService.updateFeedback(vo);
		return "redirect:/03_feedback/detail.do?id=" + vo.getFeedbackId();
	}

	/** 9. 삭제 (비밀번호 확인 후 처리됨) */
	@PostMapping("/delete.do")
	public String deleteFeedback(@RequestParam("feedbackId") int id, @RequestParam("writerPw") String inputPw,
			Model model) {
		FeedbackVO vo = feedbackService.getFeedback(id);
		if (vo != null && inputPw.equals(vo.getWriterPw())) {
			feedbackService.deleteFeedback(id);
			return "redirect:/03_feedback/list.do";
		} else {
			model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("feedback", vo);
			return "user_service/03_feedbackDeleteForm";
		}
	}

	/** 10. 내 피드백만 보기 */
	@GetMapping("/mylist.do")
	public String myFeedbackList(HttpSession session, Model model) {
		Object user = session.getAttribute("loginUser");
		if (!(user instanceof PatientVO)) {
			return "redirect:/user/selectForm.do";
		}

		PatientVO patient = (PatientVO) user;
		List<FeedbackVO> myList = feedbackService.getFeedbackByUser(patient.getPatientUserId());
		model.addAttribute("feedbackList", myList);
		return "user_service/03_feedbackMyList"; // 새로 만들 JSP
	}

}
