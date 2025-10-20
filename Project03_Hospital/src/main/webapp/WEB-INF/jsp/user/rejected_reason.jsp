<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>가입 상태 안내</title>
</head>
<body>
	<h2>가입 상태 확인</h2>

	<c:if test="${not empty message}">
		<p style="color: red;">${message}</p>
	</c:if>

	<c:if test="${not empty rejectReason}">
		<p>
			<strong>거절 사유:</strong> ${rejectReason}
		</p>
	</c:if>

	<c:if test="${not empty userId}">
		<p>
			<strong>아이디:</strong> ${userId}
		</p>
	</c:if>

	<form action="${pageContext.request.contextPath}/user/selectForm.do"
		method="get">
		<button type="submit">← 로그인으로 돌아가기</button>
	</form>
</body>
</html>
