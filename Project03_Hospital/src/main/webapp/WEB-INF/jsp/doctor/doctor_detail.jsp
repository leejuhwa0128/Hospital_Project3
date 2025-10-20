<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>의사 상세 정보</title>
<!-- 외부 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
</head>
<body>
	<div class="detail-container">
		<h2>의사 상세 정보</h2>

		<!-- 현재 페이지값 기본 세팅(없으면 1) -->
		<c:set var="sPage" value="${empty schedulePage ? 1 : schedulePage}" />
		<c:set var="rPage" value="${empty recordPage   ? 1 : recordPage}" />
		<c:set var="vPage"
			value="${empty reservationPage ? 1 : reservationPage}" />

		<!-- 기본 정보 -->
		<table class="detail-table">
			<tr>
				<th>이름</th>
				<td>${doctor.name}</td>
			</tr>
			<tr>
				<th>진료과</th>
				<td>${doctor.deptName}</td>
			</tr>
			<tr>
				<th>전문분야</th>
				<td>${doctor.specialty}</td>
			</tr>
		</table>

		<!-- 스케줄 -->
		<h3 id="schedule">스케줄</h3>

		<div class="button-group left">
			<form
				action="${pageContext.request.contextPath}/admin/insertScheduleForm.do"
				method="get" class="inline-form">
				<input type="hidden" name="doctorId" value="${doctor.doctorId}" />
				<button type="submit" class="btn-action btn-view">스케줄 등록</button>
			</form>
		</div>

		<table class="detail-table">
			<thead>
				<tr>
					<th>날짜</th>
					<th>시간</th>
					<th>내용</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="sch" items="${schedules}">
					<tr>
						<td><fmt:formatDate value="${sch.scheduleDate}"
								pattern="yyyy-MM-dd" /></td>
						<td><c:out
								value="${empty sch.scheduleTime ? '-' : sch.scheduleTime}" /></td>
						<td><c:out value="${sch.note}" /></td>
						<td>
							<div class="actions">
								<form
									action="${pageContext.request.contextPath}/admin/updateScheduleForm.do"
									method="get" class="inline-form">
									<input type="hidden" name="scheduleId"
										value="${sch.scheduleId}" />
									<button type="submit" class="btn-action btn-view">수정</button>
								</form>
								<form
									action="${pageContext.request.contextPath}/admin/deleteSchedule.do"
									method="post" class="inline-form">
									<input type="hidden" name="scheduleId"
										value="${sch.scheduleId}" /> <input type="hidden"
										name="doctorId" value="${doctor.doctorId}" /> <input
										type="hidden" name="force" value="true" />
									<%-- ✅ 강제 삭제 활성화 --%>
									<button type="submit" class="btn-action btn-delete"
										onclick="return confirm('예약이 연결된 경우에도 강제로 삭제하시겠습니까?');">
										강제삭제</button>
								</form>
							</div>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty schedules}">
					<tr>
						<td colspan="4">등록된 스케줄이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<!-- 스케줄 페이징 (버튼형, c:url 사용) -->
		<div class="pagination">
			<c:if test="${scheduleTotalPages > 1}">
				<c:set var="sPage" value="${schedulePage}" />
				<!-- 이전 블록 -->
				<c:if test="${scheduleHasPrev}">
					<c:url var="sPrevUrl" value="/admin/doctorDetail.do">
						<c:param name="doctorId" value="${doctor.doctorId}" />
						<c:param name="sPage" value="${scheduleBlockStart - 1}" />
						<c:param name="rPage" value="${recordPage}" />
						<c:param name="vPage" value="${reservationPage}" />
					</c:url>
					<a class="arrow" href="${sPrevUrl}#schedule">‹</a>
				</c:if>

				<!-- 현재 블록 숫자 -->
				<c:forEach var="p" begin="${scheduleBlockStart}"
					end="${scheduleBlockEnd}">
					<c:choose>
						<c:when test="${p == sPage}">
							<a class="active">${p}</a>
						</c:when>
						<c:otherwise>
							<c:url var="sNumUrl" value="/admin/doctorDetail.do">
								<c:param name="doctorId" value="${doctor.doctorId}" />
								<c:param name="sPage" value="${p}" />
								<c:param name="rPage" value="${recordPage}" />
								<c:param name="vPage" value="${reservationPage}" />
							</c:url>
							<a href="${sNumUrl}#schedule">${p}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- 다음 블록 -->
				<c:if test="${scheduleHasNext}">
					<c:url var="sNextUrl" value="/admin/doctorDetail.do">
						<c:param name="doctorId" value="${doctor.doctorId}" />
						<c:param name="sPage" value="${scheduleBlockEnd + 1}" />
						<c:param name="rPage" value="${recordPage}" />
						<c:param name="vPage" value="${reservationPage}" />
					</c:url>
					<a class="arrow" href="${sNextUrl}#schedule">›</a>
				</c:if>
			</c:if>
		</div>

		<!-- 진료 기록 -->
		<h3 id="records">진료 기록</h3>
		<table class="detail-table">
			<thead>
				<tr>
					<th>환자</th>
					<th>날짜</th>
					<th>진단</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="rec" items="${records}">
					<tr>
						<td><c:out value="${rec.patientName}" /></td>
						<td><fmt:formatDate value="${rec.recordDate}"
								pattern="yyyy-MM-dd" /></td>
						<td><c:out value="${rec.diagnosis}" /></td>
					</tr>
				</c:forEach>
				<c:if test="${empty records}">
					<tr>
						<td colspan="3">진료 기록이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<!-- 진료 기록 페이징 -->
		<div class="pagination">
			<c:if test="${recordTotalPages > 1}">
				<c:set var="rPage" value="${recordPage}" />
				<c:if test="${recordHasPrev}">
					<c:url var="rPrevUrl" value="/admin/doctorDetail.do">
						<c:param name="doctorId" value="${doctor.doctorId}" />
						<c:param name="sPage" value="${schedulePage}" />
						<c:param name="rPage" value="${recordBlockStart - 1}" />
						<c:param name="vPage" value="${reservationPage}" />
					</c:url>
					<a class="arrow" href="${rPrevUrl}#records">‹</a>
				</c:if>

				<c:forEach var="p" begin="${recordBlockStart}"
					end="${recordBlockEnd}">
					<c:choose>
						<c:when test="${p == rPage}">
							<a class="active">${p}</a>
						</c:when>
						<c:otherwise>
							<c:url var="rNumUrl" value="/admin/doctorDetail.do">
								<c:param name="doctorId" value="${doctor.doctorId}" />
								<c:param name="sPage" value="${schedulePage}" />
								<c:param name="rPage" value="${p}" />
								<c:param name="vPage" value="${reservationPage}" />
							</c:url>
							<a href="${rNumUrl}#records">${p}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:if test="${recordHasNext}">
					<c:url var="rNextUrl" value="/admin/doctorDetail.do">
						<c:param name="doctorId" value="${doctor.doctorId}" />
						<c:param name="sPage" value="${schedulePage}" />
						<c:param name="rPage" value="${recordBlockEnd + 1}" />
						<c:param name="vPage" value="${reservationPage}" />
					</c:url>
					<a class="arrow" href="${rNextUrl}#records">›</a>
				</c:if>
			</c:if>
		</div>

		<!-- 예약 내역 -->
		<h3 id="reservations">예약 내역</h3>
		<table class="detail-table">
			<thead>
				<tr>
					<th>환자</th>
					<th>예약일</th>
					<th>시간</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="res" items="${reservations}">
					<tr>
						<td><c:out value="${res.patientName}" /></td>

						<!-- 날짜 -->
						<td><fmt:formatDate value="${res.reservationDate}"
								pattern="yyyy-MM-dd" /></td>

						<!-- 시간: scheduleTime 우선, 없으면 reservationDate에서 HH:mm -->
						<td><c:choose>
								<c:when test="${not empty res.scheduleTime}">
									<c:out value="${res.scheduleTime}" />
								</c:when>
								<c:otherwise>
									<fmt:formatDate value="${res.reservationDate}" pattern="HH:mm" />
								</c:otherwise>
							</c:choose></td>

						<!-- 상태 변경 폼 -->
						<td class="manage-cell">
							<form
								action="${pageContext.request.contextPath}/admin/updateStatus.do"
								method="post" class="inline-form">
								<input type="hidden" name="reservationId"
									value="${res.reservationId}" /> <input type="hidden"
									name="doctorId" value="${doctor.doctorId}" /> <select
									name="status">
									<option value="대기"
										<c:if test="${res.status == '대기'}">selected</c:if>>대기</option>
									<option value="확정"
										<c:if test="${res.status == '확정'}">selected</c:if>>확정</option>
									<option value="취소"
										<c:if test="${res.status == '취소'}">selected</c:if>>취소</option>
									<option value="완료"
										<c:if test="${res.status == '완료'}">selected</c:if>>완료</option>
								</select>
								<button type="submit" class="btn-action btn-save">변경</button>
							</form>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty reservations}">
					<tr>
						<td colspan="4">예약 내역이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>



		<!-- 예약 페이징 -->
		<div class="pagination">
			<c:if test="${reservationTotalPages > 1}">
				<c:set var="vPage" value="${reservationPage}" />
				<c:if test="${reservationHasPrev}">
					<c:url var="vPrevUrl" value="/admin/doctorDetail.do">
						<c:param name="doctorId" value="${doctor.doctorId}" />
						<c:param name="sPage" value="${schedulePage}" />
						<c:param name="rPage" value="${recordPage}" />
						<c:param name="vPage" value="${reservationBlockStart - 1}" />
					</c:url>
					<a class="arrow" href="${vPrevUrl}#reservations">‹</a>
				</c:if>

				<c:forEach var="p" begin="${reservationBlockStart}"
					end="${reservationBlockEnd}">
					<c:choose>
						<c:when test="${p == vPage}">
							<a class="active">${p}</a>
						</c:when>
						<c:otherwise>
							<c:url var="vNumUrl" value="/admin/doctorDetail.do">
								<c:param name="doctorId" value="${doctor.doctorId}" />
								<c:param name="sPage" value="${schedulePage}" />
								<c:param name="rPage" value="${recordPage}" />
								<c:param name="vPage" value="${p}" />
							</c:url>
							<a href="${vNumUrl}#reservations">${p}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:if test="${reservationHasNext}">
					<c:url var="vNextUrl" value="/admin/doctorDetail.do">
						<c:param name="doctorId" value="${doctor.doctorId}" />
						<c:param name="sPage" value="${schedulePage}" />
						<c:param name="rPage" value="${recordPage}" />
						<c:param name="vPage" value="${reservationBlockEnd + 1}" />
					</c:url>
					<a class="arrow" href="${vNextUrl}#reservations">›</a>
				</c:if>
			</c:if>
		</div>

		<!-- 하단 버튼 -->
		<div class="button-group left">
			<a href="javascript:history.back();" class="btn-action btn-view">뒤로가기</a>
		</div>
	</div>
</body>
</html>
