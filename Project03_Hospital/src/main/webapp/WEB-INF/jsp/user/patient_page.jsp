<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String iframe = request.getParameter("iframe");
boolean isIframe = "true".equals(iframe);
%>

<%
	if (!isIframe) {
%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<%
	}
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<!-- Tailwind + Flowbite -->
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.js"></script>
<link href="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.css"
	rel="stylesheet" />
</head>

<body class="bg-gray-50 min-h-screen text-gray-800">
	<main class="max-w-7xl mx-auto px-4 py-10">
		<h2 class="text-2xl font-bold text-center text-blue-800 mb-10">
			<c:out value="${sessionScope.loginSuccessName}" />
			님의 마이페이지
		</h2>

		<div class="grid grid-cols-1 md:grid-cols-4 gap-6">
			<!-- Sidebar -->
			<aside class="space-y-6 md:col-span-1">
				<div class="bg-blue-100 p-4 rounded">
					<h3 class="font-semibold text-blue-900 mb-2">📌 예약/진료</h3>
					<ul class="space-y-1 text-sm">
						<li><a
							href="${pageContext.request.contextPath}/reservation.do"
							target="_blank" rel="noopener noreferrer"
							class="block p-2 rounded hover:bg-blue-200">진료 예약</a></li>

						<li><a
							href="${pageContext.request.contextPath}/reservation/my.do"
							target="_blank" rel="noopener noreferrer"
							class="block p-2 rounded hover:bg-blue-200">예약 확인</a></li>

						<li><a
							href="${pageContext.request.contextPath}/certificates/request.do"
							target="_blank" rel="noopener noreferrer"
							class="block p-2 rounded hover:bg-blue-200">증명서 발급</a></li>
						
						<li><a
							href="${pageContext.request.contextPath}/certificates/history.do"
							target="_blank" rel="noopener noreferrer"
							class="block p-2 rounded hover:bg-blue-200">서류 발급 이력 조회</a></li>

						
					</ul>
				</div>

				<div class="bg-blue-100 p-4 rounded">
					<h3 class="font-semibold text-blue-900 mb-2">📌 문의 서비스</h3>
					<ul class="space-y-1 text-sm">
						<li><a
							href="${pageContext.request.contextPath}/reservation/counsel/list.do"
							target="_blank" rel="noopener noreferrer"
							class="block p-2 rounded hover:bg-blue-200 text-blue-800">상담
								내역</a></li>

						<li><a
							href="${pageContext.request.contextPath}/03_feedback/mylist.do"
							target="_blank" rel="noopener noreferrer"
							class="block p-2 rounded hover:bg-blue-200 text-blue-800">고객의
								소리</a></li>
					</ul>
				</div>






				<div class="bg-blue-100 p-4 rounded">
					<h3 class="font-semibold text-blue-900 mb-2">📌 회원 정보</h3>
					<ul class="space-y-1 text-sm">
						<li><a href="#" data-content="edit-info"
							class="sub-link block px-4 py-2 text-blue-800 hover:bg-blue-100 rounded">
								정보 수정 / 탈퇴 </a></li>

						<li><a href="${pageContext.request.contextPath}/logout.do"
							onclick="return confirm('로그아웃 하시겠습니까?');"
							class="block p-2 rounded text-red-600 hover:bg-red-100">로그아웃</a>
						</li>
					</ul>
				</div>
			</aside>

			<!-- Main Content -->
			<section class="md:col-span-3 space-y-6">
				<!-- Home -->
				<div id="content-home" class="content-box">
					<div class="bg-white rounded shadow p-6">
						<h3 class="text-xl font-bold text-blue-800 mb-2">마이페이지 안내</h3>
						<p class="text-gray-600">왼쪽 메뉴에서 원하는 기능을 선택해 주세요.</p>
					</div>
				</div>

				<!-- 진료 예약 -->
				<div id="content-reservation" class="content-box hidden">
					<div class="bg-white rounded shadow p-6">
						<h3 class="text-lg font-bold text-blue-800 mb-2">진료 예약</h3>
						<p class="text-gray-600 mb-4">병원 예약을 신청할 수 있습니다.</p>
						<a href="${pageContext.request.contextPath}/reservation.do"
							class="text-sm text-blue-600 underline hover:text-blue-800">
							상세 보기 </a>
					</div>
				</div>

				<!-- 예약 확인 -->
				<div id="content-reservation-confirm" class="content-box hidden">
					<div class="bg-white rounded shadow p-6">
						<h3 class="text-lg font-bold text-blue-800 mb-2">예약 확인</h3>
						<p class="text-gray-600 mb-4">진료 예약 내용을 확인할 수 있습니다.</p>
						<a href="${pageContext.request.contextPath}/reservation/my.do"
							class="text-sm text-blue-600 underline hover:text-blue-800">
							상세 보기 </a>
					</div>
				</div>

				<!-- 진료 이력 -->
				<div id="content-history" class="content-box hidden">
					<div class="bg-white rounded shadow p-6">
						<h3 class="text-lg font-bold text-blue-800 mb-2">진료 이력</h3>
						<p class="text-gray-600 mb-4">과거 진료 기록을 확인할 수 있습니다.</p>
						<button data-modal-target="modal-history"
							data-modal-toggle="modal-history"
							class="text-sm text-blue-600 underline hover:text-blue-800">상세
							보기</button>
					</div>
				</div>

				<!-- 증명서 발급 -->
				<div id="content-certificate" class="content-box hidden">
					<div class="bg-white rounded shadow p-6">
						<h3 class="text-lg font-bold text-blue-800 mb-2">증명서 발급</h3>
						<p class="text-gray-600 mb-4">증명서를 발급받을 수 있습니다.</p>
						<a
							href="${pageContext.request.contextPath}/certificates/request.do"
							class="text-sm text-blue-600 underline hover:text-blue-800">
							상세 보기 </a>
					</div>
				</div>

				<!--  상담 내역 -->
				<div id="content-counsel" class="content-box hidden">
					<div class="bg-white rounded shadow p-6">
						<h3 class="text-lg font-bold text-blue-800 mb-2">상담 내역</h3>
						<p class="text-gray-600 mb-4">과거 상담 내역을 확인할 수 있습니다.</p>
						<a
							href="${pageContext.request.contextPath}/reservation/counsel/list.do"
							class="text-sm text-blue-600 underline hover:text-blue-800">
							상세 보기 </a>
					</div>
				</div>
				<!--  상담 내역 -->
				<div id="content-feedback" class="content-box hidden">
					<div class="bg-white rounded shadow p-6">
						<h3 class="text-lg font-bold text-blue-800 mb-2">고객의 소리</h3>
						<p class="text-gray-600 mb-4">고객 의견을 확인하고 관리할 수 있습니다.</p>
						<a href="${pageContext.request.contextPath}/03_feedback/mylist.do"
							class="text-sm text-blue-600 underline hover:text-blue-800">
							상세 보기 </a>
					</div>



				</div>
				<div id="content-edit-info" class="content-box hidden">
					<h3 class="text-lg font-bold text-blue-800 mb-2">정보 수정 / 탈퇴</h3>
					<jsp:include page="/patient/editPatientForm.do" />
				</div>



			</section>
		</div>
	</main>

	<!-- 🔽 공통 모달 (Flowbite + iframe) -->





	<div id="modal-edit" class="modal-template">
		<iframe id="iframe-modal-edit"></iframe>
	</div>



	<div id="modal-counsel" class="modal-template">
		<iframe id="iframe-modal-counsel"></iframe>
	</div>
	<div id="modal-feedback" class="modal-template">
		<iframe id="iframe-modal-feedback"></iframe>
	</div>

	<div id="modal-reservation" class="modal-template">
		<iframe id="iframe-modal-reservation" src="about:blank"></iframe>
	</div>
	<div id="modal-reservation-confirm" class="modal-template">
		<iframe id="iframe-modal-reservation-confirm" src="about:blank"></iframe>
	</div>
	<div id="modal-history" class="modal-template">
		<iframe id="iframe-modal-history" src="about:blank"></iframe>
	</div>
	<div id="modal-certificate" class="modal-template">
		<iframe id="iframe-modal-certificate" src="about:blank"></iframe>
	</div>





	<style>
