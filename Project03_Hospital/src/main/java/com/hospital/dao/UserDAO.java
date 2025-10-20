package com.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hospital.vo.*;

@Mapper
public interface UserDAO {
	UserVO login(UserVO vo);

	int insertPendingUser(UserVO vo);

	int insertUser(UserVO vo);

	int insertDoctorInfo(DoctorVO doctor);

	List<PendingUserVO> selectPendingUsers();

	PendingUserVO selectPendingUserById(String userId);

	int updatePendingStatus(@Param("userId") String userId, @Param("status") String status);

	int rejectPendingUser(@Param("userId") String userId, @Param("rejectReason") String rejectReason,
			@Param("reviewedBy") String reviewedBy);

	List<PartnerHospitalVO> selectHospitals();

	List<DepartmentVO> selectDepartments();

	int existsByUserId(String userId);

	int existsByRrn(String rrn);

	int existsByEmail(String email);

	int existsUserIdAll(String userId);

	int existsEmailAll(String email);

	int existsRrnAll(String rrn);

	PendingUserVO findPendingUser(@Param("userId") String userId, @Param("password") String password);

	List<PendingUserVO> selectAllPendingUsers();

	List<PendingUserVO> getPendingUsersByStatus(String status);

	List<PendingUserVO> searchPendingUsers(@Param("keyword") String keyword);

	List<DoctorVO> getAllDoctors();

	List<DoctorVO> searchDoctors(@Param("keyword") String keyword);

	int deleteDoctor(@Param("doctorId") String doctorId);

	int getCoopUserCount();

	List<UserVO> getPagedCoopUsers(@Param("start") int start, @Param("size") int size);

	int countSearchCoopUsers(@Param("keyword") String keyword);

	List<UserVO> searchPagedCoopUsers(@Param("keyword") String keyword, @Param("start") int start,
			@Param("size") int size);

	int deleteUser(@Param("userId") String userId);

	UserVO getUserById(String userId);

	UserVO findUserByEmail(@Param("email") String email);

	void insertSocialUser(UserVO vo);

	PatientVO findPatientByEmail(@Param("email") String email);

	int countPendingUsers();

	int countPendingUsersByRole(String role);
	
	  int updateProfile(UserVO vo);
	  int updateUser(UserVO user);
	  
	  //ID PW 추가
	  String findUserId(Map<String, Object> param);
	  
	  int existsUserForReset(Map<String,Object> param);
	  int updatePassword(Map<String,Object> param);
}
