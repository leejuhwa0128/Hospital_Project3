package com.hospital.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.dao.RecordDAO;
import com.hospital.service.RecordService;
import com.hospital.vo.MedicalRecordVO;

@Service
public class RecordServiceImpl implements RecordService {

	@Autowired
	private RecordDAO recordDAO;

	@Override
	public List<MedicalRecordVO> getRecordsByPatientNo(int patientNo) {
		return recordDAO.getRecordsByPatientNo(patientNo);
	}
}
