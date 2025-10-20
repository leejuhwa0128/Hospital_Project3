// com.hospital.controller.CompatRedirectController  (별도 파일로)
package com.hospital.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CompatRedirectController {

    // 예전 주소로 들어오면 정식 주소로 리다이렉트
    @GetMapping("/volunteerDetail.jsp")
    public String legacy(@RequestParam(defaultValue = "1") int id, HttpServletRequest req){
        return "redirect:" + req.getContextPath() + "/hospital_info/volunteer/detail.do?id=" + id;
    }
}