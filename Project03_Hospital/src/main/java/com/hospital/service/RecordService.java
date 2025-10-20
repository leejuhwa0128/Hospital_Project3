package com.hospital.service;

import java.util.List;

import com.hospital.vo.MedicalRecordVO;

public interface RecordService {
	List<MedicalRecordVO> getRecordsByPatientNo(int patientNo);
}
