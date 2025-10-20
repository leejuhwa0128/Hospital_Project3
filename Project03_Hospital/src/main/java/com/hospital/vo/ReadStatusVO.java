package com.hospital.vo;

import java.util.Date;

public class ReadStatusVO {
	private int readId;
    private int noticeId;
    private String userId;
    private Date readAt;

    // === Getter & Setter ===

    public int getReadId() {
        return readId;
    }

    public void setReadId(int readId) {
        this.readId = readId;
    }

    public int getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(int noticeId) {
        this.noticeId = noticeId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getReadAt() {
        return readAt;
    }

    public void setReadAt(java.sql.Date readAt) {
        this.readAt = readAt;
    }

    // === toString ===

    @Override
    public String toString() {
        return "ReadVO{" +
                "readId=" + readId +
                ", noticeId=" + noticeId +
                ", userId='" + userId + '\'' +
                ", readAt=" + readAt +
                '}';
    }
}
