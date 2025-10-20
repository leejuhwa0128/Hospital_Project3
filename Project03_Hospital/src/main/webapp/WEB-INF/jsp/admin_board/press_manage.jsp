<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>언론보도 관리</title>
  <link href="${pageContext.request.contextPath}/resources/css/admin/manage.css" rel="stylesheet"/>
</head>
<body>
<h2>📰 언론보도 관리</h2>

<div class="button-group">
  <a class="btn" href="${pageContext.request.contextPath}/03_press.do" target="_blank"> 👁 홈페이지 이동</a>
  <a class="btn" href="${pageContext.request.contextPath}/admin_board/press_writeForm.do">+ 새 글 등록</a>
</div>

<table border="1" cellpadding="10" cellspacing="0" width="100%">
  <tr>
    <th>번호</th>
    <th>제목</th>
    <th>관리</th>
  </tr>
  <c:forEach var="event" items="${events}" varStatus="vs">
    <tr>
      <td>${vs.count}</td>
      
      <td>${event.title}</td>
      <td>
        <div class="action-buttons">
          <a class="detail" href="${pageContext.request.contextPath}/admin_board/press_view.do?eventId=${event.eventId}">상세</a>
          <a class="edit" href="${pageContext.request.contextPath}/admin_board/press_editForm.do?eventId=${event.eventId}">수정</a>
          <a class="delete" href="${pageContext.request.contextPath}/admin_board/press_delete.do?eventId=${event.eventId}" onclick="return confirm('삭제하시겠습니까?')">삭제</a>
        </div>
      </td>
    </tr>
  </c:forEach>
  <c:if test="${empty events}">
    <tr><td colspan="4" style="text-align:center;">데이터가 없습니다.</td></tr>
  </c:if>
</table>

<c:set var="cp" value="${currentPage}" />
<c:set var="tp" value="${totalPages}" />
<c:set var="displayCount" value="10" />
<c:set var="end" value="${tp lt displayCount ? tp : displayCount}" />

<c:if test="${tp > 1}">
  <div class="pagination" style="margin-top:16px; text-align:center;">
    <!-- 처음 -->
    <c:choose>
      <c:when test="${cp == 1}">
        <span class="page disabled">« 처음</span>
      </c:when>
      <c:otherwise>
        <a class="page" href="${pageContext.request.contextPath}/admin_board/pressManage.do?page=1">« 처음</a>
      </c:otherwise>
    </c:choose>

    <!-- 번호: 1 ~ displayCount (tp가 더 작으면 tp까지만) -->
    <c:forEach var="i" begin="1" end="${end}">
      <c:choose>
        <c:when test="${i == cp}">
          <span class="current">${i}</span>
        </c:when>
        <c:otherwise>
          <a class="page" href="${pageContext.request.contextPath}/admin_board/pressManage.do?page=${i}">${i}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>

    <!-- 끝 -->
    <c:choose>
      <c:when test="${cp == tp}">
        <span class="page disabled">끝 »</span>
      </c:when>
      <c:otherwise>
        <a class="page" href="${pageContext.request.contextPath}/admin_board/pressManage.do?page=${tp}">끝 »</a>
      </c:otherwise>
    </c:choose>
  </div>
</c:if>

<style>
.pagination .page, .pagination .current{
  display:inline-block; padding:6px 10px; margin:0 3px;
  border:1px solid #ddd; border-radius:8px; text-decoration:none; font-size:13px;
}
.pagination .current{ background:#4a2d2d; color:#fff; border-color:#4a2d2d; }
.pagination .page:hover{ background:#f3f3f3; }
.pagination .disabled{ color:#bbb; border-color:#eee; pointer-events:none; }
</style>

</body>
</html>
