// src/main/java/com/hospital/service/DonationService.java
package com.hospital.service;

import java.util.Date;
import java.util.List;
import com.hospital.vo.DonationVO;

public interface DonationService {
    String createOrderId();                 // yyyyMMddHHmmss + random
    int saveReady(DonationVO vo);           // 결제 준비 상태 저장
    int markPaid(DonationVO vo);            // 결제 성공 처리
    int markFailed(DonationVO vo);          // 결제 실패 처리
    DonationVO findByOrderId(String orderId); // 주문번호로 조회
    List<DonationVO> findAll();              // 전체 내역 조회
    List<DonationVO> getAllDonations();
    List<DonationVO> getDonationsByEmail(String email);
    List<DonationVO> getDonationsByPeriod(Date startDate, Date endDate);
    int countDonations();           // 전체 기부 건수 조회
    List<DonationVO> getDonationsByPage(int startRow, int endRow);  // 추가
    int sumDonations();  // ✅ 추가
    List<DonationVO> getDonationsByDonorName(String donorName, int startRow, int endRow);
    List<DonationVO> getDonationsByPeriod(String startDate, String endDate, int startRow, int endRow);
    List<DonationVO> getDonationsByFilter(String donorName, String startDate, String endDate, int startRow, int endRow); // 🔥 둘 다 필터


}