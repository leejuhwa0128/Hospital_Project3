package com.hospital.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.hospital.dao.UserDAO;
import com.hospital.dao.PatientDAO;
import com.hospital.service.UserService;
import com.hospital.vo.*;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private PatientDAO patientDAO;

	@Override
	public UserVO login(UserVO vo) {
		return userDAO.login(vo);
	}

	@Override
	public boolean register(UserVO user) {
		try {
			userDAO.insertUser(user); // 실제 DB에 삽입
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public int updateProfile(UserVO vo) {
		return userDAO.updateProfile(vo);
	}

	@Override
	public List<DepartmentVO> selectDepartments() {
		return userDAO.selectDepartments();
	}

	@Override
	public boolean insertUser(PendingUserVO vo) {
		UserVO user = new UserVO();
		user.setUserId(vo.getUserId());
		user.setPassword(vo.getPassword());
		user.setName(vo.getName());
		user.setRrn(vo.getRrn());
		user.setGender(vo.getGender());
		user.setPhone(vo.getPhone());
		user.setEmail(vo.getEmail());
		user.setRole(vo.getRole());
		user.setHospitalId(vo.getHospitalId());
		user.setDeptId(vo.getDeptId());

		int result = userDAO.insertUser(user);

		if (result > 0 && "doctor".equals(user.getRole())) {
			DoctorVO doctor = new DoctorVO();
			doctor.setDoctorId(user.getUserId());
			doctor.setDeptId(user.getDeptId());
			doctor.setSpecialty("");
			doctor.setBio("");
			doctor.setProfileImagePath("");
			userDAO.insertDoctorInfo(doctor);
		}

		if (result > 0) {
			int updated = userDAO.updatePendingStatus(user.getUserId(), "승인");
			if (updated == 0) {
				System.out.println("주의: pending_users에 해당 user_id가 없어 상태 변경 실패");
			}
		}

		return result > 0;
	}

	@Override
	public boolean rejectPendingUser(String userId, String rejectReason, String reviewedBy) {
		return userDAO.rejectPendingUser(userId, rejectReason, reviewedBy) > 0;
	}

	@Override
	public List<PendingUserVO> getPendingUserList() {
		return userDAO.selectPendingUsers();
	}

	@Override
	public PendingUserVO getPendingUserById(String userId) {
		return userDAO.selectPendingUserById(userId);
	}

	@Override
	public List<PartnerHospitalVO> getAllHospitals() {
		return userDAO.selectHospitals();
	}

	@Override
	public List<DepartmentVO> getAllDepartments() {
		return userDAO.selectDepartments();
	}

	@Override
	public PendingUserVO findPendingUser(String userId, String password) {
		return userDAO.findPendingUser(userId, password);
	}

	@Override
	public boolean insertPendingUser(UserVO vo) {
		if (userDAO.existsUserIdAll(vo.getUserId()) > 0) {
			throw new DuplicateKeyException("이미 사용 중인 아이디입니다.");
		}
		if (userDAO.existsRrnAll(vo.getRrn()) > 0) {
			throw new DuplicateKeyException("이미 등록된 주민등록번호입니다.");
		}
		if (userDAO.existsEmailAll(vo.getEmail()) > 0) {
			throw new DuplicateKeyException("이미 등록된 이메일입니다.");
		}
		return userDAO.insertPendingUser(vo) > 0;
	}

	@Override
	public List<PendingUserVO> getAllPendingUsers() {
		return userDAO.selectAllPendingUsers();
	}

	@Override
	public List<PendingUserVO> getPendingUsersByStatus(String status) {
		return userDAO.getPendingUsersByStatus(status);
	}

	@Override
	public void undoPendingStatus(String userId) {
		userDAO.updatePendingStatus(userId, "대기");
	}

	@Override
	public List<PendingUserVO> searchPendingUsers(String keyword) {
		return userDAO.searchPendingUsers(keyword);
	}

	@Override
	public List<DoctorVO> getAllDoctors() {
		return userDAO.getAllDoctors();
	}

	@Override
	public List<DoctorVO> searchDoctors(String keyword) {
		return userDAO.searchDoctors(keyword);
	}

	@Override
	public boolean deleteDoctorById(String doctorId) {
		return userDAO.deleteDoctor(doctorId) > 0;
	}

	@Override
	public int getCoopUserCount() {
		return userDAO.getCoopUserCount();
	}

	@Override
	public List<UserVO> getPagedCoopUsers(int start, int size) {
		return userDAO.getPagedCoopUsers(start, size);
	}

	@Override
	public int countSearchCoopUsers(String keyword) {
		return userDAO.countSearchCoopUsers(keyword);
	}

	@Override
	public List<UserVO> searchPagedCoopUsers(String keyword, int start, int size) {
		return userDAO.searchPagedCoopUsers(keyword, start, size);
	}

	@Override
	public boolean deleteUserById(String userId) {
		return userDAO.deleteUser(userId) > 0;
	}

	@Override
	public UserVO getUserById(String userId) {
		return userDAO.getUserById(userId);
	}

	public boolean existsByUserId(String userId) {
		return userDAO.existsByUserId(userId) > 0;
	}

	@Override
	public UserVO findUserByEmail(String email) {
		return userDAO.findUserByEmail(email);
	}

	@Override
	public void insertSocialUser(UserVO vo) {
		userDAO.insertSocialUser(vo);
	}

	@Override
	public PatientVO findPatientByEmail(String email) {
		return userDAO.findPatientByEmail(email);
	}

	@Override
	public int countPendingUsers() {
		return userDAO.countPendingUsers();
	}

	@Override
	public int countPendingUsersByRole(String role) {
		return userDAO.countPendingUsersByRole(role);
	}

	@Override
	public void updateUser(UserVO user) {
		userDAO.updateUser(user);
	}

	// ID PW 추가
	@Override
	public String findUserId(String name, String phone, String email, String phoneDigits) {
		Map<String, Object> p = new HashMap<>();
		p.put("name", name);
		if (phone != null && !phone.isEmpty())
			p.put("phone", phone);
		if (email != null && !email.isEmpty())
			p.put("email", email);
		if (phoneDigits != null && !phoneDigits.isEmpty())
			p.put("phoneDigits", phoneDigits);
		return userDAO.findUserId(p);
	}

	@Override
	public boolean verifyUserIdentity(String userId, String name, String email) {
		Map<String, Object> p = new HashMap<>();
		p.put("userId", userId);
		p.put("name", name);
		p.put("email", email);
		return userDAO.existsUserForReset(p) > 0;
	}

	@Override
	public int updatePassword(String userId, String encPwd) {
		Map<String, Object> p = new HashMap<>();
		p.put("userId", userId);
		p.put("password", encPwd);
		return userDAO.updatePassword(p);
	}

}
