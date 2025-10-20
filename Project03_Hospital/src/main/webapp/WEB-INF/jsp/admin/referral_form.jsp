<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>협진 요청 등록</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function() {
		$('#deptId')
				.change(
						function() {
							const deptId = $(this).val();
							if (!deptId) {
								$('#doctorId').html(
										'<option value="">선택</option>');
								return;
							}

							$
									.ajax({
										url : '<c:url value="/admin/getDoctorsByDept.do" />',
										method : 'GET',
										data : {
											deptId : deptId
										},
										dataType : 'json',
										success : function(doctors) {
											let options = '<option value="">선택</option>';
											(doctors || [])
													.forEach(function(d) {
														options += '<option value="' + d.doctorId + '">'
																+ d.name
																+ '</option>';
													});
											$('#doctorId').html(options);
										},
										error : function(xhr, status, error) {
											alert('의사 목록을 불러오는 데 실패했습니다.');
											console.log("error:", error);
											console.log("response:",
													xhr.responseText);
										}
									});
						});
	});
</script>
</head>
<body>

	<div class="detail-container">
		<h2>협진 요청 등록</h2>

		<!-- 메시지 -->
		<c:if test="${not empty error}">
			<p style="color: #d33;">${error}</p>
		</c:if>
		<c:if test="${not empty message}">
			<p style="color: #2a7;">${message}</p>
		</c:if>

		<!-- 관리자 진입 시 필요한 파라미터를 숨겨서 전달 -->
		<form action="<c:url value='/referral/submit.do'/>" method="post">
			<c:if test="${not empty sessionScope.loginAdmin}">
				<input type="hidden" name="coopUserId" value="${coopUserId}">
				<input type="hidden" name="coopHospitalId" value="${coopHospitalId}">
			</c:if>

			<table class="detail-table">
				<tbody>
					<tr>
						<th>환자명</th>
						<td><input type="text" name="patientName" required></td>
					</tr>
					<tr>
						<th>주민등록번호</th>
						<td><input type="text" name="rrn" required></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><input type="text" name="contact" required></td>
					</tr>
					<tr>
						<th>진료과</th>
						<td><select id="deptId" name="department" required>
								<option value="">선택</option>
								<c:forEach var="dept" items="${deptList}">
									<option value="${dept.deptId}">${dept.name}</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<th>희망 진료일</th>
						<td><input type="date" name="hopeDate" required></td>
					</tr>
					<tr>
						<th>담당의사</th>
						<td><select id="doctorId" name="doctorId">
								<option value="">선택</option>
						</select></td>
					</tr>
					<tr>
						<th>증상</th>
						<td><textarea name="symptoms" rows="3" cols="50" required></textarea></td>
					</tr>
					<tr>
						<th>의뢰사유</th>
						<td><textarea name="reason" rows="3" cols="50" required></textarea></td>
					</tr>
				</tbody>
			</table>

			<div class="button-group left" style="margin-top: 12px;">
				<button type="submit" class="btn-action btn-save">등록</button>
				<a href="javascript:history.back();" class="btn-action btn-view">←
					취소</a>
			</div>
		</form>
	</div>

</body>
</html>
