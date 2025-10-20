<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>예약/진료 안내</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
.step-box {
	background-color: #eef2ff; /* 남색 톤 연한 배경 */
	color: #1e3a8a; /* 남색 글씨 */
	font-weight: 600;
	width: 140px;
	padding: 12px;
	text-align: center;
	border-radius: 0.5rem;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	font-size: 14px;
}

.tab-btn.active {
	background-color: #1e3a8a;
}
</style>
</head>
<body class="bg-gray-50 text-gray-800">

	<main class="max-w-6xl mx-auto px-4 py-10">
		<!-- 제목 -->
		<h1
			class="text-xl sm:text-2xl font-bold text-center text-blue-900 mb-10">예약/진료
			안내</h1>

		<!-- 안내 텍스트 -->
		<div
			class="bg-white border border-gray-200 rounded-lg p-6 mb-10 text-sm space-y-3 leading-relaxed">
			<p>
				진료 예약은 <span class="font-semibold text-gray-900">회원/비회원 모두 가능</span>하며,
				전화, 방문, 인터넷으로 신청 가능합니다.
			</p>
			<p>
				<span class="font-semibold text-gray-900">당일 예약 시간 20분 전까지</span> 내원
				후 원무팀 수납/접수 바랍니다.
			</p>
			<p>
				예약 변경/취소는 <span class="font-semibold text-gray-900">진료 1일 전까지</span>
				연락 바랍니다.
			</p>
			<p>
				예약 확인은 <span class="font-semibold text-gray-900">1233-1233
					ARS 1번</span> 또는 병원 앱에서도 가능합니다.
			</p>

			<div
				class="bg-gray-100 border-l-4 border-blue-900 p-3 rounded text-sm text-gray-700">
				<strong>※ 상급종합병원 진료 시 진료의뢰서 지참 필수</strong><br> (미지참 시 건강보험 적용
				불가, 의료급여 수급자도 해당)
			</div>

			<div
				class="bg-gray-100 border-l-4 border-blue-900 p-3 rounded text-sm text-gray-700">
				<strong>※ 내원 시 환자 본인 신분증을 반드시 지참해 주세요.</strong>
			</div>
		</div>

		<!-- 탭 버튼 -->
		<div class="flex flex-wrap gap-2 justify-center mb-8">
			<button
				class="tab-btn active bg-blue-900 text-white font-medium px-5 py-2 rounded transition hover:bg-blue-800"
				onclick="showTab('internet', this)">인터넷예약</button>
			<button
				class="tab-btn bg-gray-200 text-gray-700 font-medium px-5 py-2 rounded transition hover:bg-gray-300"
				onclick="showTab('phone', this)">전화예약</button>
			<button
				class="tab-btn bg-gray-200 text-gray-700 font-medium px-5 py-2 rounded transition hover:bg-gray-300"
				onclick="showTab('visit', this)">방문예약</button>
			<button
				class="tab-btn bg-gray-200 text-gray-700 font-medium px-5 py-2 rounded transition hover:bg-gray-300"
				onclick="showTab('fast', this)">빠른예약</button>
		</div>


		<!-- 인터넷예약 -->
		<section id="internet" class="tab-content block">
			<div class="bg-white p-6 rounded-lg shadow mb-6">
				<h2 class="text-lg font-bold mb-3">인터넷 진료예약 안내</h2>
				<ul class="list-disc list-inside text-sm space-y-1">
					<li>회원 및 비회원 모두 예약이 가능합니다.</li>
					<li>대리 예약은 환자 정보 입력 후 이용하시기 바랍니다.</li>
				</ul>
			</div>

			<div class="bg-white p-6 rounded-lg shadow mb-6">
				<h2 class="text-lg font-bold mb-3">인터넷 진료예약 방법</h2>
				<div class="grid md:grid-cols-2 gap-6 text-sm">
					<div>
						<h3 class="font-semibold mb-2">본인 예약</h3>
						<ol class="list-decimal list-inside space-y-1">
							<li>개인정보 약관 동의</li>
							<li>환자등록번호 조회</li>
							<li>진료과/의료진 선택</li>
							<li><strong>예약 완료</strong></li>
						</ol>
					</div>
					<div>
						<h3 class="font-semibold mb-2">대리 예약</h3>
						<ol class="list-decimal list-inside space-y-1">
							<li>개인정보 약관 동의</li>
							<li>환자등록번호 조회</li>
							<li>환자 정보 입력</li>
							<li>진료과/의료진 선택</li>
							<li><strong>예약 완료</strong></li>
						</ol>
					</div>
				</div>
			</div>

			<div class="bg-white p-6 rounded-lg shadow mb-6">
				<h2 class="text-lg font-bold mb-4">인터넷 진료예약 절차</h2>
				<div class="mb-3 font-semibold">① 진료과를 아는 경우</div>
				<div class="flex flex-wrap gap-4 mb-6">
					<div class="step-box">
						STEP 1<br> <span>환자정보 인증</span>
					</div>
					<div class="step-box">
						STEP 2<br> <span>진료과 선택</span>
					</div>
					<div class="step-box">
						STEP 3<br> <span>의사, 예약일 선택</span>
					</div>
					<div class="step-box">
						STEP 4<br> <span>예약완료</span>
					</div>
				</div>

				<div class="mb-3 font-semibold">② 의료진을 선택하여 예약하는 경우</div>
				<div class="flex flex-wrap gap-4">
					<div class="step-box">
						STEP 1<br> <span>환자정보 인증</span>
					</div>
					<div class="step-box">
						STEP 2<br> <span>의료진 선택</span>
					</div>
					<div class="step-box">
						STEP 3<br> <span>소속, 예약일 선택</span>
					</div>
					<div class="step-box">
						STEP 4<br> <span>예약완료</span>
					</div>
				</div>
			</div>
			<!-- 추가 -->
			<%-- 링크용 URL 결정 --%>
			<c:choose>
				<%-- 환자 로그인(PatientVO)은 바로 예약 화면 --%>
				<c:when
					test="${not empty sessionScope.loginUser and not empty sessionScope.loginUser.patientName}">
					<c:url var="reserveUrl" value="/reservation.do" />
				</c:when>

				<%-- 의료진/관리자 등 다른 로그인 상태는 로그인 선택으로 --%>
				<c:when test="${not empty sessionScope.loginUser}">
					<c:url var="reserveUrl" value="/loginSelector.do">
						<c:param name="from" value="reserveGuide" />
					</c:url>
				</c:when>

				<%-- 비회원은 게스트 시작 페이지로 --%>
				<c:otherwise>
					<c:url var="reserveUrl" value="/reservation/guest-start.do">
						<c:param name="from" value="reserveGuide" />
					</c:url>
				</c:otherwise>
			</c:choose>

			<div class="text-right">
				<a href="${reserveUrl}"
					class="bg-blue-900 text-white px-6 py-2 rounded hover:bg-blue-800 transition">
					인터넷 예약 바로가기 </a>
			</div>
		</section>

		<!-- 전화예약 -->
		<section id="phone" class="tab-content hidden">
			<div class="bg-white p-6 rounded-lg shadow space-y-4 text-sm">
				<h2 class="text-lg font-bold">전화예약 안내</h2>
				<ul class="list-disc list-inside space-y-1">
					<li>예약센터 전화: <strong>1599-1004</strong></li>
					<li>운영시간: 평일 08:00~18:00 / 토요일 08:00~13:00</li>
				</ul>
				<h3 class="font-semibold mt-6">전화예약 절차</h3>
				<div class="flex flex-wrap gap-4">
					<div class="step-box">
						STEP 1<br> <span>전화 연결</span>
					</div>
					<div class="step-box">
						STEP 2<br> <span>주민번호 입력</span>
					</div>
					<div class="step-box">
						STEP 3<br> <span>예약 상담</span>
					</div>
					<div class="step-box">
						STEP 4<br> <span>접수/수납</span>
					</div>
				</div>
			</div>
		</section>

		<!-- 방문예약 -->
		<section id="visit" class="tab-content hidden">
			<div class="bg-white p-6 rounded-lg shadow space-y-4 text-sm">
				<h2 class="text-lg font-bold">방문예약 안내</h2>
				<ul class="list-disc list-inside space-y-1">
					<li>병원 접수창구에서 직접 예약 가능</li>
					<li>필요 서류(진료의뢰서, 신분증 등) 지참</li>
				</ul>
				<h3 class="font-semibold mt-6">방문예약 절차</h3>
				<div class="flex flex-wrap gap-4">
					<div class="step-box">
						STEP 1<br> <span>원무팀 방문</span>
					</div>
					<div class="step-box">
						STEP 2<br> <span>접수 및 신청</span>
					</div>
					<div class="step-box">
						STEP 3<br> <span>일정 결정</span>
					</div>
					<div class="step-box">
						STEP 4<br> <span>진료 방문</span>
					</div>
				</div>
			</div>
		</section>

		<!-- 빠른예약 -->
		<section id="fast" class="tab-content hidden">
			<div class="bg-white p-6 rounded-lg shadow space-y-4 text-sm">
				<h2 class="text-lg font-bold">빠른예약 안내</h2>
				<p>환자 또는 보호자의 연락처를 남기면 상담원이 전화드립니다.</p>
				<p>상담시간: 평일 08:30~17:30 / 토 08:30~12:30</p>
				<div class="text-center mt-6">
					<a href="${pageContext.request.contextPath}/reservation/fast.do"
						class="bg-blue-900 text-white px-6 py-3 rounded hover:bg-blue-800 transition inline-block">
						빠른 예약 신청 </a>
				</div>
			</div>
		</section>
	</main>

	<!-- 탭 스크립트 -->
	<script>
	function showTab(tabId, btn) {
		  // 탭 내용 변경
		  document.querySelectorAll('.tab-content').forEach(el => el.classList.add('hidden'));
		  document.getElementById(tabId).classList.remove('hidden');

		  // 버튼 스타일 변경
		  document.querySelectorAll('.tab-btn').forEach(b => {
		    b.classList.remove('bg-blue-900', 'text-white', 'hover:bg-blue-800', 'active');
		    b.classList.add('bg-gray-200', 'text-gray-700', 'hover:bg-gray-300');
		  });

		  btn.classList.remove('bg-gray-200', 'text-gray-700', 'hover:bg-gray-300');
		  btn.classList.add('bg-blue-900', 'text-white', 'hover:bg-blue-800', 'active');
		}

  </script>
</body>
</html>
