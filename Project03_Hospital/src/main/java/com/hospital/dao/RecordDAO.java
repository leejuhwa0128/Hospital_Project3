package com.hospital.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hospital.vo.MedicalRecordVO;

@Mapper
public interface RecordDAO {
	List<MedicalRecordVO> getRecordsByPatientNo(int patientNo);
}
