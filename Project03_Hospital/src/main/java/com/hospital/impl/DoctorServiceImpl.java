package com.hospital.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hospital.dao.DoctorDAO;
import com.hospital.service.DoctorService;
import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.ReservationVO;

@Service
public class DoctorServiceImpl implements DoctorService {

	@Autowired
	private DoctorDAO doctorDAO;

	@Override
	public List<DoctorVO> getAllDoctors() {
		return doctorDAO.getAllDoctors();
	}

	@Override
	public List<DoctorVO> searchDoctors(String keyword) {
		return doctorDAO.searchDoctors(keyword);
	}

	@Override
	public boolean updateDoctor(DoctorVO doctor) {
		return doctorDAO.updateDoctor(doctor) > 0;
	}

	@Override
	public boolean deleteDoctor(String doctorId) {
		return doctorDAO.deleteDoctor(doctorId) > 0;
	}

	@Override
	public DoctorVO getDoctorById(String doctorId) {
		return doctorDAO.getDoctorById(doctorId);
	}

	@Override
	public void updateDoctorDept(DoctorVO doctor) {
		doctorDAO.updateDoctorDept(doctor);
	}

	@Override
	public List<DepartmentVO> getAllDepartments() {
		return doctorDAO.getAllDepartments();
	}

	@Override
	public List<MedicalRecordVO> getRecordsByDoctorId(String doctorId) {
		return doctorDAO.getRecordsByDoctorId(doctorId);
	}

	@Override
	public List<ReservationVO> getReservationsByDoctorId(String doctorId) {
		return doctorDAO.getReservationsByDoctorId(doctorId);
	}

	@Override
	public List<DoctorVO> getDoctorsByDept(String deptId) {
		return doctorDAO.getDoctorsByDept(deptId);
	}

	@Override
	public int countDoctors() {
		return doctorDAO.countDoctors();
	}

	@Override
	public List<DoctorScheduleVO> getSchedulesByDoctorId(String doctorId) {
		return doctorDAO.getSchedulesByDoctorId(doctorId);
	}

}
