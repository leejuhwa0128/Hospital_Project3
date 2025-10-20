<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css">

<h2>🎓 강좌 및 행사 상세보기</h2>

<div class="con_wrap bg_13">
  <div class="board_view">
    <table class="detail-table">
      <tbody>
        <tr>
          <th>제목</th>
          <td>${event.title}</td>
        </tr>
        <tr>
          <th>카테고리</th>
          <td>${event.category}</td>
        </tr>
        <tr>
          <th>일정</th>
          <td>
            <c:choose>
              <c:when test="${not empty event.startDateStr && not empty event.endDateStr}">
                ${event.startDateStr} ~ ${event.endDateStr}
              </c:when>
              <c:otherwise>${event.eventDateStr}</c:otherwise>
            </c:choose>
          </td>
        </tr>
        <tr>
          <th>작성일</th>
          <td>${event.createdAtStr}</td>
        </tr>
        <tr>
          <th>장소</th>
          <td>${event.workLocation}</td>
        </tr>
        <tr>
          <th>강사</th>
          <td>${event.speaker}</td>
        </tr>
        <tr>
          <th>시간</th>
          <td>${event.timeInfo}</td>
        </tr>
        <tr>
          <th>연락처</th>
          <td>${event.contact}</td>
        </tr>
        <tr>
          <th>내용</th>
          <td style="white-space:pre-line;">${event.description}</td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="btn_area" style="margin-top: 20px; text-align: right;">
    <a href="${pageContext.request.contextPath}/admin_board/lecture_editForm.do?eventId=${event.eventId}" class="btn-action btn-save">수정</a>
    <a href="${pageContext.request.contextPath}/admin_board/lecture_delete.do?eventId=${event.eventId}" 
       onclick="return confirm('정말 삭제하시겠습니까?')" 
       class="btn-action btn-delete">삭제</a>
    <a href="${pageContext.request.contextPath}/admin_board/lectureManage.do" class="btn-action btn-view">← 목록</a>
  </div>
</div>
