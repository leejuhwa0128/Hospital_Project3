package com.hospital.controller;

import com.hospital.service.PraiseService;
import com.hospital.vo.PatientVO;
import com.hospital.vo.PraiseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/03_praise")
public class PraiseController {

	@Autowired
	private PraiseService praiseService;

	// 칭찬릴레이 목록 페이지
	// 칭찬릴레이 목록 페이지
	@GetMapping("/list.do")
	public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		int pageSize = 5; // 한 페이지에 10개씩
		int startRow = (page - 1) * pageSize + 1;
		int endRow = page * pageSize;

		int totalCount = praiseService.getPraiseCount();
		int totalPage = (int) Math.ceil((double) totalCount / pageSize); // ✅ 이 줄 추가!

		List<PraiseVO> praiseList = praiseService.getPraiseList(startRow, endRow);

		model.addAttribute("praiseList", praiseList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("currentPage", page);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totalPage", totalPage); // ✅ 추가

		return "user_service/03_praiseList";
	}

	// 칭찬릴레이 상세 페이지
	@GetMapping("/detail.do")
	public String detail(@RequestParam("praiseId") int praiseId, Model model) {
		PraiseVO praise = praiseService.getPraiseDetail(praiseId);
		model.addAttribute("praise", praise);
		return "user_service/03_praiseDetail"; // ✅ 파일명에 맞춤
	}

	// 칭찬릴레이 작성 폼
	@GetMapping("/writeForm.do")
	public String writeForm() {
		return "user_service/03_praiseWrite"; // ✅ 오타 수정: praise.jsp → praiseWrite.jsp
	}

	// 작성 처리
	@PostMapping("/write.do")
	public String write(PraiseVO praise, HttpSession session) {
		PatientVO loginUser = (PatientVO) session.getAttribute("loginUser");
		if (loginUser == null)
			return "redirect:/patient/selectForm.do";

		praise.setPatientUserId(loginUser.getPatientUserId());
		praiseService.insertPraise(praise);
		return "redirect:/03_praise/list.do"; // ✅ prefix 수정
	}

	// 수정 폼
	@GetMapping("/editForm.do")
	public String editForm(@RequestParam("praiseId") int praiseId, Model model, HttpSession session) {
		PatientVO loginUser = (PatientVO) session.getAttribute("loginUser");
		if (loginUser == null)
			return "redirect:/patient/selectForm.do";

		PraiseVO praise = praiseService.getPraiseDetail(praiseId);
		if (!praise.getPatientUserId().equals(loginUser.getPatientUserId())) {
			return "redirect:/03_praise/list.do";
		}

		model.addAttribute("praise", praise);
		return "user_service/03_praiseEdit"; // ✅ 파일명에 맞춤
	}

	// 수정 처리
	@PostMapping("/edit.do")
	public String edit(PraiseVO praise, HttpSession session) {
		PatientVO loginUser = (PatientVO) session.getAttribute("loginUser");
		if (loginUser == null)
			return "redirect:/patient/selectForm.do";

		PraiseVO originalPraise = praiseService.getPraiseDetail(praise.getPraiseId());
		if (!originalPraise.getPatientUserId().equals(loginUser.getPatientUserId())) {
			return "redirect:/03_praise/list.do";
		}

		praise.setPatientUserId(loginUser.getPatientUserId());
		praiseService.updatePraise(praise);
		return "redirect:/03_praise/detail.do?praiseId=" + praise.getPraiseId();
	}

	// 삭제 처리
	@PostMapping("/delete.do")
	public String delete(@RequestParam("praiseId") int praiseId, HttpSession session) {
		PatientVO loginUser = (PatientVO) session.getAttribute("loginUser");
		if (loginUser == null)
			return "redirect:/patient/selectForm.do";

		PraiseVO praise = praiseService.getPraiseDetail(praiseId);
		if (!praise.getPatientUserId().equals(loginUser.getPatientUserId())) {
			return "redirect:/03_praise/list.do";
		}

		praiseService.deletePraise(praiseId);
		return "redirect:/03_praise/list.do";
	}
}
