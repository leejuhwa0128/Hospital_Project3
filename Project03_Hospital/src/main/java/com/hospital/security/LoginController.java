package com.hospital.security;

import com.hospital.security.CaptchaService;
import com.hospital.security.CaptchaService.V3Result;
import com.hospital.service.UserService;
import com.hospital.vo.UserVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/referral")
public class LoginController {

	@Autowired
	private CaptchaService captchaService;

	@Autowired
	private UserService userService;

	@Value("${captcha.v3.siteKey}")
	private String captchaV3SiteKey;

	@Value("${captcha.v2.siteKey}")
	private String captchaV2SiteKey;

	@GetMapping("/auth.do")
	public String loginForm(HttpSession session, Model model) {
		Boolean requireCaptcha = (Boolean) session.getAttribute("requireCaptcha");
		model.addAttribute("requireCaptcha", requireCaptcha != null && requireCaptcha);
		model.addAttribute("captchaV3SiteKey", captchaV3SiteKey);
		model.addAttribute("captchaV2SiteKey", captchaV2SiteKey);
		return "/WEB-INF/jsp/referral/auth.jsp";
	}

	@PostMapping("/login2.do")
	public String login2(@RequestParam String userId,
	                     @RequestParam String password,
	                     @RequestParam(name = "recaptcha_v3", required = false) String v3token,
	                     @RequestParam(name = "g-recaptcha-response", required = false) String v2token,
	                     HttpServletRequest request,
	                     HttpSession session,
	                     Model model) {

	    // 1) requireCaptcha를 항상 boolean으로 정규화
	    boolean requireCaptcha = Boolean.TRUE.equals(session.getAttribute("requireCaptcha"));

	    // 2) v2(체크박스) 경로
	    if (requireCaptcha) {
	        if (v2token == null || v2token.trim().isEmpty()) {
	            session.setAttribute("loginError", "보안 확인(체크박스)을 완료해주세요.");
	            return "redirect:/referral/auth.do?mode=login";
	        }
	        boolean ok = captchaService.verifyV2(v2token, clientIp(request));
	        if (!ok) {
	            session.setAttribute("loginError", "보안 확인 실패. 체크박스 인증 후 다시 시도하세요.");
	            return "redirect:/referral/auth.do?mode=login";
	        }
	    }
	    // 3) v3(점수) 경로
	    else {
	        if (v3token == null || v3token.trim().isEmpty()) {
	            session.setAttribute("requireCaptcha", Boolean.TRUE);
	            session.setAttribute("loginError", "추가 보안 확인이 필요합니다. 체크박스 인증 후 로그인하세요.");
	            return "redirect:/referral/auth.do?mode=login";
	        }
	        CaptchaService.V3Result r = captchaService.verifyV3(v3token, clientIp(request), "login");
	        if (!r.ok) {
	            session.setAttribute("requireCaptcha", Boolean.TRUE);
	            session.setAttribute("loginError", "추가 보안 확인이 필요합니다. 체크박스 인증 후 로그인하세요.");
	            return "redirect:/referral/auth.do?mode=login";
	        }
	    }

	    // 4) 실제 로그인 로직
	    UserVO cred = new UserVO();
	    cred.setUserId(userId);
	    cred.setPassword(password);

	    UserVO authed = userService.login(cred); // 성공 시 사용자 객체, 실패 시 null 가정
	    if (authed == null) {
	        Integer failCount = (Integer) session.getAttribute("loginFailCount");
	        failCount = (failCount == null ? 0 : failCount) + 1;
	        session.setAttribute("loginFailCount", failCount);

	        if (failCount >= 3) {
	            session.setAttribute("requireCaptcha", Boolean.TRUE); // 3회 이상 실패 시 v2 강제
	        }

	        session.setAttribute("loginError", "아이디 또는 패스워드를 확인해 주세요.");
	        return "redirect:/referral/auth.do?mode=login";
	    }

	    // 5) 로그인 성공 → 상태 초기화 + 유저 세션 + 원래 목적지로 이동
	    session.removeAttribute("loginFailCount");
	    session.setAttribute("requireCaptcha", Boolean.FALSE); // null 대신 false로 명시 저장
	    session.setAttribute("loginUser", authed);             // 반환 객체 그대로 저장

	    String after = (String) session.getAttribute("afterLoginRedirect");
	    if (after != null && !after.isEmpty()) {
	        session.removeAttribute("afterLoginRedirect");
	        return "redirect:" + after;
	    }
	    return "redirect:/referral/home.do";
	}


	private String clientIp(HttpServletRequest req) {
		String ip = req.getHeader("X-Forwarded-For");
		if (ip != null && !ip.trim().isEmpty()) {
			return ip.split(",")[0].trim();
		}
		return req.getRemoteAddr();
	}
}
