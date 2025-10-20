<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>전체 협진 요청 내역</title>

<!-- 공통 스타일 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css">
</head>
<body>

	<div class="detail-container">
		<h2>전체 협진 요청 내역</h2>

		<!-- 필터/검색 -->
		<form action="<c:url value='/admin/allReferrals.do'/>" method="get"
			class="search-box">
			<select name="status">
				<option value="" ${empty param.status ? 'selected' : ''}>전체</option>
				<option value="접수" ${param.status == '접수' ? 'selected' : ''}>접수</option>
				<option value="완료" ${param.status == '완료' ? 'selected' : ''}>완료</option>
				<option value="회신완료" ${param.status == '회신완료' ? 'selected' : ''}>회신완료</option>
				<option value="거절" ${param.status == '거절' ? 'selected' : ''}>거절</option>
			</select> <select name="sort">
				<option value="created_at"
					${param.sort == 'created_at' ? 'selected' : ''}>요청일순</option>
				<option value="hope_date"
					${param.sort == 'hope_date'  ? 'selected' : ''}>희망일순</option>
			</select> <select name="order">
				<option value="desc" ${param.order == 'desc' ? 'selected' : ''}>내림차순</option>
				<option value="asc" ${param.order == 'asc'  ? 'selected' : ''}>오름차순</option>
			</select> <input type="text" name="keyword" placeholder="협력의 ID/이름 또는 병원명"
				value="${param.keyword}">
			<button type="submit" class="btn-action btn-view">조회</button>
		</form>

		<!-- 우측 액션 -->
		<div class="button-group right" style="margin-bottom: 10px;">
			<form method="get"
				action="${pageContext.request.contextPath}/admin/exportReferralsExcel.do"
				class="inline-form">
				<button type="submit" class="btn-action btn-view">엑셀 다운로드</button>
			</form>
		</div>

		<!-- 목록 -->
		<table class="data-table">
			<thead>
				<tr>
					<th>요청 ID</th>
					<th>의뢰자 ID</th>
					<th>협력의 이름</th>
					<th>병원명</th>
					<th>환자명</th>
					<th>연락처</th>
					<th>진료과</th>
					<th>담당의사</th>
					<th>희망일</th>
					<th>상태</th>
					<th>요청일</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="r" items="${referrals}">
					<!-- 상세 URL 안전 생성 -->
					<c:url var="detailUrl" value="/referral/referralDetail.do">
						<c:param name="requestId" value="${r.requestId}" />
					</c:url>

					<tr>
						<td>${r.requestId}</td>
						<td>${r.userId}</td>
						<td>${r.userName}</td>
						<td>${r.hospitalName}</td>
						<td>${r.patientName}</td>
						<td>${r.contact}</td>
						<td>${r.departmentName}</td>
						<td>${r.doctorId}</td>
						<td><fmt:formatDate value="${r.hopeDate}"
								pattern="yyyy-MM-dd" /></td>

						<!-- 상태 칩 -->
						<td><c:choose>
								<c:when test="${r.status == '접수'}">
									<span class="chip chip-gray">접수</span>
								</c:when>
								<c:when test="${r.status == '완료'}">
									<span class="chip chip-green">완료</span>
								</c:when>
								<c:when test="${r.status == '회신완료'}">
									<span class="chip chip-green">회신완료</span>
								</c:when>
								<c:when test="${r.status == '거절'}">
									<span class="chip chip-red">거절</span>
								</c:when>
								<c:otherwise>
									<span class="chip chip-gray">${r.status}</span>
								</c:otherwise>
							</c:choose></td>

						<td><fmt:formatDate value="${r.createdAt}"
								pattern="yyyy-MM-dd" /></td>

						<td class="actions"><a class="btn-action btn-view"
							href="${detailUrl}">상세</a></td>
					</tr>
				</c:forEach>

				<c:if test="${empty referrals}">
					<tr>
						<td colspan="12">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

</body>
</html>
