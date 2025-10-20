package com.hospital.service;

import java.util.List;

import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.ReservationVO;

public interface DoctorService {
	List<DoctorVO> getAllDoctors();

	List<DoctorVO> searchDoctors(String keyword);

	boolean updateDoctor(DoctorVO doctor);

	boolean deleteDoctor(String doctorId);

	DoctorVO getDoctorById(String doctorId);

	void updateDoctorDept(DoctorVO doctor);

	List<DepartmentVO> getAllDepartments();

	List<MedicalRecordVO> getRecordsByDoctorId(String doctorId);

	List<ReservationVO> getReservationsByDoctorId(String doctorId);

	List<DoctorVO> getDoctorsByDept(String deptId);

	int countDoctors();

	List<DoctorScheduleVO> getSchedulesByDoctorId(String doctorId); // 스케줄 조회
}
