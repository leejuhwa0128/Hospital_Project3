package com.hospital.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.mapper.FeedbackMapper;
import com.hospital.service.FeedbackService;
import com.hospital.vo.FeedbackVO;

@Service
public class FeedbackServiceImpl implements FeedbackService {

    @Autowired
    private FeedbackMapper feedbackMapper;

    @Override
    public List<FeedbackVO> getFeedbackList(Map<String, Object> paramMap) {
        return feedbackMapper.getFeedbackList(paramMap);
    }

    @Override
    public int getTotalCount(Map<String, Object> paramMap) {
        return feedbackMapper.getTotalCount(paramMap);
    }


    @Override
    public FeedbackVO getFeedback(int feedbackId) {
        return feedbackMapper.getFeedback(feedbackId);
    }

    @Override
    public void insertFeedback(FeedbackVO vo) {
        feedbackMapper.insertFeedback(vo);
    }

    @Override
    public void updateFeedback(FeedbackVO vo) {
        feedbackMapper.updateFeedback(vo);
    }

    @Override
    public void deleteFeedback(int feedbackId) {
        feedbackMapper.deleteFeedback(feedbackId);
    }

    @Override
    public void replyFeedback(FeedbackVO vo) {
        feedbackMapper.replyFeedback(vo);
    }

    @Override
    public void clearReply(int feedbackId) {
        feedbackMapper.clearReply(feedbackId);
    }
    
    @Override
    public List<FeedbackVO> getAllFeedback() {
        return feedbackMapper.selectAllFeedback(); // Mapper에 selectAllFeedback() 있어야 함
    }

    
    @Override
    public List<FeedbackVO> getFeedbackByUser(String patientUserId) {
        return feedbackMapper.selectByUser(patientUserId);
    }

 // ✅ 고객의소리 통합 검색을 위한 메서드 추가
    @Override
    public List<FeedbackVO> searchFeedbacksByKeyword(String keyword) {
        return feedbackMapper.searchFeedbacksByKeyword(keyword);
    }
}
