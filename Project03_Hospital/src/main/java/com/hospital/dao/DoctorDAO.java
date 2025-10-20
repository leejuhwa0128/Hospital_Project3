package com.hospital.dao;

import java.util.List;

import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.ReservationVO;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface DoctorDAO {
	List<DoctorVO> getAllDoctors(); // 전체 조회

	List<DoctorVO> searchDoctors(@Param("keyword") String keyword); // 이름/전공 검색

	int updateDoctor(DoctorVO doctor); // 수정

	int deleteDoctor(@Param("doctorId") String doctorId); // 삭제

	// 진료과 변경 관련
	DoctorVO getDoctorById(String doctorId);

	void updateDoctorDept(DoctorVO doctor);

	List<DepartmentVO> getAllDepartments();

	List<MedicalRecordVO> getRecordsByDoctorId(String doctorId);

	List<ReservationVO> getReservationsByDoctorId(String doctorId);

	List<DoctorVO> getDoctorsByDept(String deptId);

	int countDoctors();
	
	List<DoctorScheduleVO> getSchedulesByDoctorId(String doctorId);
}
