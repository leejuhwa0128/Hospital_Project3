package com.hospital.mapper;

import com.hospital.vo.PraiseVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PraiseMapper {
    List<PraiseVO> selectPraiseList();
    
    PraiseVO selectPraiseDetail(int praiseId);
    
    void updateViewCount(int praiseId);
    
    void insertPraise(PraiseVO praise);
    
    // 칭찬글 수정 메서드 추가
    void updatePraise(PraiseVO praise);

    // 칭찬글 삭제 메서드 추가
    void deletePraise(int praiseId);
    
    List<PraiseVO> searchPraisesByKeyword(String keyword);
    
    int countPraises();
    // 전체 게시글 개수
    int countPraise();

    // 페이징된 목록 조회
    List<PraiseVO> selectPraiseList(@Param("startRow") int startRow,
                                    @Param("endRow") int endRow);
    
}