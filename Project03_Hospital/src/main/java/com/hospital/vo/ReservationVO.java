package com.hospital.vo;

import java.sql.Date;

public class ReservationVO {
	public String getPatientName() {
		return patientName;
	}

	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}

	private int reservationId;
	private int patientNo;
	private String department;
	private String doctorId;
	private Date reservationDate;
	private String scheduleTime; // 변경된 시간 저장 방식
	private int scheduleId;
	private String doctorName; // 조인된 의사 이름
	private String departmentName; // 조인된 진료과 이름
	private String patientName; // 혼자 이름 join
	private String resvDate; // 날짜별 그룹핑된 날짜 (YYYY-MM-DD) [관리자용]
	private int resvCount; // 해당 날짜의 예약 수 [관리자용]
	private String patientPhone; // 환자 전화번호 [관리자용]
    private String deptId;      // 폼에서 넘어옴
    private Date createdAt;  
    private String status;
    
    private boolean hasRecord;

    public boolean isHasRecord() {  
        return hasRecord;
    }

    public void setHasRecord(boolean hasRecord) {  
        this.hasRecord = hasRecord;
    }

    
    
	public String getDoctorName() {
		return doctorName;
	}

	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getScheduleTime() {
		return scheduleTime;
	}

	public void setScheduleTime(String scheduleTime) {
		this.scheduleTime = scheduleTime;
	}

	public int getScheduleId() {
		return scheduleId;
	}

	public void setScheduleId(int scheduleId) {
		this.scheduleId = scheduleId;
	}

	
	

	// === Getter & Setter ===

	public int getReservationId() {
		return reservationId;
	}

	public void setReservationId(int reservationId) {
		this.reservationId = reservationId;
	}

	public int getPatientNo() {
		return patientNo;
	}

	public void setPatientNo(int patientNo) {
		this.patientNo = patientNo;
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

	public Date getReservationDate() {
		return reservationDate;
	}
	

	public void setReservationDate(Date reservationDate) {
		this.reservationDate = reservationDate;
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

	public String getResvDate() {
		return resvDate;
	}

	public void setResvDate(String resvDate) {
		this.resvDate = resvDate;
	}

	public int getResvCount() {
		return resvCount;
	}

	public void setResvCount(int resvCount) {
		this.resvCount = resvCount;
	}

	public String getPatientPhone() {
		return patientPhone;
	}

	public void setPatientPhone(String patientPhone) {
		this.patientPhone = patientPhone;
	}

	// === toString ===
	
	@Override
	public String toString() {
		return "ReservationVO [reservationId=" + reservationId + ", patientNo=" + patientNo + ", department="
				+ department + ", doctorId=" + doctorId + ", reservationDate=" + reservationDate + ", scheduleTime="
				+ scheduleTime + ", scheduleId=" + scheduleId + ", doctorName=" + doctorName + ", departmentName="
				+ departmentName + ", patientName=" + patientName + ", resvDate=" + resvDate + ", resvCount="
				+ resvCount + ", patientPhone=" + patientPhone + ", status=" + status + ", createdAt=" + createdAt
				+ ", getPatientName()=" + getPatientName() + ", getDoctorName()=" + getDoctorName()
				+ ", getDepartmentName()=" + getDepartmentName() + ", getScheduleTime()=" + getScheduleTime()
				+ ", getScheduleId()=" + getScheduleId() + ", getReservationId()=" + getReservationId()
				+ ", getPatientNo()=" + getPatientNo() + ", getDepartment()=" + getDepartment() + ", getDoctorId()="
				+ getDoctorId() + ", getReservationDate()=" + getReservationDate() + ", getStatus()=" + getStatus()
				+ ", getCreatedAt()=" + getCreatedAt() + ", getResvDate()=" + getResvDate() + ", getResvCount()="
				+ getResvCount() + ", getPatientPhone()=" + getPatientPhone() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public void setReservationDate(java.util.Date parse) {
		// TODO Auto-generated method stub	
	}

	
	
	

}
