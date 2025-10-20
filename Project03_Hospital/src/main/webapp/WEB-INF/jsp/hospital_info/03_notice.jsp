<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>
body {
	font-family: 'Arial';
	background: #f9fbfd;
	padding: 40px;
}

.main-container {
	display: flex;
}

.category-wrapper {
	width: 200px;
	margin-left: 40px;
}

.main-category {
	display: flex;
	flex-direction: column;
	background: white;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
}

.main-category li {
	list-style: none;
	font-weight: bold;
	cursor: pointer;
	padding: 10px;
	border-bottom: 1px solid #eee;
}

.main-category li a {
	text-decoration: none;
	color: black;
	display: block;
}

.main-category li:hover {
	background: #007bff;
}

.main-category li:hover a {
	color: white;
}

.content-area {
	flex: 1;
	padding: 0 40px;
}
</style>
</head>
<body>
	<div class="main-container">
		<jsp:include page="/WEB-INF/jsp/hospital_info/03_menu.jsp" />

		<div class="content-area">
			<h2>📢 공지사항</h2>


			<div style="text-align: right; margin: 10px 0;">
				<a
					href="${pageContext.request.contextPath}/info/03_write.do?category=공지">
					<button>글쓰기</button>
				</a>
			</div>

			<table border="1" width="100%">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<c:forEach var="event" items="${events}" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td><c:choose>
								<c:when test="${event.category == '공지'}">
									<a href="03_notice_view.do?eventId=${event.eventId}">${event.title}</a>
								</c:when>
								<c:when test="${event.category == '소식'}">
									<a href="03_press_view.do?eventId=${event.eventId}">${event.title}</a>
								</c:when>
								<c:when test="${event.category == '채용'}">
									<a href="03_recruit_view.do?eventId=${event.eventId}">${event.title}</a>
								</c:when>
								<c:when test="${event.category == '언론'}">
									<a href="03_newsletter_view.do?eventId=${event.eventId}">${event.title}</a>
								</c:when>
							</c:choose></td>

						<td><fmt:formatDate value="${event.createdAt}"
								pattern="yyyy-MM-dd" /></td>
						<td>${event.viewCount}</td>
					</tr>
				</c:forEach>
			</table>
			<!-- ✅ 페이징 처리 -->
			<div style="margin-top: 20px; text-align: center;">
				<c:if test="${totalPages > 1}">
					<c:forEach begin="1" end="${totalPages}" var="i">
						<c:choose>
							<c:when test="${i == currentPage}">
								<strong style="margin: 0 5px;">[${i}]</strong>
							</c:when>
							<c:otherwise>
								<a
									href="${pageContext.request.contextPath}/info/03_list.do?category=공지&page=${i}"
									style="margin: 0 5px;">${i}</a>

							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
			</div>
		</div>


	</div>
</body>
</html>
