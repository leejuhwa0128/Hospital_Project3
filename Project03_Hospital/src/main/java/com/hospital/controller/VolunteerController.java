// com.hospital.controller.VolunteerController
package com.hospital.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class VolunteerController {

    @GetMapping("/hospital_info/volunteer/list.do")
    public String list(@RequestParam(defaultValue = "1") int page, Model model){
        model.addAttribute("page", page);
        model.addAttribute("totalPages", 2);
        return "hospital_info/04_volunteer"; // /WEB-INF/jsp/hospital_info/04_volunteer.jsp
    }
}