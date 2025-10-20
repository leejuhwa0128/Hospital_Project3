package com.hospital.controller;

import com.hospital.service.CertificateService;
import com.hospital.service.PatientService;
import com.hospital.vo.CertificateVO;
import com.hospital.vo.MedicalRecordVO;
import com.hospital.vo.PagingVO;
import com.hospital.vo.PatientVO;
import com.hospital.vo.UserVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/certificates")
public class CertificateController {

    @Autowired
    private CertificateService certificatesService;

    @Autowired
    private PatientService patientService;

    // 헬퍼 메서드: URL 인코딩 (리다이렉트 시 한글 깨짐 방지)
    private String encodeUrl(String url) {
        try {
            return URLEncoder.encode(url, StandardCharsets.UTF_8.toString()).replaceAll("\\+", "%20");
        } catch (Exception e) {
            return url;
        }
    }

    @GetMapping("/request.do")
    public String showRequestForm(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
    	String loggedInUserId = (String) session.getAttribute("loggedInUserId");
    	String loggedInRole  = (String) session.getAttribute("loggedInRole");
    	if (loggedInUserId == null || loggedInRole == null) {
    	    Object u = session.getAttribute("loginUser");
    	    if (u instanceof PatientVO) {
    	        loggedInUserId = ((PatientVO) u).getPatientUserId();
    	        loggedInRole = "patient";
    	    } else if (u instanceof UserVO) {
    	        loggedInUserId = ((UserVO) u).getUserId();
    	        loggedInRole = ((UserVO) u).getRole();
    	    }
    	}
        PatientVO loggedInPatient = patientService.getPatientByUserId(loggedInUserId);
        if (loggedInPatient == null) {
            redirectAttributes.addFlashAttribute("error", "환자 정보를 찾을 수 없습니다. 다시 로그인 해주세요.");
            session.invalidate();
            String currentUrl = "/certificates/request.do";
            return "redirect:/patient/selectForm.do?returnUrl=" + encodeUrl(currentUrl);
        }

        int patientNo = loggedInPatient.getPatientNo();
        List<MedicalRecordVO> medicalRecords = certificatesService.getMedicalRecordsByPatientNo(patientNo);
        model.addAttribute("medicalRecords", medicalRecords);

        CertificateVO certificateVO = new CertificateVO();
        certificateVO.setPatientNo(patientNo);

        model.addAttribute("certificateVO", certificateVO);
        model.addAttribute("loggedInPatientName", loggedInPatient.getPatientName());
        model.addAttribute("loggedInPatientNo", patientNo);
        model.addAttribute("pageTitle", "증명서 발급 신청");
        return "certificates/certificateRequestForm";
    }

