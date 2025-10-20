package com.hospital.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hospital.service.DonationService;
import com.hospital.vo.DonationVO;

@Controller
@RequestMapping("/admin/donations")
public class DonationAdminController {

    @Autowired
    private DonationService donationService;

    /** 기부 내역 목록 */
    @GetMapping("/list.do")
    public String list(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(required = false) String donorName,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            Model model) {

        int pageSize = 10;
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        // ✅ 검색 결과 가져오기
        List<DonationVO> donations;
        if ((donorName != null && !donorName.isEmpty()) ||
            (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty())) {
            // 이름 또는 날짜가 있을 경우 → 통합 검색
            donations = donationService.getDonationsByFilter(donorName, startDate, endDate, startRow, endRow);
        } else if (email != null && !email.isEmpty()) {
            donations = donationService.getDonationsByEmail(email);
        } else {
            donations = donationService.getDonationsByPage(startRow, endRow);
        }

        int totalCount = donationService.countDonations(); // 실제 조건별 count 따로 만들 수도 있음
        int totalAmount = donationService.sumDonations();

        model.addAttribute("donations", donations);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / pageSize));
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("totalAmount", totalAmount);

        return "admin/donations";
    }

    /** 엑셀 다운로드 */
    @GetMapping("/exportExcel.do")
    public void exportExcel(HttpServletResponse response) throws IOException {
        List<DonationVO> donations = donationService.getAllDonations();

        org.apache.poi.ss.usermodel.Workbook wb = new org.apache.poi.xssf.usermodel.XSSFWorkbook();
        org.apache.poi.ss.usermodel.Sheet sheet = wb.createSheet("Donations");

        // ✅ 한글 폰트 설정
        org.apache.poi.ss.usermodel.Font font = wb.createFont();
        font.setFontName("맑은 고딕");
        font.setFontHeightInPoints((short) 11);

        org.apache.poi.ss.usermodel.CellStyle style = wb.createCellStyle();
        style.setFont(font);

        // ✅ 날짜 셀 스타일
        org.apache.poi.ss.usermodel.CellStyle dateCellStyle = wb.createCellStyle();
        short dateFormat = wb.getCreationHelper().createDataFormat().getFormat("yyyy-MM-dd HH:mm");
        dateCellStyle.setDataFormat(dateFormat);
        dateCellStyle.setFont(font);

        // 헤더 작성
        String[] headers = {"주문번호", "후원자명", "금액", "결제일"};
        org.apache.poi.ss.usermodel.Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            org.apache.poi.ss.usermodel.Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(style);
        }

        // 데이터 작성
        int rowNum = 1;
        for (DonationVO d : donations) {
            org.apache.poi.ss.usermodel.Row row = sheet.createRow(rowNum++);

            org.apache.poi.ss.usermodel.Cell c0 = row.createCell(0);
            org.apache.poi.ss.usermodel.Cell c1 = row.createCell(1);
            org.apache.poi.ss.usermodel.Cell c2 = row.createCell(2);
            org.apache.poi.ss.usermodel.Cell c3 = row.createCell(3);

            c0.setCellValue(d.getOrderId());
            c1.setCellValue(d.getDonorName() == null ? "익명" : d.getDonorName());
            c2.setCellValue(d.getAmount());

            if (d.getApprovedAt() != null) {
                c3.setCellValue(d.getApprovedAt()); // Date 타입 그대로
                c3.setCellStyle(dateCellStyle);     // 날짜 서식 적용
            } else {
                c3.setCellValue("");
                c3.setCellStyle(style);
            }

            // 다른 셀은 기본 스타일
            c0.setCellStyle(style);
            c1.setCellStyle(style);
            c2.setCellStyle(style);
        }

        // ✅ 파일명 인코딩
        String fileName = URLEncoder.encode("기부내역.xlsx", "UTF-8").replaceAll("\\+", "%20");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

        wb.write(response.getOutputStream());
        wb.close();
    }
    
}

