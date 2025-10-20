package com.hospital.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.mapper.FaqMapper;
import com.hospital.service.FaqService;
import com.hospital.vo.FaqVO;

@Service
public class FaqServiceImpl implements FaqService {

    @Autowired
    private FaqMapper faqMapper;

    @Override
    public List<FaqVO> getAllFaq() {
        return faqMapper.getAllFaq();
    }

    @Override
    public List<FaqVO> getFaqByCategory(String category) {
        return faqMapper.getFaqByCategory(category);
    }

    @Override
    public List<FaqVO> searchFaq(String keyword) {
        return faqMapper.searchFaq(keyword);
    }

    @Override
    public void insertFaq(FaqVO faq) {
        faqMapper.insertFaq(faq);
    }

    @Override
    public FaqVO getFaqById(int faqId) {
        return faqMapper.getFaqById(faqId);
    }

    @Override
    public void updateFaq(FaqVO faq) {
        faqMapper.updateFaq(faq);
    }
    
    @Override
    public int getFaqCount(Map<String, Object> param) {
        return faqMapper.getFaqCount(param);
    }

    @Override
    public List<FaqVO> getFaqList(Map<String, Object> param) {
        return faqMapper.getFaqList(param);
    }
    
    @Override
    public void deleteFaq(int faqId) {
        faqMapper.deleteFaq(faqId);  // Mapper 호출
    }
    
    // ✅ 수정: autowired된 faqMapper를 사용하여 searchFaq 메서드를 호출합니다.
    @Override
    public List<FaqVO> searchFaqsByKeyword(String searchKeyword) {
        return faqMapper.searchFaq(searchKeyword);
    }

}
