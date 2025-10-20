<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>공지 목록</title>
</head>
<body>
	<h2>공지 목록</h2>
	<a href="<c:url value='/admin/noticeForm.do'/>">➕ 새 공지 작성</a>
	<br>
	<br>
	<table border="1">
		<tr>
			<th>공지 ID</th>
			<th>제목</th>
			<th>작성자</th>
			<th>대상</th>
			<th>작성일</th>
			<th>상세</th>
		</tr>
		<c:forEach var="n" items="${notices}">
			<tr>
				<td>${n.noticeId}</td>
				<td>${n.title}</td>
				<td>${n.createdBy}</td>
				<td>${n.targetRole}</td>
				<td>${n.createdAt}</td>
				<td><a
					href="<c:url value='/admin/noticeDetail.do?noticeId=${n.noticeId}'/>">보기</a>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
