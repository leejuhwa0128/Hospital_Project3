package com.hospital.impl;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.dao.Doctor2ScheduleDAO;
import com.hospital.mapper.Doctor2ScheduleMapper;
import com.hospital.service.Doctor2ScheduleService;
import com.hospital.vo.DoctorScheduleVO;

@Service
public class Doctor2ScheduleServiceImpl implements Doctor2ScheduleService {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private Doctor2ScheduleDAO doctor2ScheduleDAO;

    @Autowired
    private Doctor2ScheduleMapper doctor2ScheduleMapper;

    @Override
    public List<DoctorScheduleVO> getScheduleByDoctorName(String doctorName) {
        return sqlSession.selectList("com.hospital.mapper.DoctorScheduleMapper.getScheduleByDoctorName", doctorName);
    }

    @Override
    public int deleteScheduleByDateTime(String date, String scheduleType, String doctorId) {
    	return doctor2ScheduleDAO.deleteScheduleByDateTime(date, scheduleType, doctorId); // ✅ 변수명 교체
    }

    @Override
    public List<DoctorScheduleVO> getSchedulesByDate(String date) {
        return doctor2ScheduleDAO.selectSchedulesByDate(date);
    }

    @Override
    public int registerSchedule(String doctorId, Date scheduleDate, String timeSlot, String scheduleTime, String note) {
        String dateStr = new SimpleDateFormat("yyyy-MM-dd").format(scheduleDate);
        if (doctor2ScheduleDAO.existsSchedule(doctorId, dateStr, scheduleTime)) {
            return 0;
        }
        return doctor2ScheduleDAO.insertSchedule(doctorId, scheduleDate, timeSlot, scheduleTime, note);
    }

    @Override
    public int saveSchedule(DoctorScheduleVO vo) {
        return doctor2ScheduleMapper.insertSchedule(
            vo.getDoctorId(),
            new java.sql.Date(vo.getScheduleDate().getTime()),
            vo.getTimeSlot(),
            vo.getScheduleTime(),
            vo.getNote()
        );
    }

    @Override
    public List<DoctorScheduleVO> getSchedulesByDateAndDoctor(String date, String doctorId) {
        return doctor2ScheduleDAO.getSchedulesByDateAndDoctor(date, doctorId);
    }
}
