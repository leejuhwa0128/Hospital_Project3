<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title}</title>
<style>
body {
	font-family: 'Arial';
	background: #f9fbfd;
	padding: 40px;
}
.main-container {
	display: flex;
}
.content-area {
	flex: 1;
	background: #fff;
	padding: 30px;
	border: 1px solid #ccc;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0,0,0,0.05);
	margin-left: 30px;
}
h2 {
	font-size: 24px;
	color: #333;
}
h3 {
	color: #007bff;
}
.meta {
	color: #777;
	margin-bottom: 10px;
}
.description {
	margin-top: 20px;
	white-space: pre-line;
	line-height: 1.6;
}
.button-area {
	text-align: right;
	margin-top: 30px;
}
.button-area a {
	display: inline-block;
	margin-left: 10px;
	padding: 8px 16px;
	background-color: #007bff;
	color: white;
	text-decoration: none;
	border-radius: 4px;
}
.button-area a:hover {
	background-color: #0056b3;
}
.btn-group {
    text-align: right;
    margin-top: 30px;
}

.btn {
    display: inline-block;
    padding: 8px 16px;
    background-color: #007bff;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    font-si

</style>
</head>
<body>

<div class="main-container">
	<!-- 좌측 메뉴 -->
	<jsp:include page="/WEB-INF/jsp/hospital_info/03_menu.jsp" />

	<!-- 본문 내용 -->
	<div class="content-area">
		<h2>${title}</h2>
		<h3>${event.title}</h3>

		<div class="meta">
			작성일: <fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd" /> |
			
		</div>

		<hr>

		<div class="description">
			${event.description}
		</div>
		
		
		<div class="btn-group">
			<a href="javascript:history.back()">← 뒤로가기</a>
		</div>
		

	</div>
</div>

</body>
</html>
