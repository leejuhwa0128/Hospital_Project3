<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String q = request.getParameter("date");
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.util.Date d = (q == null ? new java.util.Date() : sdf.parse(q));
java.util.Calendar cal = java.util.Calendar.getInstance();
cal.setTime(d);
request.setAttribute("date", sdf.format(d));
cal.add(java.util.Calendar.DATE, -1);
request.setAttribute("prevDate", sdf.format(cal.getTime()));
cal.add(java.util.Calendar.DATE, 2);
request.setAttribute("nextDate", sdf.format(cal.getTime()));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${date}예약목록</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 새창 축소 방지 -->

<style>
.summary {
	margin: 8px 0 14px;
	color: #374151;
	font-weight: 600;
}

/* 상단: 왼/가운데/오른쪽 정렬 */
.toolbar {
	display: grid;
	grid-template-columns: 1fr auto 1fr;
	align-items: center;
	gap: 10px;
	margin-bottom: 10px;
}

.toolbar .left {
	justify-self: start;
	display: flex;
	gap: 8px;
}

.toolbar .center {
	justify-self: center;
}

.toolbar .right {
	justify-self: end;
	display: flex;
	gap: 8px;
}

.btn-toggle {
	min-width: 64px
}

.btn-toggle.active {
	background: #1e293b
}
</style>
</head>
<body>
	<div class="detail-container">
		<h2 class="page-title">${date}예약목록</h2>
		<div class="summary">총 예약 수: ${fn:length(reservationList)}건</div>

		<!-- 상단 툴바 -->
		<div class="toolbar">
			<div class="left">
				<button type="button" class="btn-action btn-view btn-toggle"
					data-filter="am">오전</button>
				<button type="button" class="btn-action btn-view btn-toggle"
					data-filter="pm">오후</button>
				<button type="button" class="btn-action btn-view btn-toggle"
					data-filter="all">전체</button>
			</div>

			<div class="center">
				<a class="btn-action btn-view"
					href="${pageContext.request.contextPath}/admin/reservations/exportExcel.do?date=${date}">
					엑셀 다운로드 </a>
			</div>

			<div class="right">
				<a class="btn-action btn-view"
					href="${pageContext.request.contextPath}/admin/reservations/viewByDate.do?date=${prevDate}">‹
					이전 날짜</a> <a class="btn-action btn-view"
					href="${pageContext.request.contextPath}/admin/reservations/viewByDate.do?date=${nextDate}">다음
					날짜 ›</a>
			</div>
		</div>

		<table class="detail-table" id="reservationTable">
			<thead>
				<tr>
					<th>시간</th>
					<th>환자</th>
					<th>연락처</th>
					<th>의사</th>
					<th>진료과</th>
					<th>상태</th>
					<th>환자 상세</th>
					<th>기록</th>
					<th>스케줄</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="res" items="${reservationList}">
					<tr class="row-${res.scheduleTime lt '12:00:00' ? 'am' : 'pm'}">
						<td>${res.scheduleTime}</td>
						<td>${res.patientName}</td>
						<td>${res.patientPhone}</td>
						<td>${res.doctorName}</td>
						<td>${res.departmentName}</td>

						<td><c:choose>
								<c:when test="${res.status eq '완료'}">
									<span class="chip chip-green">완료</span>
								</c:when>
								<c:when test="${res.status eq '취소'}">
									<span class="chip chip-red">취소</span>
								</c:when>
								<c:when test="${res.status eq '확정'}">
									<span class="chip chip-gray">확정</span>
								</c:when>
								<c:otherwise>
									<span class="chip chip-gray">${res.status}</span>
								</c:otherwise>
							</c:choose> </td>

						<!-- 모두 기본 색(btn-view)로 통일 -->
						<td class="actions"><a class="btn-action btn-view"
							href="${pageContext.request.contextPath}/admin/patientDetail.do?patientNo=${res.patientNo}">환자
								상세</a></td>
						<td class="actions"><a class="btn-action btn-view"
							href="${pageContext.request.contextPath}/admin/patientRecords.do?patientNo=${res.patientNo}">기록
								보기</a></td>
						<td class="actions"><a class="btn-action btn-view"
							href="${pageContext.request.contextPath}/admin/doctorDetail.do?doctorId=${res.doctorId}">스케줄
								보기</a></td>
					</tr>
				</c:forEach>

				<c:if test="${empty reservationList}">
					<tr>
						<td colspan="9">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<script>
    // 필터(기본 전체)
    (function(){
      const rows = document.querySelectorAll('#reservationTable tbody tr');
      const toggles = document.querySelectorAll('.btn-toggle');
      function applyFilter(key){
        toggles.forEach(b => b.classList.toggle('active', b.dataset.filter === key));
        rows.forEach(tr => tr.style.display =
          (key === 'all' ? '' : (tr.classList.contains('row-'+key) ? '' : 'none')));
      }
      toggles.forEach(b => b.addEventListener('click', () => applyFilter(b.dataset.filter)));
      applyFilter('all');
    })();
  </script>
</body>
</html>
