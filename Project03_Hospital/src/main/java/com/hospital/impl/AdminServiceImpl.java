package com.hospital.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hospital.dao.AdminDAO;
import com.hospital.dao.UserDAO;
import com.hospital.service.AdminService;
import com.hospital.vo.AdminVO;
import com.hospital.vo.BoardStatVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.FeedbackVO;
import com.hospital.vo.PendingUserVO;
import com.hospital.vo.ReservationVO;
import com.hospital.vo.UserVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO adminDAO;

	@Autowired
	private UserDAO userDAO;

	@Override
	public AdminVO login(String adminId, String password) {
		return adminDAO.login(adminId, password);
	}

	@Override
	public void insertAdmin(AdminVO vo) {
		adminDAO.insertAdmin(vo);
	}

	@Override
	public int getAdmittedPatientCount() {
		return adminDAO.countAdmittedPatients();
	}

	@Override
	public int getUnreadNoticeCount() {
		return adminDAO.countUnreadNotices();
	}

	@Override
	public int getTotalReferralCount() {
		return adminDAO.countTotalReferrals();
	}

	@Override
	public int getRepliedReferralCount() {
		return adminDAO.countRepliedReferrals();
	}

	@Override
	public int countFeedbackByStatus(String status) {
		return adminDAO.countFeedbackByStatus(status);
	}

	@Override
	public List<FeedbackVO> getRecentFeedbacksByStatus(String status) {
		return adminDAO.getRecentFeedbacksByStatus(status);
	}

	@Override
	public List<ReservationVO> getReservationStatsLast7Days() {
		return adminDAO.getReservationStatsLast7Days();
	}

	@Override
	public void updateUserRole(String userId, String role) {
		adminDAO.updateUserRole(userId, role);
	}

	@Override
	public List<UserVO> getAllUsers() {
		return adminDAO.getAllUsers();
	}

	@Override
	public List<ReservationVO> getReservationSummaryByDateRange() {
		return adminDAO.getReservationSummaryByDateRange();
	}

	@Override
	public List<ReservationVO> getReservationsByDate(String date) {
		return adminDAO.getReservationsByDate(date);
	}

	@Override
	public List<BoardStatVO> getBoardPostStats() {
		return adminDAO.getBoardPostStats();
	}

	@Transactional
	@Override
	public boolean approveUser(String userId, String adminIdHash) {
		// 1) 대상 확인 (대기 상태만 승인)
		PendingUserVO pu = userDAO.selectPendingUserById(userId);
		if (pu == null || !"대기".equals(pu.getStatus()))
			return false;

		// 2) USERS로 이관
		int ins = adminDAO.insertUserFromPending(userId);
		if (ins == 0)
			return false;

		// 3) ROLE=doctor면 DOCTOR_INFO(또는 DOCTORS) 자동 등록
		if ("doctor".equalsIgnoreCase(pu.getRole())) {
			DoctorVO d = new DoctorVO();
			d.setDoctorId(pu.getUserId());
			d.setDeptId(pu.getDeptId());
			d.setSpecialty("");
			d.setBio("");
			d.setProfileImagePath("");
			userDAO.insertDoctorInfo(d);
		}

		// 4) PENDING_USERS 승인 마킹 (REVIEWED_BY: ADMINS.ADMIN_ID 해시값)
		Map<String, Object> p = new HashMap<>();
		p.put("userId", userId);
		p.put("adminId", adminIdHash);
		adminDAO.markPendingApproved(userId, adminIdHash);

		return true;
	}

	@Transactional
	@Override
	public int rejectUser(String userId, String reason, String adminIdHash) {
		Map<String, Object> p = new HashMap<>();
		p.put("userId", userId);
		p.put("reason", reason);
		p.put("adminId", adminIdHash);
		return adminDAO.rejectPendingUser(userId, reason, adminIdHash);
	}

	@Transactional
	@Override
	public int undoPendingStatus(String userId) {
		return adminDAO.undoPendingStatus(userId);
	}

}
