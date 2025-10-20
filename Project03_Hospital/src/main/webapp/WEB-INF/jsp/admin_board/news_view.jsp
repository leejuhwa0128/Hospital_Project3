<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css">

<div class="con_wrap bg_13">
  <p class="total_tit f_s20 f_w700">📄 병원소식 상세</p>

  <div class="board_view">
    <table class="detail-table">
      <tbody>
        <tr>
          <th>제목</th>
          <td>${event.title}</td>
        </tr>
        <tr>
          <th>작성일</th>
          <td><fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd"/></td>
        </tr>
        <tr>
          <th>내용</th>
          <td style="white-space:pre-line;">${event.description}</td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="btn_area" style="margin-top: 20px; text-align: right;">
    
    <a href="${pageContext.request.contextPath}/admin_board/news_editForm.do?eventId=${event.eventId}" class="btn-action btn-save">수정</a>
    <a href="${pageContext.request.contextPath}/admin_board/news_delete.do?eventId=${event.eventId}" 
       onclick="return confirm('정말 삭제하시겠습니까?')" 
       class="btn-action btn-delete">삭제</a>
    <a href="${pageContext.request.contextPath}/admin_board/newsManage.do" class="btn-action btn-view">← 목록</a>
  </div>
</div>
