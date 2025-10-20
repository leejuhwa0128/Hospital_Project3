package com.hospital.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hospital.dao.ReferralDAO;
import com.hospital.dao.ReferralNoticeDAO;
import com.hospital.mapper.ReferralMapper;
import com.hospital.service.ReferralService;
import com.hospital.vo.PartnerHospitalVO;
import com.hospital.vo.ReferralCommentVO;
import com.hospital.vo.ReferralNoticeVO;
import com.hospital.vo.ReferralReplyVO;
import com.hospital.vo.ReferralRequestVO;
import com.hospital.vo.UserVO;

@Service
public class ReferralServiceImpl implements ReferralService {

    @Autowired
    private ReferralDAO referralDAO;
    
    @Autowired
    private ReferralNoticeDAO referralNoticeDAO;

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.hospital.dao.ReferralDAO";


    @Override
    public List<PartnerHospitalVO> getPartnerLocations() {
        return referralDAO.selectPartnerLocations();
    }
    
    @Override
    public List<ReferralNoticeVO> getNoticesForAll() {
        return sqlSession.selectList(NAMESPACE + ".selectNoticesForAll");
    }

    @Override
    public List<ReferralNoticeVO> getNoticesForUserRole(String role) {
        return sqlSession.selectList(NAMESPACE + ".selectNoticesForRole", role);
    }
    
    @Autowired
    private ReferralMapper referralMapper;

    @Override
    public List<UserVO> getAllCoopDoctors() {
        return referralMapper.getAllCoopDoctors();
    }
    
    @Override
    public List<ReferralRequestVO> getReferralRequestsByUser(String userId) {
        return referralMapper.getReferralRequestsByUser(userId);
    }
    @Override
    public ReferralRequestVO getReferralRequestById(int requestId) {
        return referralMapper.getReferralRequestById(requestId);
    }
    
    @Override
    public void insertReply(ReferralReplyVO reply) {
        referralMapper.insertReply(reply);
    }
    @Override
    public ReferralNoticeVO getNoticeById(int noticeId) {
        return referralNoticeDAO.selectNoticeById(noticeId);
    }
    @Override
    public void updateRequestStatus(int requestId, String status) {
        referralMapper.updateRequestStatus(requestId, status);
    }
    @Override
    public List<ReferralNoticeVO> getAllNotices() {
        return referralNoticeDAO.selectAllNotices();
    }
    
    @Override
    public ReferralReplyVO getReplyByRequestId(int requestId) {
        return referralMapper.getReplyByRequestId(requestId);
    }
    @Override
    public void addReferralComment(ReferralCommentVO comment) {
        referralMapper.insertReferralComment(comment);
    }

    @Override
    public List<ReferralCommentVO> getCommentsByRequestId(int requestId) {
        return referralMapper.getReferralCommentsByRequestId(requestId);
    }

    @Override
    public void insertComment(ReferralCommentVO comment) {
        referralMapper.insertReferralComment(comment);
    }

    @Override
    public boolean updateComment(ReferralCommentVO comment) {
        return referralMapper.updateReferralComment(comment) > 0;
    }

    @Override
    public boolean deleteComment(int commentId, String doctorId) {
        return referralMapper.deleteReferralComment(commentId, doctorId) > 0;
    }

    
    @Override
    public List<ReferralRequestVO> selectRequestsByHospitalId(int hospitalId) {
        return referralMapper.selectReferralRequestsByHospitalId(hospitalId);
    }
    //
	@Override
	public List<ReferralRequestVO> getAllReferrals() {
		return referralDAO.getAllReferrals();
	}

	@Override
	public List<ReferralRequestVO> getReferralsByStatus(String status) {
		return referralDAO.getReferralsByStatus(status);
	}

	@Override
	public ReferralRequestVO getReferralById(int requestId) {
		return referralDAO.getReferralById(requestId);
	}

	@Override
	public boolean updateReferralStatus(int requestId, String status) {
		return referralDAO.updateReferralStatus(requestId, status) > 0;
	}

	@Override
	public void insertReferral(ReferralRequestVO vo) {
		referralDAO.insertReferral(vo);
	}

	@Override
	public List<ReferralRequestVO> getReferralsByUserId(String userId) {
		return referralDAO.getReferralsByUserId(userId);
	}

	@Override
	public List<ReferralRequestVO> getReferralsSorted(String status, String sort, String order) {
		return referralDAO.getReferralsSorted(status, sort, order);
	}

	@Override
	public List<ReferralRequestVO> getReferralsByKeyword(String keyword) {
		return referralDAO.getReferralsByKeyword(keyword);
	}
	@Override
	public void updateNotice(ReferralNoticeVO notice) {
		referralNoticeDAO.updateNotice(notice);
	}
	@Override
	public void insertNotice(ReferralNoticeVO notice) {
		referralNoticeDAO.insertNotice(notice);
	}
    @Override
    public void registerCoopUser(UserVO user) {
        referralDAO.insertCoopUser(user);
    }
    @Override
    public List<PartnerHospitalVO> getAllPartnerHospitals() {
        return sqlSession.selectList(NAMESPACE + ".getAllPartnerHospitals"); // ✅ 정상 작동
    }
    
    @Override
    public boolean isUserIdTaken(String userId) {
        return referralDAO.countUserId(userId) > 0;
    }
    

    @Override
    public List<ReferralNoticeVO> getLatestForAll(int limit) {
        return referralMapper.selectLatestForAll(limit);
    }
    
    
    @Override
    public boolean deleteNotice(long noticeId, String userId) {
        // 관리자면 작성자 제한 없이, 일반사용자는 본인글만
        int affected = referralMapper.deleteByIdConditional(noticeId, userId);
        return affected > 0;
    }
    
}
