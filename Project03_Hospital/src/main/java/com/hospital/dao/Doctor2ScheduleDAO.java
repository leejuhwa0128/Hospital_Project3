package com.hospital.dao;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hospital.mapper.Doctor2ScheduleMapper;
import com.hospital.vo.DoctorScheduleVO;

@Repository
public class Doctor2ScheduleDAO {

    @Autowired
    private Doctor2ScheduleMapper doctor2ScheduleMapper;

    public int insertSchedule(String doctorId, Date scheduleDate, String timeSlot, String scheduleTime, String note) {
        return doctor2ScheduleMapper.insertSchedule(doctorId, scheduleDate, timeSlot, scheduleTime, note);
    }

    public int deleteScheduleByDateTime(String date, String scheduleTime, String doctorId) {
        return doctor2ScheduleMapper.deleteScheduleByDateTime(date, scheduleTime, doctorId);
    }

    public List<DoctorScheduleVO> selectSchedulesByDate(String date) {
        return doctor2ScheduleMapper.selectSchedulesByDate(date);
    }

    public boolean existsSchedule(String doctorId, String date, String scheduleTime) {
        int count = doctor2ScheduleMapper.countScheduleByDateTime(doctorId, date, scheduleTime);
        return count > 0;
    }

    public List<DoctorScheduleVO> getSchedulesByDateAndDoctor(String date, String doctorId) {
        return doctor2ScheduleMapper.selectSchedulesByDateAndDoctor(date, doctorId);
    }
}
