<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ESG 활동</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

	<!-- ✅ 공통 헤더 -->
	<jsp:include page="/WEB-INF/jsp/header.jsp" />

	<!-- ✅ 전체 레이아웃 -->
	<div class="max-w-7xl mx-auto px-4 py-12 flex gap-6">

		<!-- ✅ 왼쪽 사이드바 -->
		<aside class="w-64 shrink-0">
			<jsp:include page="/WEB-INF/jsp/hospital_info/04_menu.jsp" />
		</aside>

		<!-- ✅ 메인 콘텐츠 -->
		<main class="flex-1">

			<h2
				class="text-xl sm:text-2xl font-semibold text-black mb-8 border-b border-gray-200 pb-2">
				ESG 활동</h2>

			<!-- 소개문 -->
			<div class="mb-10 text-center">
				<p class="mt-2 text-gray-600 leading-relaxed">
					환경(Environment), 사회(Social), 지배구조(Governance)를 고려한 지속가능 경영을 실천합니다.<br />
					친환경 병원 운영, 지역사회 기여, 투명한 경영을 통해 건강한 미래를 만들어갑니다.
				</p>
			</div>

			<!-- 카드 그리드 -->
			<div id="cardGrid"
				class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
				<!-- 카드 반복 -->
				<c:forEach var="i" begin="1" end="9">
					<c:set var="badge" value="${i <= 3 ? 'E' : i <= 6 ? 'S' : 'G'}" />
					<c:set var="badgeColor"
						value="${i <= 3 ? 'bg-green-600' : i <= 6 ? 'bg-blue-600' : 'bg-yellow-600'}" />
					<c:set var="titles"
						value="${['병원 에너지 효율화','의료폐기물 저감·분리','물 사용 최적화','지역사회 건강증진','직원 복지·안전 강화','다양성·포용성','투명한 경영 공개','환자정보보호','리스크 관리 체계']}" />
					<c:set var="descs"
						value="${['고효율 설비 도입과 에너지 모니터링을 통해 전력 사용량을 절감합니다.',
                                       '배출 표준화와 분리수거 교육으로 폐기물 발생을 최소화합니다.',
                                       '회수·재활용 시스템으로 물 사용을 효율화합니다.',
                                       '무료검진·보건교육으로 지역사회 건강 형평성을 높입니다.',
                                       '안전교육과 복지 제도를 통해 근무환경을 개선합니다.',
                                       '차별 없는 의료 접근성과 내부 포용 문화를 확산합니다.',
                                       '윤리규범과 감사 결과를 정기적으로 공개합니다.',
                                       '개인정보 보호 체계를 고도화하고 정기 점검을 시행합니다.',
                                       '의료·경영 리스크를 통합 관리하는 체계를 운영합니다.']}" />
					<c:set var="dates"
						value="${['2025-03-20','2025-04-02','2025-04-18','2025-05-01','2025-05-10','2025-05-16','2025-06-01','2025-06-12','2025-06-20']}" />
					<c:set var="imgNames"
						value="${['env_energy','env_waste','env_water','social_volunteer','social_staff','social_inclusion','gov_transparency','gov_security','gov_risk']}" />

					<div
						class="bg-white border rounded-lg shadow hover:shadow-md transition overflow-hidden flex flex-col">
						<!-- ✅ 이미지 클릭 시 상세로 이동 -->
						<a
							href="${pageContext.request.contextPath}/hospital_info/esg/detail.do?id=${i}">
							<img
							src="<c:url value='/resources/images/esg/${imgNames[i-1]}.jpg' />"
							alt="${titles[i-1]}" class="w-full h-40 object-cover" />
						</a>
						<div class="p-4 flex flex-col flex-grow">
							<div class="flex items-center gap-2 mb-1">
								<span
									class="inline-block px-2 py-0.5 text-xs text-white rounded ${badgeColor} font-semibold">${badge}</span>
								<p class="text-xs text-gray-500">${dates[i-1]}</p>
							</div>
							<!-- ✅ 제목 클릭 시 상세로 이동 -->
							<h3 class="text-lg font-semibold text-gray-900">
								<a
									href="${pageContext.request.contextPath}/hospital_info/esg/detail.do?id=${i}">
									${titles[i-1]} </a>
							</h3>
							<p class="text-sm text-gray-700 mt-2 flex-grow">${descs[i-1]}</p>
							<div class="mt-4"></div>
						</div>
					</div>

				</c:forEach>
			</div>
		</main>
	</div>
</body>
</html>
