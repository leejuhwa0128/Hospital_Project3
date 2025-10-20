package com.hospital.vo;


public class QnaVO {
    private int qnaId;
    private String userId;         // 일반 사용자용
    private String patientUserId;  // 환자 사용자용
    private String category;       // 일반 사용자 QNA에만 존재
    private String question;       // CLOB → String
    private String answer;         // CLOB → String
    private String isSecret;       // 'Y' or 'N'
    private java.sql.Date createdAt;

    // === Getter & Setter ===

    public int getQnaId() {
        return qnaId;
    }

    public void setQnaId(int qnaId) {
        this.qnaId = qnaId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPatientUserId() {
        return patientUserId;
    }

    public void setPatientUserId(String patientUserId) {
        this.patientUserId = patientUserId;
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

    public String getIsSecret() {
        return isSecret;
    }

    public void setIsSecret(String isSecret) {
        this.isSecret = isSecret;
    }

    public java.sql.Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.sql.Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "UnifiedQnaVO{" +
                "qnaId=" + qnaId +
                ", userId='" + userId + '\'' +
                ", patientUserId='" + patientUserId + '\'' +
                ", category='" + category + '\'' +
                ", question='" + question + '\'' +
                ", answer='" + answer + '\'' +
                ", isSecret='" + isSecret + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}

