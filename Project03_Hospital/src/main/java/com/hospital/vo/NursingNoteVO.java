package com.hospital.vo;



import java.util.Date;

public class NursingNoteVO {
    private int noteId;
    private int patientNo;
    private String nurseId;
    private Date noteDate;
    private String content;
    private Date createdAt;

    public int getNoteId() {
        return noteId;
    }

    public void setNoteId(int noteId) {
        this.noteId = noteId;
    }

    public int getPatientNo() {
        return patientNo;
    }

    public void setPatientNo(int patientNo) {
        this.patientNo = patientNo;
    }

    public String getNurseId() {
        return nurseId;
    }

    public void setNurseId(String nurseId) {
        this.nurseId = nurseId;
    }

    public Date getNoteDate() {
        return noteDate;
    }

    public void setNoteDate(Date noteDate) {
        this.noteDate = noteDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "NursingNoteVO{" +
                "noteId=" + noteId +
                ", patientNo=" + patientNo +
                ", nurseId='" + nurseId + '\'' +
                ", noteDate=" + noteDate +
                ", content='" + content + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
