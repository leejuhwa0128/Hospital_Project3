package com.hospital.controller;

import com.hospital.service.DepartmentService;
import com.hospital.service.Record2Service;
import com.hospital.service.Referral2Service;
import com.hospital.vo.DepartmentVO;
import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.PartnerHospitalVO;
import com.hospital.vo.ReferralCommentVO;
import com.hospital.vo.ReferralRequestVO;
import com.hospital.vo.UserVO;
import com.hospital.vo.ReferralReplyVO;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/referral2")
public class Referral2Controller {

	@Autowired
	private Referral2Service referral2Service;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private Record2Service record2Service;

	// ✅ 협진 신청 폼 호출
	@GetMapping("/requestForm.do")
	public String showReferralRequestForm(@RequestParam("recordId") int recordId,
	                                      Model model,
	                                      HttpSession session) {
	    boolean isDuplicate = referral2Service.isReferralAlreadySent(recordId);
	    System.out.println("DEBUG : isDuplicate: " + isDuplicate);

	    ReferralRequestVO requestVO = referral2Service.convertToReferralRequest(recordId);
	    requestVO.setRecordId(recordId);
	    requestVO.setDuplicate(isDuplicate); // 🔥 JSP에서 <c:when test="${requestVO.duplicate}"> 가능

	    model.addAttribute("requestVO", requestVO);
	    model.addAttribute("duplicate", isDuplicate);

	    // ✅ 병원 목록
	    List<PartnerHospitalVO> hospitals = referral2Service.getAllPartnerHospitals();
	    model.addAttribute("hospitals", hospitals);

	    // ✅ 진료과 목록 (DB)
	    List<DepartmentVO> departments = departmentService.getAllDepartments();
	    model.addAttribute("departments", departments);

	    return "doctor/referral_request_form";
	}

	@GetMapping("/doctors/past_certificates.do")
	public String showPastMedicalRecords(Model model, HttpSession session) {
	    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "redirect:/user/loginForm.do";
	    }

	    String doctorId = loginUser.getUserId();
	    List<MedicalRecordVO> records = record2Service.getAllRecordsWithDuplicateCheckByDoctorId(doctorId);

	    // 디버깅 출력 (선택적)
	    for (MedicalRecordVO record : records) {
	        System.out.println("recordId: " + record.getRecordId() + " / duplicate: " + record.isDuplicate());
	    }

	    model.addAttribute("recordList", records);
	    return "doctor/past_certificates"; // JSP로 forward (이제 안전)
	}

	// ✅ 협진 요청 등록 처리
//    @PostMapping("/submitRequest.do")
//    public String submitReferralRequest(@ModelAttribute ReferralRequestVO requestVO,
//                                        HttpSession session) {
//        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
//
//        if (loginUser == null) {
//            return "redirect:/user/loginForm.do";
//        }
//
//        requestVO.setDoctorId(loginUser.getUserId()); // ✅ 보내는 의사
//        // ✅ userId, hospitalId는 폼에서 선택된 값이 이미 들어옴 → set 안 해도 됨
//        requestVO.setStatus("접수");
//        
//        
//        requestVO.setUserId(loginUser.getUserId());
//        referralService.insertReferralRequest(requestVO);
//        return "redirect:/referral/history.do";
//    }
	
	
	@PostMapping("/submitRequest.do")
	public String submitReferralRequest(@ModelAttribute ReferralRequestVO requestVO,
	                                    HttpSession session) {
	    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "redirect:/user/loginForm.do";
	    }

	    // 협진 요청 등록
	    requestVO.setDoctorId(loginUser.getUserId());
	    requestVO.setStatus("접수");
	    referral2Service.insertReferralRequest(requestVO);

	    // 진료기록 요청 상태 업데이트
	    record2Service.updateRequestedStatus(requestVO.getRecordId(), true);

	    // ✅ 여기서 redirect
	    return "redirect:/past_certificates.do";
	}

	// ✅ 병원 ID로 해당 병원의 의사 목록 조회 (AJAX 용)
	@GetMapping("/doctors.do")
	@ResponseBody
	public List<UserVO> getDoctorsByHospital(@RequestParam("hospitalId") int hospitalId) {
		return referral2Service.getDoctorsByHospital(hospitalId);
	}

	// ✅ 협진 요청 수신 목록 - 우리 병원에 들어온 요청들
	@GetMapping("/received.do")
	public String showReceivedReferrals(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
			return "redirect:/user/loginForm.do";
		}

		int hospitalId = loginUser.getHospitalId();
		String userId = loginUser.getUserId();

		// 🔁 내가 보낸 것 + 우리 병원이 받은 것 모두 조회
		List<ReferralRequestVO> referrals = referral2Service.getVisibleReferrals(hospitalId, userId);
		model.addAttribute("requests", referrals);

		return "doctor/received_referrals"; // JSP는 그대로 사용

	}

	@GetMapping("detail.do")
	public String showReferralDetail(@RequestParam("requestId") int requestId, Model model, HttpSession session,
			RedirectAttributes redirectAttributes) {
		// 로그인 사용자 가져오기
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
			return "redirect:/user/loginForm.do";
		}

		// 1. 진료의뢰 상세 정보
		ReferralRequestVO request = referral2Service.getReferralRequestById(requestId);
		if (request == null) {
			redirectAttributes.addFlashAttribute("error", "해당 진료의뢰를 찾을 수 없습니다.");
			return "redirect:/referral2/received.do";
		}

		// 2. 회신 내용 (있을 수도 있고 없을 수도 있음)
		ReferralReplyVO reply = referral2Service.getReplyByRequestId(requestId);

		// 3. 댓글 목록
		List<ReferralCommentVO> comments = referral2Service.getReferralCommentsByRequestId(requestId);

		// model 등록
		model.addAttribute("request", request);
		model.addAttribute("reply", reply);
		model.addAttribute("comments", comments);
		model.addAttribute("loginUser", loginUser);

		return "doctor/referral_detail";

	}

	@PostMapping("/addComment.do") // 댓글달기
	public String addComment(@RequestParam("requestId") int requestId, @RequestParam("commentText") String commentText,
			HttpSession session, RedirectAttributes redirectAttributes) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
			return "redirect:/user/loginForm.do";
		}

		ReferralCommentVO comment = new ReferralCommentVO();
		comment.setRequestId(requestId);
		comment.setDoctorId(loginUser.getUserId());
		comment.setCommentText(commentText);

		referral2Service.addComment(comment);

		return "redirect:/referral2/detail.do?requestId=" + requestId;
	}

	@PostMapping("/updateComment.do")
	public String updateComment(@RequestParam("commentId") int commentId, @RequestParam("requestId") int requestId,
			@RequestParam("commentText") String commentText, HttpSession session,
			RedirectAttributes redirectAttributes) {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
			return "redirect:/loginForm.do";
		}

		ReferralCommentVO comment = new ReferralCommentVO();
		comment.setCommentId(commentId);
		comment.setDoctorId(loginUser.getUserId());
		comment.setCommentText(commentText);

		referral2Service.updateComment(comment);

		return "redirect:/referral2/detail.do?requestId=" + requestId;
	}

	@PostMapping("/deleteComment.do")
	public String deleteComment(@RequestParam("commentId") int commentId, @RequestParam("requestId") int requestId,
			HttpSession session, RedirectAttributes redirectAttributes) {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
			return "redirect:/loginForm.do";
		}

		referral2Service.deleteComment(commentId, loginUser.getUserId());

		return "redirect:/referral2/detail.do?requestId=" + requestId;
	}

}
