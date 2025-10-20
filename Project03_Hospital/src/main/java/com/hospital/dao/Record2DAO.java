package com.hospital.dao;

import java.util.List;

import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.QuestionnaireVO;

public interface Record2DAO {
    QuestionnaireVO getQuestionnaireByReservationId(int reservationId);
    List<MedicalRecordVO> selectRecordsByDoctorId(String doctorId);

    
    }
