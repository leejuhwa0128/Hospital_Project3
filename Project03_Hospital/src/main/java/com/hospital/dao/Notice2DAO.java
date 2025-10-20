package com.hospital.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;

import com.hospital.vo.NoticeVO;

@Mapper
public interface Notice2DAO {

    @Select("SELECT * FROM MEDICAL_NOTICES ORDER BY CREATED_AT DESC")
    List<NoticeVO> getAllNotices();

    @Select("SELECT * FROM MEDICAL_NOTICES WHERE NOTICE_ID = #{noticeId}")
    NoticeVO getNoticeById(@Param("noticeId") int noticeId);
}
