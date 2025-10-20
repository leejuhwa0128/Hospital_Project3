package com.hospital.controller;

import com.hospital.service.EventService;
import com.hospital.vo.EventVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/01_lecture")
public class LectureController {

    @Autowired
    private EventService eventService;

    /** 🔹 강좌 및 행사 안내 - 사용자 전용 목록 */
    @GetMapping("/list.do")
    public String lectureList(@RequestParam(value = "category", required = false) String category, Model model) {
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
        return "user_service/01_lectureList";
    }


    /** 🔹 강좌 및 행사 상세 보기 */
    @GetMapping("/view.do")
    public String lectureView(@RequestParam("eventId") int eventId, Model model) {
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
        return "user_service/01_lectureView";
    }
}
