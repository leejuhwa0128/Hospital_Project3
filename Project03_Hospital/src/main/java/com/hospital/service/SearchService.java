package com.hospital.service;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;

import org.springframework.stereotype.Service;

import com.hospital.vo.SearchResultVO;

@Service
public class SearchService {

    private static final String JSP_BASE_PATH = "/WEB-INF/jsp/hospital_info/";

    // ✅ 카테고리별로 결과를 그룹핑한 Map 반환
    public Map<String, List<SearchResultVO>> searchGroupedByCategory(String realPath, String keyword) {
        Map<String, List<SearchResultVO>> groupedResults = new LinkedHashMap<>();
        File baseDir = new File(realPath + JSP_BASE_PATH);

        if (!baseDir.exists()) return groupedResults;

        File[] files = baseDir.listFiles((dir, name) -> 
            name.endsWith(".jsp") &&
            !name.contains("menu") &&
            !name.contains("intro")
        );
        if (files == null) return groupedResults;

        for (File file : files) {
            try {
                String content = new String(Files.readAllBytes(file.toPath()), StandardCharsets.UTF_8);

                if (content.toLowerCase().contains(keyword.toLowerCase())) {
                    String fileName = file.getName();
                    String title = extractTitle(content, fileName);
                    String pageTitle = getCategoryTitle(fileName);
                    String summary = summarize(content, keyword);

                    SearchResultVO result = new SearchResultVO(title, summary, "/" + fileName.replace(".jsp", ".do"), pageTitle);
                    // category 필드도 반드시 세팅 (중요)
                    result.setCategory(pageTitle);

                    groupedResults.computeIfAbsent(pageTitle, k -> new ArrayList<>()).add(result);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return groupedResults;
    }

    private String extractTitle(String content, String defaultName) {
        if (content.contains("<h2>")) {
            int start = content.indexOf("<h2>") + 4;
            int end = content.indexOf("</h2>");
            if (start < end) {
                String h2 = content.substring(start, end).replaceAll("\"", "").trim();
                if (!h2.contains("${")) return h2;
            }
        }
        String base = defaultName.replace(".jsp", "")
                                .replaceAll("^\\d+_", "")
                                .replace("_", " ")
                                .trim();
        if (!base.isEmpty())
            base = base.substring(0, 1).toUpperCase() + base.substring(1);

        return base;
    }

    private String summarize(String content, String keyword) {
        String clean = content.replaceAll("<[^>]*>", "").replaceAll("&nbsp;", " ").trim();
        int idx = clean.toLowerCase().indexOf(keyword.toLowerCase());
        if (idx == -1) return "";
        int start = Math.max(0, idx - 20);
        int end = Math.min(clean.length(), idx + 50);
        return "... " + clean.substring(start, end) + " ...";
    }

    private String getCategoryTitle(String fileName) {
        if (fileName.startsWith("01_")) return "병원 소개";
        if (fileName.startsWith("02_")) return "주요 시설 안내";
        if (fileName.startsWith("03_")) return "병원 소식";
        if (fileName.startsWith("04_")) return "사회 공헌";
        return null;
    }
}
