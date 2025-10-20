<!DOCTYPE html>
<html lang="ko">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
<meta charset="UTF-8">
<title>관리자 대시보드</title>
<link
	href="https://cdn.jsdelivr.net/npm/@adminkit/core@latest/dist/css/app.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/@adminkit/core@latest/dist/js/app.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
</head>
<body>
	<div class="container-fluid p-4">
		<h2 class="mb-4 fw-bold">📊 관리자 대시보드</h2>

		<div class="row">
			<!-- 왼쪽 열: 카드 안에 카드 정렬 방식 -->
			<div class="col-md-3">
				<div class="card h-100 d-flex flex-column">
					<div class="card-body d-flex flex-column justify-content-between"
						style="gap: 16px; height: 100%;">

						<!-- 가입 승인 대기 -->
						<div class="border rounded p-3 text-center shadow-sm"
							style="background-color: #f8f9fa;">
							<h6 class="fw-bold mb-1">가입 승인 대기</h6>
							<div class="h3 mb-1">${pendingCount}명</div>
							<div class="text-muted mb-2">의사: ${pendingDoctors}, 협력의:
								${pendingCoops}</div>
							<a href="<c:url value='/admin/pendingList.do'/>"
								class="btn btn-primary btn-sm w-100">대기자 목록</a>
						</div>

						<!-- 오늘 예약 -->
						<div class="border rounded p-3 text-center shadow-sm"
							style="background-color: #f8f9fa;">
							<h6 class="fw-bold mb-1">오늘 예약</h6>
							<div class="h3 mb-2">${todayReservationCount}</div>
							<a href="<c:url value='/admin/reservationCalendar.do'/>"
								class="btn btn-success btn-sm w-100">예약 현황</a>
						</div>

						<!-- 게시판 바로가기 카드 -->
						<div
							class="border rounded p-3 shadow-sm flex-grow-1 d-flex flex-column"
							style="background-color: #f8f9fa;">
							<h6 class="fw-bold mb-2 text-center">📂 게시판 바로가기</h6>
							<div class="overflow-auto flex-grow-1">
								<table class="table table-sm table-bordered text-center mb-0">
									<thead class="table-dark">
										<tr>
											<th>게시판</th>
											<th>새글/전체</th>
											<th>바로가기</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="stat" items="${boardStats}">
											<tr>
												<td>${stat.category}</td>
												<td><span class="badge bg-secondary">${stat.recent}
														/ ${stat.total}</span></td>
												<td><c:choose>
														<c:when test="${stat.category eq '언론보도'}">
															<a href="<c:url value='/admin_board/pressManage.do'/>"
																target="contentFrame"
																class="btn btn-outline-dark btn-sm">이동</a>
														</c:when>
														<c:when test="${stat.category eq '채용공고'}">
															<a href="<c:url value='/admin_board/recruitManage.do'/>"
																target="contentFrame"
																class="btn btn-outline-dark btn-sm">이동</a>
														</c:when>
														<c:when test="${stat.category eq '병원소식'}">
															<a href="<c:url value='/admin_board/newsManage.do'/>"
																target="contentFrame"
																class="btn btn-outline-dark btn-sm">이동</a>
														</c:when>
														<c:when test="${stat.category eq '강좌/행사'}">
															<a href="<c:url value='/admin_board/lectureManage.do'/>"
																target="contentFrame"
																class="btn btn-outline-dark btn-sm">이동</a>
														</c:when>
														<c:when test="${stat.category eq '칭찬 릴레이'}">
															<a href="<c:url value='/admin_board/praiseManage.do'/>"
																target="contentFrame"
																class="btn btn-outline-dark btn-sm">이동</a>
														</c:when>
														<c:otherwise>
															<span class="text-muted">-</span>
														</c:otherwise>
													</c:choose></td>

											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>

					</div>
				</div>
			</div>





			<!-- 중앙 열: 예약 추이 (세로 막대형) -->
			<div class="col-md-6">
				<div class="card h-100">
					<div class="card-body">
						<h5 class="card-title">📈 최근 7일 예약 추이</h5>
						<div id="reservationTrendChart" style="height: 500px;"></div>
					</div>
				</div>
			</div>

			<!-- 오른쪽 열: 고객의 소리 -->
			<div class="col-md-3">
				<div class="card h-100">
					<div class="card-body">
						<h5 class="card-title text-center">고객의 소리 회신률</h5>
						<div id="feedbackGauge" style="height: 300px;"></div>
						<hr class="my-3" />
						<h6 class="fw-bold mb-2">🗒 최근 접수된 고객의소리</h6>
						<div class="overflow-auto" style="max-height: 200px;">
							<c:forEach var="fb" items="${receivedList}">
								<div class="mb-2 border-start border-primary ps-3">
									<span class="badge bg-primary">접수</span> <strong>${fb.patientUserId}</strong>
									<small class="text-muted float-end">${fb.relativeTime}</small>
									<div>${fn:substring(fb.content, 0, 30)}...</div>
								</div>
							</c:forEach>
							<c:forEach var="fb" items="${repliedList}">
								<div class="mb-2 border-start border-success ps-3">
									<span class="badge bg-success">답변완료</span> <strong>${fb.patientUserId}</strong>
									<small class="text-muted float-end">${fb.relativeTime}</small>
									<div>${fn:substring(fb.content, 0, 30)}...</div>
								</div>
							</c:forEach>
							<c:forEach var="fb" items="${pendingList}">
								<div class="mb-2 border-start border-danger ps-3">
									<span class="badge bg-danger">미처리</span> <strong>${fb.patientUserId}</strong>
									<small class="text-muted float-end">${fb.relativeTime}</small>
									<div>${fn:substring(fb.content, 0, 30)}...</div>
								</div>
							</c:forEach>
						</div>
						<div class="text-center mt-3">
							<a href="<c:url value='/admin_board/feedbackManage.do'/>"
								class="btn btn-outline-primary btn-sm">전체 보기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
