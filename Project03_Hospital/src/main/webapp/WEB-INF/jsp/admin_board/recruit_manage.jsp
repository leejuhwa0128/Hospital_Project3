<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채용공고 관리</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css?v=2">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css?v=2">
<!-- v=2 꼭 적용 -->

<style>
/* 필터 chip 강조 색상 */
.chip.active {
	background: #4a2d2d !important;
	color: #ffffff !important;
}

.chip-gray {
	background: #e5e7eb !important;
	color: #1f2937 !important;
}

.chip-gray:hover {
	background: #d1d5db !important;
}
</style>
</head>
<body>
	<h2>채용공고 관리</h2>
	<div class="con_wrap bg_13">

		<!-- ✅ 필터 버튼 -->
		<div class="filter-group">
			<c:url var="allUrl" value="/admin_board/recruitManage.do">
				<c:param name="job" value="all" />
			</c:url>
			<c:url var="docUrl" value="/admin_board/recruitManage.do">
				<c:param name="job" value="의사직" />
			</c:url>
			<c:url var="nurseUrl" value="/admin_board/recruitManage.do">
				<c:param name="job" value="간호사직" />
			</c:url>
			<c:url var="techUrl" value="/admin_board/recruitManage.do">
				<c:param name="job" value="의료기사직" />
			</c:url>
			<c:url var="supportUrl" value="/admin_board/recruitManage.do">
				<c:param name="job" value="의료지원직" />
			</c:url>

			<a href="${allUrl}"
				class="chip ${empty job || job == 'all' ? 'active' : 'chip-gray'}">전체</a>
			<a href="${docUrl}"
				class="chip ${job == '의사직' ? 'active' : 'chip-gray'}">의사직</a> <a
				href="${nurseUrl}"
				class="chip ${job == '간호사직' ? 'active' : 'chip-gray'}">간호사직</a> <a
				href="${techUrl}"
				class="chip ${job == '의료기사직' ? 'active' : 'chip-gray'}">의료기사직</a> <a
				href="${supportUrl}"
				class="chip ${job == '의료지원직' ? 'active' : 'chip-gray'}">의료지원직</a>
		</div>

		<!-- 상단 등록 버튼 -->
		<div class="top_btns" style="margin-bottom: 16px;">
			<a
				href="${pageContext.request.contextPath}/admin_board/recruit_writeForm.do"
				class="btn btn-save">+ 새 글 등록</a>
		</div>

		<!-- 채용공고 표 -->
		<div class="board_list">
			<table class="detail-table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>직무</th>
						<th>목집기간</th>
						<th>작성일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="event" items="${events}" varStatus="status">
						<tr>
							<td><c:choose>
									<c:when test="${not empty totalCount}">
									${totalCount - ((page - 1) * pageSize + status.index)}
								</c:when>
									<c:otherwise>
									${status.index + 1}
								</c:otherwise>
								</c:choose></td>
							<td>${event.title}</td>
							<td>${event.subCategory}</td>
							<td><fmt:formatDate value="${event.startDate}"
									pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
									value="${event.endDate}" pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${event.createdAt}"
									pattern="yyyy-MM-dd" /></td>
							<td class="actions"><a class="btn-action btn-view"
								href="${pageContext.request.contextPath}/admin_board/recruit_view.do?eventId=${event.eventId}">상세</a>
								<a class="btn-action btn-save"
								href="${pageContext.request.contextPath}/admin_board/recruit_editForm.do?eventId=${event.eventId}">수정</a>
								<a class="btn-action btn-delete"
								href="${pageContext.request.contextPath}/admin_board/recruit_delete.do?eventId=${event.eventId}"
								onclick="return confirm('삭제하시겠습니까?')">삭제</a></td>
						</tr>
					</c:forEach>

					<c:if test="${empty events}">
						<tr>
							<td colspan="7" style="text-align: center; padding: 20px;">등록된
								채용공고가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<!-- ✅ 페이징 버튼 -->
		<div class="pagination">
			<c:if test="${totalCount > pageSize}">
				<c:set var="pageCount"
					value="${(totalCount + pageSize - 1) / pageSize}" />
				<c:forEach begin="1" end="${pageCount}" var="i">
					<c:url var="pageUrl" value="/admin_board/recruitManage.do">
						<c:param name="page" value="${i}" />
						<c:if test="${not empty job}">
							<c:param name="job" value="${job}" />
						</c:if>
					</c:url>

					<a href="${pageUrl}" class="page-btn ${page == i ? 'active' : ''}">${i}</a>
				</c:forEach>
			</c:if>
		</div>

	</div>
</body>
</html>
