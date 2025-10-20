package com.hospital.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hospital.mapper.CounselFormMapper;
import com.hospital.service.CounselFormService;
import com.hospital.vo.CounselFormVO;

@Service
public class CounselFormServiceImpl implements CounselFormService {

    @Autowired
    private CounselFormMapper counselFormMapper;

    @Override
    public void insertCounsel(CounselFormVO counsel) {
        counselFormMapper.insertCounsel(counsel);
    }

    @Override
    public List<CounselFormVO> getAllCounsel() {
        return counselFormMapper.getAllCounsel();
    }

    @Override
    public CounselFormVO getCounselById(int counselId) {
        return counselFormMapper.getCounselById(counselId);
    }

    @Override
    public void updateStatus(int counselId, String status) {
        counselFormMapper.updateStatus(counselId, status);
    }
    
    // ✅ 빠른예약 목록 조회 추가
    @Override
    public List<CounselFormVO> getFastReservations() {
        return counselFormMapper.getFastReservations();
    }
    
    @Override
    public List<CounselFormVO> selectByEmail(String email) {
        return counselFormMapper.selectByEmail(email);
    }

}
