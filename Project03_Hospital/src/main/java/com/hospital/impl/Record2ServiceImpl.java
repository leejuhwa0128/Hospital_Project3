package com.hospital.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.dao.Record2DAO;
import com.hospital.dao.RecordDAO;
import com.hospital.dao.Referral2DAO;
import com.hospital.dao.ReferralDAO;
import com.hospital.mapper.Record2Mapper;
import com.hospital.mapper.RecordMapper;
import com.hospital.service.Record2Service;
import com.hospital.service.RecordService;
import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.QuestionnaireVO;

@Service
public class Record2ServiceImpl implements Record2Service {

    @Autowired
    private Record2Mapper record2Mapper;
    @Autowired
    private Record2DAO record2DAO;
    @Autowired
    private Referral2DAO referral2DAO;
    
    @Override
    public void saveMedicalRecord(MedicalRecordVO vo) {
       record2Mapper.insertMedicalRecord(vo);
    }

    @Override
    public MedicalRecordVO getRecordByReservationId(int reservationId) {
    	
        List<MedicalRecordVO> list = record2Mapper.selectRecordsByReservationId(reservationId);  // ✅ List로 받기
        return list.isEmpty() ? null : list.get(0);  // ✅ 첫 번째 진단서만 반환
    }
    
    @Override
    public List<MedicalRecordVO> getRecordsByDoctorId(String doctorId) {
        return record2Mapper.getRecordsByDoctorId(doctorId);
    }
    
    @Override
    public QuestionnaireVO getQuestionnaireByReservationId(int reservationId) {
        return record2Mapper.getQuestionnaireByReservationId(reservationId);
    }
    
    @Override
    public List<MedicalRecordVO> getAllRecordsWithDuplicateCheckByDoctorId(String doctorId) {
        List<MedicalRecordVO> records = record2DAO.selectRecordsByDoctorId(doctorId);
        for (MedicalRecordVO record : records) {
            boolean isDuplicate = referral2DAO.countReferralByRecordId(record.getRecordId()) > 0;
            record.setDuplicate(isDuplicate);
        }
        return records;
    }

    @Override
    public void updateRequestedStatus(int recordId, boolean requested) {
        record2Mapper.updateRequestedStatus(recordId, requested ? "Y" : "N");
    }

	@Override
	public void markReferralRequested(int recordId) {
		// TODO Auto-generated method stub
		
	}

}
