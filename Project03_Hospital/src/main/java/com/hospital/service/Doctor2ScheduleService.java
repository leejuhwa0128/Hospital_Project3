package com.hospital.service;

import java.sql.Date;
import java.util.List;
import com.hospital.vo.DoctorScheduleVO;

public interface Doctor2ScheduleService {
    // 진료 스케줄 전체 조회
    List<DoctorScheduleVO> getScheduleByDoctorName(String doctorName);
    
    // 기존 방식 - 파라미터 나열
    int registerSchedule(String doctorId, Date scheduleDate, String timeSlot, String scheduleTime, String note);

    // ✅ 추가: VO 통째로 받는 방식 (컨트롤러용)
    int saveSchedule(DoctorScheduleVO vo);

    int deleteScheduleByDateTime(String date, String scheduleType, String doctorId);

    List<DoctorScheduleVO> getSchedulesByDate(String date);
    List<DoctorScheduleVO> getSchedulesByDateAndDoctor(String date, String doctorId);
}
