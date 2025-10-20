package com.hospital.impl;

import com.hospital.dao.CertificatesDAO;
import com.hospital.service.CertificateService;
import com.hospital.vo.CertificateVO;
import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.PatientVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.io.font.PdfEncodings;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.UnitValue;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.io.font.constants.StandardFonts;

@Service
public class CertificatesServiceImpl implements CertificateService {

    @Autowired
    private CertificatesDAO certificatesDAO;

    @Override
    @Transactional
    public CertificateVO requestCertificate(CertificateVO certificateVO) {
        certificateVO.setIssuedAt(new Date());
        certificateVO.setStatus("접수");

        if (certificateVO.getRequestMethod() == null || certificateVO.getRequestMethod().isEmpty()) {
            certificateVO.setRequestMethod("온라인");
        }
        if (certificateVO.getMethod() == null || certificateVO.getMethod().isEmpty()) {
            certificateVO.setMethod("방문");
        }
        
        // JSP 폼에서 전송된 recordId를 그대로 사용합니다.
        // 기존의 최신 진료 기록을 찾는 코드는 제거했습니다.
        if (certificateVO.getRecordId() == 0) {
            System.out.println("환자 번호 " + certificateVO.getPatientNo() + "에 대한 진료 기록이 선택되지 않았습니다.");
        }
        
        certificatesDAO.insertCertificate(certificateVO);
        return certificateVO;
    }

    @Override
    public List<CertificateVO> getCertificateHistory(int patientNo) {
        return certificatesDAO.selectCertificatesByPatientNo(patientNo);
    }

    @Override
    @Transactional
    public CertificateVO updateCertificateStatus(int certificateId, String status, String issuedBy) {
        CertificateVO existingCert = certificatesDAO.selectCertificateById(certificateId);
        if (existingCert == null) {
            throw new IllegalArgumentException("Certificate not found with ID: " + certificateId);
        }

        existingCert.setStatus(status);
        existingCert.setIssuedBy(issuedBy);
        if ("발급완료".equals(status)) {
            existingCert.setIssuedAt(new Date());
        }

        certificatesDAO.updateCertificate(existingCert);
        return existingCert;
    }

    @Override
    public CertificateVO getCertificateDetail(int certificateId) {
        System.out.println("getCertificateDetail 메서드 시작. ID: " + certificateId);

        CertificateVO certificate = certificatesDAO.selectCertificateById(certificateId);

        if (certificate != null && certificate.getRecordId() != 0) {
            // DAO를 호출하여 recordId에 해당하는 진료 기록을 가져옵니다.
            MedicalRecordVO medicalRecord = certificatesDAO.selectMedicalRecordById(certificate.getRecordId());
            certificate.setMedicalRecordVO(medicalRecord);
        } else if (certificate != null) {
            // 진료 기록이 없는 경우, PDF 생성을 위해 빈 MedicalRecordVO 객체를 설정합니다.
            MedicalRecordVO emptyRecord = new MedicalRecordVO();
            emptyRecord.setDiagnosis("정보 없음");
            emptyRecord.setTreatment("정보 없음");
            emptyRecord.setPrescription("정보 없음");
            emptyRecord.setDoctorName("정보 없음");
            certificate.setMedicalRecordVO(emptyRecord);
            System.out.println("진료 기록이 없어 빈 MedicalRecordVO 객체를 생성하여 설정했습니다.");
        }

        System.out.println("getCertificateDetail 메서드 종료.");
        return certificate;
    }
    
    @Override
    public List<CertificateVO> getCertificatesByStatus(String status) {
        return certificatesDAO.getCertificatesByStatus(status);
    }

    @Override
    public byte[] generateCertificatePdf(int certificateId) throws Exception {
        System.out.println("PDF 생성 시작: certificateId = " + certificateId);
        
        // getCertificateDetail 메서드를 호출하여 MedicalRecordVO를 포함한 완전한 객체를 가져옵니다.
        CertificateVO certificate = getCertificateDetail(certificateId);
        
        if (certificate == null) {
            System.out.println("Certificate not found for ID: " + certificateId);
            throw new IllegalArgumentException("Certificate not found with ID: " + certificateId);
        }

        if (!"발급완료".equals(certificate.getStatus())) {
            System.out.println("Certificate status is not '발급완료': " + certificate.getStatus());
            throw new IllegalStateException("해당 증명서는 아직 발급 완료 상태가 아닙니다.");
        }

        System.out.println("PDF 스트림 및 문서 객체 초기화 중...");
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf);
        System.out.println("PDF 스트림 및 문서 객체 초기화 완료.");

        String fontPath = "c:/Windows/Fonts/malgunbd.ttf";
        PdfFont font = null;
        PdfFont boldFont = null;

