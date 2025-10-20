package com.hospital.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hospital.vo.PartnerHospitalVO;
import com.hospital.vo.ReferralCommentVO;
import com.hospital.vo.ReferralReplyVO;
import com.hospital.vo.ReferralRequestVO;
import com.hospital.vo.UserVO;



public interface Referral2DAO {
    
    // ✅ 진료기록 기반 협진요청 VO 생성용
    ReferralRequestVO convertToReferralRequest(int recordId);

    // ✅ 협진 병원 전체 조회
    List<PartnerHospitalVO> getAllPartnerHospitals();

    // ✅ 협진 요청 저장
    void insertReferralRequest(ReferralRequestVO requestVO);

    // ✅ 특정 병원 소속 의사(coop) 리스트 반환
    List<UserVO> getDoctorsByHospital(int hospitalId);
    
    List<ReferralRequestVO> getVisibleReferrals(@Param("hospitalId") int hospitalId, @Param("userId") String userId);
    
    ReferralRequestVO getReferralRequestById(int requestId);

    ReferralReplyVO getReplyByRequestId(int requestId);

    List<ReferralCommentVO> getReferralCommentsByRequestId(int requestId);

    
    void addComment(ReferralCommentVO comment);
    
    int getNextCommentId();
    
    void updateComment(ReferralCommentVO commentVO);

    void deleteComment(@Param("commentId") int commentId, @Param("userId") String userId);
    
    int countReferralByRecordId(int recordId);
    
    int isReferralAlreadySent(int recordId);




}
