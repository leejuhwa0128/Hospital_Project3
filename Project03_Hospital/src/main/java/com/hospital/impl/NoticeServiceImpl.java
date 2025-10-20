package com.hospital.impl;

import com.hospital.mapper.NoticeMapper;
import com.hospital.service.NoticeService;
import com.hospital.vo.NoticeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeMapper noticeMapper;

	@Override
	public void insertNotice(NoticeVO notice) {
		noticeMapper.insertNotice(notice);
	}

	@Override
	public List<NoticeVO> getAllNotices() {
		return noticeMapper.getAllNotices();
	}

	@Override
	public NoticeVO getNoticeById(int id) {
		return noticeMapper.getNoticeById(id);
	}

	@Override
	public void updateNotice(NoticeVO notice) {
		noticeMapper.updateNotice(notice);
	}

	@Override
	public void deleteNotice(int id) {
		noticeMapper.deleteNotice(id);
	}


    @Override
    public List<NoticeVO> getLatest(int limit) {
        return noticeMapper.selectLatest(limit);
    }

	// searchNoticesByKeyword 메소드 추가
    @Override
    public List<NoticeVO> searchNoticesByKeyword(String keyword) {
        return noticeMapper.searchNoticesByKeyword(keyword);
    }
}
