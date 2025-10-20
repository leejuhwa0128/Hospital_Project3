package com.hospital.vo;

import java.util.Date;

public class PatientVO {
	private int patientNo;
	private String patientUserId;
	private String patientPassword;
	private String patientName;
	private String patientRrn;
	private String patientGender;
	private String patientPhone;
	private String patientEmail;
	private Date patientCreatedAt;

	public int getPatientNo() {
		return patientNo;
	}

	public void setPatientNo(int patientNo) {
		this.patientNo = patientNo;
	}

	public String getPatientUserId() {
		return patientUserId;
	}

	public void setPatientUserId(String patientUserId) {
		this.patientUserId = patientUserId;
	}

	public String getPatientPassword() {
		return patientPassword;
	}

	public void setPatientPassword(String patientPassword) {
		this.patientPassword = patientPassword;
	}

	public String getPatientName() {
		return patientName;
	}

	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}

	public String getPatientRrn() {
		return patientRrn;
	}

	public void setPatientRrn(String patientRrn) {
		this.patientRrn = patientRrn;
	}

	public String getPatientGender() {
		return patientGender;
	}

	public void setPatientGender(String patientGender) {
		this.patientGender = patientGender;
	}

	public String getPatientPhone() {
		return patientPhone;
	}

	public void setPatientPhone(String patientPhone) {
		this.patientPhone = patientPhone;
	}

	public String getPatientEmail() {
		return patientEmail;
	}

	public void setPatientEmail(String patientEmail) {
		this.patientEmail = patientEmail;
	}

	public Date getPatientCreatedAt() {
		return patientCreatedAt;
	}

	public void setPatientCreatedAt(Date patientCreatedAt) {
		this.patientCreatedAt = patientCreatedAt;
	}

	private String role; // 예: "PATIENT", "ADMIN" 등

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return "PatientVO{" + "patientNo=" + patientNo + ", patientUserId='" + patientUserId + '\''
				+ ", patientPassword='" + patientPassword + '\'' + ", patientName='" + patientName + '\''
				+ ", patientRrn='" + patientRrn + '\'' + ", patientGender='" + patientGender + '\'' + ", patientPhone='"
				+ patientPhone + '\'' + ", patientEmail='" + patientEmail + '\'' + ", patientCreatedAt="
				+ patientCreatedAt + '}';
	}
}
