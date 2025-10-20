package com.hospital.controller;

import com.hospital.service.NoticeService;
import com.hospital.vo.NoticeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/01_notice")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	@GetMapping("/list.do")
	public String showNoticeList(Model model) {
		List<NoticeVO> noticeList = noticeService.getAllNotices();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		noticeList = noticeList.stream().peek(n -> {
			if (n.getCreatedAt() != null)
				n.setCreatedAtStr(sdf.format(n.getCreatedAt()));
		}).collect(Collectors.toList());

		model.addAttribute("noticeList", noticeList);
		return "user_service/01_noticeList";
	}

	@GetMapping("/detail.do")
	public String showNoticeDetail(@RequestParam("noticeId") int id, Model model) {
		NoticeVO notice = noticeService.getNoticeById(id);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		if (notice.getCreatedAt() != null)
			notice.setCreatedAtStr(sdf.format(notice.getCreatedAt()));

		model.addAttribute("notice", notice);
		return "user_service/01_noticeDetail";
	}
}
