<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 공통 스타일 포함 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css" />

<!-- 등록 버튼 전용 커스터마이징 -->
<style>
button.btn-save {
	background-color: #16a34a !important;
	color: #fff !important;
	font-size: 13px !important;
	font-weight: 500 !important;
	padding: 6px 12px !important;
	border: none !important;
	border-radius: 4px !important;
	cursor: pointer;
}

button.btn-save:hover {
	background-color: #15803d !important;
}
</style>

<h2>🎓 강좌 및 행사 등록</h2>
<div class="con_wrap bg_13 form-wide">
	<form action="lecture_write.do" method="post">
		<table class="kv-table">
			<tbody>
				<tr>
					<th><label for="title">제목</label></th>
					<td><input type="text" id="title" name="title" required
						style="width: 100%;"></td>
				</tr>
				<tr>
					<th><label for="category">카테고리</label></th>
					<td><select id="category" name="category" required
						style="width: 100%;">
							<option>강좌</option>
							<option>교육</option>
							<option>행사</option>
							<option>기타</option>
					</select></td>
				</tr>
				<tr>
					<th><label for="startDate">시작일</label></th>
					<td><input type="date" id="startDate" name="startDate"
						style="width: 200px;"></td>
				</tr>
				<tr>
					<th><label for="endDate">종료일</label></th>
					<td><input type="date" id="endDate" name="endDate"
						style="width: 200px;"></td>
				</tr>
				<tr>
					<th><label for="workLocation">장소</label></th>
					<td><input type="text" id="workLocation" name="workLocation"
						style="width: 100%;"></td>
				</tr>
				<tr>
					<th><label for="speaker">강사</label></th>
					<td><input type="text" id="speaker" name="speaker"
						style="width: 100%;"></td>
				</tr>
				<tr>
					<th><label for="timeInfo">시간</label></th>
					<td><input type="text" id="timeInfo" name="timeInfo"
						style="width: 100%;"></td>
				</tr>
				<tr>
					<th><label for="contact">연락처</label></th>
					<td><input type="text" id="contact" name="contact"
						style="width: 100%;"></td>
				</tr>
				<tr>
					<th><label for="description">내용</label></th>
					<td><textarea id="description" name="description" rows="6"
							style="width: 100%; max-width: 100%; box-sizing: border-box;"></textarea>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="button-group right" style="margin-top: 20px;">
			<button type="submit" class="btn-save">등록</button>
			<a
				href="${pageContext.request.contextPath}/admin_board/lectureManage.do"
				class="btn-action btn-view">목록</a>
		</div>
	</form>
</div>
