package com.hospital.vo;

import java.sql.Date;

public class DoctorVO {
    private String doctorId;          // 의사 id
    private String deptId;            // 소속 진료과 id
    private String specialty;         // 전문 분야
    private String bio;               // 소개
    private String profileImagePath;  // 프로필 이미지 경로
    private Date createdAt;           // 등록일
    private String name;              // 의사 이름 (users 조인)
    private String deptName;          // 진료과 이름 (departments 조인)

    public String getDoctorId() {
        return doctorId;
    }
    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId;
    }

    public String getDeptId() {
        return deptId;
    }
    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getSpecialty() {
        return specialty;
    }
    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

    public String getBio() {
        return bio;
    }
    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getProfileImagePath() {
        return profileImagePath;
    }
    public void setProfileImagePath(String profileImagePath) {
        this.profileImagePath = profileImagePath;
    }

    public Date getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getDeptName() {
        return deptName;
    }
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    @Override
    public String toString() {
        return "DoctorVO{" +
                "doctorId='" + doctorId + '\'' +
                ", deptId='" + deptId + '\'' +
                ", specialty='" + specialty + '\'' +
                ", bio='" + bio + '\'' +
                ", profileImagePath='" + profileImagePath + '\'' +
                ", createdAt=" + createdAt +
                ", name='" + name + '\'' +
                ", deptName='" + deptName + '\'' +
                '}';
    }
}
