<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>칭찬 릴레이</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css?v=2">
</head>
<body>

<h2>🌟 칭찬 릴레이</h2>
<div class="con_wrap bg_13">

  <!-- 상단 버튼 -->
  <div class="top_btns" style="margin-bottom: 16px;">
    <a href="${pageContext.request.contextPath}/03_praise/list.do" target="_blank" class="btn btn-view">👁 홈페이지 이동</a>
  </div>

  <!-- 테이블 -->
  <div class="board_list">
    <table class="detail-table">
      <thead>
        <tr>
          <th>번호</th>
          <th>제목</th>
          <th>작성일</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="praise" items="${praiseList}" varStatus="status">
          <tr>
            <td>
              <c:choose>
                <c:when test="${not empty totalCount}">
                  ${totalCount - ((currentPage - 1) * pageSize + status.index)}
                </c:when>
                <c:otherwise>
                  ${status.index + 1}
                </c:otherwise>
              </c:choose>
            </td>
            <td>${praise.title}</td>
            <td><fmt:formatDate value="${praise.createdAt}" pattern="yyyy.MM.dd"/></td>
            <td class="actions">
              <a class="btn-action btn-view" href="${pageContext.request.contextPath}/admin_board/praise_view.do?praiseId=${praise.praiseId}">상세</a>
              <a class="btn-action btn-delete" href="${pageContext.request.contextPath}/admin_board/praise_delete.do?praiseId=${praise.praiseId}" onclick="return confirm('삭제하시겠습니까?')">삭제</a>
            </td>
          </tr>
        </c:forEach>

        <c:if test="${empty praiseList}">
          <tr>
            <td colspan="4" style="text-align:center; padding:20px;">등록된 칭찬 릴레이가 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>

  <!-- 페이징 -->
  <div class="pagination">
    <c:if test="${totalCount > pageSize}">
      <c:set var="pageCount" value="${(totalCount + pageSize - 1) / pageSize}" />
      <c:forEach begin="1" end="${pageCount}" var="i">
        <c:url var="pageUrl" value="/admin_board/praiseManage.do">
          <c:param name="page" value="${i}" />
        </c:url>
        <a href="${pageUrl}" class="page-btn ${currentPage == i ? 'active' : ''}">${i}</a>
      </c:forEach>
    </c:if>
  </div>

</div>
</body>
</html>
