package com.hospital.service;

import java.util.List;
import com.hospital.vo.DoctorScheduleVO;

public interface DoctorScheduleService {
	List<DoctorScheduleVO> getSchedulesByDoctorId(String doctorId);

	DoctorScheduleVO getScheduleById(int scheduleId);

	void updateSchedule(DoctorScheduleVO vo);

	void insertSchedule(DoctorScheduleVO vo);
	
	List<DoctorScheduleVO> getSchedulesByDoctorAndDate(String doctorId, String date);
	
	// 기본 삭제
	void deleteSchedule(long scheduleId);

	// 강제 삭제 지원
	void deleteSchedule(long scheduleId, boolean force);
}
