package com.hospital.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.dao.Doctor2DAO;
import com.hospital.mapper.DoctorMapper;
import com.hospital.service.Doctor2Service;
import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.ReservationVO;

@Service
public class Doctor2ServiceImpl implements Doctor2Service {
	

	 @Autowired
	    private Doctor2DAO doctor2DAO;  
    

    @Autowired
    private DoctorMapper doctor2Mapper;

    @Override
    public List<DepartmentVO> getAllDepartments() {
        return doctor2DAO.getAllDepartments();
    }

    @Override
    public List<DoctorVO> getDoctorsByDeptId(String deptId) {
        return doctor2DAO.getDoctorsByDeptId(deptId);
    }

    @Override
    public List<DoctorScheduleVO> getSchedulesByDoctorAndDate(String doctorId, String date) {
        return doctor2DAO.getSchedulesByDoctorAndDate(doctorId, date);
    }

    @Override
    public DoctorVO getDoctorById(String doctorId) {
        return doctor2Mapper.getDoctorById(doctorId); 
    }

    @Override
    public void updateDoctorProfile(String doctorId, String bio) {
        doctor2Mapper.updateDoctorProfile(doctorId, bio);
    }
    
    @Override
    public List<ReservationVO> getTodayPatientsByDoctorId(String doctorId) {
        return doctor2DAO.selectTodayPatientsByDoctorId(doctorId);
    }

    @Override
    public ReservationVO getReservationById(int reservationId) {
        return doctor2DAO.selectReservationById(reservationId);
    }
    @Override
    public void updateStatusToCompleted(int reservationId) {
        doctor2DAO.updateStatusToCompleted(reservationId);
    }
}
