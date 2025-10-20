// src/main/java/com/hospital/controller/CommunityController.java
package com.hospital.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CommunityController {

    /** 커뮤니티 목록 */
    @GetMapping("/hospital_info/community/list.do")
    public String list(
            @RequestParam(defaultValue = "1") int page,
            Model model
    ) {
        // 페이징(목록 카드 수와 perPage는 JSP/JS와 맞춰주세요)
        int totalItems = 9;   // 카드 총 개수 예시
        int perPage = 6;
        int totalPages = (int) Math.ceil(totalItems / (double) perPage);

        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);

        // /WEB-INF/jsp/hospital_info/04_community.jsp
        return "hospital_info/04_community";
    }

    /** 커뮤니티 상세 */
    @GetMapping("/hospital_info/community/detail.do")
    public String detail(
            @RequestParam(defaultValue = "1") int id,
            @RequestParam(defaultValue = "1") int page,
            Model model
    ) {
        model.addAttribute("id", id);
        model.addAttribute("page", page); // 목록으로 돌아갈 때 현재 페이지 유지용

        // /WEB-INF/jsp/hospital_info/04_communityDetail.jsp
        return "hospital_info/04_communityDetail";
    }

    /* ===== 레거시/단축 경로 호환 ===== */

    /** /04_community.do -> 정식 목록 URL로 리디렉트 */
    @GetMapping("/04_community.do")
    public String redirectList(@RequestParam(required = false) Integer page) {
        if (page != null) return "redirect:/hospital_info/community/list.do?page=" + page;
        return "redirect:/hospital_info/community/list.do";
    }

    /** /04_communityDetail.do -> 정식 상세 URL로 리디렉트 */
    @GetMapping("/04_communityDetail.do")
    public String redirectDetail(
            @RequestParam(required = false) Integer id,
            @RequestParam(required = false) Integer page
    ) {
        StringBuilder sb = new StringBuilder("redirect:/hospital_info/community/detail.do");
        boolean first = true;
        if (id != null) {
            sb.append(first ? "?" : "&").append("id=").append(id);
            first = false;
        }
        if (page != null) {
            sb.append(first ? "?" : "&").append("page=").append(page);
        }
        return sb.toString();
    }
}
