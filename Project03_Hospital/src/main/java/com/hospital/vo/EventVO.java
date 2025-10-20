// src/main/java/com/hospital/vo/EventVO.java
package com.hospital.vo;

import java.util.Date;

public class EventVO {

    // ====== PK ======
    private Integer eventId;

    // ====== 기본 정보 ======
    private String title;
    private String description;   // 설명 (CLOB)
    private String content;       // 본문 내용
    private String category;      // 공지/소식/채용/언론
    private String subCategory;   // 채용 직종

    // ====== 부가 정보 ======
    private String reporter;
    private String source;
    private String thumbnailPath;
    private String imagePath;         // 본문 이미지 경로
    private String workLocation;
    private String location;          // 장소 (DB 컬럼에 따라 병용 가능)
    private String speaker;
    private String timeInfo;
    private String contact;
    private String contactEmail;      // 채용 - 접수 이메일
    private String createdBy;
    private String status;

    // ====== 채용 관련 추가 필드 ======
    private String resumeFilePath;    // 이력서 파일 경로
    private String resumeForm;        // 이력서 양식
    private String jobPosition;       // 직무
    private String workingType;       // 근무형태
    private Integer recruitCount;     // 모집 인원
    private String filePath;          // 첨부파일 경로
    private String originalFileName;  // 첨부파일 원본 이름

    // ====== 날짜/카운트 (DB 매핑) ======
    private Date startDate;   // 기간형 컨텐츠 시작일
    private Date endDate;     // 기간형 컨텐츠 종료일
    private Date eventDate;   // 단일 일정(언론/소식 등에서 사용 가능)
    private Date createdAt;
    private Date updatedAt;
    private Integer viewCount;

    // ====== 컨트롤러에서 요구하는 문자열 표현 필드 ======
    // AdminBoardController 에서 setStartDateStr / setEndDateStr / setEventDateStr / setCreatedAtStr 등을 호출함
    private String startDateStr;
    private String endDateStr;
    private String eventDateStr;
    private String createdAtStr;

    // ====== Getter / Setter ======
    public Integer getEventId() { return eventId; }
    public void setEventId(Integer eventId) { this.eventId = eventId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getSubCategory() { return subCategory; }
    public void setSubCategory(String subCategory) { this.subCategory = subCategory; }

    public String getReporter() { return reporter; }
    public void setReporter(String reporter) { this.reporter = reporter; }

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }

    public String getThumbnailPath() { return thumbnailPath; }
    public void setThumbnailPath(String thumbnailPath) { this.thumbnailPath = thumbnailPath; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public String getWorkLocation() { return workLocation; }
    public void setWorkLocation(String workLocation) { this.workLocation = workLocation; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getSpeaker() { return speaker; }
    public void setSpeaker(String speaker) { this.speaker = speaker; }

    public String getTimeInfo() { return timeInfo; }
    public void setTimeInfo(String timeInfo) { this.timeInfo = timeInfo; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getContactEmail() { return contactEmail; }
    public void setContactEmail(String contactEmail) { this.contactEmail = contactEmail; }

    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getResumeFilePath() { return resumeFilePath; }
    public void setResumeFilePath(String resumeFilePath) { this.resumeFilePath = resumeFilePath; }

    public String getResumeForm() { return resumeForm; }
    public void setResumeForm(String resumeForm) { this.resumeForm = resumeForm; }

    public String getJobPosition() { return jobPosition; }
    public void setJobPosition(String jobPosition) { this.jobPosition = jobPosition; }

    public String getWorkingType() { return workingType; }
    public void setWorkingType(String workingType) { this.workingType = workingType; }

    public Integer getRecruitCount() { return recruitCount; }
    public void setRecruitCount(Integer recruitCount) { this.recruitCount = recruitCount; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public String getOriginalFileName() { return originalFileName; }
    public void setOriginalFileName(String originalFileName) { this.originalFileName = originalFileName; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public Date getEventDate() { return eventDate; }
    public void setEventDate(Date eventDate) { this.eventDate = eventDate; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public Integer getViewCount() { return viewCount; }
    public void setViewCount(Integer viewCount) { this.viewCount = viewCount; }

    public String getStartDateStr() { return startDateStr; }
    public void setStartDateStr(String startDateStr) { this.startDateStr = startDateStr; }

    public String getEndDateStr() { return endDateStr; }
    public void setEndDateStr(String endDateStr) { this.endDateStr = endDateStr; }

    public String getEventDateStr() { return eventDateStr; }
    public void setEventDateStr(String eventDateStr) { this.eventDateStr = eventDateStr; }

    public String getCreatedAtStr() { return createdAtStr; }
    public void setCreatedAtStr(String createdAtStr) { this.createdAtStr = createdAtStr; }
}
