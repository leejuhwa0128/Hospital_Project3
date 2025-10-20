package com.hospital.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hospital.service.Notice2Service;
import com.hospital.service.NoticeService;
import com.hospital.vo.NoticeVO;
import com.hospital.vo.UserVO;

@Controller
public class Notice2Controller {

    @Autowired
    private Notice2Service notice2Service;
    @GetMapping("/doctor_notice.do")
    public String showNoticeList(@RequestParam(required = false) String searchType,
                                 @RequestParam(required = false) String keyword,
                                 HttpSession session,
                                 Model model) {

        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/user/login.do";
        }

        String role = loginUser.getRole();

        List<NoticeVO> noticeList;

        if (keyword != null && !keyword.trim().isEmpty()) {
            noticeList = notice2Service.searchNoticesByRoleAndKeyword(role, searchType, keyword);
        } else {
            noticeList = notice2Service.getNoticesByRole(role);
        }

        model.addAttribute("noticeList", noticeList);
        model.addAttribute("searchType", searchType);
        model.addAttribute("keyword", keyword);
        return "notice/doctor_notice";
    }
    @RequestMapping("/doctor_notice_content.do")
    public String noticeDetail(@RequestParam("noticeId") int noticeId,
                                HttpSession session,
                                Model model,
                                HttpServletResponse response) throws IOException {

        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write("<script>alert('로그인이 필요합니다.'); location.href='login.do';</script>");
            return null;
        }

        NoticeVO notice = notice2Service.getNoticeById(noticeId);

        String targetRole = notice.getTargetRole();
        String userRole = loginUser.getRole();

        if (!"all".equals(targetRole) && !userRole.equals(targetRole)) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write("<script>alert('접근 권한이 없습니다.'); history.back();</script>");
            return null;
        }

        model.addAttribute("notice", notice);
        return "notice/doctor_notice_content";
    }
}
