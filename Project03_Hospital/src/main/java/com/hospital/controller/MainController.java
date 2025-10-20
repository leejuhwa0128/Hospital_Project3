package com.hospital.controller;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hospital.service.EventService;
import com.hospital.service.NoticeService;
import com.hospital.vo.EventVO;
import com.hospital.vo.NoticeVO;

@Controller
public class MainController {

    @Autowired
    private EventService eventService;

    @Autowired
    private NoticeService noticeService;  // ✅ NoticeService 추가!

    @RequestMapping("/main.do")
    public String mainPage(Model model) {
        // 언론보도는 그대로 EventService에서 가져오기
        List<EventVO> pressList = eventService.getEventsByCategoryInfo("언론");

        // 공지사항은 NoticeService로 가져오기
        List<NoticeVO> noticeList = noticeService.getAllNotices();

        // 공지사항 날짜 포맷 변경
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
        noticeList = noticeList.stream().peek(n -> {
            if (n.getCreatedAt() != null)
                n.setCreatedAtStr(sdf.format(n.getCreatedAt()));
        }).collect(Collectors.toList());  // ✅ toList() 대신 collect(Collectors.toList())

        // 언론보도 3개 제한
        if (pressList.size() > 3) {
            pressList = pressList.subList(0, 3);
        }

        // 공지사항 3개 제한
        if (noticeList.size() > 3) {
            noticeList = noticeList.subList(0, 3);
        }

        model.addAttribute("pressList", pressList);
        model.addAttribute("noticeList", noticeList);

        return "main";
    }
}
