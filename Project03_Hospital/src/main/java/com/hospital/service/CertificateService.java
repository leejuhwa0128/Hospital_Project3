package com.hospital.service;

import com.hospital.vo.CertificateVO;
import com.hospital.vo.MedicalRecordVO;

import java.util.Date;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

// 서비스 인터페이스
public interface CertificateService {

    // RQ-603: 증명서 발급 신청
    CertificateVO requestCertificate(CertificateVO certificateVO);

    // RQ-605: 서류 발급 이력 조회
    List<CertificateVO> getCertificateHistory(int patientNo);

    // (추가) 증명서 상태 변경 (관리자 기능)
    // 현재 updateCertificateStatus는 CertificateVO 전체를 받아 업데이트하는 것이 더 유연합니다.
    // 기존의 updateCertificate(CertificateVO certificate)와 유사하게 통합하는 것이 좋습니다.
    // 여기서는 기존 메서드 시그니처를 유지하되, 구현체에서 CertificateVO를 받아 처리하도록 합니다.
    CertificateVO updateCertificateStatus(int certificateId, String status, String issuedBy);

    // (추가) 단일 증명서 조회
    CertificateVO getCertificateDetail(int certificateId); // 메서드명 변경 (더 명확하게)

    // (추가) 특정 상태의 증명서 목록 조회 (관리자용)
    List<CertificateVO> getCertificatesByStatus(String status);

    // (추가) PDF 생성 로직 (서비스 레이어에서 수행)
    byte[] generateCertificatePdf(int certificateId) throws Exception;

    // (추가) viewedAt 업데이트
    void updateViewedAt(int certificateId, Date viewedAt);
    
    // (추가) 증명서 단건 조회
    public CertificateVO getCertificateById(int certificateId);
    //의료진용
    public List<CertificateVO> getPendingCertificates();
    @Transactional
    public void completeCertificate(CertificateVO certificateVO);

 // CertificateService.java (서비스 인터페이스)
    public List<MedicalRecordVO> getMedicalRecordsByPatientNo(int patientNo);
    
    
    /**
     * 특정 환자의 전체 증명서 이력 개수를 조회합니다.
     * @param patientNo 환자 번호
     * @return 전체 증명서 개수
     */
    int getCertificateHistoryCount(int patientNo);

    /**
     * 특정 환자의 증명서 이력을 페이지에 맞게 조회합니다.
     * @param patientNo 환자 번호
     * @param startIndex 시작 인덱스
     * @param pageSize 페이지당 항목 수
     * @return 해당 페이지의 증명서 목록
     */
    List<CertificateVO> getCertificateHistoryByPage(int patientNo, int startIndex, int pageSize);
    
    
    List<CertificateVO> getPendingCertificatesByDept(String deptId); 
    
    public List<CertificateVO> getAllDoctorCertificates();
    
    // 서류 내용을 업데이트하고 상태를 변경하는 메소드
    void updateCertificate(CertificateVO certificateVO);


    public int getCertificateCount();
    public List<CertificateVO> getPaginatedCertificates(int offset, int limit);
    
    
    int getPendingCountByDept(String deptId);

    List<CertificateVO> getPendingCertificatesByDeptPaged(String deptId, int offset, int limit);

    

}
