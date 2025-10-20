<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>공지 작성</title>
</head>
<body>
	<h2>공지 등록</h2>
	<form action="<c:url value='/admin/noticeSubmit.do'/>" method="post">
		제목: <input type="text" name="title" required><br>
		<br> 대상: <select name="targetRole" required>
			<option value="all">전체</option>
			<option value="doctor">의사</option>
			<option value="nurse">간호사</option>
		</select><br>
		<br> 내용:<br>
		<textarea name="content" rows="10" cols="60" required></textarea>
		<br>
		<br>
		<button type="submit">등록</button>
		<a href="javascript:history.back();">취소</a>
	</form>
</body>
</html>
