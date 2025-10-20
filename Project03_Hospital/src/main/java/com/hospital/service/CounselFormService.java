package com.hospital.service;

import java.util.List;
import com.hospital.vo.CounselFormVO;

public interface CounselFormService {
    void insertCounsel(CounselFormVO counsel);
    List<CounselFormVO> getAllCounsel();
    CounselFormVO getCounselById(int counselId);
    void updateStatus(int counselId, String status);
    
    List<CounselFormVO> getFastReservations();
    
    List<CounselFormVO> selectByEmail(String email);

    
}


