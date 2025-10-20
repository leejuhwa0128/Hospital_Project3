<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>기부 내역 관리</title>
   <!-- ✅ CSS 외부 파일 연결 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/donation.css"/>
</head>
<body>
<div class="donation-list">
  <h2>💙 기부 내역 관리</h2>
  

  <!-- ✅ 요약 정보 -->
  <div class="summary">
    총 기부 건수: <b>${totalCount}</b>건,
    총 금액: <b><fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₩"/></b>
  </div>

  <!-- ✅ 검색 폼 -->
  <form method="get" action="list.do" class="search-form">
    <input type="text" name="donorName" placeholder="후원자명 검색" value="${param.donorName}">
    <input type="date" name="startDate" value="${param.startDate}">
    <input type="date" name="endDate" value="${param.endDate}">
    <button type="submit">검색</button>
    <a href="list.do" class="btn-reset">초기화</a>
  </form>


  <table>
    <thead>
      <tr>
        <th>주문번호</th>
        <th>후원자명</th>
        <th>금액</th>
        <th>결제일</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="d" items="${donations}">
        <tr>
          <td>${d.orderId}</td>
          <td><c:out value="${empty d.donorName ? '익명' : d.donorName}"/></td>
          <td><fmt:formatNumber value="${d.amount}" type="currency" currencySymbol="₩"/></td>
          <td><fmt:formatDate value="${d.approvedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <!-- ✅ 페이징 -->
  <div class="pagination">
<c:if test="${currentPage > 1}">
  <a href="?page=${currentPage-1}&donorName=${param.donorName}&startDate=${param.startDate}&endDate=${param.endDate}">이전</a>
</c:if>
<c:forEach begin="1" end="${totalPages}" var="p">
  <a href="?page=${p}&donorName=${param.donorName}&startDate=${param.startDate}&endDate=${param.endDate}"
     class="${p == currentPage ? 'active' : ''}">${p}</a>
</c:forEach>
<c:if test="${currentPage < totalPages}">
  <a href="?page=${currentPage+1}&donorName=${param.donorName}&startDate=${param.startDate}&endDate=${param.endDate}">다음</a>
</c:if>
  </div>

  <a href="<c:url value='/admin/donations/exportExcel.do'/>" class="btn-export">📂 엑셀 다운로드</a>
</div>
</body>
</html>
