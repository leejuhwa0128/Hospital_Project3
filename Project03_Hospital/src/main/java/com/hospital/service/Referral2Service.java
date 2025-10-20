package com.hospital.service;

import java.util.List;

import com.hospital.vo.PartnerHospitalVO;
import com.hospital.vo.ReferralCommentVO;
import com.hospital.vo.ReferralReplyVO;
import com.hospital.vo.ReferralRequestVO;
import com.hospital.vo.UserVO;

public interface Referral2Service {
    ReferralRequestVO convertToReferralRequest(int recordId);
    List<PartnerHospitalVO> getAllPartnerHospitals();
    void insertReferralRequest(ReferralRequestVO requestVO);
    
    List<UserVO> getDoctorsByHospital(int hospitalId);
    
 // 우리 병원으로 들어온 협진 요청 조회
    //List<ReferralRequestVO> getReceivedReferrals(int hospitalId);
    List<ReferralRequestVO> getVisibleReferrals(int hospitalId, String userId);
    
    
    ReferralRequestVO getReferralRequestById(int requestId);
    ReferralReplyVO getReplyByRequestId(int requestId);
    List<ReferralCommentVO> getReferralCommentsByRequestId(int requestId);

    void addComment(ReferralCommentVO comment);

    void updateComment(ReferralCommentVO commentVO);
    
    void deleteComment(int commentId, String userId);
    
    boolean isReferralAlreadySent(int recordId);
    
  




}
