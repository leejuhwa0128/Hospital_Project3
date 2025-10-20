<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>의료진 공지사항 관리</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css?v=2">
</head>
<body>
	<h2>의료진 공지사항 관리</h2>

	<div class="con_wrap bg_13">

		<!-- 상단 버튼 -->
		<div class="top_btns" style="margin-bottom: 16px;">
			<a
				href="${pageContext.request.contextPath}/admin_board/medicalNoticeWriteForm.do"
				class="btn btn-save">+ 새 글 등록</a>
		</div>

		<!-- 목록 테이블 -->
		<div class="board_list">
			<table class="detail-table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="notice" items="${notices}" varStatus="status">
						<tr>
							<td><c:choose>
									<c:when test="${not empty totalCount}">
                  ${totalCount - ((page - 1) * pageSize + status.index)}
                </c:when>
									<c:otherwise>
                  ${status.index + 1}
                </c:otherwise>
								</c:choose></td>
							<td><c:out value="${notice.title}" /></td>
							<td>${notice.adminName}</td>
							<td><fmt:formatDate value="${notice.createdAt}"
									pattern="yyyy-MM-dd" /></td>
							<td class="actions"><a class="btn-action btn-view"
								href="${pageContext.request.contextPath}/admin_board/medicalNoticeView.do?noticeId=${notice.noticeId}">상세</a>
								<a class="btn-action btn-save"
								href="${pageContext.request.contextPath}/admin_board/medicalNoticeEditForm.do?noticeId=${notice.noticeId}">수정</a>
								<form
									action="${pageContext.request.contextPath}/admin_board/medicalNoticeDelete.do"
									method="post" class="inline-form"
									onsubmit="return confirm('삭제하시겠습니까?')">
									<input type="hidden" name="noticeId" value="${notice.noticeId}">
									<button type="submit" class="btn-action btn-delete">삭제</button>
								</form></td>
						</tr>
					</c:forEach>

					<c:if test="${empty notices}">
						<tr>
							<td colspan="5" style="text-align: center; padding: 20px;">등록된
								의료진 공지사항이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<!-- 페이징 -->
		<div class="pagination">
			<c:if test="${totalCount > pageSize}">
				<c:set var="pageCount"
					value="${(totalCount + pageSize - 1) / pageSize}" />
				<c:forEach begin="1" end="${pageCount}" var="i">
					<c:url var="pageUrl" value="/admin_board/medicalNoticeManage.do">
						<c:param name="page" value="${i}" />
					</c:url>
					<a href="${pageUrl}" class="page-btn ${page == i ? 'active' : ''}">${i}</a>
				</c:forEach>
			</c:if>
		</div>

	</div>

</body>
</html>
