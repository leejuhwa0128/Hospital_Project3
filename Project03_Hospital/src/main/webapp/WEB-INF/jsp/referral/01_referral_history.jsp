<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/referral/referral_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDIPRIME 협진병원센터</title>

<!-- 사이드바 전용 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/referral_sidebar.css?v=20250811">

<style>
body {
	margin: 0;
	padding: 0;
	font-family: '맑은 고딕', 'Malgun Gothic', sans-serif
}

.container {
	display: flex;
	gap: 24px;
	max-width: 1200px;
	margin: 0 auto;
	padding: 24px 16px
}
/* 본문 */
.content {
	flex: 1;
	padding: 6px
}

.content .header {
	margin: 6px 0 22px;
	border-bottom: 2px solid #000;
	padding-bottom: 8px
}

.content .header h2 {
	margin: 6px 0 0;
	font-size: 20px;
	color: #000
}

.path {
	font-size: 12px;
	color: #666
}
/* 소개/안내 박스 */
.lead {
	margin: 8px 0 22px;
	font-size: 14px;
	line-height: 1.8;
	color: #000
}

.info-box {
	margin: 18px 0 28px
}

.info-title {
	font-weight: 800;
	font-size: 15px;
	margin: 0 0 10px;
	color: #111;
	display: flex;
	align-items: center;
	gap: 8px
}

.info-title .dot {
	color: #111
}

.info-title .label {
	color: #111
}

.info-title .tel {
	color: #111
}

.info-content {
	border: 1px solid #000;
	background: #fff;
	color: #000;
	padding: 16px;
	border-radius: 8px;
	font-size: 14px;
	line-height: 1.75
}
/* 소제목(밑줄 없음) */
h2.no-underline {
	border: 0;
	margin-top: 28px
}
/* 지도 */
.map-box {
	width: 100%;
	max-width: 700px;
	height: 400px;
	border: 1px solid #e6e6e6;
	border-radius: 8px;
	overflow: hidden
}

@media ( max-width :900px) {
	.container {
		flex-direction: column
	}
	.map-box {
		height: 320px
	}
}
/* 지도 범례 */
.map-legend {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 16px;
	margin: 8px 0 10px;
	padding: 8px 12px;
	border: 1px solid #e6e6e6;
	border-radius: 8px;
	background: #f9fafb;
	font-size: 13px;
	color: #333;
}

.legend-item {
	display: inline-flex;
	align-items: center;
	gap: 8px
}

