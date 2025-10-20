package com.hospital.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.mapper.Notice2Mapper;
import com.hospital.mapper.NoticeMapper;
import com.hospital.service.Notice2Service;
import com.hospital.service.NoticeService;
import com.hospital.vo.NoticeVO;

@Service
public class Notice2ServiceImpl implements Notice2Service {

    @Autowired
    private Notice2Mapper notice2Mapper;

    @Override
    public List<NoticeVO> getNoticesByRole(String role) {
        return notice2Mapper.getNoticesByRole(role);
    }

    @Override
    public NoticeVO getNoticeById(int noticeId) {
        return notice2Mapper.getNoticeById(noticeId);
    }
    
    @Override
    public List<NoticeVO> searchNoticesByRoleAndKeyword(String role, String searchType, String keyword) {
        return notice2Mapper.searchNoticesByRoleAndKeyword(role, searchType, keyword);
    }

}
