package com.hospital.security;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Service
public class CaptchaService {

    @Value("${captcha.v3.secret}") private String v3Secret;
    @Value("${captcha.v2.secret}") private String v2Secret;
    @Value("${captcha.v3.threshold:0.5}") private double threshold;

    public static class V3Result {
        public boolean ok;
        public boolean success;
        public double score;
        public String action;
        public String hostname;
        public String[] errorCodes;
        public String raw;
    }

    public V3Result verifyV3(String token, String remoteIp, String expectedAction) {
        V3Result r = new V3Result();
        if (token == null || token.trim().isEmpty()) {
            r.ok = false;
            r.raw = "missing-token";
            return r;
        }

        try (CloseableHttpClient client = HttpClients.createDefault()) {
            String params = "secret=" + URLEncoder.encode(v3Secret, "UTF-8") +
                    "&response=" + URLEncoder.encode(token, "UTF-8") +
                    "&remoteip=" + URLEncoder.encode(remoteIp == null ? "" : remoteIp, "UTF-8");

            HttpPost post = new HttpPost("https://www.google.com/recaptcha/api/siteverify");
            post.setHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
            post.setEntity(new StringEntity(params, StandardCharsets.UTF_8));

            try (CloseableHttpResponse resp = client.execute(post)) {
                String body = EntityUtils.toString(resp.getEntity(), StandardCharsets.UTF_8);
                r.raw = body;

                // ✅ JSON으로 안정 파싱
                com.fasterxml.jackson.databind.ObjectMapper om = new com.fasterxml.jackson.databind.ObjectMapper();
                com.fasterxml.jackson.databind.JsonNode root = om.readTree(body);

                r.success  = root.path("success").asBoolean(false);
                r.action   = root.path("action").asText(null);
                r.score    = root.path("score").asDouble(0.0);
                r.hostname = root.path("hostname").asText(null);

                if (root.has("error-codes") && root.get("error-codes").isArray()) {
                    r.errorCodes = om.convertValue(root.get("error-codes"), String[].class);
                }

                boolean actionOk = (expectedAction == null) ||
                                   expectedAction.equalsIgnoreCase(r.action);

                r.ok = r.success && actionOk && r.score >= threshold;
            }
        } catch (Exception e) {
            r.ok = false;
            r.raw = "exception:" + e.getClass().getSimpleName();
        }
        return r;
    }

    public boolean verifyV2(String token, String remoteIp) {
        if (token == null || token.trim().isEmpty()) return false;
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            String params = "secret=" + URLEncoder.encode(v2Secret, "UTF-8") +
                    "&response=" + URLEncoder.encode(token, "UTF-8") +
                    "&remoteip=" + URLEncoder.encode(remoteIp == null ? "" : remoteIp, "UTF-8");

            HttpPost post = new HttpPost("https://www.google.com/recaptcha/api/siteverify");
            post.setHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
            post.setEntity(new StringEntity(params, StandardCharsets.UTF_8));

            try (CloseableHttpResponse resp = client.execute(post)) {
                String body = EntityUtils.toString(resp.getEntity(), StandardCharsets.UTF_8);

                // 🔎 디버그 로그 (임시)
                System.out.println("[reCAPTCHA v2] resp body = " + body);
                System.out.println("[reCAPTCHA v2] siteKey(last4)=" +
                        (/* site key 출력 원하면 */ "****") +
                        ", secret(last4)=" + (v2Secret != null ? v2Secret.substring(Math.max(0, v2Secret.length()-4)) : "null"));

                com.fasterxml.jackson.databind.ObjectMapper om = new com.fasterxml.jackson.databind.ObjectMapper();
                com.fasterxml.jackson.databind.JsonNode root = om.readTree(body);

                // 에러코드도 같이 찍기
                if (root.has("error-codes")) {
                    System.out.println("[reCAPTCHA v2] error-codes = " + root.get("error-codes").toString());
                }
                return root.path("success").asBoolean(false);
            }
        } catch (Exception e) {
            System.out.println("[reCAPTCHA v2] exception: " + e.getMessage());
            return false;
        }
    }

}
