// src/main/java/com/hospital/mapper/DonationMapper.java
package com.hospital.mapper;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hospital.vo.DonationVO;

@Mapper
public interface DonationMapper {

    // 결제 준비
    int insertReady(DonationVO vo);

    // 결제 성공 → 내역 저장
    int insertDonation(DonationVO vo);

    // 결제 성공 → 상태 업데이트
    int updatePaid(String orderId);

    // 결제 실패 → 상태 업데이트
    int updateFailed(String orderId);

    // 주문번호로 단건 조회
    DonationVO findByOrderId(String orderId);

    // 전체 내역 조회
    List<DonationVO> findAll();

    // 기부 내역 전체 조회 (간략 필드)
    List<DonationVO> selectAllDonations();
    
    List<DonationVO> getDonationsByEmail(String email);


    List<DonationVO> getDonationsByPeriod(@Param("startDate") Date startDate,
                                          @Param("endDate") Date endDate);
    
    int countDonations();   // 전체 건수
    List<DonationVO> getDonationsByPage(@Param("startRow") int startRow,
            @Param("endRow") int endRow); // 추가
    
    int sumDonations();
 // ✅ 후원자명 검색
    List<DonationVO> getDonationsByDonorName(@Param("donorName") String donorName,
                                             @Param("startRow") int startRow,
                                             @Param("endRow") int endRow);

    
    List<DonationVO> getDonationsByFilter(@Param("donorName") String donorName,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate,
            @Param("startRow") int startRow,
            @Param("endRow") int endRow);
    
 // DonationMapper.java
    List<DonationVO> selectDonationsByDate(@Param("startDate") String startDate,
                                           @Param("endDate") String endDate);

	List<DonationVO> getDonationsByPeriod(String startDate, String endDate, int startRow, int endRow);
}
    


