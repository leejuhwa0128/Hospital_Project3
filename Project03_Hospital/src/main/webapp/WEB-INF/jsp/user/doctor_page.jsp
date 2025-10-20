<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의사 마이페이지</title>
<style>
/* 전체 페이지 기본 레이아웃 */
.mypage-wrapper {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

.mypage-wrapper h2 {
	margin-bottom: 20px;
	font-size: 28px;
	color: #333;
}

.mypage-layout-container {
	display: flex;
	border: 1px solid #ddd;
	min-height: 600px;
	background: #fff;
}

.mypage-content-area {
	flex-grow: 1;
	padding: 40px;
}

.content-box {
	display: none;
}

.content-box.active {
	display: block;
}

.content-box h3 {
	font-size: 24px;
	margin-bottom: 15px;
	border-bottom: 2px solid #007bff;
	padding-bottom: 10px;
}

/* Sidebar (헤더와 충돌 방지: mp- 접두어 사용) */
.mypage-sidebar {
	width: 250px;
	background: #f0f8ff;
	border-right: 1px solid #e0f0ff;
	padding-top: 15px;
	box-sizing: border-box;
}

.mypage-menu {
	padding: 0;
	margin: 0;
}

/* 아코디언 헤더 */
.mp-menu {
	padding: 15px 20px;
	cursor: pointer;
	font-weight: bold;
	font-size: 16px;
	color: #004085;
	background: transparent;
	border: none;
	width: 100%;
	text-align: left;
	transition: background-color .3s ease;
	position: relative;
	box-sizing: border-box;
	border-bottom: 1px solid #ddd;
}

.mp-menu:hover {
	background: #eaf6ff;
}

/* 아코디언 콘텐츠 */
.mp-submenu {
	list-style: none;
	padding: 0;
	margin: 0;
	max-height: 0;
	overflow: hidden;
	background: #fff;
	transition: max-height .3s ease-out;
	border-top: 1px solid #e0f0ff;
}

.mp-submenu.active {
	max-height: 500px;
}

/* 링크 */
.mp-submenu a {
	display: block;
	padding: 15px 20px;
	text-decoration: none;
	color: #333;
	font-size: 14px;
	transition: background-color .3s ease, color .3s ease;
	box-sizing: border-box;
}

.mp-submenu a:hover, .mp-submenu a.active {
	background: #eaf6ff;
	color: #0056b3;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="mypage-wrapper">
		<h2>
			👤
			<c:out value="${sessionScope.loginSuccessName}" />
			님의 마이페이지
		</h2>

		<div class="mypage-layout-container">
			<div class="mypage-sidebar">
				<div class="mypage-menu">
					<!-- 공지사항 -->
					<div class="mp-menu">공지사항</div>
					<div class="mp-submenu">
						<a href="/01_notice/list.do" target="_blank"
							rel="noopener noreferrer">본원 (전체)</a> <a
							href="/referral/referral_notice.do" target="_blank"
							rel="noopener noreferrer">협력센터 (전체)</a>
					</div>

					<!-- 본원의 -->
					<div class="mp-menu">본원의</div>
					
					<div class="mp-submenu">
						<a href="${pageContext.request.contextPath}/doctor_schedule.do"
							target="_blank" rel="noopener noreferrer">내 스케줄 확인</a> <a
							href="${pageContext.request.contextPath}/doctor_certificates.do"
							target="_blank" rel="noopener noreferrer">내 예약 확인</a> <a
							href="${pageContext.request.contextPath}/past_certificates.do"
							target="_blank" rel="noopener noreferrer">진료의뢰 신청</a> <a
							href="${pageContext.request.contextPath}/referral2/received.do"
							target="_blank" rel="noopener noreferrer">진료의뢰 현황</a> <a
							href="${pageContext.request.contextPath}/certificates/doctor/pending.do"

							target="_blank" rel="noopener noreferrer">제증명 발급</a> <a
							href="${pageContext.request.contextPath}/doctor/main.do"
							target="_blank" rel="noopener noreferrer">의료진 검색</a>
					</div>
					<!-- 회원정보 서비스 -->
					<div class="mp-menu">회원정보 서비스</div>
					<div class="mp-submenu">
						<a href="#" data-content="edit-info" role="button">정보 수정/탈퇴</a> <a
							href="${pageContext.request.contextPath}/logout.do"
							onclick="return confirm('로그아웃 하시겠습니까?');">로그아웃</a>
					</div>
				</div>
			</div>

			<div class="mypage-content-area">
				<!-- 홈 -->
				<div id="content-home" class="content-box active">
					<h3>마이페이지에 오신 것을 환영합니다!</h3>
					<p>왼쪽 메뉴에서 원하는 서비스를 선택하세요.</p>
				</div>

				<!-- 공지 placeholder (필요 시 내부 렌더 사용) -->
				<div id="content-hospitalAll" class="content-box">
					<h3>본원 (전체) 공지사항</h3>
					<p>본원 공지사항 목록이 여기에 표시됩니다.</p>
				</div>
				<div id="content-collaboAll" class="content-box">
					<h3>협력센터 (전체) 공지사항</h3>
					<p>협력센터 공지사항 목록이 여기에 표시됩니다.</p>
				</div>

				<!-- [본문 영역] 본원의 탭별 컨텐츠 박스 - 그대로 붙여넣기 -->
				<div id="content-my-schedule" class="content-box">
					<h3>내 스케줄 확인</h3>
					<p>스케줄 데이터가 여기에 표시됩니다.</p>
				</div>

				<div id="content-my-reservation" class="content-box">
					<h3>내 예약 확인</h3>
					<p>예약 내역이 여기에 표시됩니다.</p>
				</div>

				<div id="content-referral-apply" class="content-box">
					<h3>진료의뢰 신청</h3>
					<p>진료의뢰 신청 폼이 여기에 표시됩니다.</p>
				</div>

				<div id="content-referral-status" class="content-box">
					<h3>진료의뢰 현황</h3>
					<p>진료의뢰 현황 내역이 여기에 표시됩니다.</p>
				</div>

				<div id="content-doctor-pending" class="content-box">
					<h3>제증명 발급</h3>

				</div>

				<!-- 기타 -->
				<div id="content-doctor-search" class="content-box">
					<h3>의료진 검색</h3>
					<p>의료진 검색 페이지 내용이 여기에 표시됩니다.</p>
				</div>

				<div id="content-edit-info" class="content-box">
					<h3>정보 수정/탈퇴</h3>
					<jsp:include page="/user/profileEdit.do" />
				</div>
			</div>
		</div>
	</div>

	<script>
      document.addEventListener('DOMContentLoaded', function() {
         var sidebar = document.querySelector('.mypage-sidebar');
         var menuLinks = sidebar
               .querySelectorAll('.mp-submenu a[data-content]');
         var boxes = document
               .querySelectorAll('.mypage-content-area .content-box');
         var menus = sidebar.querySelectorAll('.mp-menu');

         function showContent(id) {
            menuLinks.forEach(function(a) {
               a.classList.remove('active');
            });
            boxes.forEach(function(b) {
               b.classList.remove('active');
            });

            var target = document.getElementById('content-' + id);
            if (target) {
               target.classList.add('active');
               var active = sidebar
                     .querySelector('.mp-submenu a[data-content="' + id
                           + '"]');
               if (active)
                  active.classList.add('active');
            } else {
               document.getElementById('content-home').classList
                     .add('active');
            }
         }

         function closeAllAccordions() {
            menus.forEach(function(m) {
               var s = m.nextElementSibling;
               if (s)
                  s.classList.remove('active');
            });
         }

         function openAccordion(btn) {
            var sub = btn.nextElementSibling;
            if (sub)
               sub.classList.add('active');
         }

         sidebar.addEventListener('click', function(e) {
            var t = e.target;

            // 내부 컨텐츠 열기
            if (t.tagName === 'A' && t.dataset.content) {
               e.preventDefault();
               showContent(t.dataset.content);

               var parent = t.closest('.mp-submenu');
               if (parent) {
                  closeAllAccordions();
                  openAccordion(parent.previousElementSibling);
               }
            }

            // 아코디언 토글
            if (t.classList.contains('mp-menu')) {
               var sub = t.nextElementSibling;
               var willOpen = !sub.classList.contains('active');
               closeAllAccordions();
               if (willOpen)
                  sub.classList.add('active');
            }
         });

         // 초기 상태: 공지사항 + 본원의 둘 다 펼치기
         if (menus.length >= 2) {
            menus[0].nextElementSibling.classList.add('active'); // 공지사항
            menus[1].nextElementSibling.classList.add('active'); // 본원의
         } else if (menus.length) {
            menus[0].nextElementSibling.classList.add('active');
         }

         // 기본 콘텐츠
         showContent('home');
      });
   </script>
</body>
</html>

<jsp:include page="/WEB-INF/jsp/footer.jsp" />
