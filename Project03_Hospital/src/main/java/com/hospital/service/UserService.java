package com.hospital.service;

import java.util.List;

import com.hospital.vo.*;

public interface UserService {
	UserVO login(UserVO vo); // 로그인

	boolean insertPendingUser(UserVO vo); // 1. 가입 신청

	boolean insertUser(PendingUserVO vo); // 2. 관리자 승인

	boolean rejectPendingUser(String userId, String rejectReason, String reviewedBy); // 3. 관리자 반려
	
	boolean register(UserVO user);

	List<PendingUserVO> getPendingUserList(); // 4. 대기 목록

	PendingUserVO getPendingUserById(String userId); // 5. 단건 조회

	List<PartnerHospitalVO> getAllHospitals(); // 병원 목록

	List<DepartmentVO> getAllDepartments(); // 진료과 목록

	PendingUserVO findPendingUser(String userId, String password); // 회원 가입 승인 상태 표시

	List<PendingUserVO> getAllPendingUsers();

	List<PendingUserVO> getPendingUsersByStatus(String status);

	void undoPendingStatus(String userId);

	List<PendingUserVO> searchPendingUsers(String keyword);

	List<DoctorVO> getAllDoctors();

	List<DoctorVO> searchDoctors(String keyword);

	boolean deleteDoctorById(String doctorId);

	int getCoopUserCount(); // 전체 협력의 수

	List<UserVO> getPagedCoopUsers(int start, int size); // 페이징된 협력의 목록

	int countSearchCoopUsers(String keyword); // 검색 결과 수

	List<UserVO> searchPagedCoopUsers(String keyword, int start, int size); // 검색 + 페이징

	boolean deleteUserById(String userId);

	UserVO getUserById(String userId);

	// ✅ (추가) 이메일로 사용자 조회
	UserVO findUserByEmail(String email);

	void insertSocialUser(UserVO vo);

	PatientVO findPatientByEmail(String email);

	int countPendingUsers();

	int countPendingUsersByRole(String role);
	
	 List<DepartmentVO> selectDepartments();

	 int updateProfile(UserVO vo);
	 
	 void updateUser(UserVO user); 

	 
	// 아이디·이름·이메일이 모두 일치하는지 확인
	 boolean verifyUserIdentity(String userId, String name, String email);

	 // userId로 비밀번호 해시 업데이트
	 int updatePassword(String userId, String encPwd);
	 
	// 기존 Map<String,Object> 버전은 그대로 두고, 아래 메소드만 추가
	 String findUserId(String name, String phone, String email, String phoneDigits);
}
