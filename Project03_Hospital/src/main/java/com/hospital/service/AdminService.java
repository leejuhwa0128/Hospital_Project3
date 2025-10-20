package com.hospital.service;

import java.util.List;
import java.util.Map;

import com.hospital.vo.AdminVO;
import com.hospital.vo.BoardStatVO;
import com.hospital.vo.FeedbackVO;
import com.hospital.vo.ReservationVO;
import com.hospital.vo.UserVO;

public interface AdminService {
	AdminVO login(String encryptedId, String encryptedPwd);

	void insertAdmin(AdminVO vo);

	int getAdmittedPatientCount();

	int getUnreadNoticeCount();

	int getTotalReferralCount();

	int getRepliedReferralCount();

	int countFeedbackByStatus(String status);

	List<FeedbackVO> getRecentFeedbacksByStatus(String status);

	List<ReservationVO> getReservationStatsLast7Days();

	void updateUserRole(String userId, String role);

	List<UserVO> getAllUsers();

	List<ReservationVO> getReservationSummaryByDateRange();

	List<ReservationVO> getReservationsByDate(String date);

	boolean approveUser(String userId, String adminIdHash); // USERS 이관 + PENDING 마킹(트랜잭션)

	int rejectUser(String userId, String reason, String adminIdHash);

	int undoPendingStatus(String userId);
	
	List<BoardStatVO> getBoardPostStats();

}
