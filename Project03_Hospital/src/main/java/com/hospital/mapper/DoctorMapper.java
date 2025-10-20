package com.hospital.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.hospital.vo.DoctorVO;

public interface DoctorMapper {
	@Select("SELECT * FROM DOCTOR_INFO WHERE DOCTOR_ID = #{doctorId}")
	DoctorVO getDoctorById(@Param("doctorId") String doctorId);
	
    @Update("UPDATE DOCTOR_INFO SET BIO = #{bio} WHERE DOCTOR_ID = #{doctorId}")
    void updateDoctorProfile(@Param("doctorId") String doctorId, @Param("bio") String bio);
	
}
