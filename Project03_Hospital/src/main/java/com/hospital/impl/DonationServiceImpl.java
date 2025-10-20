
package com.hospital.impl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.mapper.DonationMapper;
import com.hospital.service.DonationService;
import com.hospital.vo.DonationVO;

@Service
public class DonationServiceImpl implements DonationService {

    @Autowired
    private DonationMapper mapper;

    /** 주문번호 생성 (yyyyMMddHHmmss + 랜덤 6자리) */
    @Override
    public String createOrderId() {
        String ts = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        int rnd = ThreadLocalRandom.current().nextInt(100000, 999999);
        return "DON_" + ts + "_" + rnd;
    }

    /** 결제 준비 상태 저장 */
    @Override
    public int saveReady(DonationVO vo) {
        return mapper.insertReady(vo);
    }

    /** 결제 성공 처리 */
    @Override
    public int markPaid(DonationVO vo) {
        int inserted = mapper.insertDonation(vo);
        int updated  = mapper.updatePaid(vo.getOrderId());
        return inserted + updated;
    }

    /** 결제 실패 처리 */
    @Override
    public int markFailed(DonationVO vo) {
        return mapper.updateFailed(vo.getOrderId());
    }

    /** 주문번호로 단건 조회 */
    @Override
    public DonationVO findByOrderId(String orderId) {
        return mapper.findByOrderId(orderId);
    }

    /** 전체 내역 조회 (관리자) */
    @Override
    public List<DonationVO> getAllDonations() {
        return mapper.selectAllDonations();
    }

    /** 이메일별 내역 조회 (사용자) */
    @Override
    public List<DonationVO> getDonationsByEmail(String email) {
        return mapper.getDonationsByEmail(email);
    }

    /** 기간별 내역 조회 (사용자) */
    @Override
    public List<DonationVO> getDonationsByPeriod(Date startDate, Date endDate) {
        return mapper.getDonationsByPeriod(startDate, endDate);
    }

    /** 전체 건수 (관리자 페이징용) */
    @Override
    public int countDonations() {
        return mapper.countDonations();
    }

    /** 페이징 처리된 목록 (관리자) */
    @Override
    public List<DonationVO> getDonationsByPage(int startRow, int endRow) {
        return mapper.getDonationsByPage(startRow, endRow);
    }
    
    @Override
    public List<DonationVO> findAll() {
        return mapper.findAll(); // DonationMapper.xml 에 <select id="findAll"> 필요
    }
    
    @Override
    public int sumDonations() {
        return mapper.sumDonations();
    }
    @Autowired
    private DonationMapper donationMapper;  // ✅ 객체 주입

    @Override
    public List<DonationVO> getDonationsByDonorName(String donorName, int startRow, int endRow) {
        return donationMapper.getDonationsByDonorName(donorName, startRow, endRow); // ✅ 인스턴스 통해 호출
    }
    
    @Override
    public List<DonationVO> getDonationsByFilter(String donorName, String startDate, String endDate, int startRow, int endRow) {
        return donationMapper.getDonationsByFilter(donorName, startDate, endDate, startRow, endRow);
    }

    @Override
    public List<DonationVO> getDonationsByPeriod(String startDate, String endDate, int startRow, int endRow) {
        return donationMapper.getDonationsByPeriod(startDate, endDate, startRow, endRow);
    }
    
}

