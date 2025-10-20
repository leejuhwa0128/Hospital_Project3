package com.hospital.dao;

import com.hospital.vo.FaqVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FaqDAO {

    @Autowired
    private SqlSession sqlSession;

    // FaqMapper의 'searchFaq' 쿼리를 호출하는 메서드입니다.
    public List<FaqVO> searchFaq(String searchKeyword) {
        return sqlSession.selectList("FaqMapper.searchFaq", searchKeyword);
    }
}