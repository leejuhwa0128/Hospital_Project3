package com.hospital.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.hospital.vo.ReferralNoticeVO;

@Mapper
public interface ReferralNoticeDAO {
    List<ReferralNoticeVO> selectAllNotices();
    ReferralNoticeVO selectNoticeById(int noticeId);
    void insertNotice(ReferralNoticeVO notice);
    void updateNotice(ReferralNoticeVO notice);
    void deleteNotice(int noticeId); // ❗이건 아직 XML에 없음
}
