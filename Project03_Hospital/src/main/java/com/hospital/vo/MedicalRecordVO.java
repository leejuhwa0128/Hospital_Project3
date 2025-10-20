package com.hospital.vo;

import java.util.Date;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonFormat;

public class MedicalRecordVO {
	private int recordId;
	private int reservationId;
	private String doctorId;
	private String diagnosis;
	private String treatment;
	private String prescription;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	private Date recordDate;
	private String content;
	private String medication;

	private String departmentName; // 진료과 이름 (departments 테이블 조인)
	private int patientNo; // 환자번호 join

	// ★★★ 이 부분이 있는지 다시 한번 확인하세요! ★★★
	private String patientName;

	private String doctorName;

	private boolean requested; // 협진 신청 여부

	private boolean duplicate;
	
	
	

	public boolean isDuplicate() {
		return duplicate;
	}

	public void setDuplicate(boolean duplicate) {
		this.duplicate = duplicate;
	}

	public boolean isRequested() {
		return requested;
	}

	public void setRequested(boolean requested) {
		this.requested = requested;
	}

	// --- Getter와 Setter ---
	public int getRecordId() {
		return recordId;
	}

	public void setRecordId(int recordId) {
		this.recordId = recordId;
	}

	public int getReservationId() {
		return reservationId;
	}

	public void setReservationId(int reservationId) {
		this.reservationId = reservationId;
	}

	public String getDoctorId() {
		return doctorId;
	}

	public void setDoctorId(String doctorId) {
		this.doctorId = doctorId;
	}

	public String getDiagnosis() {
		return diagnosis;
	}

	public void setDiagnosis(String diagnosis) {
		this.diagnosis = diagnosis;
	}

	public String getTreatment() {
		return treatment;
	}

	public void setTreatment(String treatment) {
		this.treatment = treatment;
	}

	public String getPrescription() {
		return prescription;
	}

	public void setPrescription(String prescription) {
		this.prescription = prescription;
	}

	public Date getRecordDate() {
		return recordDate;
	}

	public void setRecordDate(Date recordDate) {
		this.recordDate = recordDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMedication() {
		return medication;
	}

	public void setMedication(String medication) {
		this.medication = medication;
	}

	public String getDoctorName() {
		return doctorName;
	}

	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}

	// ★★★ 이 부분이 있는지 다시 한번 확인하세요! ★★★
	public String getPatientName() {
		return patientName;
	}

	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public int getPatientNo() {
		return patientNo;
	}

	public void setPatientNo(int patientNo) {
		this.patientNo = patientNo;
	}

	@Override
	public String toString() {
		return "MedicalRecordVO [recordId=" + recordId + ", reservationId=" + reservationId + ", doctorId=" + doctorId
				+ ", diagnosis=" + diagnosis + ", treatment=" + treatment + ", prescription=" + prescription
				+ ", recordDate=" + recordDate + ", content=" + content + ", medication=" + medication
				+ ", departmentName=" + departmentName + ", patientNo=" + patientNo + ", patientName=" + patientName
				+ ", doctorName=" + doctorName + ", requested=" + requested + ", duplicate=" + duplicate
				+ ", isDuplicate()=" + isDuplicate() + ", isRequested()=" + isRequested() + ", getRecordId()="
				+ getRecordId() + ", getReservationId()=" + getReservationId() + ", getDoctorId()=" + getDoctorId()
				+ ", getDiagnosis()=" + getDiagnosis() + ", getTreatment()=" + getTreatment() + ", getPrescription()="
				+ getPrescription() + ", getRecordDate()=" + getRecordDate() + ", getContent()=" + getContent()
				+ ", getMedication()=" + getMedication() + ", getDoctorName()=" + getDoctorName()
				+ ", getPatientName()=" + getPatientName() + ", getDepartmentName()=" + getDepartmentName()
				+ ", getPatientNo()=" + getPatientNo() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}

	public List<MedicalRecordVO> getMedicalRecordsByPatientNo(int patientNo) {
		// TODO Auto-generated method stub
		return null;
	}
}
