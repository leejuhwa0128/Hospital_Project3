<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 공통 스타일 포함 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css" />

<!-- 등록/수정 버튼 전용 커스터마이징 -->
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

<h2>고객의 소리 답변</h2>

<div class="con_wrap bg_13 form-wide">
	<!-- 피드백 정보 출력 -->
	<table class="kv-table">
		<tbody>
			<tr>
				<th>카테고리</th>
				<td>${feedback.category}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${feedback.patientUserId}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td style="white-space:pre-line;">${feedback.content}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><fmt:formatDate value="${feedback.createdAt}" pattern="yyyy.MM.dd HH:mm" /></td>
			</tr>
			<tr>
				<th>현재 답변</th>
				<td style="white-space:pre-line;">${feedback.reply}</td>
			</tr>
		</tbody>
	</table>

	<!-- 답변 수정 폼 -->
	<form action="${pageContext.request.contextPath}/admin_board/editReply.do" method="post" style="margin-top: 20px;">
		<input type="hidden" name="feedbackId" value="${feedback.feedbackId}" />

		<table class="kv-table">
			<tbody>
				<tr>
					<th><label for="reply">답변 내용</label></th>
					<td>
						<textarea id="reply" name="reply" required
							style="width: 100%; max-width: 100%; height: 200px; box-sizing: border-box;"
							placeholder="답변 내용을 수정하세요">${feedback.reply}</textarea>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="button-group right" style="margin-top: 20px;">
			<button type="submit" class="btn-save">등록</button>
			<a href="${pageContext.request.contextPath}/admin_board/feedbackManage.do" class="btn-action btn-view">목록</a>
		</div>
	</form>
</div>
