// com.hospital.controller.EsgController.java
package com.hospital.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class EsgController {

    private static final int PER_PAGE = 6;

    /* ========== 정식 경로 ========== */

    @GetMapping("/hospital_info/esg/list.do")
    public String list(@RequestParam(defaultValue = "1") int page, Model model) {
        int totalItems = 9; // 카드 개수(예시)
        int totalPages = (int) Math.ceil((double) totalItems / PER_PAGE);

        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        return "hospital_info/04_esg"; // /WEB-INF/jsp/hospital_info/04_esg.jsp
    }

    @GetMapping("/hospital_info/esg/detail.do")
    public String detail(@RequestParam(defaultValue = "1") int id,
                         @RequestParam(defaultValue = "1") int page,
                         Model model) {
        model.addAttribute("id", id);
        model.addAttribute("page", page);
        return "hospital_info/04_esgDetail"; // /WEB-INF/jsp/hospital_info/04_esgDetail.jsp
    }

    /* ========== 레거시 경로(리다이렉트) ========== */

    @GetMapping("/04_esg.do")
    public String redirectToList(@RequestParam(required = false) Integer page) {
        String q = (page != null) ? "?page=" + page : "";
        return "redirect:/hospital_info/esg/list.do" + q;
    }

    @GetMapping("/04_esgDetail.do")
    public String redirectToDetail(@RequestParam(defaultValue = "1") int id,
                                   @RequestParam(required = false) Integer page) {
        String q = "?id=" + id + ((page != null) ? "&page=" + page : "");
        return "redirect:/hospital_info/esg/detail.do" + q;
    }
}
