<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상담 상세 보기</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css?v=2">
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
</head>
<body>

	<div class="con_wrap bg_13">
		<p class="total_tit f_s20 f_w700">📨 상담 상세 보기</p>

		<div class="board_view">
			<table class="detail-table">
				<tbody>
					<tr>
						<th>이름</th>
						<td><c:out value="${counsel.patientName}" /></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><c:out value="${counsel.email}" /></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><c:out value="${counsel.phone}" /></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><c:out value="${counsel.subject}" /></td>
					</tr>
					<tr>
						<th>상태</th>
						<td><c:choose>
								<c:when test="${counsel.status eq '대기'}">
									<span class="chip chip-gray">대기</span>
								</c:when>
								<c:when test="${counsel.status eq '이메일 답변 완료'}">
									<span class="chip chip-blue">이메일 답변 완료</span>
								</c:when>
								<c:when test="${counsel.status eq '전화 답변 완료'}">
									<span class="chip chip-green">전화 답변 완료</span>
								</c:when>
								<c:otherwise>
									<span class="chip chip-gray"><c:out
											value="${counsel.status}" /></span>
								</c:otherwise>
							</c:choose></td>
					</tr>
					<tr>
						<th>신청일</th>
						<td><fmt:formatDate value="${counsel.createdAt}"
								pattern="yyyy-MM-dd HH:mm" /></td>
					</tr>
				</tbody>
			</table>

			<!-- 상담 내용 -->
			<div class="notice-content"
				style="margin-top: 20px; white-space: pre-line;">
				<c:out value="${counsel.message}" />
			</div>
		</div>

		<!-- 버튼 영역 -->
		<div class="btn_area" style="margin-top: 20px; text-align: right;">
			<!-- 좌측 기능: 이메일/전화 -->
			<a class="btn-action btn-undo" href="mailto:${counsel.email}">✉
				이메일</a> <a class="btn-action btn-book" href="tel:${counsel.phone}">📞
				전화</a>

			<!-- 상태 변경 폼 -->
			<form
				action="${pageContext.request.contextPath}/admin/counsel/updateStatus.do"
				method="post" style="display: inline;">
				<input type="hidden" name="counselId" value="${counsel.counselId}" />
				<select name="status" style="margin-left: 10px; padding: 4px 6px;">
					<option value="대기"
						<c:if test="${counsel.status == '대기'}">selected</c:if>>대기</option>
					<option value="이메일 답변 완료"
						<c:if test="${counsel.status == '이메일 답변 완료'}">selected</c:if>>이메일
						답변 완료</option>
					<option value="전화 답변 완료"
						<c:if test="${counsel.status == '전화 답변 완료'}">selected</c:if>>전화
						답변 완료</option>
				</select>
				<button type="submit" class="btn-action btn-save">상태 변경</button>
			</form>

			<!-- 목록 이동 -->
			<a href="${pageContext.request.contextPath}/admin/counselList.do"
				class="btn-action btn-view">← 목록</a>
		</div>
	</div>

</body>
</html>
