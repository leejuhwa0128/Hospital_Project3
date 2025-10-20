package com.hospital.mapper;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.hospital.vo.DoctorScheduleVO;

public interface Doctor2ScheduleMapper {
    
    @Insert("INSERT INTO doctor_schedules " +
            "(schedule_id, doctor_id, schedule_date, time_slot, schedule_time, note, created_at) " +
            "VALUES (doctor_schedule_seq.NEXTVAL, #{doctorId}, #{scheduleDate}, #{timeSlot}, #{scheduleTime}, #{note}, SYSDATE)")
    int insertSchedule(
        @Param("doctorId") String doctorId,
        @Param("scheduleDate") Date scheduleDate,
        @Param("timeSlot") String timeSlot,
        @Param("scheduleTime") String scheduleTime,
        @Param("note") String note
    );

    @Delete("DELETE FROM doctor_schedules " +
            "WHERE schedule_date = TO_DATE(#{date}, 'MM/DD/YYYY') " +
            "AND schedule_time = #{scheduleTime} " +
            "AND doctor_id = #{doctorId}")
    int deleteScheduleByDateTime(
        @Param("date") String date,
        @Param("scheduleTime") String scheduleTime,
        @Param("doctorId") String doctorId
    );

    @Select("SELECT schedule_time AS scheduleTime, time_slot AS timeSlot, note FROM doctor_schedules " +
            "WHERE schedule_date = TO_DATE(#{date}, 'MM/DD/YYYY') AND doctor_id = #{doctorId}")
    List<DoctorScheduleVO> selectSchedulesByDateAndDoctor(
        @Param("date") String date,
        @Param("doctorId") String doctorId
    );
    
    @Select("SELECT schedule_time AS scheduleTime, time_slot AS timeSlot, note FROM doctor_schedules " +
            "WHERE schedule_date = TO_DATE(#{date}, 'MM/DD/YYYY')")
    List<DoctorScheduleVO> selectSchedulesByDate(@Param("date") String date);

    @Select("SELECT COUNT(*) FROM doctor_schedules " +
            "WHERE doctor_id = #{doctorId} " +
            "AND schedule_date = TO_DATE(#{date}, 'YYYY-MM-DD') " +
            "AND schedule_time = #{scheduleTime}")
    int countScheduleByDateTime(
        @Param("doctorId") String doctorId,
        @Param("date") String date,
        @Param("scheduleTime") String scheduleTime
    );
}
