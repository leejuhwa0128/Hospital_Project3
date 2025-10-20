package com.hospital.vo;

import java.util.Date;

public class PraiseRelayVO {

    private Long praiseId;             // 칭찬 릴레이 ID // long 을 써야하는지  int 쓸지 모르겠음 ㅋ 이랬다 저랬다 함
    private String title;              // 칭찬 제목
    private String content;            // 내용 (CLOB)
    private int viewCount;             // 조회수
    private Date createdAt;            // 생성일자
    private String patientUserId;      // 작성자 (환자 ID)

    // 기본 생성자
    public PraiseRelayVO() {
    }

    // 전체 필드 생성자 (테스트용)
    public PraiseRelayVO(Long praiseId, String title, String content, int viewCount, Date createdAt, String patientUserId) {
        this.praiseId = praiseId;
        this.title = title;
        this.content = content;
        this.viewCount = viewCount;
        this.createdAt = createdAt;
        this.patientUserId = patientUserId;
    }

    public Long getPraiseId() {
        return praiseId;
    }

    public void setPraiseId(Long praiseId) {
        this.praiseId = praiseId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getPatientUserId() {
        return patientUserId;
    }

    public void setPatientUserId(String patientUserId) {
        this.patientUserId = patientUserId;
    }

    @Override
    public String toString() {
        return "PraiseRelayVO{" +
                "praiseId=" + praiseId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", viewCount=" + viewCount +
                ", createdAt=" + createdAt +
                ", patientUserId='" + patientUserId + '\'' +
                '}';
    }
}
