package com.hospital.mapper;

import com.hospital.vo.PatientVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PatientMapper {
    PatientVO selectPatientByUserId(String userId);
}