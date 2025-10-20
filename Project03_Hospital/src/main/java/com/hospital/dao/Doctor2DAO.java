package com.hospital.dao;


import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.ReservationVO;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
@Mapper
public interface Doctor2DAO {
    List<DepartmentVO> getAllDepartments();
    List<DoctorVO> getDoctorsByDeptId(@Param("deptId") String deptId);
    List<DoctorScheduleVO> getSchedulesByDoctorAndDate(@Param("doctorId") String doctorId,
                                                        @Param("date") String date);
    
    
    
    List<ReservationVO> selectTodayPatientsByDoctorId(@Param("doctorId") String doctorId);
    ReservationVO selectReservationById(@Param("reservationId") int reservationId);
    
    int updateStatusToCompleted(@Param("reservationId") int reservationId);
}
