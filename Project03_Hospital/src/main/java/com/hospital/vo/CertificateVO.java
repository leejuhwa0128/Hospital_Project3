package com.hospital.vo;

import java.util.Date;

public class CertificateVO {
    private int certificateId;
    private int patientNo; 
    private Integer recordId; 
    private String type;
    private String content; 
    
    // JSP에서 사용되는 진단명(diagnosis) 필드를 추가합니다.
    private String diagnosis;
    
    private Date issuedAt;
    private String issuedBy;
    private String method;
    private String requestMethod;
    private String status;
    private Date viewedAt;

    private PatientVO patientVO; 
    private MedicalRecordVO medicalRecordVO;

    // --- Getters and Setters ---
    public int getCertificateId() { return certificateId; }
    public void setCertificateId(int certificateId) { this.certificateId = certificateId; }
    public int getPatientNo() { return patientNo; }
    public void setPatientNo(int patientNo) { this.patientNo = patientNo; }
    public Integer getRecordId() { return recordId; }
    public void setRecordId(Integer recordId) { this.recordId = recordId; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    // 추가된 diagnosis의 getter, setter
    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
    
    public Date getIssuedAt() { return issuedAt; }
    public void setIssuedAt(Date issuedAt) { this.issuedAt = issuedAt; }
    public String getIssuedBy() { return issuedBy; }
    public void setIssuedBy(String issuedBy) { this.issuedBy = issuedBy; }
    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }
    public String getRequestMethod() { return requestMethod; }
    public void setRequestMethod(String requestMethod) { this.requestMethod = requestMethod; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getViewedAt() { return viewedAt; }
    public void setViewedAt(Date viewedAt) { this.viewedAt = viewedAt; }
    public PatientVO getPatientVO() { return patientVO; }
    public void setPatientVO(PatientVO patientVO) { this.patientVO = patientVO; }
    public MedicalRecordVO getMedicalRecordVO() { return medicalRecordVO; }
    public void setMedicalRecordVO(MedicalRecordVO medicalRecordVO) { this.medicalRecordVO = medicalRecordVO; }
    
    @Override
    public String toString() {
        return "CertificateVO{" +
                "certificateId=" + certificateId +
                ", patientNo=" + patientNo +
                ", recordId=" + recordId +
                ", type='" + type + '\'' +
                ", content='" + content + '\'' +
                ", diagnosis='" + diagnosis + '\'' + // 추가된 필드
                ", issuedAt=" + issuedAt +
                ", issuedBy='" + issuedBy + '\'' +
                ", method='" + method + '\'' +
                ", requestMethod='" + requestMethod + '\'' +
                ", status='" + status + '\'' +
                ", viewedAt=" + viewedAt +
                '}';
    }

	public String getFilePath() {
		return null;
	}
	
	 private String issuedByName; 
	    public String getIssuedByName() {
	        return issuedByName;
	    }
	    public void setIssuedByName(String issuedByName) {
	        this.issuedByName = issuedByName;
	    }
}