package com.hospital.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hospital.service.EventService;
import com.hospital.service.SearchService;
import com.hospital.vo.EventVO;
import com.hospital.vo.SearchResultVO;



@Controller
public class HeaderController {
	@RequestMapping("/header.do")
	public String showHeader() {
		return "header";
	}

	// 공통
	@RequestMapping("/login.do")
	public String showLoginPage() {
		return "login";
	}

	@RequestMapping("/mypage.do")
	public String mypage() {
		return "user/mypage";
	}

	@RequestMapping("/01_main_info.do")
	public String mainInfo1() {
		return "hospital_info/01_main_info";
	}

	@RequestMapping("/02_main_info.do")
	public String mainInfo2() {
		return "hospital_info/02_main_info";
	}

	@RequestMapping("/03_main_info.do")
	public String mainInfo3() {
		return "hospital_info/03_main_info";
	}

	@RequestMapping("/04_main_info.do")
	public String mainInfo4() {
		return "hospital_info/04_main_info";
	}
	
	@RequestMapping("/privacy_policy.do")
	public String privacy_policy() {
		return "notice/privacy_policy";
	}

	// 검색
	@Autowired
	private ServletContext servletContext;

	@Autowired
	private SearchService searchService;
	
	@Autowired
	private EventService eventService;


	@RequestMapping("/search.do")
	public String search(@RequestParam("keyword") String keyword, Model model) {
	    String realPath = servletContext.getRealPath("/");

	    Map<String, List<SearchResultVO>> groupedResults = searchService.searchGroupedByCategory(realPath, keyword);

	    // 🔸 Search라는 제목 가진 항목 제거 (예시용 필터링)
	    for (List<SearchResultVO> list : groupedResults.values()) {
	        list.removeIf(result -> "Search".equalsIgnoreCase(result.getTitle()));
	    }

	    model.addAttribute("groupedResults", groupedResults);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("title", "검색 결과");

	    return "hospital_info/search";
	}



	// 병원 소개 (01_)
	@RequestMapping("/01_overview.do")
	public String overview(Model model) {
		model.addAttribute("target", "01_overview.jsp");
		model.addAttribute("title", "병원 소개");
		return "hospital_info/01_intro";
	}

	@RequestMapping("/01_mission.do")
	public String mission(Model model) {
		model.addAttribute("target", "01_mission.jsp");
		model.addAttribute("title", "병원 소개");
		return "hospital_info/01_intro";
	}

	@RequestMapping("/01_greeting.do")
	public String greeting(Model model) {
		model.addAttribute("target", "01_greeting.jsp");
		model.addAttribute("title", "병원 소개");
		return "hospital_info/01_intro";
	}

	@RequestMapping("/01_history.do")
	public String history(Model model) {
		model.addAttribute("target", "01_history.jsp");
		model.addAttribute("title", "병원 소개");
		return "hospital_info/01_intro";
	}

	@RequestMapping("/01_partners.do")
	public String partners(Model model) {
		model.addAttribute("target", "01_partners.jsp");
		model.addAttribute("title", "병원 소개");
		return "hospital_info/01_intro";
	}

	@RequestMapping("/01_orgchart.do")
	public String orgchart(Model model) {
		model.addAttribute("target", "01_orgchart.jsp");
		model.addAttribute("title", "병원 소개");
		return "hospital_info/01_intro";
	}

	@RequestMapping("/01_philosophy.do")
	public String philosophy(Model model) {
		model.addAttribute("target", "01_philosophy.jsp");
		model.addAttribute("title", "병원 소개");
		return "hospital_info/01_intro";
	}

	@RequestMapping("/01_tour.do")
	public String tour(Model model) {
		model.addAttribute("target", "01_tour.jsp");
		model.addAttribute("title", "병원 소개");
		return "hospital_info/01_intro";
	}

	@RequestMapping("/01_statistics.do")
	public String statistics(Model model) {
		model.addAttribute("target", "01_statistics.jsp");
		model.addAttribute("title", "병원 소개");
		return "hospital_info/01_intro";
	}

