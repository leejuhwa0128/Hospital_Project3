<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>🎓 강좌 및 행사 관리</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css?v=2">
</head>
<body>

	<h2>🎓 강좌 및 행사 관리</h2>

	<div class="con_wrap bg_13">

		<!-- 카테고리 필터 버튼 -->
		<div class="filter-group" style="margin-bottom: 16px;">
			<a href="?category=전체"
				class="chip ${currentCategory == '전체' ? 'active' : 'chip-gray'}">전체</a>
			<a href="?category=강좌"
				class="chip ${currentCategory == '강좌' ? 'active' : 'chip-gray'}">강좌</a>
			<a href="?category=교육"
				class="chip ${currentCategory == '교육' ? 'active' : 'chip-gray'}">교육</a>
			<a href="?category=행사"
				class="chip ${currentCategory == '행사' ? 'active' : 'chip-gray'}">행사</a>
			<a href="?category=기타"
				class="chip ${currentCategory == '기타' ? 'active' : 'chip-gray'}">기타</a>
		</div>

		<!-- 상단 버튼 -->
		<div class="top_btns" style="margin-bottom: 16px;">
			<a href="${pageContext.request.contextPath}/01_lecture/list.do"
				target="_blank" class="btn btn-view">👁 홈페이지 이동</a> <a
				href="lecture_writeForm.do" class="btn btn-save">+ 새 글 등록</a>
		</div>

		<!-- 목록 테이블 -->
		<div class="board_list">
			<table class="detail-table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>카테고리</th>
						<th>일정</th>
						<th>작성일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${lectureList}" varStatus="i">
						<tr>
							<td>${i.count}</td>
							<td>${item.title}</td>
							<td>${item.category}</td>
							<td><c:choose>
									<c:when
										test="${not empty item.startDateStr && not empty item.endDateStr}">
                  ${item.startDateStr} ~ ${item.endDateStr}
                </c:when>
									<c:otherwise>${item.eventDateStr}</c:otherwise>
								</c:choose></td>
							<td>${item.createdAtStr}</td>
							<td class="actions"><a class="btn-action btn-view"
								href="lecture_view.do?eventId=${item.eventId}">상세</a> <a
								class="btn-action btn-save"
								href="lecture_editForm.do?eventId=${item.eventId}">수정</a> <a
								class="btn-action btn-delete"
								href="lecture_delete.do?eventId=${item.eventId}"
								onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a></td>
						</tr>
					</c:forEach>
					<c:if test="${empty lectureList}">
						<tr>
							<td colspan="6" style="text-align: center; padding: 20px;">등록된
								강좌 및 행사가 없습니다.</td>
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
				<c:set var="displayCount" value="10" />
				<c:set var="end" value="${tp lt displayCount ? tp : displayCount}" />

				<c:choose>
					<c:when test="${cp == 1}">
						<span class="page-btn disabled">« 처음</span>
					</c:when>
					<c:otherwise>
						<a class="page-btn"
							href="${pageContext.request.contextPath}/admin_board/lectureManage.do?page=1">«
							처음</a>
					</c:otherwise>
				</c:choose>

				<c:forEach var="i" begin="1" end="${end}">
					<c:choose>
						<c:when test="${i == cp}">
							<span class="page-btn active">${i}</span>
						</c:when>
						<c:otherwise>
							<a class="page-btn"
								href="${pageContext.request.contextPath}/admin_board/lectureManage.do?page=${i}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:choose>
					<c:when test="${cp == tp}">
						<span class="page-btn disabled">끝 »</span>
					</c:when>
					<c:otherwise>
						<a class="page-btn"
							href="${pageContext.request.contextPath}/admin_board/lectureManage.do?page=${tp}">끝
							»</a>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>

	</div>

</body>
</html>