.legend-pin {
	width: 14px;
	height: 20px;
	display: inline-block;
	background-repeat: no-repeat;
	background-size: contain;
	transform: translateY(2px)
}
/* 파랑 핀 (센터) */
.legend-pin.blue {
	background-image:
		url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="14" height="20" viewBox="0 0 28 40"><path fill="%230b57d0" d="M14 0C6.268 0 0 6.268 0 14c0 10.5 14 26 14 26s14-15.5 14-26C28 6.268 21.732 0 14 0z"/><circle cx="14" cy="14" r="6" fill="%23ffffff"/></svg>')
}
/* 노랑 핀 (파트너) */
.legend-pin.yellow {
	background-image:
		url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="14" height="20" viewBox="0 0 28 40"><path fill="%23ffc107" d="M14 0C6.268 0 0 6.268 0 14c0 10.5 14 26 14 26s14-15.5 14-26C28 6.268 21.732 0 14 0z"/><circle cx="14" cy="14" r="6" fill="%23ffffff"/></svg>')
}
</style>
</head>
<body>

	<div class="container">
		<!-- 좌측 메뉴(사이드바) -->
		<aside class="ref-sidebar">
			<h3>진료협력센터소개</h3>
			<ul class="ref-side-menu">
				<li><a class="is-active" href="/referral/history.do">개요</a></li>
				<li><a href="/referral/greeting.do">센터장 인사말</a></li>
			</ul>
		</aside>

		<!-- 본문 -->
		<main class="content">
			<div class="header">
				<div class="path">Home &gt; 진료협력센터소개 &gt; 개요</div>
				<h2>개요</h2>
			</div>

			<p class="lead">
				<strong>진료협력센터 운영 개요</strong><br> MEDIPRIME 협진병원센터는 전국 협력의료기관과의
				네트워크를 기반으로 <b>환자 편의 증진</b>과 <b>의료의 질 향상</b>을 목표로 운영됩니다. 빠르고 정확한
				의뢰·회송 체계와 표준화된 정보 공유로, 환자 치료의 연속성과 안전을 강화합니다.
			</p>

			<!-- 박스 1 -->
			<section class="info-box">
				<h3 class="info-title">
					<span class="dot">●</span> <span class="label">진료예약</span> <span
						class="tel">| 02-1234-5678</span>
				</h3>
				<div class="info-content">
					<p>협력병원을 위한 전용 회선과 전담 인력을 통해 신속하고 정확하게 예약을 지원합니다.</p>
					<p>암·심장질환 등 중증 환자의 경우, 당일·우선 진료 연계를 통해 치료 접근성을 높이고 있습니다.</p>
				</div>
			</section>

			<!-- 박스 2 -->
			<section class="info-box">
				<h3 class="info-title">
					<span class="dot">●</span> <span class="label">진료결과 회신</span> <span
						class="tel">| 진료협력시스템을 통한 결과 공유</span>
				</h3>
				<div class="info-content">
					<p>환자의 동의하에 진료기록 및 검사결과를 의뢰기관에 신속하게 회신하여, 진료의 연속성과 효율을 강화합니다.</p>
				</div>
			</section>

			<!-- 박스 3 -->
			<section class="info-box">
				<h3 class="info-title">
					<span class="dot">●</span> <span class="label">환자 되의뢰 및 회송</span>
				</h3>
				<div class="info-content">
					<p>급성기·중증 치료 종료 후 필요한 후속관리(만성질환 관리, 재활 등)는 환자/보호자 상담을 거쳐 의뢰기관
						또는 환자 연고지의 협력의료기관으로 안전하게 연계합니다.</p>
				</div>
			</section>

			<!-- 박스 4 -->
			<section class="info-box">
				<h3 class="info-title">
					<span class="dot">●</span> <span class="label">협력의료기관 지원</span> <span
						class="tel">| 02-1234-1234</span>
				</h3>
				<div class="info-content">
					<p>협력기관 위촉 시 협력증서 및 협력회원 카드(주차권·간편증) 제공, 교육·연수 프로그램 초청 등 다양한
						혜택을 제공합니다.</p>
					<p>문의 및 고충사항은 전담창구로 연락 주시면 신속히 확인하고 회신 드리겠습니다.</p>
				</div>
			</section>

			<h2 class="no-underline">진료협력센터 위치</h2>
			<p>서울특별시 강남구 역삼로 120, 성보역삼빌딩 2층 (우)06251</p>
			<div class="map-legend" aria-label="지도 범례">
				<span class="legend-item"><span class="legend-pin blue"
					aria-hidden="true"></span>MEDIPRIME 협진병원</span> <span class="legend-item"><span
					class="legend-pin yellow" aria-hidden="true"></span>다른 협진 병원</span>
			</div>

			<div id="map" class="map-box"></div>

			<h2 class="no-underline">운영시간</h2>
			<p>평일·토요일 : 오전 9시 ~ 오후 6시 (공휴일 휴무)</p>
		</main>
	</div>

	<!-- Kakao Maps API: services 라이브러리 추가 -->
	<script
		src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=4780c337ec076206b2a8500099ae5fc7&autoload=false&libraries=services"></script>
	<script>
		kakao.maps
				.load(function() {
					var container = document.getElementById('map');
					var map = new kakao.maps.Map(container, {
						center : new kakao.maps.LatLng(37.49361, 127.0327),
						level : 5
					});

					var bounds = new kakao.maps.LatLngBounds();
					var geocoder = new kakao.maps.services.Geocoder();

					// 파란색(센터) / 노란색(파트너) 마커 이미지
					var BLUE_PIN = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="28" height="40" viewBox="0 0 28 40"><path fill="%230b57d0" d="M14 0C6.268 0 0 6.268 0 14c0 10.5 14 26 14 26s14-15.5 14-26C28 6.268 21.732 0 14 0z"/><circle cx="14" cy="14" r="6" fill="%23ffffff"/></svg>';
					var YELLOW_PIN = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="28" height="40" viewBox="0 0 28 40"><path fill="%23ffc107" d="M14 0C6.268 0 0 6.268 0 14c0 10.5 14 26 14 26s14-15.5 14-26C28 6.268 21.732 0 14 0z"/><circle cx="14" cy="14" r="6" fill="%23ffffff"/></svg>';

					var pinSize = new kakao.maps.Size(28, 40);
					var pinOffset = new kakao.maps.Point(14, 40);
					var blueImg = new kakao.maps.MarkerImage(BLUE_PIN, pinSize,
							{
								offset : pinOffset
							});
					var yellowImg = new kakao.maps.MarkerImage(YELLOW_PIN,
							pinSize, {
								offset : pinOffset
							});

					// 항상 센터 마커 먼저 (파란색)
					var centerPos = new kakao.maps.LatLng(37.49361, 127.0327);
					new kakao.maps.Marker({
						position : centerPos,
						map : map,
						title : '진료협력센터',
						image : blueImg
					});
					bounds.extend(centerPos);

					var base = '${pageContext.request.contextPath}';

					fetch(base + '/referral/partners/locations.do', {
						headers : {
							'Accept' : 'application/json'
						},
						credentials : 'same-origin'
					})
							.then(
									function(res) {
										if (!res.ok) {
											return res
													.text()
													.then(
															function(t) {
																throw new Error(
																		'HTTP '
																				+ res.status
																				+ ' '
																				+ res.statusText
																				+ ' / '
																				+ t
																						.substring(
																								0,
																								120));
															});
										}
										var ct = (res.headers
												.get('content-type') || '');
										if (ct.indexOf('application/json') === -1) {
											return res
													.text()
													.then(
															function(t) {
																throw new Error(
																		'Non-JSON response: '
																				+ ct
																				+ ' / '
																				+ t
																						.substring(
																								0,
																								120));
															});
										}
										return res.json();
									})
							.then(
									function(list) {
										if (Array.isArray(list)
												&& list.length > 0) {
											var jobs = list
													.map(function(item) {
														var title = item.name
																|| '';
														if (item.lat != null
																&& item.lng != null) {
															var p = new kakao.maps.LatLng(
																	item.lat,
																	item.lng);
															new kakao.maps.Marker(
																	{
																		position : p,
																		map : map,
																		title : title,
																		image : yellowImg
																	});
															bounds.extend(p);
															return Promise
																	.resolve();
														} else if (item.address) {
															return new Promise(
																	function(
																			resolve) {
																		geocoder
																				.addressSearch(
																						item.address,
																						function(
																								result,
																								status) {
																							if (status === kakao.maps.services.Status.OK
																									&& result[0]) {
																								var p = new kakao.maps.LatLng(
																										result[0].y,
																										result[0].x);
																								new kakao.maps.Marker(
																										{
																											position : p,
																											map : map,
																											title : title,
																											image : yellowImg
																										});
																								bounds
																										.extend(p);
																							}
																							resolve();
																						});
																	});
														} else {
															return Promise
																	.resolve();
														}
													});

											return Promise.all(jobs).then(
													function() {
														map.setBounds(bounds); // 센터+파트너 모두 보이도록
													});
										} else {
											map.setCenter(centerPos); // 파트너 없으면 센터만
										}
									}).then(null, function(err) {
								console.error('partners load fail', err);
								map.setCenter(centerPos); // 에러여도 센터 마커 유지
							});

				});
	</script>

	<%@ include file="/WEB-INF/jsp/referral/referral_footer.jsp"%>
</body>
</html>
