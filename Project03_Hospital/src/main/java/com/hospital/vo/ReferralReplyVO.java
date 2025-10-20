package com.hospital.vo;

import java.util.Date;

public class ReferralReplyVO {
	private int replyId;
    private int requestId;
    private String responderName;
    private String replyContent;     
    private Date replyDate;         
    private String status;
    private int hospitalId;
    private String attachmentPath;
    
    

    private String cleanReplyContent;

    // === Getter & Setter ===
    
    public String getCleanReplyContent() {
        return cleanReplyContent;
    }

    public void setCleanReplyContent(String cleanReplyContent) {
        this.cleanReplyContent = cleanReplyContent;
    }

    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public String getResponderName() {
        return responderName;
    }

    public void setResponderName(String responderName) {
        this.responderName = responderName;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public Date getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(Date replyDate) {
        this.replyDate = replyDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getHospitalId() {
        return hospitalId;
    }

    public void setHospitalId(int hospitalId) {
        this.hospitalId = hospitalId;
    }

    public String getAttachmentPath() {
        return attachmentPath;
    }

    public void setAttachmentPath(String attachmentPath) {
        this.attachmentPath = attachmentPath;
    }

    // === toString ===

    @Override
    public String toString() {
        return "ReplyVO{" +
                "replyId=" + replyId +
                ", requestId=" + requestId +
                ", responderName='" + responderName + '\'' +
                ", replyContent='" + replyContent + '\'' +
                ", replyDate=" + replyDate +
                ", status='" + status + '\'' +
                ", hospitalId=" + hospitalId +
                ", attachmentPath='" + attachmentPath + '\'' +
                '}';
    }
}
