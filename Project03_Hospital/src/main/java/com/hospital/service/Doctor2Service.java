package com.hospital.service;

import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.ReservationVO;

import java.util.List;

public interface Doctor2Service {
    List<DepartmentVO> getAllDepartments();

    List<DoctorVO> getDoctorsByDeptId(String deptId);

    List<DoctorScheduleVO> getSchedulesByDoctorAndDate(String doctorId, String date);

    DoctorVO getDoctorById(String doctorId); // 예: 아이디로 정보 가져오는 메서드

    void updateDoctorProfile(String doctorId, String bio);
    
    List<ReservationVO> getTodayPatientsByDoctorId(String doctorId);
    ReservationVO getReservationById(int reservationId);
    
    void updateStatusToCompleted(int reservationId);
}
