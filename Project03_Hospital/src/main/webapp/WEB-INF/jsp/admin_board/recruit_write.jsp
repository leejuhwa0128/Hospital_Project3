<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- CSS: 공통 + 디테일 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css?v=3">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<style>
button.btn-save {
	background-color: #16a34a !important;
	color: #fff !important;
	font-size: 13px !important;
	font-weight: 500 !important;
	padding: 6px 12px !important;
	border: none !important;
	border-radius: 4px !important;
}

button.btn-save:hover {
	background-color: #15803d !important;
}
</style>
<div class="detail-container form-wide">
	<h2 class="page-title">📢 채용 공고 등록</h2>

	<form
		action="${pageContext.request.contextPath}/admin_board/recruit_write.do"
		method="post" enctype="multipart/form-data">

		<input type="hidden" name="category" value="채용" />

		<table class="kv-table">
			<tbody>
				<tr>
					<th><label for="title">제목</label></th>
					<td><input type="text" id="title" name="title" required
						placeholder="제목을 입력하세요"></td>
				</tr>

				<tr>
					<th><label for="subCategory">직무 분류</label></th>
					<td><select name="subCategory" id="subCategory" required>
							<option value="">선택</option>
							<option value="의사직">의사직</option>
							<option value="간호사직">간호사직</option>
							<option value="의료기사직">의료기사직</option>
							<option value="의료지원직">의료지원직</option>
					</select></td>
				</tr>

				<tr>
					<th><label for="jobPosition">세부 직무</label></th>
					<td><input type="text" id="jobPosition" name="jobPosition"
						placeholder="예: 소아청소년과 전문의"></td>
				</tr>

				<tr>
					<th><label for="workingType">근무 형태</label></th>
					<td><select name="workingType" id="workingType" required>
							<option value="">선택</option>
							<option value="정규직">정규직</option>
							<option value="계약직">계약직</option>
							<option value="인턴">인턴</option>
							<option value="기타">기타</option>
					</select></td>
				</tr>

				<tr>
					<th><label for="workLocation">근무지</label></th>
					<td><input type="text" id="workLocation" name="workLocation"
						required placeholder="예: 서울 본원"></td>
				</tr>

				<tr>
					<th><label for="recruitCount">모집 인원</label></th>
					<td><input type="number" id="recruitCount" name="recruitCount"
						required></td>
				</tr>

				<tr>
					<th><label for="contactEmail">접수 이메일</label></th>
					<td><input type="email" id="contactEmail" name="contactEmail"
						required></td>
				</tr>

				<tr>
					<th><label for="contact">연락처</label></th>
					<td><input type="text" id="contact" name="contact" required></td>
				</tr>

				<tr>
					<th><label for="recruitDate">모집 기간</label></th>
					<td><input type="text" id="recruitDate" name="recruitPeriod"
						placeholder="YYYY-MM-DD ~ YYYY-MM-DD" required /> <input
						type="hidden" name="startDate" id="startDate" /> <input
						type="hidden" name="endDate" id="endDate" /></td>
				</tr>

				<tr>
					<th><label for="thumbnailFile">썸네일 이미지</label></th>
					<td><input type="file" id="thumbnailFile" name="thumbnailFile"
						accept="image/*"></td>
				</tr>

				<tr>
					<th><label for="resumeFile">이력서 양식 파일</label></th>
					<td><input type="file" id="resumeFile" name="resumeFile"
						accept=".pdf,.hwp,.doc,.docx"></td>
				</tr>

				<tr>
					<th><label for="description">상세 설명</label></th>
					<td><textarea id="description" name="description"
							placeholder="상세 내용을 입력하세요."></textarea></td>
				</tr>
			</tbody>
		</table>

		<div class="button-group right" style="margin-top: 16px;">
			<button type="submit" class="btn-action btn-save">등록</button>
			<a
				href="${pageContext.request.contextPath}/admin_board/recruitManage.do"
				class="btn-action btn-view">목록</a>
		</div>
	</form>
</div>

<script>
	flatpickr("#recruitDate", {
		mode : "range",
		locale : "ko",
		dateFormat : "Y-m-d",
		onChange : function(selectedDates) {
			if (selectedDates.length === 2) {
				document.getElementById("startDate").value = flatpickr
						.formatDate(selectedDates[0], "Y-m-d");
				document.getElementById("endDate").value = flatpickr
						.formatDate(selectedDates[1], "Y-m-d");
			}
		}
	});
</script>
