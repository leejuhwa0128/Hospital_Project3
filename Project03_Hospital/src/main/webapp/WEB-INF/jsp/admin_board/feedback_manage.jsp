<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>🗣 고객의 소리 관리</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css?v=2">
</head>
<body>
	<h2>🗣 고객의 소리 관리</h2>

	<div class="con_wrap bg_13">

		<!-- 상단 버튼 -->
		<div class="top_btns" style="margin-bottom: 16px;">
			<a href="${pageContext.request.contextPath}/03_feedback/list.do"
				target="_blank" class="btn btn-view">👁 홈페이지 이동</a>
		</div>

		<!-- 필터 버튼 (카테고리 + 상태) -->
		<div class="top_btns" style="margin-bottom: 24px;">
			<!-- 카테고리 -->
			<div class="filter-group" style="margin-bottom: 10px;">
				<a href="${baseUrl}?category="
					class="${empty curCategory ? 'chip active' : 'chip chip-gray'}">전체</a>
				<a href="${baseUrl}?category=칭찬"
					class="${curCategory == '칭찬' ? 'chip active' : 'chip chip-gray'}">칭찬</a>
				<a href="${baseUrl}?category=불만"
					class="${curCategory == '불만' ? 'chip active' : 'chip chip-gray'}">불만</a>
				<a href="${baseUrl}?category=제안"
					class="${curCategory == '제안' ? 'chip active' : 'chip chip-gray'}">제안</a>
				<a href="${baseUrl}?category=문의"
					class="${curCategory == '문의' ? 'chip active' : 'chip chip-gray'}">문의</a>
				<a href="${baseUrl}?category=기타"
					class="${curCategory == '기타' ? 'chip active' : 'chip chip-gray'}">기타</a>
			</div>
			<!-- 상태 필터 -->
			<div class="filter-group" style="margin-top: 6px;">
				<a href="${baseUrl}?category=${fn:escapeXml(curCategory)}&status=접수"
					class="chip-blue ${curStatus eq '접수' ? 'active' : ''}">미완료</a> <a
					href="${baseUrl}?category=${fn:escapeXml(curCategory)}&status=답변완료"
					class="chip-blue ${curStatus eq '답변완료' ? 'active' : ''}">완료</a>
			</div>
		</div>

		<!-- 목록 -->
		<div class="board_list">
			<table class="detail-table">
				<thead>
					<tr>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성일</th>
						<th>상태</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="feedback" items="${feedbackList}">
						<tr>
							<td>${feedback.rowNumber}</td>
							<td>${feedback.category}</td>
							<td>${feedback.title}</td>
							<td><fmt:formatDate value="${feedback.createdAt}"
									pattern="yyyy.MM.dd" /></td>
							<td><c:choose>
									<c:when test="${feedback.status eq '답변완료'}">
										<span style="color: green;">✅ 완료</span>
									</c:when>
									<c:otherwise>
										<span style="color: red;">❌ 미완료</span>
									</c:otherwise>
								</c:choose></td>
							<td class="actions"><a class="btn-action btn-view"
								href="${pageContext.request.contextPath}/admin_board/feedbackView.do?feedbackId=${feedback.feedbackId}">상세</a>
								<a class="btn-action btn-save"
								href="${pageContext.request.contextPath}/admin_board/editReplyForm.do?feedbackId=${feedback.feedbackId}">수정</a>
								<a class="btn-action btn-delete"
								href="${pageContext.request.contextPath}/admin_board/deleteReply.do?feedbackId=${feedback.feedbackId}"
								onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a></td>
						</tr>
					</c:forEach>

					<c:if test="${empty feedbackList}">
						<tr>
							<td colspan="6"
								style="text-align: center; padding: 20px; color: #999;">등록된
								글이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<!-- 페이징 -->
		<c:if test="${totalPages > 1}">
			<div class="pagination">
				<c:set var="cp" value="${currentPage}" />
				<c:set var="tp" value="${totalPages}" />

				<c:forEach var="i" begin="1" end="${tp}">
					<c:url var="pageUrl" value="/admin_board/feedbackManage.do">
						<c:param name="page" value="${i}" />
						<c:param name="category" value="${curCategory}" />
						<c:param name="status" value="${curStatus}" />
					</c:url>
					<a href="${pageUrl}" class="page-btn ${cp == i ? 'active' : ''}">${i}</a>
				</c:forEach>
			</div>
		</c:if>

	</div>
</body>
</html>