    @PostMapping("/request.do")
    public String submitCertificateRequest(@ModelAttribute CertificateVO certificateVO,
                                           RedirectAttributes redirectAttributes,
                                           HttpSession session) {
        String loggedInUserId = (String) session.getAttribute("loggedInUserId");
        String loggedInRole  = (String) session.getAttribute("loggedInRole");
        if (loggedInUserId == null || loggedInRole == null) {
            Object u = session.getAttribute("loginUser");
            if (u instanceof PatientVO) {
                loggedInUserId = ((PatientVO) u).getPatientUserId();
                loggedInRole = "patient";
            } else if (u instanceof UserVO) {
                loggedInUserId = ((UserVO) u).getUserId();
                loggedInRole = ((UserVO) u).getRole();
            }
        }

        PatientVO loggedInPatient = patientService.getPatientByUserId(loggedInUserId);
        if (loggedInPatient == null) {
            redirectAttributes.addFlashAttribute("error", "환자 정보를 찾을 수 없습니다. 다시 로그인 해주세요.");
            session.invalidate();
            String currentUrl = "/certificates/request.do";
            return "redirect:/patient/selectForm.do?returnUrl=" + encodeUrl(currentUrl);
        }

        if (loggedInPatient.getPatientNo() != certificateVO.getPatientNo()) {
            redirectAttributes.addFlashAttribute("error", "로그인 정보와 환자 번호가 일치하지 않습니다. 올바른 환자 번호를 입력해주세요.");
            redirectAttributes.addFlashAttribute("certificateVO", certificateVO);
            return "redirect:/certificates/request.do";
        }

        try {
            CertificateVO result = certificatesService.requestCertificate(certificateVO);
            String patientName = loggedInPatient.getPatientName();
            String message = patientName + "님, 증명서 발급이 성공적으로 완료되었습니다. 신청번호: " + result.getCertificateId();
            redirectAttributes.addFlashAttribute("message", message);
            return "redirect:/certificates/history.do?patientNo=" + result.getPatientNo();
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "증명서 발급 신청 실패: " + e.getMessage());
            redirectAttributes.addFlashAttribute("certificateVO", certificateVO);
            return "redirect:/certificates/request.do";
        }
    }

    @GetMapping("/history.do")
    public String showCertificateHistory(@RequestParam(required = false, defaultValue = "1") int page,
                                         @RequestParam(required = false, defaultValue = "15") int pageSize,
                                         Model model, HttpSession session, RedirectAttributes redirectAttributes) {

    	String loggedInUserId = (String) session.getAttribute("loggedInUserId");
    	String loggedInRole  = (String) session.getAttribute("loggedInRole");
    	if (loggedInUserId == null || loggedInRole == null) {
    	    Object u = session.getAttribute("loginUser");
    	    if (u instanceof PatientVO) {
    	        loggedInUserId = ((PatientVO) u).getPatientUserId();
    	        loggedInRole = "patient";
    	    } else if (u instanceof UserVO) {
    	        loggedInUserId = ((UserVO) u).getUserId();
    	        loggedInRole = ((UserVO) u).getRole();
    	    }
    	}

        PatientVO loggedInPatient = patientService.getPatientByUserId(loggedInUserId);
        if (loggedInPatient == null) {
            redirectAttributes.addFlashAttribute("error", "환자 정보를 찾을 수 없습니다. 다시 로그인 해주세요.");
            session.invalidate();
            String currentUrl = "/certificates/history.do";
            return "redirect:/patient/selectForm.do?returnUrl=" + encodeUrl(currentUrl);
        }

        int actualPatientNo = loggedInPatient.getPatientNo();
        int totalCount = certificatesService.getCertificateHistoryCount(actualPatientNo);
        PagingVO pageInfo = new PagingVO(totalCount, page, pageSize, 5);
        List<CertificateVO> history = certificatesService.getCertificateHistoryByPage(actualPatientNo, pageInfo.getStartIndex(), pageSize);

        model.addAttribute("searchPatientNo", actualPatientNo);
        model.addAttribute("certificates", history);
        model.addAttribute("page", pageInfo);
//        model.addAttribute("pageTitle", "서류 발급 이력 조회");
        model.addAttribute("loggedInPatientName", loggedInPatient.getPatientName());

        return "certificates/certificateHistory";
    }

    @GetMapping("/detail/{certificateId}.do")
    public String showCertificateDetail(@PathVariable("certificateId") int certificateId, Model model,
                                        HttpSession session, RedirectAttributes redirectAttributes) {
        String loggedInUserId = (String) session.getAttribute("loggedInUserId");
        String loggedInRole  = (String) session.getAttribute("loggedInRole");
        if (loggedInUserId == null || loggedInRole == null) {
            Object u = session.getAttribute("loginUser");
            if (u instanceof PatientVO) {
                loggedInUserId = ((PatientVO) u).getPatientUserId();
                loggedInRole = "patient";
            } else if (u instanceof UserVO) {
                loggedInUserId = ((UserVO) u).getUserId();
                loggedInRole = ((UserVO) u).getRole();
            }
        }

        if (loggedInUserId == null) {
            redirectAttributes.addFlashAttribute("error", "로그인 후 이용 가능합니다.");
            String currentUrl = "/certificates/detail/" + certificateId + ".do";
            return "redirect:/patient/selectForm.do?returnUrl=" + encodeUrl(currentUrl);
        }

        CertificateVO certificate = certificatesService.getCertificateDetail(certificateId);
        if (certificate == null) {
            redirectAttributes.addFlashAttribute("error", "존재하지 않는 증명서입니다.");
            return "redirect:/certificates/history.do";
        }

        boolean hasAdminRole = "admin".equals(loggedInRole) || "coop".equals(loggedInRole) || "doctor".equals(loggedInRole) || "nurse".equals(loggedInRole);

        if (!hasAdminRole) {
            PatientVO loggedInPatient = patientService.getPatientByUserId(loggedInUserId);
            if (loggedInPatient == null || loggedInPatient.getPatientNo() != certificate.getPatientNo()) {
                redirectAttributes.addFlashAttribute("error", "다른 환자의 증명서를 조회할 수 없습니다.");
                return "redirect:/certificates/history.do?patientNo=" + (loggedInPatient != null ? loggedInPatient.getPatientNo() : "");
            }
        }

        if (!"발급완료".equals(certificate.getStatus())) {
            redirectAttributes.addFlashAttribute("error", "해당 증명서는 아직 발급 완료 상태가 아닙니다.");
            if (!hasAdminRole) {
                PatientVO loggedInPatient = patientService.getPatientByUserId(loggedInUserId);
                return "redirect:/certificates/history.do?patientNo=" + (loggedInPatient != null ? loggedInPatient.getPatientNo() : "");
            } else {
                return "redirect:/admin/certificates/list.do";
            }
        }

        if (certificate.getViewedAt() == null) {
            certificatesService.updateViewedAt(certificate.getCertificateId(), new Date());
            certificate.setViewedAt(new Date());
        }

        model.addAttribute("certificate", certificate);
        model.addAttribute("pageTitle", "증명서 상세 조회");
        return "certificates/certificateDetail";
    }

    @GetMapping("/download.do")
    public ResponseEntity<byte[]> downloadCertificate(@RequestParam("certificateId") int certificateId,
                                                      HttpSession session) {
        // 1) 세션에서 아이디/권한 해석 (fallback 포함)
        String loggedInUserId = (String) session.getAttribute("loggedInUserId");
        String loggedInRole   = (String) session.getAttribute("loggedInRole");
        if (loggedInUserId == null || loggedInRole == null) {
            Object u = session.getAttribute("loginUser");
            if (u instanceof PatientVO) {
                loggedInUserId = ((PatientVO) u).getPatientUserId();
                loggedInRole   = "patient";
            } else if (u instanceof UserVO) {
                loggedInUserId = ((UserVO) u).getUserId();
                loggedInRole   = ((UserVO) u).getRole();
            }
        }

        CertificateVO certificate = certificatesService.getCertificateDetail(certificateId);
        if (certificate == null) return ResponseEntity.notFound().build();

        boolean hasAdminRole = "admin".equals(loggedInRole) || "coop".equals(loggedInRole) || "doctor".equals(loggedInRole) || "nurse".equals(loggedInRole);

        if (!hasAdminRole) {
            PatientVO loggedInPatient = patientService.getPatientByUserId(loggedInUserId);
            if (loggedInPatient == null || loggedInPatient.getPatientNo() != certificate.getPatientNo()) {
                return ResponseEntity.status(403).body(null);
            }
        }

        if (!"발급완료".equals(certificate.getStatus())) return ResponseEntity.status(403).body(null);

        try {
            byte[] pdfBytes = certificatesService.generateCertificatePdf(certificateId);
            if (certificate.getViewedAt() == null) {
                certificatesService.updateViewedAt(certificate.getCertificateId(), new Date());
            }

            String fileName = certificate.getType() + "_" + certificate.getCertificateId() + ".pdf";
            String encodedFileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8.toString()).replaceAll("\\+", "%20");

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_PDF)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedFileName + "\"")
                    .body(pdfBytes);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("PDF 생성 중 알 수 없는 오류가 발생했습니다.".getBytes(StandardCharsets.UTF_8));
        }
    }

    @GetMapping("/doctor/pending.do")
    public String showPendingCertificates(@RequestParam(defaultValue = "1") int page,
                                          @RequestParam(defaultValue = "15") int pageSize,
                                          HttpSession session,
                                          Model model,
                                          RedirectAttributes redirectAttributes) {

        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        if (loginUser == null || !"doctor".equals(loginUser.getRole())) {
            redirectAttributes.addFlashAttribute("error", "의사 계정으로 로그인해야 합니다.");
            return "redirect:/user/loginForm.do";
        }

        String deptId = loginUser.getDeptId();

        // 총 개수 + 페이지 계산
        int totalCount = certificatesService.getPendingCountByDept(deptId);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        int offset = (page - 1) * pageSize;
        int end = page * pageSize; // ✅ 이걸로 바꾸세요

        // ✅ 로그 찍기
        System.out.println("[페이징] page: " + page + ", offset: " + offset + ", end: " + end + ", totalPages: " + totalPages);

        List<CertificateVO> pagedList = certificatesService.getPendingCertificatesByDeptPaged(deptId, offset, end);

        model.addAttribute("certificates", pagedList);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageTitle", "접수된 제증명 목록");

        // 페이징 데이터 추가
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "doctor/doctor_pending_list";
    }




    @GetMapping("/doctor/writeForm.do")
    public String showDoctorWriteForm(@RequestParam("certificateId") int certificateId, Model model) {
        CertificateVO certificate = certificatesService.getCertificateById(certificateId);
        model.addAttribute("certificate", certificate);
        return "doctor/doctor_Pending_Certificates";
    }

    @PostMapping("/saveCertificate.do")
    public String saveDoctorCertificate(@ModelAttribute CertificateVO certificateVO, RedirectAttributes redirectAttributes) {
        try {
            certificatesService.completeCertificate(certificateVO);
            redirectAttributes.addFlashAttribute("message", "소견서가 성공적으로 저장되었습니다.");
            return "redirect:/certificates/doctor/pending.do";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "저장 실패: " + e.getMessage());
            return "redirect:/certificates/doctor/writeForm.do?certificateId=" + certificateVO.getCertificateId();
        }
    }

    @GetMapping("/doctor/editForm.do")
    public String showEditForm(@RequestParam("certificateId") int certificateId, Model model) {
        CertificateVO certificate = certificatesService.getCertificateDetail(certificateId);
        model.addAttribute("certificate", certificate);
        return "doctor/doctor_pending_editForm";
    }

    @PostMapping("/updateCertificate.do")
    public String updateCertificate(@ModelAttribute CertificateVO certificateVO, RedirectAttributes redirectAttributes) {
        try {
            certificatesService.updateCertificate(certificateVO);
            redirectAttributes.addFlashAttribute("message", "증명서가 성공적으로 수정되었습니다.");
            return "redirect:/certificates/doctor/pending.do";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "수정 실패: " + e.getMessage());
            return "redirect:/certificates/doctor/editForm.do?certificateId=" + certificateVO.getCertificateId();
        }
    }
}
