<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>칭찬릴레이</title>
<style>
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

.page-info {
	font-size: 14px;
	margin-bottom: 10px;
}

.write-btn {
	float: right;
	margin-bottom: 10px;
}
</style>
</head>
<body>

	<span class="text-sm text-gray-600"> 총 <strong> <c:choose>
				<c:when test="${not empty totalCount}">${totalCount}</c:when>
				<c:otherwise>${praiseList.size()}</c:otherwise>
			</c:choose>
	</strong>개
	</span>

	<h1>칭찬릴레이</h1>
	<p>칭찬릴레이 게시판은 우리병원에서 있었던 크고 작은 칭찬이야기, 따뜻한 이야기, 감동적인 이야기를 게시하여 함께
		공유하며 따뜻한 감동을 고객 여러분과 나누기 위해 만들었습니다.</p>
	<p>
		<a href="${pageContext.request.contextPath}/03_praise/writeForm.do"
			class="write-btn">칭찬글 작성</a>

	</p>

	<div class="page-info">
		총
		<c:out value="${praiseList.size()}" />
		개
	</div>

	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>등록일</th>
				<th>조회</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty praiseList}">
					<tr>
						<td colspan="5" style="text-align: center;">등록된 칭찬글이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="praise" items="${praiseList}">
						<tr>
							<td><c:out value="${praise.praiseId}" /></td>
							<td><a
								href="${pageContext.request.contextPath}/03_praise/detail.do?praiseId=${praise.praiseId}">
									<c:out value="${praise.title}" />
							</a></td>
							<td><fmt:formatDate value="${praise.createdAt}"
									pattern="yyyy.MM.dd" /></td>
							<td><c:out value="${praise.viewCount}" /></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	<div class="flex justify-center mt-6">
		<c:forEach var="i" begin="1" end="${totalPage}">
			<a
				href="${pageContext.request.contextPath}/03_praise/list.do?page=${i}"
				class="mx-1 px-3 py-1 border rounded
              <c:if test='${i == currentPage}'> bg-blue-800 text-white border-blue-800</c:if>
              <c:if test='${i != currentPage}'> hover:bg-gray-100</c:if>">
				${i} </a>
		</c:forEach>
	</div>

</body>
</html>