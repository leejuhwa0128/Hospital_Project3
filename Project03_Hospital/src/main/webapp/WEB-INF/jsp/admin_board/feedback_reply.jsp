<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>게시글 답변</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_edit.css" />
</head>
<body>

<h2>🗣 게시글 답변</h2>

<form action="${pageContext.request.contextPath}/admin_board/reply.do" method="post">
  <input type="hidden" name="feedbackId" value="${feedback.feedbackId}" />

  <p><strong>제목:</strong> ${feedback.title}</p>
  <p><strong>작성자:</strong> ${feedback.writerName}</p>

  <label>답변 내용</label><br />
  <textarea name="reply" rows="8" required placeholder="답변 내용을 입력하세요."></textarea><br /><br />

  <div style="text-align: right;">
    <button type="submit">답변 등록</button>
    <a class="btn" href="javascript:history.back()">취소</a>
  </div>
</form>

</body>
</html>
