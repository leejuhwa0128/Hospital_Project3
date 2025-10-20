package com.hospital.service;

import java.util.List;
import java.util.Map;
import com.hospital.vo.FaqVO;

public interface FaqService {
    List<FaqVO> getAllFaq();
    List<FaqVO> getFaqByCategory(String category);
    List<FaqVO> searchFaq(String keyword);
    void insertFaq(FaqVO faq);
    FaqVO getFaqById(int faqId);
    void updateFaq(FaqVO faq);
    void deleteFaq(int faqId);  // ✅ 추가!

    
    // ✅ 페이징용 추가
    int getFaqCount(Map<String, Object> param);
    List<FaqVO> getFaqList(Map<String, Object> param);
 
    // ✅ 수정: 인터페이스에는 메서드 선언만 합니다.
    List<FaqVO> searchFaqsByKeyword(String searchKeyword);
}