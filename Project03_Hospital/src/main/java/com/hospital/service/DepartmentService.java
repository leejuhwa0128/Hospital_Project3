// src/main/java/com/hospital/service/DepartmentService.java
package com.hospital.service;

import java.util.List;
import java.util.Map;

import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;

public interface DepartmentService {

    // 진료과
    List<DepartmentVO> getAllDepartments(); // 전체 진료과 목록
    List<DepartmentVO> searchDepartments(String keyword); // 특정 진료과 검색
    List<DoctorVO> getDoctorsByDeptId(String deptId); // 특정 진료과 소속 의료진 목록
    DepartmentVO getDepartmentById(String deptId); //특정 진료과 상세 조회
	List<DoctorVO> searchDoctors(String searchKeyword); //추가

    // 의료진 목록/페이징
    int countDoctors(String deptId, String keyword);
    List<DoctorVO> getDoctors(String deptId, String keyword, int limit, int offset);

    // 의료진 상세
    DoctorVO getDoctorById(String doctorId);

    // 스케줄
    List<DoctorScheduleVO> getDoctorSchedules(String doctorId);
    List<DoctorScheduleVO> findSchedulesInRange(Map<String, Object> param); // doctorId, startDate, endDate

}
