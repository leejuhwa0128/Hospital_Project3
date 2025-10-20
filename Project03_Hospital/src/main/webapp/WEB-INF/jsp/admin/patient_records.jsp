<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>환자 진료 기록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
</head>
<body>

	<div class="detail-container">
		<h2>환자 진료 기록</h2>

		<table class="detail-table">
			<thead>
				<tr>
					<th>기록 ID</th>
					<th>진료일</th>
					<th>의사</th>
					<th>진료과</th>
					<th>진단명</th>
					<th>치료 내용</th>
					<th>처방전</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="record" items="${recordList}">
					<tr>
						<td>${record.recordId}</td>
						<td><fmt:formatDate value="${record.recordDate}"
								pattern="yyyy-MM-dd" /></td>
						<td>${record.doctorName}</td>
						<td>${record.departmentName}</td>
						<td>${record.diagnosis}</td>
						<td>${record.treatment}</td>
						<td>${record.prescription}</td>
					</tr>
				</c:forEach>
				<c:if test="${empty recordList}">
					<tr>
						<td colspan="7">진료 기록이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<div class="button-group left">
			<a href="javascript:history.back();" class="btn-action btn-view">뒤로가기</a>
		</div>
	</div>

</body>
</html>
