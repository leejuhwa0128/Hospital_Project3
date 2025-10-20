package com.hospital.vo;

import java.util.Date;

public class ReferralCommentVO {
    private int commentId;
    private int requestId;
    private String doctorId;
    private String doctorName; // JOIN 결과용
    private String commentText;
    private Date commentAt;

    public int getCommentId() {
        return commentId;
    }
    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }
    public int getRequestId() {
        return requestId;
    }
    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }
    public String getDoctorId() {
        return doctorId;
    }
    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId;
    }
    public String getDoctorName() {
        return doctorName;
    }
    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }
    public String getCommentText() {
        return commentText;
    }
    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }
    public Date getCommentAt() {
        return commentAt;
    }
    public void setCommentAt(Date commentAt) {
        this.commentAt = commentAt;
    }
}