document.addEventListener("DOMContentLoaded", function () {
  const reservationDates = [
    <c:forEach var="stat" items="${reservationStats}" varStatus="i">
      '${stat.resvDate}'<c:if test="${!i.last}">,</c:if>
    </c:forEach>
  ];
  const reservationCounts = [
    <c:forEach var="stat" items="${reservationStats}" varStatus="i">
      ${stat.resvCount}<c:if test="${!i.last}">,</c:if>
    </c:forEach>
  ];
  const reversedDates = reservationDates.reverse();
  const reversedCounts = reservationCounts.reverse();

  Highcharts.chart('reservationTrendChart', {
    chart: { type: 'bar' },
    title: null,
    xAxis: {
      categories: reversedDates,
      title: { text: '날짜' }
    },
    yAxis: {
      title: { text: '예약 건수' },
      allowDecimals: false
    },
    series: [{
      name: '예약',
      data: reversedCounts,
      color: '#4a2d2d'
    }],
    credits: { enabled: false }
  });

  const received = ${feedbackReceived != null ? feedbackReceived : 0};
  const completed = ${feedbackCompleted != null ? feedbackCompleted : 0};
  const total = received + completed;
  const rate = total === 0 ? 0 : Math.round((completed / total) * 100);

  Highcharts.chart('feedbackGauge', {
    chart: { type: 'solidgauge', height: 300 },
    title: null,
    pane: {
      startAngle: -90,
      endAngle: 90,
      center: ['50%', '85%'],
      size: '100%',
      background: {
        backgroundColor: '#EEE',
        innerRadius: '60%',
        outerRadius: '100%',
        shape: 'arc'
      }
    },
    tooltip: { enabled: false },
    yAxis: {
      min: 0,
      max: 100,
      stops: [
        [0.3, '#f44336'],
        [0.6, '#fbc02d'],
        [0.9, '#4caf50']
      ],
      lineWidth: 0,
      tickWidth: 0,
      minorTickInterval: null,
      tickAmount: 2,
      title: { text: '회신률', y: -60 },
      labels: { y: 20 }
    },
    plotOptions: {
      solidgauge: {
        dataLabels: {
          y: 10,
          borderWidth: 0,
          useHTML: true,
          format: '<div style="text-align:center;"><span style="font-size:24px;">{y}%</span></div>'
        }
      }
    },
    series: [{ name: '회신률', data: [rate] }],
    credits: { enabled: false }
  });
});
</script>
</body>
</html>
