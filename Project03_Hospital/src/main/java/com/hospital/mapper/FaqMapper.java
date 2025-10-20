package com.hospital.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.hospital.vo.FaqVO;

@Mapper
public interface FaqMapper {
    List<FaqVO> getAllFaq();
    List<FaqVO> getFaqByCategory(String category);
    List<FaqVO> searchFaq(String keyword);
    void insertFaq(FaqVO faq);
    FaqVO getFaqById(int faqId);
    void updateFaq(FaqVO faq);
    void deleteFaq(int faqId);


    // ✅ 페이징용 추가
    int getFaqCount(Map<String, Object> param);
    List<FaqVO> getFaqList(Map<String, Object> param);
}