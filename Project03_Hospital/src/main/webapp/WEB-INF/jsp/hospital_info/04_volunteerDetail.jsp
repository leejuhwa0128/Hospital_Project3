<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="embed" value="${param.embed eq '1'}" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<c:if test="${not embed}">
	<!DOCTYPE html>
	<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>의료 봉사 활동 상세</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://cdn.tailwindcss.com"></script>
<style>
.line-clamp-2 {
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden
}

.line-clamp-3 {
	display: -webkit-box;
	-webkit-line-clamp: 3;
	-webkit-box-orient: vertical;
	overflow: hidden
}
</style>
</head>
<body class="bg-gray-50 text-gray-800">
</c:if>

<main
	class="<c:out value='${embed ? "px-0 py-0" : "max-w-5xl mx-auto px-6 py-10"}'/>">

	<%-- id 기본값 처리 --%>
	<c:set var="idNum" value="${empty param.id ? 1 : param.id}" />

	<%-- 봉사활동 데이터 분기 --%>
	<c:choose>
		<c:when test="${idNum == 1}">
			<c:set var="title" value="의료 봉사 활동 1" />
			<c:set var="date" value="2025-08-01" />
			<c:set var="location" value="국내 외진 지역" />
			<c:set var="summary" value="국내 외진 지역에서 의료 봉사를 진행하며 건강을 나누는 활동입니다." />
			<c:set var="thumb" value="/resources/images/volunteer/thumbnail1.jpg" />
			<c:set var="tags" value="무료진료, 지역보건, 예방접종" />
		</c:when>
		<c:when test="${idNum == 2}">
			<c:set var="title" value="의료 봉사 활동 2" />
			<c:set var="date" value="2025-08-05" />
			<c:set var="location" value="전남 · 도서지역" />
			<c:set var="summary" value="봉사자들이 함께 참여한 의료 봉사로 환자들의 치료를 지원하였습니다." />
			<c:set var="thumb" value="/resources/images/volunteer/thumbnail2.jpg" />
			<c:set var="tags" value="외과, 처치, 긴급의료" />
		</c:when>
		<c:when test="${idNum == 3}">
			<c:set var="title" value="의료 봉사 활동 3" />
			<c:set var="date" value="2025-08-10" />
			<c:set var="location" value="충북 · 농촌" />
			<c:set var="summary" value="필요한 의료 장비를 제공하며 봉사 활동을 했습니다." />
			<c:set var="thumb" value="/resources/images/volunteer/thumbnail3.jpg" />
			<c:set var="tags" value="의료장비지원, 검진, 교육" />
		</c:when>
		<c:when test="${idNum == 4}">
			<c:set var="title" value="의료 봉사 활동 4" />
			<c:set var="date" value="2025-08-12" />
			<c:set var="location" value="강원도" />
			<c:set var="summary" value="원격지의 어린이들에게 의료 서비스를 제공하는 봉사 활동입니다." />
			<c:set var="thumb" value="/resources/images/volunteer/thumbnail4.jpg" />
			<c:set var="tags" value="의료장비지원, 검진, 교육" />
		</c:when>
		<c:when test="${idNum == 5}">
			<c:set var="title" value="의료 봉사 활동 5" />
			<c:set var="date" value="2025-08-15" />
			<c:set var="location" value="서울 장애인 중앙 센터" />
			<c:set var="summary" value="장애인을 위한 무료 건강 검진을 제공한 봉사 활동입니다." />
			<c:set var="thumb" value="/resources/images/volunteer/thumbnail3.jpg" />
			<c:set var="tags" value="의료장비지원, 검진, 교육" />
		</c:when>
		<c:when test="${idNum == 6}">
			<c:set var="title" value="의료 봉사 활동 6" />
			<c:set var="date" value="2025-08-20" />
			<c:set var="location" value="장애인센터" />
			<c:set var="summary" value="결핵 환자들을 위한 의료 봉사 및 치료 지원 활동입니다." />
			<c:set var="thumb" value="/resources/images/volunteer/thumbnail6.jpg" />
			<c:set var="tags" value="의료장비지원, 검진, 교육" />
		</c:when>
		<c:otherwise>
			<c:set var="title" value="의료 봉사 활동" />
			<c:set var="date" value="2025-08-15" />
			<c:set var="location" value="기타 지역" />
			<c:set var="summary" value="지역 여건에 맞춘 맞춤형 진료와 보건 교육을 실시했습니다." />
			<c:set var="thumb" value="/resources/images/volunteer/thumbnail1.jpg" />
			<c:set var="tags" value="무료진료, 보건교육" />
		</c:otherwise>
	</c:choose>

	<%-- 카드 래퍼(임베드일 땐 외곽 카드/그림자 생략) --%>
	<section
		class="<c:out value='${embed ? "" : "bg-white rounded-2xl shadow border border-gray-100"}'/>">
		<div class="<c:out value='${embed ? "p-0" : "p-6 sm:p-8"}'/>">

			<%-- 헤더 --%>
			<div class="grid grid-cols-1 md:grid-cols-3 gap-6 items-start">
				<div
					class="relative overflow-hidden rounded-xl ring-1 ring-gray-200">
					<img src="${ctx}${thumb}" alt="${title}"
						class="h-56 w-full object-cover md:h-full transition-transform duration-300 hover:scale-105" />
					<div
						class="absolute inset-x-0 bottom-0 bg-gradient-to-t from-black/50 to-transparent h-20"></div>
					<span
						class="absolute top-3 left-3 inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md text-xs font-medium bg-white/90 text-gray-800 ring-1 ring-gray-200">
						<%-- 달력 아이콘 --%> <svg xmlns="http://www.w3.org/2000/svg"
							class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none"
							stroke="currentColor">
							<rect x="3" y="4" width="18" height="18" rx="2" ry="2" />
							<line x1="16" y1="2" x2="16" y2="6" />
							<line x1="8" y1="2" x2="8" y2="6" />
							<line x1="3" y1="10" x2="21" y2="10" /></svg> ${date}
					</span> <span
						class="absolute top-3 right-3 inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md text-xs font-medium bg-white/90 text-gray-800 ring-1 ring-gray-200">
						<%-- 위치 아이콘 --%> <svg xmlns="http://www.w3.org/2000/svg"
							class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none"
							stroke="currentColor">
							<path d="M12 21s-6-5.33-6-10a6 6 0 1 1 12 0c0 4.67-6 10-6 10z" />
							<circle cx="12" cy="11" r="2.5" /></svg> ${location}
					</span>
				</div>

				<div class="md:col-span-2">
					<h1
						class="text-2xl md:text-3xl font-bold text-gray-900 tracking-tight">${title}</h1>
					<p class="mt-3 text-gray-700 leading-relaxed">${summary}</p>
					<div class="mt-4 flex flex-wrap gap-2">
						<c:forEach var="tag" items="${fn:split(tags, ',')}">
							<span
								class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium bg-blue-50 text-blue-700 ring-1 ring-blue-100">
								${fn:trim(tag)} </span>
						</c:forEach>
					</div>
				</div>
			</div>

			<hr class="my-8 border-gray-200" />

			<%-- 본문 --%>
			<div class="space-y-8">
				<c:choose>
					<c:when test="${idNum == 1}">
						<section>
							<h2
								class="text-lg font-semibold text-gray-900 flex items-center gap-2">
								<svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5"
									viewBox="0 0 24 24" fill="none" stroke="currentColor">
									<path
										d="M20 7v10a2 2 0 0 1-2 2H8l-4-4V7a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2z" /></svg>
								진료 개요
							</h2>
							<p class="mt-2 text-gray-700">의사, 간호사, 약사, 물리치료사 등 15명이 팀을
								이루어 고혈압·당뇨 선별검사와 투약 상담을 진행했습니다.</p>

							<h3 class="mt-5 text-sm font-semibold text-gray-900">주요 활동</h3>
							<ul class="mt-2 space-y-2 text-gray-700">
								<li class="flex items-start gap-2"><span
									class="mt-1 inline-block w-1.5 h-1.5 rounded-full bg-blue-600"></span>기초
									건강검진(혈압, 혈당, 체성분)</li>
								<li class="flex items-start gap-2"><span
									class="mt-1 inline-block w-1.5 h-1.5 rounded-full bg-blue-600"></span>만성질환
									약물 복약지도</li>
								<li class="flex items-start gap-2"><span
									class="mt-1 inline-block w-1.5 h-1.5 rounded-full bg-blue-600"></span>예방접종
									및 위생 교육</li>
							</ul>
						</section>
					</c:when>

					<c:when test="${idNum == 2}">
						<section>
							<h2
								class="text-lg font-semibold text-gray-900 flex items-center gap-2">
								<svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5"
									viewBox="0 0 24 24" fill="none" stroke="currentColor">
									<path d="M12 22s8-4.5 8-12a8 8 0 1 0-16 0c0 7.5 8 12 8 12z" /></svg>
								진료 개요
							</h2>
							<p class="mt-2 text-gray-700">도서 지역 보건소와 연계하여 외상 처치 및 응급 대응
								훈련을 병행했습니다.</p>

							<h3 class="mt-5 text-sm font-semibold text-gray-900">주요 활동</h3>
							<ul class="mt-2 space-y-2 text-gray-700">
								<li class="flex items-start gap-2"><span
									class="mt-1 inline-block w-1.5 h-1.5 rounded-full bg-emerald-600"></span>외상
									환자 응급 처치</li>
								<li class="flex items-start gap-2"><span
									class="mt-1 inline-block w-1.5 h-1.5 rounded-full bg-emerald-600"></span>보건소
									인력 대상 BLS 교육</li>
								<li class="flex items-start gap-2"><span
									class="mt-1 inline-block w-1.5 h-1.5 rounded-full bg-emerald-600"></span>응급키트
									보급</li>
							</ul>
						</section>
					</c:when>

					<c:otherwise>
						<section>
							<h2
								class="text-lg font-semibold text-gray-900 flex items-center gap-2">
								<svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5"
									viewBox="0 0 24 24" fill="none" stroke="currentColor">
									<path d="M3 12h18M3 6h18M3 18h18" /></svg>
								활동 개요
							</h2>
							<p class="mt-2 text-gray-700">지역 여건에 맞춘 맞춤형 진료와 보건 교육을
								실시했습니다.</p>

							<h3 class="mt-5 text-sm font-semibold text-gray-900">주요 활동</h3>
							<ul class="mt-2 space-y-2 text-gray-700">
								<li class="flex items-start gap-2"><span
									class="mt-1 inline-block w-1.5 h-1.5 rounded-full bg-indigo-600"></span>무료
									진료 및 투약 상담</li>
								<li class="flex items-start gap-2"><span
									class="mt-1 inline-block w-1.5 h-1.5 rounded-full bg-indigo-600"></span>예방
									및 위생 교육</li>
								<li class="flex items-start gap-2"><span
									class="mt-1 inline-block w-1.5 h-1.5 rounded-full bg-indigo-600"></span>지자체·보건소
									협력 네트워크 구축</li>
							</ul>
						</section>
					</c:otherwise>
				</c:choose>
			</div>



			<hr class="my-8 border-gray-200" />

			<%-- 정보 박스 --%>
			<section>
				<h2 class="text-lg font-semibold text-gray-900">기본 정보</h2>
				<div class="mt-4 grid grid-cols-1 sm:grid-cols-2 gap-4 text-sm">
					<div
						class="flex items-start gap-3 p-4 rounded-xl bg-gray-50 ring-1 ring-gray-200">
						<svg xmlns="http://www.w3.org/2000/svg"
							class="w-5 h-5 mt-0.5 text-gray-600" viewBox="0 0 24 24"
							fill="none" stroke="currentColor">
							<rect x="3" y="4" width="18" height="18" rx="2" />
							<line x1="16" y1="2" x2="16" y2="6" />
							<line x1="8" y1="2" x2="8" y2="6" />
							<line x1="3" y1="10" x2="21" y2="10" /></svg>
						<div>
							<span class="font-semibold">진행일:</span> <span
								class="text-gray-700">${date}</span>
						</div>
					</div>
					<div
						class="flex items-start gap-3 p-4 rounded-xl bg-gray-50 ring-1 ring-gray-200">
						<svg xmlns="http://www.w3.org/2000/svg"
							class="w-5 h-5 mt-0.5 text-gray-600" viewBox="0 0 24 24"
							fill="none" stroke="currentColor">
							<path d="M12 21s-6-5.33-6-10a6 6 0 1 1 12 0c0 4.67-6 10-6 10z" />
							<circle cx="12" cy="11" r="2.5" /></svg>
						<div>
							<span class="font-semibold">장소:</span> <span
								class="text-gray-700">${location}</span>
						</div>
					</div>
					<div
						class="flex items-start gap-3 p-4 rounded-xl bg-gray-50 ring-1 ring-gray-200">
						<svg xmlns="http://www.w3.org/2000/svg"
							class="w-5 h-5 mt-0.5 text-gray-600" viewBox="0 0 24 24"
							fill="none" stroke="currentColor">
							<path d="M3 7h18M6 7v10m12-10v10M6 17h12" /></svg>
						<div>
							<span class="font-semibold">참여 인원:</span> <span
								class="text-gray-700">약 10~20명</span>
						</div>
					</div>
					<div
						class="flex items-start gap-3 p-4 rounded-xl bg-gray-50 ring-1 ring-gray-200">
						<svg xmlns="http://www.w3.org/2000/svg"
							class="w-5 h-5 mt-0.5 text-gray-600" viewBox="0 0 24 24"
							fill="none" stroke="currentColor">
							<path d="M22 12h-4l-3 9L9 3l-3 9H2" /></svg>
						<div>
							<span class="font-semibold">문의:</span> <span
								class="text-gray-700">봉사코디네이터 (02-1234-5678)</span>
						</div>
					</div>
				</div>
			</section>
			
			
						<hr class="my-8 border-gray-200" />

			<!-- ✅ 갤러리 -->
			<section class="mt-10">
				<h2 class="text-lg font-semibold text-gray-900">현장 스냅</h2>
				<div class="mt-4 grid grid-cols-1 sm:grid-cols-3 gap-4">
					<c:forEach var="n" begin="1" end="3">
						<div class="overflow-hidden rounded-xl ring-1 ring-gray-200">
							<img
								src="<c:url value='/resources/images/volunteer/${idNum}_${n}.jpg'/>"
								alt="활동 ${idNum} 사진 ${n}"
								class="w-full h-40 object-cover transition-transform duration-300 hover:scale-105"
								onerror="this.onerror=null; this.src='${ctx}${thumb}';" />
						</div>
					</c:forEach>
				</div>
			</section>

			<%-- 네비게이션 (임베드 모드에서는 숨김) --%>
			<c:if test="${not embed}">
				<div class="mt-10 flex items-center justify-between">
					<c:set var="prevId" value="${idNum - 1}" />
					<c:set var="nextId" value="${idNum + 1}" />
					<c:if test="${prevId < 1}">
						<c:set var="prevId" value="1" />
					</c:if>
					<c:if test="${nextId > 12}">
						<c:set var="nextId" value="12" />
					</c:if>

					<a
						href="<c:url value='/hospital_info/volunteer/detail.do'><c:param name='id' value='${prevId}'/></c:url>"
						class="inline-flex items-center gap-1 text-blue-600 hover:text-blue-700">
						<svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4"
							viewBox="0 0 24 24" fill="none" stroke="currentColor">
							<path d="M15 18l-6-6 6-6" /></svg> 이전
					</a> <a href="${ctx}/04_volunteer.do"
						class="inline-flex items-center gap-1 px-3 py-1.5 rounded-md bg-blue-600 text-white hover:bg-blue-700">
						목록으로 </a> <a
						href="<c:url value='/hospital_info/volunteer/detail.do'><c:param name='id' value='${nextId}'/></c:url>"
						class="inline-flex items-center gap-1 text-blue-600 hover:text-blue-700">
						다음 <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4"
							viewBox="0 0 24 24" fill="none" stroke="currentColor">
							<path d="M9 18l6-6-6-6" /></svg>
					</a>
				</div>
			</c:if>

		</div>
	</section>
	<br>
<br>


</main>

<c:if test="${not embed}">
	</body>
	</html>
</c:if>
