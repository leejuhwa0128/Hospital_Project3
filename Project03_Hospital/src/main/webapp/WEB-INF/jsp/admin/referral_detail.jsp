<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>협진 상세정보</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css">
</head>
<body>
<div class="con_wrap bg_13">
  <p class="total_tit f_s20 f_w700">📄 협진 상세정보</p>

  <div class="board_view">
    <table class="detail-table">
      <tbody>
        <tr><th>요청 ID</th><td>${referral.requestId}</td></tr>
        <tr><th>의뢰자 ID</th><td>${referral.userId}</td></tr>
        <tr><th>환자명</th><td>${referral.patientName}</td></tr>
        <tr><th>주민번호</th><td>${referral.rrn}</td></tr>
        <tr><th>연락처</th><td>${referral.contact}</td></tr>
        <tr><th>진료과</th><td>${referral.department}</td></tr>
        <tr><th>담당 의사</th><td>${referral.doctorId}</td></tr>
        <tr><th>희망 진료일</th><td><fmt:formatDate value="${referral.hopeDate}" pattern="yyyy-MM-dd"/></td></tr>
        <tr><th>증상</th><td>${referral.symptoms}</td></tr>
        <tr><th>의뢰사유</th><td>${referral.reason}</td></tr>
        <tr>
          <th>상태</th>
          <td class="manage-cell">
            <c:choose>
              <c:when test="${not empty sessionScope.loginAdmin}">
                <form action="${pageContext.request.contextPath}/referral/updateReferralStatus.do"
                      method="post" class="status-form inline-form">
                  <input type="hidden" name="requestId" value="${referral.requestId}">
                  <select name="status">
                    <option value="접수" ${referral.status eq '접수' ? 'selected' : ''}>접수</option>
                    <option value="완료" ${referral.status eq '완료' ? 'selected' : ''}>완료</option>
                    <option value="거절" ${referral.status eq '거절' ? 'selected' : ''}>거절</option>
                  </select>
                  <button type="submit" class="btn-action btn-save">변경</button>
                </form>
              </c:when>
              <c:otherwise>
                ${referral.status}
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
      </tbody>
    </table>
  </div>

  <!-- 목록으로 이동 버튼 -->
  <div class="btn_area" style="margin-top: 20px; text-align: right;">
    <a href="${pageContext.request.contextPath}/admin/allReferrals.do" class="btn-action btn-view">← 목록</a>
  </div>
</div>
</body>
</html>
