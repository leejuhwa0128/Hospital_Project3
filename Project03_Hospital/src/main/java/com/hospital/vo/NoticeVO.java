package com.hospital.vo;

import java.util.Date;

public class NoticeVO {

	private int noticeId; // 공지 ID
	private String title; // 제목
	private String content; // 내용 (CLOB)
	private String createdBy; // 작성자 ID
	private Date createdAt; // 작성일
	private Date updatedAt; // 수정일

	// DB에는 없지만 화면용
	private String writer; // 작성자 표시용 (ex. "관리자")
	private String createdAtStr; // 포맷된 작성일자 문자열
	
	  private String createdByName;    // ★ 추가: 어드민 이름
	    
	    

	    public String getCreatedByName() { return createdByName; }
	    public void setCreatedByName(String createdByName) { this.createdByName = createdByName; }
		
		//의료진 공지사항
		private String targetRole;

	    public String getTargetRole() {
	        return targetRole;
	    }

	    public void setTargetRole(String targetRole) {
	        this.targetRole = targetRole;
	    }

	public int getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
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

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getCreatedAtStr() {
		return createdAtStr;
	}

	public void setCreatedAtStr(String createdAtStr) {
		this.createdAtStr = createdAtStr;
	}
}
