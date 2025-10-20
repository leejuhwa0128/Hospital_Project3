package com.hospital.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hospital.vo.PatientVO;

@Mapper
public interface PatientDAO {
	int insertPatient(PatientVO vo); // 회원가입

	int updatePatientToMember(PatientVO vo); // 회원가입(비회원 -> 회원)

	PatientVO findNonMemberPatient(@Param("patientName") String patientName, @Param("patientRrn") String patientRrn);// 비회원조회

	PatientVO login(PatientVO vo); // 로그인

	int existsByUserId(String userId); // id 전역검사

	int existsByRrn(String rrn); // 주민번호 전역검사

	int existsByEmail(String email); // email 전역검사

	// ✅ 관리자 기능 추가
	List<PatientVO> getAllPatients();

	List<PatientVO> searchPatients(String keyword);

	void deletePatientByNo(int patientNo); // 환자번호 기준 삭제

	void deletePatientByUserId(String patientUserId); // 소셜 로그인 ID 기준 삭제

	PatientVO getPatientByNo(int patientNo);

	void deletePatient(String patientUserId);

	// 반드시 있어야 함
	void insertSocialPatient(PatientVO vo);

	PatientVO findPatientByEmail(@Param("email") String email);

	int updatePatientInfo(PatientVO vo);

	PatientVO getPatientById(String patientUserId);

	void updatePatientInfoAndPassword(PatientVO vo);

	String findPatientId(String patientName, String patientPhone);

	int checkPatientForPassword(String patientUserId, String patientRrn);

	void updateTemporaryPassword(String patientUserId, String tempPassword);

	PatientVO selectPatientByUserId(String userId);

	PatientVO selectPatientByEmail(String email);


	int existsByPhone(String phone);

	int countPatients();
	
	 PatientVO getPatientByUserId(String userId);
	 
	 int stripToGuest(@Param("patientNo") int patientNo);

}
