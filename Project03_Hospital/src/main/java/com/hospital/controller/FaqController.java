package com.hospital.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hospital.service.FaqService;
import com.hospital.vo.FaqVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/03_faq")
public class FaqController {

    @Autowired
    private FaqService faqService;

    // FAQ 목록
    @GetMapping("/list.do")
    public String listFaqs(
        @RequestParam(required = false) String category,
        @RequestParam(required = false) String keyword,
        @RequestParam(defaultValue = "1") int page,
        Model model) {

        int pageSize = 10;
        int start = (page - 1) * pageSize;

        Map<String, Object> param = new HashMap<>();
        param.put("category", category);
        param.put("keyword", keyword);
        param.put("start", start);
        param.put("pageSize", pageSize);

        List<FaqVO> faqList = faqService.getFaqList(param);
        int totalCount = faqService.getFaqCount(param);

        model.addAttribute("faqList", faqList);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);

        return "user_service/03_faqList";
    }

    // FAQ 작성 폼
    @GetMapping("/write.do")
    public String showWriteForm() {
        return "user_service/03_faqWrite";
    }

    // FAQ 작성 처리
    @PostMapping("/write.do")
    public String submitFaq(@ModelAttribute FaqVO faq) {
        faqService.insertFaq(faq);
        return "redirect:/03_faq/list.do";
    }

    // FAQ 수정 폼
    @GetMapping("/edit.do")
    public String showEditForm(@RequestParam("id") int id, Model model) {
        model.addAttribute("faq", faqService.getFaqById(id));
        return "user_service/03_faqEdit";
    }

    // FAQ 수정 처리
    @PostMapping("/edit.do")
    public String updateFaq(@ModelAttribute FaqVO faq) {
        faqService.updateFaq(faq);
        return "redirect:/03_faq/list.do";
    }
}
