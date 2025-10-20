<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>협진 내역</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
</head>
<body>

	<div class="detail-container">
		<h2>협진 요청 목록</h2>

		<!-- 상단 액션: 
       - 관리자: coopUserId/coopHospitalId가 있을 때만 등록 버튼 노출(컨트롤러에서 필수이므로)
       - 협력의(일반 사용자): 파라미터 없이 폼 진입 허용 -->
		<div class="button-group left">
			<c:if
				test="${not empty sessionScope.loginAdmin && not empty coopUserId && not empty coopHospitalId}">
				<a class="btn-action btn-save"
					href="<c:url value='/referral/referralForm.do'>
                  <c:param name='coopUserId' value='${coopUserId}'/>
                  <c:param name='coopHospitalId' value='${coopHospitalId}'/>
               </c:url>">협진
					요청 등록</a>
			</c:if>

			<c:if
				test="${not empty sessionScope.loginUser && sessionScope.loginUser.role == 'coop'}">
				<a class="btn-action btn-save"
					href="<c:url value='/referral/referralForm.do'/>">협진 요청 등록</a>
			</c:if>
		</div>

		<!-- 필터 -->
		<form action="<c:url value='/referral/filterCoopLog.do'/>"
			method="get" class="search-box">
			<select name="status">
				<option value="" ${empty param.status ? 'selected' : ''}>전체</option>
				<option value="접수" ${param.status == '접수'  ? 'selected' : ''}>접수</option>
				<option value="완료" ${param.status == '완료'  ? 'selected' : ''}>완료</option>
				<option value="거절" ${param.status == '거절'  ? 'selected' : ''}>거절</option>
			</select>
			<button type="submit" class="btn">조회</button>
		</form>

		<!-- 목록 -->
		<table>
			<thead>
				<tr>
					<th>요청 ID</th>
					<th>의뢰자</th>
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
					<tr>
						<td>${r.requestId}</td>
						<td>${r.userId}</td>
						<td>${r.patientName}</td>
						<td>${r.contact}</td>
						<td>${r.departmentName}</td>
						<td>${r.doctorId}</td>
						<td><fmt:formatDate value="${r.hopeDate}"
								pattern="yyyy-MM-dd" /></td>

						<td><c:choose>
								<c:when test="${r.status == '완료'}">
									<span class="chip chip-green">완료</span>
								</c:when>
								<c:when test="${r.status == '접수'}">
									<span class="chip chip-gray">접수</span>
								</c:when>
								<c:otherwise>
									<span class="chip chip-red">${r.status}</span>
								</c:otherwise>
							</c:choose></td>

						<td><fmt:formatDate value="${r.createdAt}"
								pattern="yyyy-MM-dd" /></td>
						<td><a class="btn-action btn-view"
							href="<c:url value='/referral/referralDetail.do'>
                        <c:param name='requestId' value='${r.requestId}'/>
                     </c:url>">상세</a>
						</td>
					</tr>
				</c:forEach>

				<c:if test="${empty referrals}">
					<tr>
						<td colspan="10">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

</body>
</html>