.modal-template {
	display: none;
	position: fixed;
	inset: 0;
	z-index: 50;
	background-color: rgba(0, 0, 0, 0.5);
	padding: 1rem;
}

.modal-template.active {
	display: flex;
	align-items: center;
	justify-content: center;
}

.modal-template>iframe {
	width: 100%;
	max-width: 900px;
	height: 600px;
	border-radius: 0.5rem;
	border: none;
	background: white;
}
</style>

	<script>
    document.addEventListener('DOMContentLoaded', function () {
      const links = document.querySelectorAll('a[data-content]');
      const boxes = document.querySelectorAll('.content-box');

      function showContent(id) {
        boxes.forEach(box => box.classList.add('hidden'));
        const target = document.getElementById('content-' + id);
        if (target) target.classList.remove('hidden');

        document.querySelectorAll('.sub-link').forEach(link => link.classList.remove('bg-blue-300'));
        const active = document.querySelector(`a[data-content="${id}"]`);
        if (active) active.classList.add('bg-blue-300');
      }

      links.forEach(link => {
        link.addEventListener('click', function (e) {
          e.preventDefault();
          const id = this.getAttribute('data-content');
          window.location.hash = id;
          showContent(id);
        });
      });

      const hash = window.location.hash.replace('#', '');
      if (hash) showContent(hash);
      else showContent('home');
    });

    // 모달 열기
    function openModalWithURL(modalId, url) {
      const modal = document.getElementById(modalId);
      const iframe = document.getElementById('iframe-' + modalId);
      if (modal && iframe) {
        iframe.src = url;
        modal.classList.add('active');
        modal.addEventListener('click', (e) => {
          if (e.target === modal) {
            modal.classList.remove('active');
            iframe.src = 'about:blank';
          }
        });
      }
    }
  </script>
</body>
</html>

<jsp:include page="/WEB-INF/jsp/footer.jsp" />
