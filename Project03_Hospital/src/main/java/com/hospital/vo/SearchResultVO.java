package com.hospital.vo;

public class SearchResultVO {
    private String title;
    private String summary;  // 미리보기 텍스트용 필드
    private String url;
    private String category; // 카테고리명
    private String content; // Correctly declare the content field here

    // 생성자 - summary 포함, category 포함 버전으로 통일
    public SearchResultVO(String title, String summary, String url, String category) {
        this.title = title;
        this.summary = summary;
        this.url = url;
        this.category = category;
        this.content = content;
    }

    // Getter/Setter
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
    
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    
    // Add the missing getPageTitle() method, as it's used in your JSP
    public String getPageTitle() {
        // Since 'pageTitle' is not a field, you can return 'category'
        return category;
    }
}
