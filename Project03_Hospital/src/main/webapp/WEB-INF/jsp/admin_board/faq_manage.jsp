<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>❓ FAQ 관리</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css?v=3">
</head>
<body>

	<h2>❓ FAQ 관리</h2>

	<div class="con_wrap bg_13">

		<!-- 카테고리 필터 -->
		<div class="top_btns" style="margin-bottom: 16px;">
			<div class="filter-group">
				<a href="?category="
					class="chip ${empty category ? 'active' : 'chip-gray'}">전체</a> <a
					href="?category=진료예약"
					class="chip ${category == '진료예약' ? 'active' : 'chip-gray'}">진료예약</a>
				<a href="?category=외래진료"
					class="chip ${category == '외래진료' ? 'active' : 'chip-gray'}">외래진료</a>
				<a href="?category=입퇴원"
					class="chip ${category == '입퇴원' ? 'active' : 'chip-gray'}">입퇴원</a>
				<a href="?category=서류발급"
					class="chip ${category == '서류발급' ? 'active' : 'chip-gray'}">서류발급</a>
				<a href="?category=병원안내"
					class="chip ${category == '병원안내' ? 'active' : 'chip-gray'}">병원안내</a>
				<a href="?category=기타"
					class="chip ${category == '기타' ? 'active' : 'chip-gray'}">기타</a>
			</div>

			<div class="button-group" style="margin-top: 10px;">
				<a class="btn btn-view"
					href="${pageContext.request.contextPath}/01_faqList.do"
					target="_blank">👁 홈페이지 이동</a> <a class="btn btn-save"
					href="faq_writeForm.do">+ 새 글 등록</a>
			</div>
		</div>

		<!-- 목록 테이블 -->
		<table class="detail-table">
			<thead>
				<tr>
					<th>번호</th>
					<th>카테고리</th>
					<th>질문</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="faq" items="${faqList}" varStatus="vs">
					<tr>
						<td>${vs.count}</td>
						<td>${faq.category}</td>
						<td>${faq.question}</td>
						<td class="actions"><a class="btn-action btn-view"
							href="${pageContext.request.contextPath}/admin_board/faq_view.do?faqId=${faq.faqId}">상세</a>
							<a class="btn-action btn-save"
							href="${pageContext.request.contextPath}/admin_board/faq_editForm.do?faqId=${faq.faqId}">수정</a>
							<a class="btn-action btn-delete"
							href="${pageContext.request.contextPath}/admin_board/faq_delete.do?faqId=${faq.faqId}"
							onclick="return confirm('삭제하시겠습니까?')">삭제</a></td>
					</tr>
				</c:forEach>

				<c:if test="${empty faqList}">
					<tr>
						<td colspan="4" style="text-align: center; padding: 20px;">등록된
							FAQ가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<!-- 페이징 -->
		<c:if test="${totalPages > 1}">
			<div class="pagination" style="margin-top: 16px; text-align: center;">
				<c:choose>
					<c:when test="${currentPage == 1}">
						<span class="page disabled">« 처음</span>
					</c:when>
					<c:otherwise>
						<a class="page"
							href="${pageContext.request.contextPath}/admin_board/faqManage.do?page=1">«
							처음</a>
					</c:otherwise>
				</c:choose>

				<c:set var="end" value="${totalPages lt 10 ? totalPages : 10}" />
				<c:forEach var="i" begin="1" end="${end}">
					<c:choose>
						<c:when test="${i == currentPage}">
							<span class="current">${i}</span>
						</c:when>
						<c:otherwise>
							<a class="page"
								href="${pageContext.request.contextPath}/admin_board/faqManage.do?page=${i}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:choose>
					<c:when test="${currentPage == totalPages}">
						<span class="page disabled">끝 »</span>
					</c:when>
					<c:otherwise>
						<a class="page"
							href="${pageContext.request.contextPath}/admin_board/faqManage.do?page=${totalPages}">끝
							»</a>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>

	</div>

</body>
</html>
