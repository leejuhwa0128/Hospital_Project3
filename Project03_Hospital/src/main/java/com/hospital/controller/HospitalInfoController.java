package com.hospital.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/hospital_info")
public class HospitalInfoController {

    @GetMapping("/overview.do")
    public String overview() {
        return "hospital_info/01_overview";
    }

    @GetMapping("/mission_vision.do")
    public String missionVision() {
        return "hospital_info/01_mission";
    }

    @GetMapping("/greeting.do")
    public String greeting() {
        return "hospital_info/01_greeting";
    }

    @GetMapping("/history.do")
    public String history() {
        return "hospital_info/01_history";
    }

    @GetMapping("/organization_chart.do")
    public String organizationChart() {
        return "hospital_info/01_orgchart";
    }

    @GetMapping("/philosophy.do")
    public String philosophy() {
        return "hospital_info/01_philosophy";
    }

    @GetMapping("/virtual_tour.do")
    public String virtualTour() {
        return "hospital_info/01_tour";
    }

    @GetMapping("/statistics.do")
    public String statistics() {
        return "hospital_info/01_statistics";
    }
    
    
 // 주요 시설 안내 페이지
    @GetMapping("/directions.do")
    public String directions() {
        return "hospital_info/02_directions";
    }
    
    @GetMapping("/facilities.do")
    public String facilities() {
        return "hospital_info/02_facilities";
    }
    
    @GetMapping("/convenience.do")
    public String convenience() {
        return "hospital_info/02_convenience";
    }
    
    @GetMapping("/phone.do")
    public String phone() {
        return "hospital_info/02_phone";
    }
    
    //병원 소식
    @GetMapping("/recruit.do")
    public String  recruit() {
        return "hospital_info/03_recruit";
    }
    
    
    @GetMapping("/press.do")
    public String press() {
        return "hospital_info/03_press";
    }
    
    
    @GetMapping("/healthinfo.do")
    public String healthinfo() {
        return "hospital_info/03_healthinfo";
    }
    
    
    @GetMapping("/news.do")
    public String news() {
        return "hospital_info/03_news";
    }
    
    
   //사회공헌
    @GetMapping("/donation.do")
    public String donation() {
        return "hospital_info/04_donation";
    }
    
    @GetMapping("/volunteer.do")
    public String volunteer() {
        return "hospital_info/04_volunteer";
    }
    
    @GetMapping("/esg.do")
    public String esg() {
        return "hospital_info/04_esg";
    }
    
    @GetMapping("/community.do")
    public String community() {
        return "hospital_info/04_community";
    }
    
    
}