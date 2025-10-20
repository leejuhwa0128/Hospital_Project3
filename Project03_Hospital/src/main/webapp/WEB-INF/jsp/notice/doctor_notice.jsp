<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>의료진 공지사항</title>
<script>
    var contextPath = "${pageContext.request.contextPath}";
</script>
<script>
$(function () {
	$("#mainBtn").off("click").on("click", function () {
        location.href = contextPath + "/doctor_main.do";
    });
});
</script>
</head>

<body>

	<h2 style="text-align: center;">의료진 공지사항</h2>

	<table border="1" width="100%" cellspacing="0" cellpadding="5">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="notice" items="${noticeList}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td><a
						href="doctor_notice_content.do?noticeId=${notice.noticeId}">
							${notice.title} </a></td>
					<td><c:out value="${empty notice.createdByName ? notice.createdBy : notice.createdByName}"/>
</td>
					<td><fmt:formatDate value="${notice.createdAt}"
							pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
			<c:if test="${empty noticeList}">
				<tr>
					<td colspan="4">등록된 공지사항이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<!-- 검색 영역 -->
	<div style="text-align: center;">
		<form action="doctor_notice.do" method="get"
			style="display: inline-block;">
			<select name="searchType">
				<option value="title">제목만</option>
				<option value="writer">글작성자</option>
				<option value="content">댓글내용</option>
			</select> <input type="text" name="keyword" placeholder="검색어를 입력해주세요">
			<button type="submit">검색</button>
		</form>

		<!-- 전체글 버튼 -->
		<form action="doctor_notice.do" method="get"
			style="display: inline-block; margin-left: 10px;">
			<button type="submit">전체글</button>
			<button type="button" id="mainBtn">메인</button>
		</form>
	</div>
</body>
</html>
