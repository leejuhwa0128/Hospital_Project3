package com.hospital.vo;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

public class DoctorScheduleVO {
    private int scheduleId;
    private String doctorId;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date scheduleDate;

    private String time;           // 시간대 표시용 (예: 09:00~12:00)
    private String timeSlot;       // '오전' / '오후'
    private String scheduleTime;   // DB에 저장된 시간 범위 문자열
    private String scheduleType;   // '외래진료', '강의', '학회', '휴가', '기타'
    private String note;
    private Date created_at;

    public int getScheduleId() {
        return scheduleId;
    }
    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public String getDoctorId() {
        return doctorId;
    }
    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId;
    }

    public Date getScheduleDate() {
        return scheduleDate;
    }
    public void setScheduleDate(Date scheduleDate) {
        this.scheduleDate = scheduleDate;
    }

    public String getTime() {
        return time;
    }
    public void setTime(String time) {
        this.time = time;
    }

    public String getTimeSlot() {
        return timeSlot;
    }
    public void setTimeSlot(String timeSlot) {
        this.timeSlot = timeSlot;
    }

    public String getScheduleTime() {
        return scheduleTime;
    }
    public void setScheduleTime(String scheduleTime) {
        this.scheduleTime = scheduleTime;
    }

    public String getScheduleType() {
        return scheduleType;
    }
    public void setScheduleType(String scheduleType) {
        this.scheduleType = scheduleType;
    }

    public String getNote() {
        return note;
    }
    public void setNote(String note) {
        this.note = note;
    }

    public Date getCreated_at() {
        return created_at;
    }
    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    @Override
    public String toString() {
        return "DoctorScheduleVO [scheduleId=" + scheduleId 
                + ", doctorId=" + doctorId 
                + ", scheduleDate=" + scheduleDate
                + ", time=" + time
                + ", timeSlot=" + timeSlot
                + ", scheduleTime=" + scheduleTime
                + ", scheduleType=" + scheduleType
                + ", note=" + note
                + ", created_at=" + created_at + "]";
    }
}
