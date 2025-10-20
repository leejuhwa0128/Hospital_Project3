package com.hospital.impl;

import com.hospital.dao.Referral2DAO;
import com.hospital.dao.ReferralDAO;
import com.hospital.service.Referral2Service;
import com.hospital.service.ReferralService;
import com.hospital.vo.PartnerHospitalVO;
import com.hospital.vo.ReferralRequestVO;
import com.hospital.vo.UserVO;
import com.hospital.vo.ReferralReplyVO;
import com.hospital.vo.ReferralCommentVO;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Referral2ServiceImpl implements Referral2Service {

    @Autowired
    private Referral2DAO referral2DAO;

    @Override
    public ReferralRequestVO convertToReferralRequest(int recordId) {
        return referral2DAO.convertToReferralRequest(recordId);
    }

    @Override
    public List<PartnerHospitalVO> getAllPartnerHospitals() {
        return referral2DAO.getAllPartnerHospitals();
    }

    @Override
    public void insertReferralRequest(ReferralRequestVO requestVO) {
        referral2DAO.insertReferralRequest(requestVO);
    }
    
    @Override
    public List<UserVO> getDoctorsByHospital(int hospitalId) {
        return referral2DAO.getDoctorsByHospital(hospitalId);
    }
    
    @Override
    public List<ReferralRequestVO> getVisibleReferrals(int hospitalId, String userId) {
        return referral2DAO.getVisibleReferrals(hospitalId, userId);
    }
    
    @Override
    public ReferralRequestVO getReferralRequestById(int requestId) {
        return referral2DAO.getReferralRequestById(requestId);
    }

    @Override
    public ReferralReplyVO getReplyByRequestId(int requestId) {
        ReferralReplyVO reply = referral2DAO.getReplyByRequestId(requestId);  // ✅ 먼저 가져오기

        if (reply != null && reply.getReplyContent() != null) {
            String clean = reply.getReplyContent().replaceAll("<[^>]*>", "");
            reply.setCleanReplyContent(clean);
        }

        return reply;  // ✅ 가공된 객체 반환
    }


    @Override
    public List<ReferralCommentVO> getReferralCommentsByRequestId(int requestId) {
        return referral2DAO.getReferralCommentsByRequestId(requestId);
        
    }


    @Override
    public void addComment(ReferralCommentVO comment) {
        int nextId = referral2DAO.getNextCommentId();
        comment.setCommentId(nextId);
        referral2DAO.addComment(comment);
    }

    @Override
    public void updateComment(ReferralCommentVO commentVO) {
        referral2DAO.updateComment(commentVO);
    }
    
    @Override
    public void deleteComment(int commentId, String userId) {
        referral2DAO.deleteComment(commentId, userId);
    }
    
    @Override
    public boolean isReferralAlreadySent(int recordId) {
        return referral2DAO.countReferralByRecordId(recordId) > 0;
    }
   


}

