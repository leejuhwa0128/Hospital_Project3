package com.hospital.service;

import java.util.List;

import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.QuestionnaireVO;

public interface Record2Service {
	public void saveMedicalRecord(MedicalRecordVO vo);

	MedicalRecordVO getRecordByReservationId(int reservationId);

	List<MedicalRecordVO> getRecordsByDoctorId(String doctorId);

	QuestionnaireVO getQuestionnaireByReservationId(int reservationId);

	// 진료기록 ID 리스트 조회 (협진 여부 확인용)
	List<MedicalRecordVO> getAllRecordsWithDuplicateCheckByDoctorId(String doctorId);
	
	void markReferralRequested(int recordId);
	
	void updateRequestedStatus(int recordId, boolean requested);

}
