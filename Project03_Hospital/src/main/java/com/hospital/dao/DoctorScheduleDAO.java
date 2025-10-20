package com.hospital.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.hospital.vo.DoctorScheduleVO;

@Mapper
public interface DoctorScheduleDAO {
	List<DoctorScheduleVO> getSchedulesByDoctorId(@Param("doctorId") String doctorId);

	DoctorScheduleVO getScheduleById(@Param("scheduleId") int scheduleId);

	void updateSchedule(DoctorScheduleVO vo);

	void insertSchedule(DoctorScheduleVO vo); // 필요 시

	List<DoctorScheduleVO> selectByDoctorAndDate(@Param("doctorId") String doctorId, @Param("date") String date); // yyyy-MM-dd

	// 삭제 (하드)
	int deleteSchedule(@Param("scheduleId") long scheduleId); // ← 단일화 (이름 겹치기 금지)

	// 예약 연계 처리
	int countActiveReservationsBySchedule(@Param("scheduleId") long scheduleId); // '대기','확정'

	int cancelReservationsBySchedule(@Param("scheduleId") long scheduleId); // 활성 예약 '취소'

	int nullifyReservationsBySchedule(@Param("scheduleId") long scheduleId); // FK 끊기 (schedule_id=NULL)

}
