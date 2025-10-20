<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료진 공지사항 상세보기</title>

<!-- 공통 스타일 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css">

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
		<div class="button-group"
			style="margin-bottom: 24px; display: flex; justify-content: flex-end; gap: 6px;">
			<a
				href="<c:url value='/admin_board/medicalNoticeEditForm.do'/>?noticeId=${notice.noticeId}"
				class="btn-action btn-save">수정</a> <a
				href="<c:url value='/admin_board/medicalNoticeDelete.do'/>?noticeId=${notice.noticeId}"
				onclick="return confirm('삭제하시겠습니까?')" class="btn-action btn-delete">삭제</a>

			<a href="<c:url value='/admin_board/medicalNoticeManage.do'/>"
				class="btn-action btn-view">← 목록</a>
		</div>

		<!-- 요약 테이블 -->
		<table class="notice-table">
			<tr>
				<th>제목</th>
				<td colspan="3"><c:out value="${notice.title}" /></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><c:out value="${notice.adminName}" /></td>
				<th>등록일</th>
				<td><fmt:formatDate value="${notice.createdAt}"
						pattern="yyyy-MM-dd" /></td>
			</tr>
		</table>

		<!-- 본문 -->
		<div class="notice-content"><c:out value="${notice.content}" escapeXml="false" /></div>


	</div>

</body>
</html>
