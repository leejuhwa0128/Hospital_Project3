package com.hospital.service;

import java.util.List;

import com.hospital.vo.NoticeVO;

public interface Notice2Service {
	List<NoticeVO> getNoticesByRole(String role);
	List<NoticeVO> searchNoticesByRoleAndKeyword(String role, String searchType, String keyword);

    NoticeVO getNoticeById(int noticeId);
}