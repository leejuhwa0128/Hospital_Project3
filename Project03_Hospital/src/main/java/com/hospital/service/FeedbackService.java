package com.hospital.service;

import java.util.List;
import java.util.Map;
import com.hospital.vo.FeedbackVO;

public interface FeedbackService {
    List<FeedbackVO> getFeedbackList(Map<String, Object> paramMap);
    int getTotalCount(Map<String, Object> paramMap);

    FeedbackVO getFeedback(int feedbackId);
    void insertFeedback(FeedbackVO vo);
    void updateFeedback(FeedbackVO vo);
    void deleteFeedback(int feedbackId);
    void replyFeedback(FeedbackVO vo);
    void clearReply(int feedbackId);
    
    List<FeedbackVO> getAllFeedback();

    List<FeedbackVO> getFeedbackByUser(String patientUserId);
   
    List<FeedbackVO> searchFeedbacksByKeyword(String keyword);
    
}
