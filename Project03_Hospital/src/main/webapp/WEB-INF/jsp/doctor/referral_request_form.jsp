<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>협진 요청서 작성</title>
<!-- Bootstrap 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>


<body class="bg-light">

	<div class="container my-5">
		<div class="card shadow-sm">
			<div class="card-header bg-primary text-white fw-bold">협진 요청서
				작성</div>
			<div class="card-body">
				<form method="post"
					action="${pageContext.request.contextPath}/referral2/submitRequest.do"
					class="row g-2">

					<!-- 환자 정보 -->
					<div class="col-md-6 form-floating">
						<input type="text" name="patientName"
							value="${requestVO.patientName}" class="form-control" readonly>
						<label>환자명</label>
					</div>
					<div class="col-md-6 form-floating">
						<input type="text" name="rrn" value="${requestVO.rrn}"
							class="form-control" readonly> <label>주민번호</label>
					</div>
					<div class="col-md-6 form-floating">
						<input type="text" name="contact" value="${requestVO.contact}"
							class="form-control" readonly> <label>연락처</label>
					</div>
					<div class="col-md-6 form-floating">
						<select name="departmentId" class="form-select">
							<option value="">-- 진료과 선택 --</option>
							<c:forEach var="dept" items="${departments}">
								<option value="${dept.deptId}"
									<c:if test="${requestVO.departmentId eq dept.deptId}">selected</c:if>>
									<c:out value="${dept.name}" />
								</option>
							</c:forEach>
						</select><label>진료과</label>
					</div>

					<!-- 협진 대상 -->
					<div class="col-md-6 form-floating">
						<select id="hospitalSelect" class="form-select" required>
							<option value="">-- 병원 선택 --</option>
							<c:forEach var="h" items="${hospitals}">
								<option value="${h.hospitalId}">${h.name}</option>
							</c:forEach>
						</select> <label>협진 병원</label>
					</div>
					<div class="col-md-6 form-floating">
						<select id="doctorSelect" class="form-select" required>
							<option value="">-- 병원 선택 먼저 --</option>
						</select> <label>협진 의사</label>
					</div>

					<!-- 추가 입력 -->
					<div class="col-md-6 form-floating">
						<input type="date" name="hopeDate" class="form-control"> <label>희망
							날짜</label>
					</div>
					<div class="col-12 form-floating">
						<textarea name="symptoms" rows="3" class="form-control"
							style="height: 100px"></textarea>
						<label>증상</label>
					</div>
					<div class="col-12 form-floating">
						<textarea name="reason" rows="3" class="form-control"
							style="height: 100px"></textarea>
						<label>협진 사유</label>
					</div>

					<!-- 숨겨진 필드 -->
					<input type="hidden" name="doctorId" value="${loginUser.userId}" />
					<input type="hidden" name="userId" id="selectedUserId" /> <input
						type="hidden" name="hospitalId" id="selectedHospitalId" /> <input
						type="hidden" name="recordId" value="${requestVO.recordId}" />

					<!-- 버튼 -->
					<div class="col-12 text-end mt-3">
						<button type="submit" class="btn btn-primary px-4">협진 요청
							등록</button>
					</div>
				</form>

			</div>
		</div>
	</div>

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<!-- AJAX 스크립트 -->
	<script>
		$(document)
				.ready(
						function() {
							$('#hospitalSelect')
									.change(
											function() {
												const hospitalId = $(this)
														.val();
												$('#selectedHospitalId').val(
														hospitalId);

												if (hospitalId) {
													$
															.ajax({
																url : "${pageContext.request.contextPath}/referral2/doctors.do",
																type : "GET",
																data : {
																	hospitalId : hospitalId
																},
																dataType : "json",
																success : function(
																		doctors) {
																	const $doctorSelect = $('#doctorSelect');
																	$doctorSelect
																			.empty();
																	$doctorSelect
																			.append('<option value="">-- 의사 선택 --</option>');
																	$
																			.each(
																					doctors,
																					function(
																							index,
																							doctor) {
																						$doctorSelect
																								.append('<option value="' + doctor.userId + '">'
																										+ doctor.name
																										+ '</option>');
																					});
																},
																error : function() {
																	alert("의사 정보를 불러오는 데 실패했습니다.");
																}
															});
												} else {
													$('#doctorSelect')
															.html(
																	'<option value="">-- 병원 선택 먼저 --</option>');
												}
											});

							$('#doctorSelect').change(function() {
								const selectedUserId = $(this).val();
								$('#selectedUserId').val(selectedUserId);
							});
						});
	</script>

</body>
</html>
