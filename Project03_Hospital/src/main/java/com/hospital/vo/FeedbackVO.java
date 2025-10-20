package com.hospital.vo;

import java.util.Date;

public class FeedbackVO {

	private int feedbackId;
	private String patientUserId;
	private String category;
	private String content;
	private String reply;
	private String repliedBy;
	private Date repliedAt;
	private String status;
	private Date createdAt;

	// 리스트 순번
	private int rowNumber;

	// 상대시간 (ex. 2시간 전)
	private String relativeTime;

	// ===== JSP 추가 입력 필드 (DB에 없음) =====
	private String senderName;
	private String phone;
	private String email;
	private String relation;
	private String patientName;
	private String hospitalNo;
	private String birthDate;
	private String title;
	private String writerName;
	private String writerPw;

	// ===== 기본 생성자 =====
	public FeedbackVO() {
	}

	// ===== Getter/Setter =====
	public int getFeedbackId() {
		return feedbackId;
	}

	public void setFeedbackId(int feedbackId) {
		this.feedbackId = feedbackId;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public String getRepliedBy() {
		return repliedBy;
	}

	public void setRepliedBy(String repliedBy) {
		this.repliedBy = repliedBy;
	}

	public Date getRepliedAt() {
		return repliedAt;
	}

	public void setRepliedAt(Date repliedAt) {
		this.repliedAt = repliedAt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public int getRowNumber() {
		return rowNumber;
	}

	public void setRowNumber(int rowNumber) {
		this.rowNumber = rowNumber;
	}

	public String getRelativeTime() {
		return relativeTime;
	}

	public void setRelativeTime(String relativeTime) {
		this.relativeTime = relativeTime;
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRelation() {
		return relation;
	}

	public void setRelation(String relation) {
		this.relation = relation;
	}

	public String getPatientName() {
		return patientName;
	}

	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}

	public String getHospitalNo() {
		return hospitalNo;
	}

	public void setHospitalNo(String hospitalNo) {
		this.hospitalNo = hospitalNo;
	}

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriterName() {
		return writerName;
	}

	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}

	public String getWriterPw() {
		return writerPw;
	}

	public void setWriterPw(String writerPw) {
		this.writerPw = writerPw;
	}

	@Override
	public String toString() {
		return "FeedbackVO{" + "feedbackId=" + feedbackId + ", patientUserId='" + patientUserId + '\'' + ", category='"
				+ category + '\'' + ", title='" + title + '\'' + ", content='" + content + '\'' + ", reply='" + reply
				+ '\'' + ", repliedBy='" + repliedBy + '\'' + ", repliedAt=" + repliedAt + ", status='" + status + '\''
				+ ", createdAt=" + createdAt + ", senderName='" + senderName + '\'' + ", phone='" + phone + '\''
				+ ", email='" + email + '\'' + ", relation='" + relation + '\'' + ", patientName='" + patientName + '\''
				+ ", hospitalNo='" + hospitalNo + '\'' + ", birthDate='" + birthDate + '\'' + ", relativeTime='"
				+ relativeTime + '\'' + '}';
	}
}
