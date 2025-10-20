package com.hospital.vo;

import java.util.Date;

public class FaqVO {
    private int faqId;
    private String category;
    private String question;
    private String answer;
    private Date createdAt;

    // Getter & Setter
    public int getFaqId() {
        return faqId;
    }
    public void setFaqId(int faqId) {
        this.faqId = faqId;
    }
    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    public String getQuestion() {
        return question;
    }
    public void setQuestion(String question) {
        this.question = question;
    }
    public String getAnswer() {
        return answer;
    }
    public void setAnswer(String answer) {
        this.answer = answer;
    }
    public Date getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
