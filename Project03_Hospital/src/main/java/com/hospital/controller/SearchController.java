package com.hospital.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hospital.service.DepartmentService;
import com.hospital.service.NoticeService;
import com.hospital.service.EventService;
import com.hospital.service.FaqService;
import com.hospital.service.FeedbackService;
import com.hospital.service.PraiseService;
import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.NoticeVO;
import com.hospital.vo.EventVO;
import com.hospital.vo.FaqVO;
import com.hospital.vo.FeedbackVO;
import com.hospital.vo.PraiseVO;
import com.hospital.vo.SearchResultVO;

@Controller
public class SearchController {

    @Autowired
    private DepartmentService departmentService;
    
    @Autowired
    private NoticeService noticeService;

    @Autowired
    private EventService eventService;
    
    @Autowired
    private FaqService faqService;
    
    @Autowired
    private FeedbackService feedbackService;
    
    @Autowired
    private PraiseService praiseService;

    @GetMapping("/search/result.do")
    public String searchResult(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        String searchKeyword = (keyword != null && !keyword.trim().isEmpty()) ? keyword.trim() : null;

        if (searchKeyword == null) {
            return "search/result";
        }

        List<DoctorVO> doctorResults = departmentService.searchDoctors(searchKeyword);
        List<DepartmentVO> departmentResults = departmentService.searchDepartments(searchKeyword);
        
        // 병원 정보 카테고리별로 리스트 분리
        List<SearchResultVO> introResults = new ArrayList<>();
        List<SearchResultVO> facilitiesResults = new ArrayList<>();
        List<SearchResultVO> newsResults = new ArrayList<>();
        List<SearchResultVO> csrResults = new ArrayList<>();
        
        List<NoticeVO> noticeResults = new ArrayList<>();
        List<EventVO> lectureResults = new ArrayList<>();
        List<FaqVO> faqResults = new ArrayList<>();
        List<FeedbackVO> feedbackResults = new ArrayList<>();
        List<PraiseVO> praiseResults = new ArrayList<>();
        
        // 기존의 문자열 데이터는 그대로 사용
        String overviewContent = "MEDIPRIME은 환자 중심의 의료 서비스를 제공하며, 지역 사회 건강 증진에 기여하고자 설립되었습니다. 최첨단 의료 시설과 최고의 의료진을 기반으로, 정확한 진단과 효과적인 치료를 통해 환자분들의 빠른 회복과 건강한 삶을 되찾아 드리는 데 최선을 다하고 있습니다.";
        String missionVisionContent = "최고의 의료 서비스로 환자의 건강과 행복을 최우선으로 생각하며, 지역 사회의 건강 증진에 기여합니다. MEDIPRIME의 존재 이유이자 궁극적인 목표입니다. 환자 한 분 한 분의 건강과 삶의 질 향상을 위해 모든 역량을 집중하고, 나아가 지역 주민 전체의 건강 파트너가 되는 것을 사명으로 삼습니다. 미션을 달성하기 위한 구체적인 미래상입니다. 최신 기술을 접목한 스마트 의료 시스템을 통해 의료 서비스의 질을 높이고, 지역 사회로부터 가장 신뢰받는 병원이 되고자 합니다.";
        String greetingContent = "건강한 사회를 실현하기 위해 끊임없는 혁신과 도전을 이어가며, 환자 여러분의 믿음에 보답하겠습니다. 존경하는 환자분들과 지역 사회 구성원 여러분, MEDIPRIME 병원장 김핑구입니다.";
        String historyContent = "2025년03월 미래의학 연구센터 착공, 비대면 진료 플랫폼 구축 등 진행 중. 07월 강남구 우수 의료기관 표창, 취약계층 의료비 지원 확대. 08월 응급의료센터 심정지 대응 시스템 고도화. 09월 병원 내 약제 자동 분배 시스템 도입. 12월 서울대학교병원과 진료협력 협약 체결. 2023년. 03월 소화기 내시경 장비 전면 교체 완료. 06월 병원 고객만족도 조사 1위. 07월 건강검진센터 리뉴얼 및 개인 맞춤형 정밀 검진 프로그램 도입. 10월 국내 5대 보험사와 협진 계약 체결. 11월 AI 기반 의료 영상 분석 시스템 도입";
        String organizationChartContent = "환자 중심의 효율적인 의료 서비스 제공을 위해 조직이 구성되어 있습니다.";
        String philosophyContent = "MEDIPRIME의 모든 진료과는 환자 중심의 가치를 최우선으로 삼아 운영됩니다.";
        String virtualTourContent = "본 병원의 주요 시설 및 진료 환경을 미리 체험해보실 수 있습니다. 아래 영상을 통해 병원의 내부 구조를 확인해보세요.";
        String statisticsContent = "인원 현황, 병상 현황, 수술 및 검사 실적, 환자 수 현황";
        String directionsContent = "MEDIPRIME 병원에 오시는 길을 상세히 안내해 드립니다. 지하철 이용안내, 버스 이용 안내, 도보 안내, 자가용 이용 안내 등 다양한 방법으로 오실 수 있습니다. 특히 자가용을 이용하시는 경우 강남대로에서 역삼로로 진입하여 성보역삼빌딩을 찾으시면 건물 앞 주차장을 30분 무료로 이용하실 수 있습니다.";
        String facilitiesContent = "MEDIPRIME 병원의 층별 시설을 안내해 드립니다. 병원 내에는 맛있어 식당과 다있어 편의점 등의 주변 편의시설이 있으며, 특히 B관 B2층 로비에서는 24시간 이용 가능한 건강해 카페, 행복해카페, 쉬어가 휴게실, 다줄게은행, 아프지마약국, 돈많아 ATM, 향긋해 꽃집 등을 이용할 수 있습니다.";
        String convenienceContent = "병원 주변의 맛있어 식당과 다있어 편의점 등 다양한 편의 시설을 안내해 드립니다.";
        String phoneContent = "MEDIPRIME 병원의 주요 전화번호를 안내해 드립니다. 대표번호, 진료예약, 건강검진, 고객센터 등 용도에 맞는 전화번호를 확인할 수 있습니다.";
        String recruitContent = "MEDIPRIME 병원 채용 공고를 확인하고 지원할 수 있는 페이지입니다.";
        String pressContent = "메디프라임 병원의 주요 언론 보도 내용입니다: 로봇 수술 1천례 달성, 지역 사회와 함께하는 건강 나눔 캠페인 전개, 인공지능 기반 진단 시스템 도입, 그리고 지역 의료 혁신을 선도하는 첨단 진료 시스템과 환자 중심 케어 강화에 대한 내용이 있습니다.";
        String healthinfoContent = "환자와 일반인을 위한 다양한 건강 정보, 질환 예방 및 관리 팁을 제공합니다.";
        String newsContent = "병원 소식입니다: 건강한 여름나기 캠페인 안내, 신규 의료진 초빙 안내, 야간 진료 확대 운영, 그리고 지역 주민을 위한 무료 건강 강좌 개최 등 다양한 소식을 전해드립니다.";
        String donationContent = "의료 소외 계층을 위한 기부금 전달 및 봉사 활동을 진행합니다.";
        String volunteerContent = "메디프라임 병원은 국내외 취약 지역을 대상으로 의료 봉사를 실천하고 있습니다. 의료진과 자원봉사자들이 함께 건강한 사회를 만들기 위해 노력하며, 2025년 8월 1일에는 국내 외진 지역에서 의료 봉사를 진행하는 등 꾸준한 활동을 이어가고 있습니다.";
        String esgContent = "메디프라임 병원은 환경(Environment), 사회(Social), 지배구조(Governance)를 고려한 지속가능 경영을 실천합니다. 친환경 병원 운영, 지역사회 기여, 투명한 경영을 통해 건강한 미래를 만들어가는 데 노력하고 있습니다.";
        String communityContent = "메디프라임 병원은 지역 사회와의 협력을 통해 주민들의 건강 증진과 복지 향상을 위한 다양한 프로그램을 운영하고 있습니다. 건강 강좌, 무료 검진, 그리고 지역 행사 지원 등을 통해 지역과 함께 성장하는 활동을 펼치고 있습니다.";

        // 병원 소개 관련 내용 검색
        if (overviewContent.contains(searchKeyword) || missionVisionContent.contains(searchKeyword) || greetingContent.contains(searchKeyword) || organizationChartContent.contains(searchKeyword) || philosophyContent.contains(searchKeyword) || virtualTourContent.contains(searchKeyword) || statisticsContent.contains(searchKeyword) || historyContent.contains(searchKeyword)) {
            if (overviewContent.contains(searchKeyword)) introResults.add(new SearchResultVO("병원 개요", "병원 소개", "/01_overview.do", overviewContent));
            if (missionVisionContent.contains(searchKeyword)) introResults.add(new SearchResultVO("미션/비전", "병원 소개", "/01_mission.do", missionVisionContent));
            if (greetingContent.contains(searchKeyword)) introResults.add(new SearchResultVO("인사말", "병원 소개", "/01_greeting.do", greetingContent));
            if (historyContent.contains(searchKeyword)) introResults.add(new SearchResultVO("연혁", "병원 소개", "/01_history.do", historyContent));
            if (organizationChartContent.contains(searchKeyword)) introResults.add(new SearchResultVO("조직도", "병원 소개", "/01_orgchart.do", organizationChartContent));
            if (philosophyContent.contains(searchKeyword)) introResults.add(new SearchResultVO("운영 철학", "병원 소개", "/01_philosophy.do", philosophyContent));
            if (virtualTourContent.contains(searchKeyword)) introResults.add(new SearchResultVO("병원 둘러보기", "병원 소개", "/01_tour.do", virtualTourContent));
            if (statisticsContent.contains(searchKeyword)) introResults.add(new SearchResultVO("현황 및 통계", "병원 소개", "/01_statistics.do", statisticsContent));
        }

        // 주요 시설 관련 내용 검색
        if (directionsContent.contains(searchKeyword) || facilitiesContent.contains(searchKeyword) || convenienceContent.contains(searchKeyword) || phoneContent.contains(searchKeyword)) {
            if (directionsContent.contains(searchKeyword)) facilitiesResults.add(new SearchResultVO("병원 오시는 길", "주요 시설 안내", "/02_directions.do", directionsContent));
            if (facilitiesContent.contains(searchKeyword)) facilitiesResults.add(new SearchResultVO("층별 시설 안내", "주요 시설 안내", "/02_facilities.do", facilitiesContent));
            if (convenienceContent.contains(searchKeyword)) facilitiesResults.add(new SearchResultVO("주변 편의 시설", "주요 시설 안내", "/02_convenience.do", convenienceContent));
            if (phoneContent.contains(searchKeyword)) facilitiesResults.add(new SearchResultVO("전화번호 안내", "주요 시설 안내", "/02_phone.do", phoneContent));
        }
        
        // 병원 소식 관련 내용 검색
        if (recruitContent.contains(searchKeyword) || pressContent.contains(searchKeyword) || healthinfoContent.contains(searchKeyword) || newsContent.contains(searchKeyword)) {
            if (recruitContent.contains(searchKeyword)) newsResults.add(new SearchResultVO("채용 정보", "병원 소식", "/03_recruit.do", recruitContent));
            if (pressContent.contains(searchKeyword)) newsResults.add(new SearchResultVO("언론 보도", "병원 소식", "/03_press.do", pressContent));
            if (healthinfoContent.contains(searchKeyword)) newsResults.add(new SearchResultVO("건강 정보", "병원 소식", "/03_healthinfo.do", healthinfoContent));
            if (newsContent.contains(searchKeyword)) newsResults.add(new SearchResultVO("병원 소식", "병원 소식", "/03_news.do", newsContent));
        }
        
        // 사회공헌 관련 내용 검색
        if (donationContent.contains(searchKeyword) || volunteerContent.contains(searchKeyword) || esgContent.contains(searchKeyword) || communityContent.contains(searchKeyword)) {
            if (donationContent.contains(searchKeyword)) csrResults.add(new SearchResultVO("나눔과 기부", "사회공헌", "/04_donation.do", donationContent));
            if (volunteerContent.contains(searchKeyword)) csrResults.add(new SearchResultVO("의료 봉사", "사회공헌", "/04_volunteer.do", volunteerContent));
            if (esgContent.contains(searchKeyword)) csrResults.add(new SearchResultVO("ESG 경영", "사회공헌", "/04_esg.do", esgContent));
            if (communityContent.contains(searchKeyword)) csrResults.add(new SearchResultVO("커뮤니티 활동", "사회공헌", "/04_community.do", communityContent));
        }

        // 서비스 클래스에서 검색 결과 가져오기 (기존 코드)
        List<NoticeVO> foundNotices = noticeService.searchNoticesByKeyword(searchKeyword);
        if (foundNotices != null && !foundNotices.isEmpty()) {
            noticeResults.addAll(foundNotices);
        }
        List<EventVO> foundLectures = eventService.searchEventsByKeyword(searchKeyword);
        if (foundLectures != null && !foundLectures.isEmpty()) {
            lectureResults.addAll(foundLectures);
        }
        List<FaqVO> foundFaqs = faqService.searchFaqsByKeyword(searchKeyword);
        if (foundFaqs != null && !foundFaqs.isEmpty()) {
            faqResults.addAll(foundFaqs);
        }
        List<FeedbackVO> foundFeedbacks = feedbackService.searchFeedbacksByKeyword(searchKeyword);
        if (foundFeedbacks != null && !foundFeedbacks.isEmpty()) {
            feedbackResults.addAll(foundFeedbacks);
        }
        List<PraiseVO> foundPraises = praiseService.searchPraisesByKeyword(searchKeyword);
        if (foundPraises != null && !foundPraises.isEmpty()) {
            praiseResults.addAll(foundPraises);
        }

        // 모델에 추가
        model.addAttribute("doctorResults", doctorResults);
        model.addAttribute("doctorCount", doctorResults.size());
        model.addAttribute("departmentResults", departmentResults);
        model.addAttribute("departmentCount", departmentResults.size());
        
        model.addAttribute("introResults", introResults);
        model.addAttribute("introCount", introResults.size());
        
        model.addAttribute("facilitiesResults", facilitiesResults);
        model.addAttribute("facilitiesCount", facilitiesResults.size());
        
        model.addAttribute("newsResults", newsResults);
        model.addAttribute("newsCount", newsResults.size());
        
        model.addAttribute("csrResults", csrResults);
        model.addAttribute("csrCount", csrResults.size());
        
        model.addAttribute("noticeResults", noticeResults);
        model.addAttribute("noticeCount", noticeResults.size());
        model.addAttribute("lectureResults", lectureResults);
        model.addAttribute("lectureCount", lectureResults.size());
        model.addAttribute("faqResults", faqResults);
        model.addAttribute("faqCount", faqResults.size());
        model.addAttribute("feedbackResults", feedbackResults);
        model.addAttribute("feedbackCount", feedbackResults.size());
        model.addAttribute("praiseResults", praiseResults);
        model.addAttribute("praiseCount", praiseResults.size());

        model.addAttribute("searchKeyword", searchKeyword);
        
        return "search/result";
    }
}