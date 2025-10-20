package com.hospital.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ReferralRequestVO {
	private int requestId;
    private String userId;
    private String patientName;
    private String rrn;
    private String contact;
    private String department;
    private String doctorId;
    private String departmentId;  // 🔹 진료과 ID
    
    @DateTimeFormat(pattern = "yyyy-MM-dd") // ✅ OK!
    private Date hopeDate;
    
    
    private String reason;       
    private String symptoms;     
    private int hospitalId;
    private String status;
    private Date createdAt;
    
    
    private String departmentName;
    private String doctorName;
    private String userName;
    private String hospitalName;
    private boolean replyExists; // boolean은 resultType int → 0/1 맵핑됨
    
    private int recordId;
    
    private boolean duplicate;
    public boolean isDuplicate() {
        return duplicate;
    }

    public void setDuplicate(boolean duplicate) {
        this.duplicate = duplicate;
    }

    // === Getter & Setter ===

    public int getRecordId() {
        return recordId;
    }

    public void setRecordId(int recordId) {
        this.recordId = recordId;
    }

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getDoctorName() {
		return doctorName;
	}

	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getHospitalName() {
		return hospitalName;
	}

	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}

	public boolean isReplyExists() {
		return replyExists;
	}

	public void setReplyExists(boolean replyExists) {
		this.replyExists = replyExists;
	}

	public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getRrn() {
        return rrn;
    }

    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId;
    }

    public Date getHopeDate() {
        return hopeDate;
    }

    public void setHopeDate(Date hopeDate) {
        this.hopeDate = hopeDate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }

    public int getHospitalId() {
        return hospitalId;
    }

    public void setHospitalId(int hospitalId) {
        this.hospitalId = hospitalId;
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

    // === toString ===
    @Override
    public String toString() {
        return "RequestVO{" +
                "requestId=" + requestId +
                ", userId='" + userId + '\'' +
                ", patientName='" + patientName + '\'' +
                ", rrn='" + rrn + '\'' +
                ", contact='" + contact + '\'' +
                ", department='" + department + '\'' +
                ", doctorId='" + doctorId + '\'' +
                ", hopeDate=" + hopeDate +
                ", reason='" + reason + '\'' +
                ", symptoms='" + symptoms + '\'' +
                ", hospitalId=" + hospitalId +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                ", recordId=" + recordId + // ✅ 추가
                '}';
    }

	public String getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(String departmentId) {
		this.departmentId = departmentId;
	}
}
