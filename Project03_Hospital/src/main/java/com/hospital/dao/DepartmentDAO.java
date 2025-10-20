// src/main/java/com/hospital/dao/DepartmentDAO.java
package com.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;

@Mapper
public interface DepartmentDAO {

    // 진료과
    List<DepartmentVO> getAllDepartments(); //전체 진료과 목록
    List<DepartmentVO> searchDepartments(@Param("keyword") String keyword); //특정 진료과 검색
    List<DoctorVO> getDoctorsByDeptId(@Param("deptId") String deptId); // 특정 진료과 소속 의료진 목록
    DepartmentVO getDepartmentById(@Param("deptId") String deptId); // 특정 진료과 상세 조회
    

    // 의료진 목록/페이징
    int countDoctors(@Param("deptId") String deptId,
                     @Param("keyword") String keyword);
    List<DoctorVO> getDoctors(@Param("deptId") String deptId,
                              @Param("keyword") String keyword,
                              @Param("limit") int limit,
                              @Param("offset") int offset);

    // 의료진 상세
    DoctorVO getDoctorById(@Param("doctorId") String doctorId);

    // 스케줄
    List<DoctorScheduleVO> getDoctorSchedules(@Param("doctorId") String doctorId);
    List<DoctorScheduleVO> findSchedulesInRange(Map<String, Object> param); // doctorId, startDate, endDate
	
    //통합검색 의료진
    List<DoctorVO> searchDoctors(String keyword);
    
   
}


