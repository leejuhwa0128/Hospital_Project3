package com.hospital.vo;

import java.sql.Date;

public class UserVO {
	private String userId;
	private String password;
	private String name;
	private String rrn;
	private String gender;
	private String phone;
	private String email;
	private String role;
	private String deptId;
	private Integer hospitalId;
	private String hospitalName;
	private Date regDate;
	private String departmentName;
	private boolean approved;
	
	public String getDepartmentName() {
	    return departmentName;
	}

	public void setDepartmentName(String departmentName) {
	    this.departmentName = departmentName;
	}
	
	public boolean isApproved() {
		return approved;
	}

	public void setApproved(boolean approved) {
		this.approved = approved;
	}


	public String getHospitalName() {
		return hospitalName;
	}

	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public Integer getHospitalId() {
		return hospitalId;
	}

	public void setHospitalId(Integer hospitalId) {
		this.hospitalId = hospitalId;
	}

	public UserVO() {

	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRrn() {
		return rrn;
	}

	public void setRrn(String rrn) {
		this.rrn = rrn;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
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

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "UserVO [userId=" + userId + ", password=" + password + ", name=" + name + ", rrn=" + rrn + ", gender="
				+ gender + ", phone=" + phone + ", email=" + email + ", role=" + role + ", hospitalId=" + hospitalId
				+ ", deptId=" + deptId + ", regDate=" + regDate + ", hospitalName=" + hospitalName + "]";
	}

}
