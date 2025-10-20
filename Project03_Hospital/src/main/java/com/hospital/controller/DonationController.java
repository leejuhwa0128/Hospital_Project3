package com.hospital.controller;

import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import com.hospital.service.DonationService;
import com.hospital.vo.DonationVO;

@Controller
public class DonationController {

    @Autowired
    private DonationService donationService;

    // ✅ application.properties 값 주입
    @Value("${toss.secret.key}")
    private String tossSecretKey; // test_sk_ 로 시작

    @Value("${toss.client.key}")
    private String tossClientKey; // test_ck_ 로 시작

    /** 기부 페이지 진입 */
    @GetMapping("/04_donation.do")
    public String donationPage(Model model) {
        // 주문 ID 생성 (날짜 + 랜덤 4자리)
        String orderId = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) +
                         String.format("%04d", new Random().nextInt(10000));

        model.addAttribute("tossClientKey", tossClientKey);
        model.addAttribute("orderId", orderId);

        System.out.println("✅ [TOSS 결제 페이지 진입]");
        System.out.println("ClientKey = " + tossClientKey);
        System.out.println("SecretKey = " + tossSecretKey);
        System.out.println("OrderId   = " + orderId);

        // hospital_info/04_donation.jsp 로 이동
        return "hospital_info/04_donation";
    }

    /** 결제 성공 콜백 */
    @GetMapping("/donation/success.do")
    public String successDonation(@RequestParam String paymentKey,
                                  @RequestParam String orderId,
                                  @RequestParam long amount,
                                  @RequestParam String donorName,
                                  @RequestParam String email,
                                  Model model,
                                  HttpSession session) {

        String url = "https://api.tosspayments.com/v1/payments/confirm";
        RestTemplate rt = new RestTemplate();

        String basicAuth = Base64.getEncoder()
                .encodeToString((tossSecretKey + ":").getBytes(StandardCharsets.UTF_8));

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Basic " + basicAuth);

        Map<String, Object> body = new HashMap<>();
        body.put("paymentKey", paymentKey);
        body.put("orderId", orderId);
        body.put("amount", amount);

        try {
            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);
            ResponseEntity<Map> resp = rt.postForEntity(url, entity, Map.class);

            // ✅ 결제 승인 성공 → DB 저장
            DonationVO vo = new DonationVO();
            vo.setOrderId(orderId);
            vo.setDonorName(donorName);
            vo.setEmail(email);
            vo.setAmount(amount);
            vo.setPaymentKey(paymentKey);
            vo.setMethod((String) resp.getBody().get("method"));
            vo.setApprovedAt(new Date());

            donationService.markPaid(vo);
            
            // ✅ 세션에 이메일 저장
            session.setAttribute("donorEmail", email);

            System.out.println("✅ 결제 승인 완료 : " + vo);

            // ✅ JSP에서 donation 객체 통째로 사용 가능하도록 전달
            model.addAttribute("donation", vo);
            model.addAttribute("amount", amount);
            model.addAttribute("orderId", orderId);
            model.addAttribute("donorName", vo.getDonorName());

            return "hospital_info/donation_success";


        } catch (HttpStatusCodeException e) {
            System.err.println("❌ 결제 승인 실패 : " + e.getResponseBodyAsString());

            model.addAttribute("orderId", orderId);
            model.addAttribute("message", e.getResponseBodyAsString());
            model.addAttribute("code", e.getStatusCode().toString());
            return "hospital_info/donation_fail";
        }
    }

    /** 결제 실패 콜백 */
    @GetMapping("/donation/fail.do")
    public String failDonation(@RequestParam String code,
                               @RequestParam String message,
                               @RequestParam String orderId,
                               Model model) {

        System.err.println("❌ 결제 실패 : " + message + " (code=" + code + ")");

        model.addAttribute("orderId", orderId);
        model.addAttribute("code", code);
        model.addAttribute("message", message);
        return "hospital_info/donation_fail";
    }
    
    /** 기부 내역 페이지 */
    @GetMapping("/donation/history.do")
    public String donationHistory(HttpSession session, Model model) {
        String email = (String) session.getAttribute("donorEmail"); // ✅ 결제할 때 저장한 이메일 불러오기

        if (email == null) {
            model.addAttribute("error", "후원 내역을 조회할 수 없습니다. 결제를 먼저 진행해주세요.");
            return "hospital_info/donation_history";
        }

        List<DonationVO> donations = donationService.getDonationsByEmail(email);
        model.addAttribute("donations", donations);

        return "hospital_info/donation_history";
    }
}

