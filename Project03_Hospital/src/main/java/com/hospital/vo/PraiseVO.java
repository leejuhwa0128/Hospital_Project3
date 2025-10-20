package com.hospital.vo;

import java.util.Date;

public class PraiseVO {

	private Integer praiseId; // ? ? 릴레? ID // long ? ? ? ? ? ? int ? ? 모르겠음 ? ? ? ? ??? ? ?
	private String title; // ? ? ? ?
	private String content; // ? ? (CLOB)
	private int viewCount; // 조회?
	private Date createdAt; // ? ? ? ?
	private String patientUserId; // ? ? ? (? ? ID)

	// 기본 ? ? ?
	public PraiseVO() {
	}

	// ? ? ? ? ? ? ? (? ? ? ? )
	public PraiseVO(Integer praiseId, String title, String content, int viewCount, Date createdAt,
			String patientUserId) {
		this.praiseId = praiseId;
		this.title = title;
		this.content = content;
		this.viewCount = viewCount;
		this.createdAt = createdAt;
		this.patientUserId = patientUserId;
	}

	public Integer getPraiseId() {
		return praiseId;
	}

	public void setPraiseId(Integer praiseId) {
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
		return "PraiseRelayVO{" + "praiseId=" + praiseId + ", title='" + title + '\'' + ", content='" + content + '\''
				+ ", viewCount=" + viewCount + ", createdAt=" + createdAt + ", patientUserId='" + patientUserId + '\''
				+ '}';
	}
}
