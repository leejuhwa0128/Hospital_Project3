package com.hospital.service;

import java.util.List;
import com.hospital.vo.NoticeVO;

public interface NoticeService {
	void insertNotice(NoticeVO notice);

	List<NoticeVO> getAllNotices();

	NoticeVO getNoticeById(int id);

	void updateNotice(NoticeVO notice);

	void deleteNotice(int id);
	
	List<NoticeVO> getLatest(int limit);
	
	// 정적(static) 메소드를 일반 메소드로 변경
		List<NoticeVO> searchNoticesByKeyword(String keyword);
	
}