        System.out.println("폰트 로드 시도 중: " + fontPath);
        try {
        	font = PdfFontFactory.createFont(fontPath, PdfEncodings.IDENTITY_H, true);
        	boldFont = PdfFontFactory.createFont(fontPath, PdfEncodings.IDENTITY_H, true);

            System.out.println("폰트 로드 성공.");
        } catch (IOException e) {
            System.err.println("한글 폰트를 로드할 수 없습니다. " + fontPath + " 경로를 확인하거나 다른 폰트로 변경하세요.");
            e.printStackTrace();
            font = PdfFontFactory.createFont(StandardFonts.HELVETICA);
            boldFont = PdfFontFactory.createFont(StandardFonts.HELVETICA_BOLD);
            System.out.println("폰트 로드 실패, 기본 폰트 사용.");
        }
        document.setFont(font);
        System.out.println("문서 기본 폰트 설정 완료.");

        System.out.println("PDF 내용 작성 시작...");
        document.add(new Paragraph(certificate.getType() + " (제 " + certificate.getCertificateId() + " 호)")
                .setFontSize(24)
                .setTextAlignment(TextAlignment.CENTER)
                .setFont(boldFont));
        document.add(new Paragraph("\n"));

        document.add(new Paragraph("■ 환자 정보").setFontSize(14).setFont(boldFont));
        Table patientTable = new Table(UnitValue.createPercentArray(new float[]{1, 3}));
        patientTable.setWidth(UnitValue.createPercentValue(100));
        patientTable.addCell(new Paragraph("환자명").setFont(boldFont));
        patientTable.addCell(new Paragraph(certificate.getPatientVO() != null ? certificate.getPatientVO().getPatientName() : "정보 없음").setFont(font));
        patientTable.addCell(new Paragraph("생년월일").setFont(boldFont));
        patientTable.addCell(new Paragraph(
                        (certificate.getPatientVO() != null && certificate.getPatientVO().getPatientRrn() != null && certificate.getPatientVO().getPatientRrn().length() >= 6) ?
                                certificate.getPatientVO().getPatientRrn().substring(0, 6) : "정보 없음"
                ).setFont(font));
        patientTable.addCell(new Paragraph("성별").setFont(boldFont));
        patientTable.addCell(new Paragraph(certificate.getPatientVO() != null ? certificate.getPatientVO().getPatientGender() : "정보 없음").setFont(font));
        patientTable.addCell(new Paragraph("연락처").setFont(boldFont));
        patientTable.addCell(new Paragraph(certificate.getPatientVO() != null ? certificate.getPatientVO().getPatientPhone() : "정보 없음").setFont(font));
        document.add(patientTable);
        document.add(new Paragraph("\n"));
        System.out.println("환자 정보 섹션 추가 완료.");

        if (certificate.getMedicalRecordVO() != null) {
            System.out.println("진료 정보 섹션 추가 시도 중...");
            MedicalRecordVO mr = certificate.getMedicalRecordVO();
            document.add(new Paragraph("■ 진료 정보").setFontSize(14).setFont(boldFont));
            Table medicalTable = new Table(UnitValue.createPercentArray(new float[]{1, 3}));
            medicalTable.setWidth(UnitValue.createPercentValue(100));
            medicalTable.addCell(new Paragraph("담당의").setFont(boldFont));
            medicalTable.addCell(new Paragraph(mr.getDoctorName() != null ? mr.getDoctorName()  : "정보 없음").setFont(font));
            medicalTable.addCell(new Paragraph("진료일").setFont(boldFont));
            medicalTable.addCell(new Paragraph(mr.getRecordDate() != null ? new SimpleDateFormat("yyyy년 MM월 dd일").format(mr.getRecordDate()) : "정보 없음").setFont(font));
            medicalTable.addCell(new Paragraph("진단명").setFont(boldFont));
            medicalTable.addCell(new Paragraph(mr.getDiagnosis() != null ? mr.getDiagnosis() : "정보 없음").setFont(font));
            medicalTable.addCell(new Paragraph("치료 내용").setFont(boldFont));
            medicalTable.addCell(new Paragraph(mr.getTreatment() != null ? mr.getTreatment() : "정보 없음").setFont(font));
            medicalTable.addCell(new Paragraph("처방 내용").setFont(boldFont));
            medicalTable.addCell(new Paragraph(mr.getPrescription() != null ? mr.getPrescription() : "정보 없음").setFont(font));
            document.add(medicalTable);
            document.add(new Paragraph("\n"));
            System.out.println("진료 정보 섹션 추가 완료.");
        } else {
            System.out.println("medicalRecordVO가 null이므로 진료 정보 섹션 추가 건너뜀.");
        }
        
        String contentTitle = "■ 증명 내용";
        String contentText = certificate.getContent() != null ? certificate.getContent() : "내용 없음";
        
        if ("소견서".equals(certificate.getType())) {
            contentTitle = "■ 치료소견";
            if (certificate.getContent() != null && !certificate.getContent().isEmpty()) {
                contentText = certificate.getContent();  // ✅ 이게 실제 소견 내용
            } else {
                contentText = "내용 없음";
            }
        }
        
