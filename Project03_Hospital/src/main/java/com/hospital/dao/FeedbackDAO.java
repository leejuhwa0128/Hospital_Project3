package com.hospital.dao;

import java.util.List;
import java.util.Map;
import com.hospital.vo.FeedbackVO;

public interface FeedbackDAO {
    List<FeedbackVO> getFeedbackListByCategory(Map<String, Object> paramMap);
    int getTotalCount(String category);
    FeedbackVO getFeedbackById(int feedbackId);
    void insertFeedback(FeedbackVO vo);
    void updateFeedback(FeedbackVO vo);
    void deleteFeedback(int feedbackId);
    void replyFeedback(FeedbackVO vo);  // ✅ 여기만 바꾸면 됨
    void clearReply(int feedbackId);
}
