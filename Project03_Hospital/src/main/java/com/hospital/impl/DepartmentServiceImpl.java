// src/main/java/com/hospital/impl/DepartmentServiceImpl.java
package com.hospital.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.dao.DepartmentDAO;
import com.hospital.service.DepartmentService;
import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;

@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentDAO departmentDAO;

    @Override
    public List<DepartmentVO> getAllDepartments() {
        return departmentDAO.getAllDepartments();
    }

    @Override
    public List<DepartmentVO> searchDepartments(String keyword) {
        return departmentDAO.searchDepartments(keyword);
    }

    @Override
    public DepartmentVO getDepartmentById(String deptId) {
        return departmentDAO.getDepartmentById(deptId);
    }

    @Override
    public int countDoctors(String deptId, String keyword) {
        return departmentDAO.countDoctors(deptId, keyword);
    }

    @Override
    public List<DoctorVO> getDoctors(String deptId, String keyword, int limit, int offset) {
        return departmentDAO.getDoctors(deptId, keyword, limit, offset);
    }
    
    @Override
    public DoctorVO getDoctorById(String doctorId) {
        return departmentDAO.getDoctorById(doctorId);
    }

    @Override
    public List<DoctorScheduleVO> getDoctorSchedules(String doctorId) {
        return departmentDAO.getDoctorSchedules(doctorId);
    }

    @Override
    public List<DoctorScheduleVO> findSchedulesInRange(Map<String, Object> param) {
        return departmentDAO.findSchedulesInRange(param);
    }
    
    @Override
    public List<DoctorVO> getDoctorsByDeptId(String deptId) {
        return departmentDAO.getDoctorsByDeptId(deptId);
    }
    
    @Override
    public List<DoctorVO> searchDoctors(String keyword) {
        return departmentDAO.searchDoctors(keyword);
    }

}
