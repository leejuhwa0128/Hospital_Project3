package com.hospital.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hospital.vo.PartnerHospitalVO;
import com.hospital.vo.ReferralCommentVO;
import com.hospital.vo.ReferralNoticeVO;
import com.hospital.vo.ReferralReplyVO;
import com.hospital.vo.ReferralRequestVO;
import com.hospital.vo.UserVO;

public interface ReferralService {
	List<PartnerHospitalVO> getAllPartnerHospitals();

	List<UserVO> getAllCoopDoctors();

	List<ReferralRequestVO> getReferralRequestsByUser(String userId);

	ReferralRequestVO getReferralRequestById(int requestId);

	void insertReply(ReferralReplyVO reply);

	// 요청 상태 업데이트 (완료 or 거절)
	void updateRequestStatus(int requestId, String status);

	ReferralReplyVO getReplyByRequestId(int requestId);

	List<ReferralNoticeVO> getAllNotices();

	ReferralNoticeVO getNoticeById(int noticeId);

	void updateNotice(ReferralNoticeVO notice);

	void insertNotice(ReferralNoticeVO notice);

	void addReferralComment(ReferralCommentVO comment);

	List<ReferralCommentVO> getCommentsByRequestId(int requestId);

	void insertComment(ReferralCommentVO comment);

	boolean updateComment(ReferralCommentVO comment);

	boolean deleteComment(int commentId, String doctorId);

	List<ReferralRequestVO> selectRequestsByHospitalId(int hospitalId);

	void registerCoopUser(UserVO user);

	List<ReferralRequestVO> getAllReferrals();

	List<ReferralRequestVO> getReferralsByStatus(String status);

	ReferralRequestVO getReferralById(int requestId);

	boolean updateReferralStatus(int requestId, String status);

	void insertReferral(ReferralRequestVO vo);

	List<ReferralRequestVO> getReferralsByUserId(String userId);

	List<ReferralRequestVO> getReferralsSorted(String status, String sort, String order);

	List<ReferralRequestVO> getReferralsByKeyword(String keyword);

	List<ReferralNoticeVO> getNoticesForAll();

	List<ReferralNoticeVO> getNoticesForUserRole(String role);
	
	boolean isUserIdTaken(String userId);

	 List<ReferralNoticeVO> getLatestForAll(int limit);
	 
	 boolean deleteNotice(long noticeId, String userId);
	 
	  List<PartnerHospitalVO> getPartnerLocations();
	  
	  
}
