<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 공통 스타일 적용 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css?v=2">

<!-- 버튼 클래스 통일 -->
<style>
  .btn-action.btn-delete {
    background-color: #dc2626 !important;
    color: #fff !important;
    border: none !important;
  }

  .btn-action.btn-delete:hover {
    background-color: #b91c1c !important;
  }
</style>

<c:url var="editUrl" value="/admin_board/press_editForm.do" />
<c:url var="deleteUrl" value="/admin_board/press_delete.do" />
<c:url var="listUrl" value="/admin_board/pressManage.do" />

<div class="con_wrap bg_13">
  <p class="total_tit f_s20 f_w700">📄 언론보도 상세</p>

  <div class="board_view">
    <table class="detail-table">
      <tbody>
        <tr>
          <th>제목</th>
          <td><c:out value="${event.title}" /></td>
        </tr>
        <tr>
          <th>작성일</th>
          <td><fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd" /></td>
        </tr>
        <tr>
          <th>기자명</th>
          <td><c:out value="${event.reporter}" /></td>
        </tr>
        <tr>
          <th>썸네일</th>
          <td>
            <c:choose>
              <c:when test="${not empty event.thumbnailPath}">
                <img src="${pageContext.request.contextPath}${event.thumbnailPath}" width="200" />
              </c:when>
              <c:otherwise>
                <img src="${pageContext.request.contextPath}/press/default-thumb.png" width="200" />
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
        <tr>
          <th>출처</th>
          <td><c:out value="${event.source}" /></td>
        </tr>
        <tr>
          <th>내용</th>
          <td style="white-space: pre-line;">${fn:trim(event.description)}</td>
        </tr>
      </tbody>
    </table>
  </div>

  <!-- 버튼 영역 (오른쪽 정렬) -->
  <div class="btn_area" style="margin-top: 20px; text-align: right;">
    <a href="${editUrl}?eventId=${event.eventId}" class="btn-action btn-save">수정</a>
    <a href="${deleteUrl}?eventId=${event.eventId}" 
       onclick="return confirm('정말 삭제하시겠습니까?')" 
       class="btn-action btn-delete">삭제</a>
    <a href="${listUrl}" class="btn-action btn-view">← 목록</a>
  </div>
</div>
