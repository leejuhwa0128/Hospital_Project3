<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 공통 스타일 포함 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css?v=3" />

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

<h2>언론보도 수정</h2>
<div class="con_wrap bg_13 form-wide">

	<form action="${pageContext.request.contextPath}/admin_board/press_update.do" 
		  method="post" enctype="multipart/form-data">

		<input type="hidden" name="eventId" value="${event.eventId}" />
		<input type="hidden" name="category" value="언론" />

		<table class="kv-table">
			<tbody>
				<tr>
					<th><label for="title">제목</label></th>
					<td><input type="text" id="title" name="title" value="${event.title}"
						required placeholder="제목을 입력하세요"
						style="width: 100%;"></td>
				</tr>

				<tr>
					<th><label for="description">내용</label></th>
					<td>
						<textarea id="description" name="description" required
							style="width: 100%; max-width: 100%; height: 300px; box-sizing: border-box;"
							placeholder="내용을 입력하세요">${event.description}</textarea>
					</td>
				</tr>

				<tr>
					<th><label for="reporter">기자명</label></th>
					<td><input type="text" id="reporter" name="reporter"
						value="${event.reporter}" required placeholder="기자명을 입력하세요"
						style="width: 100%;"></td>
				</tr>

				<tr>
					<th><label for="source">출처</label></th>
					<td><input type="text" id="source" name="source"
						value="${event.source}" placeholder="출처 URL 또는 기관명"
						style="width: 100%;"></td>
				</tr>

				<tr>
					<th>현재 썸네일</th>
					<td>
						<c:choose>
							<c:when test="${not empty event.thumbnailPath}">
								<img src="${pageContext.request.contextPath}${event.thumbnailPath}" width="200" />
							</c:when>
							<c:otherwise>
								<img src="${pageContext.request.contextPath}/press/default-thumb.png" width="200" />
							</c:otherwise>
						</c:choose>
					</td>
				</tr>

				<tr>
					<th><label for="thumbnailFile">새 썸네일</label></th>
					<td><input type="file" id="thumbnailFile" name="thumbnailFile" accept="image/*" /></td>
				</tr>
			</tbody>
		</table>

		<div class="button-group right" style="margin-top: 20px;">
			<button type="submit" class="btn-save">수정 완료</button>
			<a href="${pageContext.request.contextPath}/admin_board/pressManage.do"
			   class="btn-action btn-view">목록</a>
		</div>
	</form>
</div>
