<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css">

<div class="con_wrap bg_13">
  <p class="total_tit f_s20 f_w700">🗣 고객 문의 상세</p>

  <div class="board_view">
    <table class="detail-table">
      <tbody>
        <tr>
          <th>카테고리</th>
          <td>${feedback.category}</td>
        </tr>
        <tr>
          <th>작성자</th>
          <td>${feedback.patientUserId}</td>
        </tr>
        <tr>
          <th>내용</th>
          <td style="white-space:pre-line;">${feedback.content}</td>
        </tr>
        <tr>
          <th>작성일</th>
          <td><fmt:formatDate value="${feedback.createdAt}" pattern="yyyy.MM.dd HH:mm"/></td>
        </tr>
        <tr>
          <th>상태</th>
          <td>${feedback.status}</td>
        </tr>

        <c:if test="${not empty feedback.reply}">
          <tr>
            <th>답변</th>
            <td style="white-space:pre-line;">${feedback.reply}</td>
          </tr>
          <tr>
            <th>답변자</th>
            <td>${feedback.repliedBy}</td>
          </tr>
          <tr>
            <th>답변일</th>
            <td><fmt:formatDate value="${feedback.repliedAt}" pattern="yyyy.MM.dd HH:mm"/></td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>

  <div class="btn_area" style="margin-top: 20px; text-align: right;">
    <a href="${pageContext.request.contextPath}/admin_board/editReplyForm.do?feedbackId=${feedback.feedbackId}" class="btn-action btn-save">수정</a>
    <a href="${pageContext.request.contextPath}/admin_board/deleteReply.do?feedbackId=${feedback.feedbackId}" 
       onclick="return confirm('정말 삭제하시겠습니까?')" 
       class="btn-action btn-delete">삭제</a>
    <a href="${pageContext.request.contextPath}/admin_board/feedbackManage.do" class="btn-action btn-view">← 목록</a>
  </div>
</div>
