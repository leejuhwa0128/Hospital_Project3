<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>공지사항 상세</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css?v=2">
</head>
<body>

<h2>공지사항 상세</h2>

<div class="con_wrap bg_13">
  <div class="board_view">
    <table class="detail-table">
      <tbody>
        <tr>
          <th>제목</th>
          <td>${notice.title}</td>
        </tr>
        <tr>
          <th>작성일</th>
          <td><fmt:formatDate value="${notice.createdAt}" pattern="yyyy-MM-dd"/></td>
        </tr>
        <tr>
          <th>내용</th>
          <td style="white-space:pre-line;">${notice.content}</td>
        </tr>
      </tbody>
    </table>
  </div>

  <!-- 하단 버튼 -->
  <div class="btn_area" style="margin-top: 20px; text-align: right;">
    <a href="${pageContext.request.contextPath}/admin_board/notice_editForm.do?noticeId=${notice.noticeId}" class="btn-action btn-save">수정</a>
    <a href="${pageContext.request.contextPath}/admin_board/notice_delete.do?noticeId=${notice.noticeId}" 
       onclick="return confirm('정말 삭제하시겠습니까?')" 
       class="btn-action btn-delete">삭제</a>
    <a href="${pageContext.request.contextPath}/admin_board/noticeManage.do" class="btn-action btn-view">← 목록</a>
  </div>
</div>

</body>
</html>
