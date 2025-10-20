<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입 승인 관리</title>

<!-- 공통 스타일 (캐시버스터 포함) -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css?v=20250812-3">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css?v=20250812-3">

</head>
<body>
	<h2>가입 승인 관리</h2>

	<!-- 카드 메뉴 -->
	<div class="card-container">
		<div class="card"
			onclick="location.href='${pageContext.request.contextPath}/admin/pendingList.do'">
			<h3>승인 대기 목록</h3>
			<p>승인되지 않은 요청 확인</p>
		</div>
		<div class="card"
			onclick="location.href='${pageContext.request.contextPath}/admin/pendingAll.do'">
			<h3>전체 신청 내역</h3>
			<p>승인/반려 포함 전체 보기</p>
		</div>
	</div>

	<!-- 상태 필터 버튼 -->
	<c:if test="${showFilterButtons}">
		<div class="filter-group">
			<form method="get"
				action="${pageContext.request.contextPath}/admin/pendingFilter.do"
				class="inline-form">
				<button type="submit" name="status" value=""
					class="chip chip-blue ${empty param.status ? 'active' : ''}">전체</button>

				<button type="submit" name="status" value="대기"
					class="chip chip-gray ${param.status == '대기' ? 'active' : ''}">대기</button>

				<button type="submit" name="status" value="승인"
					class="chip chip-green ${param.status == '승인' ? 'active' : ''}">승인</button>

				<button type="submit" name="status" value="반려"
					class="chip chip-red ${param.status == '반려' ? 'active' : ''}">반려</button>
			</form>
		</div>
	</c:if>

	<!-- 검색 -->
	<form method="get"
		action="${pageContext.request.contextPath}/admin/searchPendingUsers.do"
		class="search-box">
		<input type="text" name="keyword" placeholder="이름, 아이디 검색" required>
		<button type="submit">검색</button>
	</form>

	<!-- 목록 -->
	<c:if test="${not empty pendingUsers}">
		<table>
			<thead>
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>역할</th>
					<th>상태</th>
					<th>신청일</th>
					<th>처리자</th>
					<th>처리일</th>
					<th>반려 사유</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="user" items="${pendingUsers}">
					<tr>
						<td>${user.userId}</td>
						<td>${user.name}</td>
						<td>${user.role}</td>

						<!-- 상태칩 -->
						<td><c:choose>
								<c:when test="${user.status == '승인'}">
									<span class="chip chip-green">승인</span>
								</c:when>
								<c:when test="${user.status == '반려'}">
									<span class="chip chip-red">반려</span>
								</c:when>
								<c:otherwise>
									<span class="chip chip-gray">대기</span>
								</c:otherwise>
							</c:choose></td>

						<td><fmt:formatDate value="${user.appliedAt}"
								pattern="yyyy-MM-dd" /></td>
						<td>${empty user.reviewerName ? '-' : user.reviewerName}</td>
						<td><fmt:formatDate value="${user.reviewedAt}"
								pattern="yyyy-MM-dd HH:mm" /></td>

						<!-- 반려 사유 툴팁 -->
						<td><c:if test="${user.status == '반려'}">
								<span class="reject-reason"
									title="${fn:escapeXml(user.rejectReason)}"> <c:out
										value="${user.rejectReason}" />
								</span>
							</c:if></td>

						<!-- 액션 -->
						<td><c:choose>
								<c:when test="${user.status == '대기'}">
									<form method="post"
										action="${pageContext.request.contextPath}/admin/approveUser.do"
										class="inline-form">
										<input type="hidden" name="userId" value="${user.userId}">
										<button type="submit" class="btn-action btn-save">승인</button>
									</form>

									<button type="button" class="btn-action btn-delete"
										onclick="rejectWithReason('${user.userId}')">반려</button>
								</c:when>

								<c:otherwise>
									<c:if test="${user.status == '반려'}">
										<form method="post"
											action="${pageContext.request.contextPath}/admin/undoStatus.do"
											class="inline-form">
											<input type="hidden" name="userId" value="${user.userId}">
											<button type="submit" class="btn-action btn-undo"
												onclick="return confirm('대기 상태로 되돌리시겠습니까?')">대기로 전환</button>

										</form>
									</c:if>
								</c:otherwise>
							</c:choose></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>

	<script>
		function rejectWithReason(userId) {
			const raw = prompt("반려 사유를 입력하세요:");
			if (raw === null)
				return; // 취소 눌렀을 때
			const reason = raw.trim();
			if (!reason)
				return; // 공백만 입력 시 무시

			// 미리 만들어둔 숨김 폼에 값 채우고 제출
			document.getElementById('rejectUserId').value = userId;
			document.getElementById('rejectReason').value = reason;
			document.getElementById('rejectForm').submit();
		}
	</script>

	<form id="rejectForm" method="post"
		action="${pageContext.request.contextPath}/admin/rejectUser.do"
		style="display: none">
		<input type="hidden" name="userId" id="rejectUserId"> <input
			type="hidden" name="rejectReason" id="rejectReason">
	</form>
</body>
</html>