	// 주요 시설 안내 (02_)
	@RequestMapping("/02_directions.do")
	public String directions(Model model) {
		model.addAttribute("target", "02_directions.jsp");
		model.addAttribute("title", "주요 시설 안내");
		return "hospital_info/02_intro";
	}

	@RequestMapping("/02_facilities.do")
	public String facilities(Model model) {
		model.addAttribute("target", "02_facilities.jsp");
		model.addAttribute("title", "주요 시설 안내");
		return "hospital_info/02_intro";
	}

	@RequestMapping("/02_convenience.do")
	public String convenience(Model model) {
		model.addAttribute("target", "02_convenience.jsp");
		model.addAttribute("title", "주요 시설 안내");
		return "hospital_info/02_intro";
	}

	@RequestMapping("/02_phone.do")
	public String phone(Model model) {
		model.addAttribute("target", "02_phone.jsp");
		model.addAttribute("title", "주요 시설 안내");
		return "hospital_info/02_intro";
	}

	// 병원 소식 (03_)

	@RequestMapping("/03_news.do")
	public String press(Model model) {
		model.addAttribute("target", "03_news.jsp");
		model.addAttribute("title", "병원 소식");
		return "hospital_info/03_intro";
	}

	@RequestMapping("/03_recruit.do")
	public String recruit(Model model) {
		model.addAttribute("target", "03_recruit.jsp");
		model.addAttribute("title", "병원 소식");
		return "hospital_info/03_intro";
	}

	@RequestMapping("/03_press.do")
	public String newsletter(Model model) {
		model.addAttribute("target", "03_press.jsp");
		model.addAttribute("title", "병원 소식");
		return "hospital_info/03_intro";
	}
	
	@RequestMapping("/03_press_view.do")
	public String pressView(@RequestParam("eventId") int eventId, Model model) {
	    System.out.println("▶▶ pressView 실행됨 / eventId = " + eventId);
	    
	    EventVO before = eventService.getEventByIdInfo(eventId);
	    System.out.println("[이전 조회수] " + before.getViewCount());

	    eventService.incrementViewCount(eventId);

	    EventVO after = eventService.getEventByIdInfo(eventId);
	    System.out.println("[증가 후 조회수] " + after.getViewCount());

	    model.addAttribute("event", after);
	    model.addAttribute("target", "03_press_view.jsp");
	    model.addAttribute("title", "언론보도 상세");

	    return "hospital_info/03_intro";
	}





	
	

	@RequestMapping("/03_healthinfo.do")
	public String healthinfo(Model model) {
		model.addAttribute("target", "03_healthinfo.jsp");
		model.addAttribute("title", "병원 소식");
		return "hospital_info/03_intro";
	}

	// 사회공헌 (04_)
	@RequestMapping("/04_donation.do")
	public String donation(Model model) {
		model.addAttribute("target", "04_donation.jsp");
		model.addAttribute("title", "사회 공헌");
		return "hospital_info/04_intro";
	}

	@RequestMapping("/04_volunteer.do")
	public String volunteer(Model model) {
		model.addAttribute("target", "04_volunteer.jsp");
		model.addAttribute("title", "사회 공헌");
		return "hospital_info/04_intro";
	}
	
	@RequestMapping(value = "/hospital_info/volunteer/detail.do", method = RequestMethod.GET)
	public String detail(@RequestParam(defaultValue = "1") int id, Model model) {
	    model.addAttribute("id", id);
	    return "hospital_info/04_volunteerDetail";
	}



	@RequestMapping("/04_esg.do")
	public String esg(Model model) {
		model.addAttribute("target", "04_esg.jsp");
		model.addAttribute("title", "사회 공헌");
		return "hospital_info/04_intro";
	}

	@RequestMapping("/04_community.do")
	public String community(Model model) {
		model.addAttribute("target", "04_community.jsp");
		model.addAttribute("title", "사회 공헌");
		return "hospital_info/04_intro";
	}
}
