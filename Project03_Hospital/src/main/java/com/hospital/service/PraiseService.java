package com.hospital.service;

import com.hospital.mapper.PraiseMapper;
import com.hospital.vo.PraiseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PraiseService {

	@Autowired
	private PraiseMapper praiseMapper;

	public List<PraiseVO> getPraiseList() {
		return praiseMapper.selectPraiseList();
	}

	public PraiseVO getPraiseDetail(int praiseId) {
		// 조회수 증가
		praiseMapper.updateViewCount(praiseId);
		// 상세 내용 조회
		return praiseMapper.selectPraiseDetail(praiseId);
	}

	public void insertPraise(PraiseVO praise) {
		praiseMapper.insertPraise(praise);
	}

	public void updatePraise(PraiseVO praise) {
		praiseMapper.updatePraise(praise);
	}

	public void deletePraise(int praiseId) {
		praiseMapper.deletePraise(praiseId);
	}

	public List<PraiseVO> getAllPraises() {
		return praiseMapper.selectPraiseList(); // 이미 존재함 → 그대로 getAllPraises()에 연결
	}
	
	  // ⭐️ 이 메서드를 추가해야 합니다. 
    public List<PraiseVO> searchPraisesByKeyword(String searchKeyword) {
        return praiseMapper.searchPraisesByKeyword(searchKeyword);
    }
    
	 // ✅ 페이징용 전체 개수
    public int getPraiseCount() {
        return praiseMapper.countPraise();
    }

    // ✅ 페이징된 목록
    public List<PraiseVO> getPraiseList(int startRow, int endRow) {
        return praiseMapper.selectPraiseList(startRow, endRow);
    }


}