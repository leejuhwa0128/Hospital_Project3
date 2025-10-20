package com.hospital.mapper;

import java.util.List;
import java.util.Map;
import com.hospital.vo.FeedbackVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FeedbackMapper {

    List<FeedbackVO> getFeedbackList(Map<String, Object> paramMap);
    int getTotalCount(Map<String, Object> paramMap);

    FeedbackVO getFeedback(int feedbackId);
    void insertFeedback(FeedbackVO vo);
    void updateFeedback(FeedbackVO vo);
    void deleteFeedback(int feedbackId);
    void replyFeedback(FeedbackVO vo);
    void clearReply(int feedbackId);
    
    List<FeedbackVO> selectAllFeedback();
    
    List<FeedbackVO> selectByUser(String patientUserId);

    public List<FeedbackVO> searchFeedbacksByKeyword(String keyword);

}
