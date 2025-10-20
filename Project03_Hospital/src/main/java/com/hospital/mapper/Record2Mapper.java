package com.hospital.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.QuestionnaireVO;

public interface Record2Mapper {
	@Insert("INSERT INTO medical_records (record_id, reservation_id, doctor_id, content, medication, diagnosis, treatment, prescription, record_date) " +
	        "VALUES (seq_medical_record_id.NEXTVAL, #{reservationId}, #{doctorId}, #{content}, #{medication}, #{diagnosis}, #{treatment}, #{prescription}, SYSDATE)")
	void insertMedicalRecord(MedicalRecordVO vo);

	
    @Select("SELECT reservation_id, doctor_id, record_date, diagnosis, prescription, treatment " +
            "FROM medical_records WHERE reservation_id = #{reservationId}")
    MedicalRecordVO getRecordByReservationId(@Param("reservationId") int reservationId);

    
    @Select("SELECT * FROM medical_records WHERE reservation_id = #{reservationId}")
    List<MedicalRecordVO> selectRecordsByReservationId(int reservationId);
    
    @Select("SELECT * FROM medical_questionnaires WHERE reservation_id = #{reservationId}")
    QuestionnaireVO getQuestionnaireByReservationId(@Param("reservationId") int reservationId);
    
    void updateRequestedStatus(@Param("recordId") int recordId, @Param("requested") String requested);
    
    List<MedicalRecordVO> getRecordsByDoctorId(@Param("doctorId") String doctorId);


}
