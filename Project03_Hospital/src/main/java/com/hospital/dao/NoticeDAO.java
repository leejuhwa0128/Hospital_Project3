package com.hospital.dao;

import java.util.List;

import com.hospital.vo.NoticeVO;

public interface NoticeDAO {
	void insertNotice(NoticeVO notice);

	List<NoticeVO> getAllNotices();

	NoticeVO getNoticeById(int id);

	void updateNotice(NoticeVO notice);

	void deleteNotice(int id);
	
	List<NoticeVO> findByTitleContaining(String query);

}
