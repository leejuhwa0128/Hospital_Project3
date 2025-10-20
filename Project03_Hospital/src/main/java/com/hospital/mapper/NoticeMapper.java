package com.hospital.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hospital.vo.NoticeVO;


@Mapper
public interface NoticeMapper {
    void insertNotice(NoticeVO notice);
    List<NoticeVO> getAllNotices();
    NoticeVO getNoticeById(int id);
    void updateNotice(NoticeVO notice);
    void deleteNotice(int id);
    List<NoticeVO> selectLatest(@Param("limit") int limit);
    // 키워드를 포함하는 공지사항을 제목 또는 내용에서 검색
    List<NoticeVO> searchNoticesByKeyword(@Param("keyword") String keyword);
}
