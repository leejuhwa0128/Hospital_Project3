<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 상세</title>
</head>
<body>

	<h2>${notice.title}</h2>
	<p>
		<strong>작성자:</strong>
		<c:out
			value="${empty notice.createdByName ? notice.createdBy : notice.createdByName}" />
	</p>

	<p>
		<strong>작성일:</strong>
		<fmt:formatDate value="${notice.createdAt}"
			pattern="yyyy-MM-dd HH:mm:ss" />
	</p>
	<hr>
	<p>${notice.content}</p>


	<br>
	<a href="doctor_notice.do">목록으로</a>

</body>
</html>