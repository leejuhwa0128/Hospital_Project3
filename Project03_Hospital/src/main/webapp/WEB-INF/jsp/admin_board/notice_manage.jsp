<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>공지사항 관리</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css?v=2">
</head>
<body>

<h2>공지사항 관리</h2>

<div class="con_wrap bg_13">

  <!-- 상단 버튼 -->
  <div class="top_btns" style="margin-bottom: 16px;">
    <a href="${pageContext.request.contextPath}/01_notice/list.do" target="_blank" class="btn btn-view">👁 홈페이지 이동</a>
    <a href="${pageContext.request.contextPath}/admin_board/notice_writeForm.do" class="btn btn-save">+ 새 글 등록</a>
  </div>

  <!-- 목록 테이블 -->
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
        <c:forEach var="notice" items="${noticeList}" varStatus="i">
          <tr>
            <td>${i.count}</td>
            <td>${notice.title}</td>
            <td><fmt:formatDate value="${notice.createdAt}" pattern="yyyy.MM.dd" /></td>
            <td class="actions">
              <a class="btn-action btn-view" href="${pageContext.request.contextPath}/admin_board/notice_view.do?noticeId=${notice.noticeId}">상세</a>
              <a class="btn-action btn-save" href="${pageContext.request.contextPath}/admin_board/notice_editForm.do?noticeId=${notice.noticeId}">수정</a>
              <a class="btn-action btn-delete" href="${pageContext.request.contextPath}/admin_board/notice_delete.do?noticeId=${notice.noticeId}" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            </td>
          </tr>
        </c:forEach>

        <c:if test="${empty noticeList}">
          <tr>
            <td colspan="4" style="text-align:center; padding:20px;">등록된 공지사항이 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>

  <!-- 페이징 -->
  <c:set var="cp" value="${currentPage}" />
  <c:set var="tp" value="${totalPages}" />
  <c:set var="displayCount" value="10" />
  <c:set var="end" value="${tp lt displayCount ? tp : displayCount}" />

  <c:if test="${tp > 1}">
    <div class="pagination" style="text-align:center; margin-top: 16px;">
      <!-- 처음 -->
      <c:choose>
        <c:when test="${cp == 1}">
          <span class="page-btn disabled">« 처음</span>
        </c:when>
        <c:otherwise>
          <a class="page-btn" href="${pageContext.request.contextPath}/admin_board/noticeManage.do?page=1">« 처음</a>
        </c:otherwise>
      </c:choose>

      <!-- 번호 -->
      <c:forEach var="i" begin="1" end="${end}">
        <c:choose>
          <c:when test="${i == cp}">
            <span class="page-btn active">${i}</span>
          </c:when>
          <c:otherwise>
            <a class="page-btn" href="${pageContext.request.contextPath}/admin_board/noticeManage.do?page=${i}">${i}</a>
          </c:otherwise>
        </c:choose>
      </c:forEach>

      <!-- 끝 -->
      <c:choose>
        <c:when test="${cp == tp}">
          <span class="page-btn disabled">끝 »</span>
        </c:when>
        <c:otherwise>
          <a class="page-btn" href="${pageContext.request.contextPath}/admin_board/noticeManage.do?page=${tp}">끝 »</a>
        </c:otherwise>
      </c:choose>
    </div>
  </c:if>

</div>

</body>
</html>
