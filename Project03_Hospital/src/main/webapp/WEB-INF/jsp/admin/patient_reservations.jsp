<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>환자 예약 내역</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
</head>
<body>

	<h2>환자 예약 내역</h2>

	<table class="detail-table">
		<thead>
			<tr>
				<th>예약 ID</th>
				<th>예약일</th>
				<th>시간</th>
				<th>의사</th>
				<th>진료과</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="reservation" items="${reservationList}">
				<tr>
					<td>${reservation.reservationId}</td>
					<td><fmt:formatDate value="${reservation.reservationDate}"
							pattern="yyyy-MM-dd" /></td>
					<td>${reservation.scheduleTime}</td>
					<td>${reservation.doctorName}</td>
					<td>${reservation.departmentName}</td>
					<td>${reservation.status}</td>
				</tr>
			</c:forEach>
			<c:if test="${empty reservationList}">
				<tr>
					<td colspan="6">예약 내역이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

	<div class="button-group left">
		<a href="javascript:history.back();" class="btn-action btn-view">뒤로가기</a>
	</div>

</body>
</html>
