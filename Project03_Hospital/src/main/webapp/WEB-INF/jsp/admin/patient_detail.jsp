<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>환자 상세정보</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">

</head>
<body>

	<div class="detail-container">
		<h2>환자 상세정보</h2>

		<table class="detail-table">
			<tr>
				<th>이름</th>
				<td>${patient.patientName}</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>${patient.patientUserId}</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>${patient.patientGender}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${patient.patientPhone}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${patient.patientEmail}</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td><fmt:formatDate value="${patient.patientCreatedAt}"
						pattern="yyyy-MM-dd" /></td>
			</tr>
		</table>

		<div class="button-group left">
			<a
				href="${pageContext.request.contextPath}/admin/patientReservations.do?patientNo=${patient.patientNo}"
				class="btn-action btn-view">예약 내역 보기</a> <a
				href="${pageContext.request.contextPath}/admin/patientRecords.do?patientNo=${patient.patientNo}"
				class="btn-action btn-view">진료 기록 보기</a> <a
				href="javascript:history.back();" class="btn-action btn-view">뒤로가기</a>
		</div>
	</div>

</body>
</html>
