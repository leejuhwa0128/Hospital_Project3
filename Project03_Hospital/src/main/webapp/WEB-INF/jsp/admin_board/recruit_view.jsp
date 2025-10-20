<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채용공고 상세보기</title>

<!-- 공통 스타일 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css">

<style>
.notice-wrapper {
	background: #fff;
	padding: 24px;
	border: 1px solid #ddd;
	border-radius: 8px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
	margin-bottom: 30px;
}
.notice-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}
.notice-table th, .notice-table td {
	padding: 12px 14px;
	border: 1px solid #ddd;
	font-size: 14px;
	text-align: left;
}
.notice-table th {
	width: 140px;
}
.notice-content {
	padding: 20px;
	background: #f9f9f9;
	border: 1px solid #e5e7eb;
	border-radius: 6px;
	font-size: 15px;
	line-height: 1.7;
	color: #333;
	white-space: pre-wrap;
}
.button-group {
	text-align: right;
	margin-bottom: 20px;
}
</style>
</head>
<body>

<div class="notice-wrapper">

	<!-- 상단 버튼 -->
	<div class="button-group">
		<c:if test="${not empty event.resumeFilePath}">
			<a class="btn-action btn-save"
				href="${pageContext.request.contextPath}/upload/${event.resumeFilePath}"
				download>⬇ 이력서 양식 다운로드</a>
		</c:if>

		<a class="btn-action btn-save"
			href="${pageContext.request.contextPath}/admin_board/recruit_editForm.do?eventId=${event.eventId}">
			✏️ 수정</a>

		<form action="${pageContext.request.contextPath}/admin_board/recruit_delete.do"
			  method="post" class="inline-form" style="display: inline;"
			  onsubmit="return confirm('정말 삭제하시겠습니까?');">
			<input type="hidden" name="eventId" value="${event.eventId}">
			<button type="submit" class="btn-action btn-delete">🗑 삭제</button>
		</form>

		<a class="btn-action btn-view"
			href="${pageContext.request.contextPath}/admin_board/recruitManage.do">
			← 목록</a>
	</div>

	<!-- 요약 테이블 -->
	<table class="notice-table">
		<tr>
			<th>제목</th>
			<td colspan="3"><c:out value="${event.title}" /></td>
		</tr>
		<tr>
			<th>직무</th>
			<td><c:out value="${event.jobPosition}" /></td>
			<th>모집 인원</th>
			<td><c:out value="${event.recruitCount}" /> 명</td>
		</tr>
		<tr>
			<th>근무 형태</th>
			<td><c:out value="${event.workingType}" /></td>
			<th>근무지</th>
			<td><c:out value="${event.workLocation}" /></td>
		</tr>
		<tr>
			<th>모집 기간</th>
			<td><fmt:formatDate value="${event.startDate}" pattern="yyyy-MM-dd" /> ~ 
				<fmt:formatDate value="${event.endDate}" pattern="yyyy-MM-dd" /></td>
			<th>작성일</th>
			<td><fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd HH:mm" /></td>
		</tr>
		<tr>
			<th>접수 이메일</th>
			<td><c:out value="${event.contactEmail}" /></td>
			<th>연락처</th>
			<td><c:out value="${event.contact}" /></td>
		</tr>
	</table>

	<!-- 본문 정제 -->
	<c:set var="__desc1" value="${event.description}" />
	<c:set var="__desc2" value="${fn:replace(__desc1, '&nbsp;', ' ')}" />
	<c:set var="__desc3" value="${fn:replace(__desc2, '&#160;', ' ')}" />
	<c:set var="__desc4" value="${fn:replace(__desc3, ' ', ' ')}" />
	<c:set var="__desc5" value="${fn:replace(__desc4, '﻿', '')}" />

	<!-- 본문 출력 (공백 없이 시작) -->
	<div class="notice-content"><c:out value="${fn:trim(__desc5)}" escapeXml="false" /></div>

</div>

</body>
</html>
