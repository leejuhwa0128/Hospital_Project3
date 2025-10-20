<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 스타일 포함 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css" />

<!-- 수정 버튼 전용 스타일 -->
<style>
button.btn-save {
	background-color: #16a34a;
	color: #fff;
	font-size: 13px;
	font-weight: 500;
	padding: 6px 12px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}
button.btn-save:hover {
	background-color: #15803d;
}
</style>

<h2>🎓 강좌 및 행사 수정</h2>

<div class="con_wrap bg_13 form-wide">
<form action="lecture_edit.do" method="post">
	<input type="hidden" name="eventId" value="${event.eventId}" />

	<table class="kv-table">
		<tbody>
			<tr>
				<th><label>제목</label></th>
				<td><input type="text" name="title" value="${event.title}" required style="width:100%;"></td>
			</tr>
			<tr>
				<th><label>카테고리</label></th>
				<td>
					<select name="category" required>
						<option value="강좌" ${event.category == '강좌' ? 'selected' : ''}>강좌</option>
						<option value="교육" ${event.category == '교육' ? 'selected' : ''}>교육</option>
						<option value="행사" ${event.category == '행사' ? 'selected' : ''}>행사</option>
						<option value="기타" ${event.category == '기타' ? 'selected' : ''}>기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th><label>시작일</label></th>
				<td><input type="date" name="startDate" value="${event.startDateStr}" style="width:200px;"></td>
			</tr>
			<tr>
				<th><label>종료일</label></th>
				<td><input type="date" name="endDate" value="${event.endDateStr}" style="width:200px;"></td>
			</tr>
			<tr>
				<th><label>장소</label></th>
				<td><input type="text" name="workLocation" value="${event.workLocation}" style="width:100%;"></td>
			</tr>
			<tr>
				<th><label>강사</label></th>
				<td><input type="text" name="speaker" value="${event.speaker}" style="width:100%;"></td>
			</tr>
			<tr>
				<th><label>시간</label></th>
				<td><input type="text" name="timeInfo" value="${event.timeInfo}" style="width:100%;"></td>
			</tr>
			<tr>
				<th><label>연락처</label></th>
				<td><input type="text" name="contact" value="${event.contact}" style="width:100%;"></td>
			</tr>
			<tr>
				<th><label>내용</label></th>
				<td><textarea name="description" rows="6" style="width:100%;">${event.description}</textarea></td>
			</tr>
		</tbody>
	</table>

	<div class="button-group right" style="margin-top: 20px;">
		<button type="submit" class="btn-save">수정 완료</button>
		<a href="${pageContext.request.contextPath}/admin_board/lectureManage.do" class="btn-action btn-view">목록</a>
	</div>
</form>
</div>
