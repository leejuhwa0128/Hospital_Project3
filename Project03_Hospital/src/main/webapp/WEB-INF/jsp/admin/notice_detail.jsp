<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>공지 상세</title>
</head>
<body>
	<h2>공지 상세</h2>
	<p>
		<strong>제목:</strong> ${notice.title}
	</p>
	<p>
		<strong>작성자:</strong> ${notice.createdBy}
	</p>
	<p>
		<strong>대상:</strong> ${notice.targetRole}
	</p>
	<p>
		<strong>작성일:</strong> ${notice.createdAt}
	</p>
	<p>
		<strong>내용:</strong><br> ${notice.content}
	</p>

	<br>
	<a href="javascript:history.back();">← 목록으로</a>
</body>
</html>
