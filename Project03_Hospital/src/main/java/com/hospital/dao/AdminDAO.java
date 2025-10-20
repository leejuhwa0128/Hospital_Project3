package com.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.hospital.vo.AdminVO;
import com.hospital.vo.BoardStatVO;
import com.hospital.vo.FeedbackVO;
import com.hospital.vo.MedicalNoticeVO;
import com.hospital.vo.ReservationVO;
import com.hospital.vo.UserVO;

@Mapper
public interface AdminDAO {
	AdminVO login(@Param("adminId") String adminId, @Param("password") String password);

	void insertAdmin(AdminVO vo);

	int countAdmittedPatients();

	int countUnreadNotices();

	int countTotalReferrals();

	int countRepliedReferrals();

	int countFeedbackByStatus(String status);

	List<FeedbackVO> getRecentFeedbacksByStatus(String status);

	List<ReservationVO> getReservationStatsLast7Days();

	void updateUserRole(@Param("userId") String userId, @Param("role") String role);

	List<UserVO> getAllUsers();

	List<ReservationVO> getReservationSummaryByDateRange();

	List<ReservationVO> getReservationsByDate(@Param("date") String date);
	
	// 승인: USERS로 이관 (INSERT ... SELECT FROM PENDING_USERS WHERE STATUS='대기')
    int insertUserFromPending(@Param("userId") String userId);

    // 승인 마킹: STATUS='승인', REVIEWED_BY=adminIdHash, REVIEWED_AT=SYSDATE
    int markPendingApproved(@Param("userId") String userId,
                            @Param("adminId") String adminIdHash);

    // 반려: STATUS='반려', REVIEWED_BY/AT, REJECT_REASON
    int rejectPendingUser(@Param("userId") String userId,
                          @Param("reason") String reason,
                          @Param("adminId") String adminIdHash);

    // 되돌리기(반려→대기): REVIEWED_* NULL, REJECT_REASON NULL
    int undoPendingStatus(@Param("userId") String userId);
    
    List<BoardStatVO> getBoardPostStats();

}
