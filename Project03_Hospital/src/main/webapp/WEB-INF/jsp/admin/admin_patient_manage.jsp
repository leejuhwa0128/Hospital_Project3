<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>환자 관리</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css?v=20250812-1">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css?v=20250812-1">
</head>
<body>

	<h2>환자 관리</h2>

	<div class="search-box">
		<form
			action="${pageContext.request.contextPath}/admin/patientSearch.do"
			method="get">
			<input type="text" name="keyword" placeholder="이름 또는 ID"
				value="${param.keyword}">
			<button type="submit">검색</button>
		</form>
	</div>

	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>성별</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>가입일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="patient" items="${patientList}">
				<tr>
					<td>${patient.patientNo}</td>
					<td>${patient.patientUserId}</td>
					<td>${patient.patientName}</td>
					<td>${patient.patientGender}</td>
					<td>${patient.patientPhone}</td>
					<td>${patient.patientEmail}</td>
					<td><fmt:formatDate value="${patient.patientCreatedAt}"
							pattern="yyyy-MM-dd" /></td>
					<td>
						<form
							action="${pageContext.request.contextPath}/admin/patientDetail.do"
							method="get" class="inline-form">
							<input type="hidden" name="patientNo"
								value="${patient.patientNo}">
							<button class="btn-action btn-view">상세</button>
						</form>

						<form
							action="${pageContext.request.contextPath}/admin/patientReservations.do"
							method="get" class="inline-form">
							<input type="hidden" name="patientNo"
								value="${patient.patientNo}">
							<button class="btn-action btn-book">예약내역</button>
						</form>

						<form
							action="${pageContext.request.contextPath}/admin/patientRecords.do"
							method="get" class="inline-form">
							<input type="hidden" name="patientNo"
								value="${patient.patientNo}">
							<button class="btn-action btn-record">진료기록</button>
						</form> <!-- ✅ 관리자 강제 비회원화 (확인창 + 중복제출 방지) --> <c:choose>
							<c:when test="${empty patient.patientUserId}">
								<span class="badge badge-secondary"></span>
							</c:when>
							<c:otherwise>
								<form
									action="${pageContext.request.contextPath}/admin/adminForceDelete.do"
									method="post" class="inline-form"
									onsubmit="return confirmStrip(this);">
									<input type="hidden" name="patientNo"
										value="${patient.patientNo}">
									<button type="submit" class="btn-action btn-delete">비회원화</button>
								</form>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>

			<c:if test="${empty patientList}">
				<tr>
					<td colspan="8">환자 정보가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

	<div class="pagination">
		<c:if test="${totalPages > 1}">
			<c:forEach begin="1" end="${totalPages}" var="pageNum">
				<c:choose>
					<c:when test="${pageNum == currentPage}">
						<a class="active">${pageNum}</a>
					</c:when>
					<c:otherwise>
						<a
							href="${pageContext.request.contextPath}/admin/patientList.do?page=${pageNum}">${pageNum}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
	</div>

	<script>
		// 중복 제출 전역 플래그
		let __STRIP_IN_PROGRESS__ = false;

		function confirmStrip(form) {
			if (__STRIP_IN_PROGRESS__)
				return false;

			// 행에서 이름/아이디 추출 (테이블 컬럼 순서 기준)
			const row = form.closest('tr');
			const idTxt = row && row.cells[1] ? row.cells[1].textContent.trim()
					: '';
			const nameTxt = row && row.cells[2] ? row.cells[2].textContent
					.trim() : '';

			// 안내 메시지
			let msg = '';
			if (nameTxt || idTxt)
				msg += `[${nameTxt || '-'}${idTxt ? ' / ' + idTxt : ''}] `;
			msg += '해당 계정을 비회원화하시겠습니까?\n';
			msg += '아이디/비밀번호는 제거되어 로그인할 수 없고,\n예약/진료기록 등 이력은 회원번호로 유지됩니다.';

			if (!confirm(msg))
				return false;

			// 확인 시 중복 제출 방지
			__STRIP_IN_PROGRESS__ = true;
			const btn = form.querySelector('button[type="submit"]');
			if (btn) {
				btn.disabled = true;
				btn.textContent = '처리중...';
			}
			return true;
		}
	</script>

</body>
</html>
