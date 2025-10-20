package com.hospital.dao;

import com.hospital.vo.CertificateVO;
import com.hospital.vo.MedicalRecordVO;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.Date;
import java.util.List;

@Mapper // 또는 @Repository
public interface CertificatesDAO {

    int insertCertificate(CertificateVO certificateVO);

    List<CertificateVO> selectCertificatesByPatientNo(int patientNo);

    // PatientVO, MedicalRecordVO까지 포함하여 상세 정보를 가져오는 메서드
    CertificateVO selectCertificateById(int certificateId);

    int updateCertificate(CertificateVO certificate); // 관리자용 증명서 업데이트 (상태, 발급자, 내용 등)

    List<CertificateVO> getCertificatesByStatus(String status);

    // viewedAt 필드를 업데이트하는 메서드
    int updateViewedAt(@Param("certificateId") int certificateId, @Param("viewedAt") Date viewedAt);

    MedicalRecordVO selectLatestMedicalRecordByPatientNo(int patientNo);

    void completeCertificate(CertificateVO certificateVO);

    MedicalRecordVO selectMedicalRecordById(Integer recordId);

    List<MedicalRecordVO> selectMedicalRecordsByPatientNo(int patientNo);

    int getCertificateHistoryCount(@Param("patientNo") int patientNo);

    List<CertificateVO> getCertificateHistoryByPage(@Param("patientNo") int patientNo, @Param("startIndex") int startIndex, @Param("pageSize") int pageSize);

    List<CertificateVO> getPendingCertificatesByDept(String deptId);

    List<CertificateVO> getAllDoctorCertificates();

    CertificateVO getCertificateById(int certificateId);

    void updateCertificateContent(CertificateVO certificateVO);

    void updateCertificateStatus(@Param("certificateId") int certificateId, @Param("status") String status);

    int getCertificateCount();

    List<CertificateVO> getAllDoctorCertificates(@Param("offset") int offset, @Param("limit") int limit);
    
    int getPendingCountByDept(@Param("deptId") String deptId);
    List<CertificateVO> getPendingCertificatesByDeptPaged(@Param("deptId") String deptId,
                                                          @Param("offset") int offset,
                                                          @Param("end") int end);



}
