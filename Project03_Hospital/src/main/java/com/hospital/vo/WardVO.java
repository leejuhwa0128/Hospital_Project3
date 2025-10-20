package com.hospital.vo;

import java.util.Date;

public class WardVO {
    private int wardId;
    private int patientNo;
    private Date admissionDate;
    private Date dischargeDate;
    private String roomNo;
    private String bedNo;
    private String status;
    private String nurseId;
    private String memo;
    private Date createdAt;

    // === Getter & Setter ===

    public int getWardId() {
        return wardId;
    }

    public void setWardId(int wardId) {
        this.wardId = wardId;
    }

    public int getPatientNo() {
        return patientNo;
    }

    public void setPatientNo(int patientNo) {
        this.patientNo = patientNo;
    }

    public Date getAdmissionDate() {
        return admissionDate;
    }

    public void setAdmissionDate(Date admissionDate) {
        this.admissionDate = admissionDate;
    }

    public Date getDischargeDate() {
        return dischargeDate;
    }

    public void setDischargeDate(Date dischargeDate) {
        this.dischargeDate = dischargeDate;
    }

    public String getRoomNo() {
        return roomNo;
    }

    public void setRoomNo(String roomNo) {
        this.roomNo = roomNo;
    }

    public String getBedNo() {
        return bedNo;
    }

    public void setBedNo(String bedNo) {
        this.bedNo = bedNo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNurseId() {
        return nurseId;
    }

    public void setNurseId(String nurseId) {
        this.nurseId = nurseId;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
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
        return "WardVO{" +
                "wardId=" + wardId +
                ", patientNo=" + patientNo +
                ", admissionDate=" + admissionDate +
                ", dischargeDate=" + dischargeDate +
                ", roomNo='" + roomNo + '\'' +
                ", bedNo='" + bedNo + '\'' +
                ", status='" + status + '\'' +
                ", nurseId='" + nurseId + '\'' +
                ", memo='" + memo + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
