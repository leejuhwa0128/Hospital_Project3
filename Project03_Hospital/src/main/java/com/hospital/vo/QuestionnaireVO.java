package com.hospital.vo;

import java.util.Date;

public class QuestionnaireVO {
    private int questionnaireId;
    private int reservationId;
    private String content; 
    private Date submittedAt;

    // === Getter & Setter ===

    public int getQuestionnaireId() {
        return questionnaireId;
    }

    public void setQuestionnaireId(int questionnaireId) {
        this.questionnaireId = questionnaireId;
    }

    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getSubmittedAt() {
        return submittedAt;
    }

    public void setSubmittedAt(java.sql.Date submittedAt) {
        this.submittedAt = submittedAt;
    }

    // === toString ===

    @Override
    public String toString() {
        return "QuestionnaireVO{" +
                "questionnaireId=" + questionnaireId +
                ", reservationId=" + reservationId +
                ", content='" + content + '\'' +
                ", submittedAt=" + submittedAt +
                '}';
    }
}