        document.add(new Paragraph(contentTitle).setFontSize(14).setFont(boldFont));
        document.add(new Paragraph(contentText).setFont(font).setMarginBottom(30));
        System.out.println(contentTitle + " 섹션 추가 완료.");

        document.add(new Paragraph(certificate.getIssuedAt() != null ? new SimpleDateFormat("yyyy년 MM월 dd일").format(certificate.getIssuedAt()) : "발급일 정보 없음")
                .setTextAlignment(TextAlignment.RIGHT).setFont(font).setFontSize(12));
        document.add(new Paragraph("MEDIPRIME 병원").setTextAlignment(TextAlignment.RIGHT).setFont(boldFont).setFontSize(18));
        document.add(new Paragraph("(발급자: " + (certificate.getIssuedBy() != null ? certificate.getIssuedBy() : "정보 없음") + ")").setTextAlignment(TextAlignment.RIGHT).setFont(font).setFontSize(10));
        System.out.println("발급일 및 병원 정보 섹션 추가 완료.");

        document.close();
        System.out.println("PDF 문서 닫기 완료.");
        return baos.toByteArray();
    }

    @Override
    @Transactional
    public void updateViewedAt(int certificateId, Date viewedAt) {
        System.out.println("updateViewedAt 메서드 시작: certificateId = " + certificateId + ", viewedAt = " + viewedAt);
        certificatesDAO.updateViewedAt(certificateId, viewedAt);
        System.out.println("updateViewedAt 메서드 완료.");
    }
    
    @Override
    public CertificateVO getCertificateById(int certificateId) {
        return certificatesDAO.selectCertificateById(certificateId);
    }

    @Override
    public List<CertificateVO> getPendingCertificates() {
        return certificatesDAO.getCertificatesByStatus("접수");
    }

    @Override
    @Transactional
    public void completeCertificate(CertificateVO certificateVO) {
        System.out.println("completeCertificate 메서드 시작. 증명서 ID: " + certificateVO.getCertificateId());
        
        certificateVO.setStatus("발급완료");
        certificateVO.setIssuedAt(new Date());
        
        try {
            System.out.println("DAO를 통해 증명서 발급 완료 처리 시도...");
            certificatesDAO.completeCertificate(certificateVO);
            System.out.println("DAO 호출 성공.");
        } catch (Exception e) {
            System.err.println("!!!!!!!!!!!!!!!!!! DAO 호출 중 치명적인 오류 발생 !!!!!!!!!!!!!!!!!!!");
            System.err.println("오류 메시지: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("증명서 발급 완료 DB 저장 실패", e);
        }
        
        System.out.println("증명서 발급 완료 처리 성공. 메서드 종료.");
    }
    // CertificateService 인터페이스에 추가한 메서드를 여기에 구현합니다.
    @Override
    public List<MedicalRecordVO> getMedicalRecordsByPatientNo(int patientNo) {
        // 변경된 DAO 메서드 이름으로 호출합니다.
        return certificatesDAO.selectMedicalRecordsByPatientNo(patientNo);
    }
    
    @Override
    public int getCertificateHistoryCount(int patientNo) {
        // DAO 객체를 통해 메서드 호출
        return certificatesDAO.getCertificateHistoryCount(patientNo);
    }

    @Override
    public List<CertificateVO> getCertificateHistoryByPage(int patientNo, int startIndex, int pageSize) {
        // DAO 객체를 통해 메서드 호출
        return certificatesDAO.getCertificateHistoryByPage(patientNo, startIndex, pageSize);
    }
    
    @Override
    public List<CertificateVO> getPendingCertificatesByDept(String deptId) {
        return certificatesDAO.getPendingCertificatesByDept(deptId);
    }
    @Override
    public List<CertificateVO> getAllDoctorCertificates() {
        // ★★★ 여기의 변수명을 위에서 선언한 변수명(certificatesDAO)과 동일하게 맞춰주세요.
        return certificatesDAO.getAllDoctorCertificates();
    }
    
    // 서류 내용 업데이트 및 상태 변경
    @Override
    public void updateCertificate(CertificateVO certificateVO) {
        // 1. 서류 내용을 업데이트합니다.
        certificatesDAO.updateCertificateContent(certificateVO);
        
        // 2. 서류 상태를 '발급완료'로 변경합니다.
        certificatesDAO.updateCertificateStatus(certificateVO.getCertificateId(), "발급완료");
    }
    
    @Override
    public int getCertificateCount() {
        return certificatesDAO.getCertificateCount();
    }

    @Override
    public List<CertificateVO> getPaginatedCertificates(int offset, int limit) {
        return certificatesDAO.getAllDoctorCertificates(offset, limit);
    }
    
    
    @Override
    public int getPendingCountByDept(String deptId) {
        return certificatesDAO.getPendingCountByDept(deptId);
    }

    @Override
    public List<CertificateVO> getPendingCertificatesByDeptPaged(String deptId, int offset, int end) {
        return certificatesDAO.getPendingCertificatesByDeptPaged(deptId, offset, end);
    }

}
    
    
