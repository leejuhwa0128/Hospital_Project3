<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_service/03/faqform.css">

</head>
<body>
<div class="main-container">
	<jsp:include page="/WEB-INF/jsp/user_service/03_menu.jsp" />
	<div class="content-area">
		<h2>FAQ 수정</h2>
		<form action="${pageContext.request.contextPath}/03_faq/edit.do" method="post">
			<input type="hidden" name="faqId" value="${faq.faqId}" />
			<table>
				<tr>
					<th>질문</th>
					<td><input type="text" name="question" value="${faq.question}" required /></td>
				</tr>
				<tr>
					<th>답변</th>
					<td><textarea name="answer" rows="8" required>${faq.answer}</textarea></td>
				</tr>
			</table>
			<br>
			<button type="submit">수정 완료</button>
			<button type="button" onclick="history.back()">취소</button>
		</form>
	</div>
</div>
</body>
</html>
