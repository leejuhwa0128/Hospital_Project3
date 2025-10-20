package com.hospital.service;

import java.util.List;

import com.hospital.vo.PatientVO;

public interface PatientService {
	boolean registerPatient(PatientVO vo); // 회원가입

	void updatePatientToMember(PatientVO vo); // 회원가입(비회원 -> 회원)

	PatientVO findNonMemberPatient(String name, String rrn); // 비회원 데이터 조회 (회원가입 시 체크용)

	PatientVO login(PatientVO vo); // 로그인

	// 3. 전체 환자 목록 조회 (관리자)
	List<PatientVO> getAllPatients();

	// 4. 환자 검색 (관리자)
	List<PatientVO> searchPatients(String keyword);

	// 5. 환자 삭제 (관리자)
	void deletePatient(int patientNo);
	
	// 5. 환자 비회원화(임시-완성아님 나중에 해야함)
	boolean stripToGuest(int patientNo);	

	// 6. 환자 상세보기
	PatientVO getPatientByNo(int patientNo);

	void logdeletePatient(String patientUserId);

	void insertSocialPatient(PatientVO vo);

	PatientVO findPatientByEmail(String email);

	// (회원 정보수정)
	boolean updatePatientInfo(PatientVO vo);

	PatientVO getPatientById(String patientUserId);

	void updatePatientInfoAndPassword(PatientVO vo);

	String findPatientId(String name, String rrn);

	String findTempPassword(String id, String rrn);

	boolean isUserIdDuplicated(String userId);

	boolean isEmailDuplicated(String email);

	int countPatients();
	
	public boolean isRrnDuplicated(String rrn);
	public boolean isPhoneDuplicated(String phone);
	
	 PatientVO getPatientByUserId(String userId);


}