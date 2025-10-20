package com.hospital.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.hospital.vo.PartnerHospitalVO;
import com.hospital.vo.ReferralNoticeVO;
import com.hospital.vo.ReferralRequestVO;
import com.hospital.vo.UserVO;

@Mapper
public interface ReferralDAO {

    // 협력병원 전체 조회
    List<PartnerHospitalVO> getAllPartnerHospitals();
    
    // 협진 전체 조회
    List<ReferralRequestVO> getAllReferrals();

    // 상태별 협진 조회 (예: 접수, 회신 완료 등)
    List<ReferralRequestVO> getReferralsByStatus(@Param("status") String status);

    // 특정 협진 상세 조회
    ReferralRequestVO getReferralById(@Param("requestId") int requestId);

    // 협진 상태 변경
    int updateReferralStatus(@Param("requestId") int requestId, @Param("status") String status);

    // 협진 등록
    int insertReferral(ReferralRequestVO vo);

    // 유저 기준 조회
    List<ReferralRequestVO> getReferralsByUserId(@Param("userId") String userId);

    // 정렬 기준 협진 조회
    List<ReferralRequestVO> getReferralsSorted(@Param("status") String status,
                                               @Param("sort") String sort,
                                               @Param("order") String order);

    // 키워드 기반 협진 조회
    List<ReferralRequestVO> getReferralsByKeyword(@Param("keyword") String keyword);
    
    void insertCoopUser(UserVO user);
    
    int countUserId(String userId);
    
    List<ReferralNoticeVO> selectLatestForAll(@Param("limit") int limit);
    
    List<PartnerHospitalVO> selectPartnerLocations();
}
