// src/main/java/com/hospital/controller/InformationController.java
package com.hospital.controller;

import com.hospital.service.EventService;
import com.hospital.vo.EventVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class InformationController {

    @Autowired
    private EventService eventService;

    // =======================[ 언론보도 ]=============================
    @GetMapping("/03_press.do")
    public String pressPage(@RequestParam(value = "page", defaultValue = "1") int page,
                            Model model) {
        int pageSize = 5;
        int offset = (page - 1) * pageSize;
        int totalCount = eventService.countEventsByCategory("언론");
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        List<EventVO> list = eventService.getEventsByCategoryWithPaging("언론", offset, pageSize);

        model.addAttribute("events", list);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "hospital_info/03_press";
    }

    @GetMapping("/03_press_view.do")
    public String pressView(@RequestParam("eventId") int eventId, Model model) {
        EventVO event = eventService.getEventByIdInfo(eventId);
        model.addAttribute("event", event);
        model.addAttribute("title", "언론 보도");
        return "hospital_info/03_press_view";
    }

    // =======================[ 채용 공고 ]=============================
    @GetMapping("/03_recruit.do")
    public String recruitPage(@RequestParam(value = "page", defaultValue = "1") int page,
                              @RequestParam(value = "subCategory", required = false) String subCategory,
                              Model model) {
        final int pageSize = 10;
        int offset = (page - 1) * pageSize;

        int totalCount = eventService.countRecruit(subCategory);                 // <- String 전달
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        List<EventVO> list = eventService.selectRecruitPage(subCategory, offset, pageSize); // <- String 전달

        model.addAttribute("recruitList", list);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("subCategory", (subCategory != null && subCategory.trim().isEmpty()) ? null : subCategory);
        return "hospital_info/03_recruit";
    }

    // 상세보기 매핑
    @GetMapping({"/03_recruit_view.do"})
    public String recruitView(@RequestParam("eventId") int eventId, Model model) {
        EventVO event = eventService.getEventByIdInfo(eventId);
        model.addAttribute("event", event);
        model.addAttribute("title", "채용 공고");
        return "hospital_info/03_recruit_view"; // ← 여기!
    }


    // =======================[ 병원 소식 ]=============================
    @GetMapping("/03_news.do")
    public String newsPage(@RequestParam(value = "page", defaultValue = "1") int page,
                           Model model) {
        int pageSize = 5;
        int offset = (page - 1) * pageSize;
        int totalCount = eventService.countEventsByCategory("소식");
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        List<EventVO> list = eventService.getEventsByCategoryWithPaging("소식", offset, pageSize);

        model.addAttribute("events", list);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "hospital_info/03_news";
    }

    @GetMapping("/03_news_view.do")
    public String newsView(@RequestParam("eventId") int eventId, Model model) {
        EventVO event = eventService.getEventByIdInfo(eventId);
        model.addAttribute("event", event);
        model.addAttribute("title", "병원 소식");
        return "hospital_info/03_news_view";
    }

    // =======================[ 건강 정보 ]=============================
    @GetMapping("/03_healthinfo.do")
    public String healthInfoPage(@RequestParam(value = "page", required = false) Integer page,
                                 Model model) {
        final int totalItems = 8;
        final int pageSize   = 6;
        final int totalPages = (int) Math.ceil(totalItems / (double) pageSize);
        if (page == null || page < 1) page = 1;
        if (page > totalPages) page = totalPages;

        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        return "hospital_info/03_healthinfo";
    }

    // =======================[ 공통 - 작성/수정/삭제 ]=============================
    @PostMapping("/info/03_write.do")
    public String writeEventInfo(@ModelAttribute EventVO eventVO) {
        eventService.insertEventInfo(eventVO);
        return "redirect:/03_" + getPathKey(eventVO.getCategory()) + ".do";
    }

    @GetMapping("/info/03_write.do")
    public String showWriteFormInfo(@RequestParam("category") String category, Model model) {
        model.addAttribute("category", category);
        return "hospital_info/03_write";
    }

    @GetMapping("/info/03_edit.do")
    public String editFormInfo(@RequestParam("eventId") int eventId, Model model) {
        EventVO event = eventService.getEventByIdInfo(eventId);
        model.addAttribute("event", event);
        return "hospital_info/03_write";
    }

    @PostMapping("/info/03_update.do")
    public String updateEventInfo(@ModelAttribute EventVO eventVO) {
        eventService.updateEventInfo(eventVO);
        return "redirect:/03_" + getPathKey(eventVO.getCategory()) + ".do";
    }

    @GetMapping("/info/03_delete.do")
    public String deleteEventInfo(@RequestParam("eventId") int eventId,
                                  @RequestParam("category") String category) {
        eventService.deleteEventInfo(eventId);
        return "redirect:/03_" + getPathKey(category) + ".do";
    }

    private String getPathKey(String category) {
        switch (category) {
            case "소식": return "news";
            case "채용": return "recruit";
            case "언론": return "press";
            default:     return "news";
        }
    }

    // 공통 목록 (카테고리별) — 채용은 subCategory까지 처리
    @GetMapping("/info/03_list.do")
    public String eventList(@RequestParam("category") String category,
                            @RequestParam(value = "page", defaultValue = "1") int page,
                            @RequestParam(value = "subCategory", required = false) String subCategory,
                            Model model) {
        int pageSize = 10;
        int offset = (page - 1) * pageSize;

        if ("채용".equals(category)) {
            int totalCount = eventService.countRecruit(subCategory);
            int totalPages = (int) Math.ceil((double) totalCount / pageSize);
            List<EventVO> list = eventService.selectRecruitPage(subCategory, offset, pageSize);

            model.addAttribute("recruitList", list);
            model.addAttribute("subCategory", (subCategory != null && subCategory.trim().isEmpty()) ? null : subCategory);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            return "hospital_info/03_recruit";
        } else {
            int totalCount = eventService.countEventsByCategory(category);
            int totalPages = (int) Math.ceil((double) totalCount / pageSize);
            List<EventVO> list = eventService.getEventsByCategoryWithPaging(category, offset, pageSize);

            model.addAttribute("events", list);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            switch (category) {
                case "소식": return "hospital_info/03_news";
                case "언론": return "hospital_info/03_press";
                default:     return "redirect:/";
            }
        }
    }
}
