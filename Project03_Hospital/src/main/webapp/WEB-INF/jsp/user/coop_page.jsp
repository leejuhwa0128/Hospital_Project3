<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>협진의 마이페이지</title>
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
	background-color: #fff;
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

/* Sidebar 스타일 (제공된 doctor_mypage_sidebar.jsp 기반) */
.mypage-sidebar {
	width: 250px;
	background-color: #f0f8ff; /* 연한 하늘색 배경 */
	border-right: 1px solid #e0f0ff;
	padding-top: 15px;
	box-sizing: border-box;
}

.mypage-menu {
	padding: 0;
	margin: 0;
}

/* 메뉴 그룹 (아코디언 헤더) 스타일 */
.menu {
	padding: 15px 20px;
	cursor: pointer;
	font-weight: bold;
	font-size: 16px;
	color: #004085; /* 진한 파란색 글씨 */
	background-color: transparent;
	border: none;
	width: 100%;
	text-align: left;
	transition: background-color 0.3s ease;
	position: relative;
	box-sizing: border-box;
	border-bottom: 1px solid #ddd;
}

.menu:hover {
	background-color: #eaf6ff; /* 호버 시 더 밝은 하늘색 */
}

/* 서브메뉴 (아코디언 콘텐츠) 스타일 */
.submenu {
	list-style: none;
	padding: 0;
	margin: 0;
	max-height: 0;
	overflow: hidden;
	background-color: #ffffff; /* 하위 메뉴 배경색 */
	transition: max-height 0.3s ease-out;
	border-top: 1px solid #e0f0ff;
}

.submenu.active {
	max-height: 300px; /* 펼쳐졌을 때의 최대 높이 */
}

/* 서브메뉴 링크 스타일 */
.submenu a {
	display: block;
	padding: 15px 20px;
	text-decoration: none;
	color: #333;
	font-size: 14px;
	transition: background-color 0.3s ease, color 0.3s ease;
	box-sizing: border-box;
}

.submenu a:hover, .submenu a.active {
	background-color: #eaf6ff;
	color: #0056b3;
	font-weight: bold;
}
</style>
</head>
<body>
	<%-- 이 부분은 사용자가 로그인할 때 세션에 저장된 이름을 사용합니다. --%>
	<div class="mypage-wrapper">
		<h2>
			👤
			<c:out value="${sessionScope.loginSuccessName}" />
			님의 마이페이지
		</h2>

		<div class="mypage-layout-container">
			<div class="mypage-sidebar">
				<div class="mypage-menu">
					<div class="menu">공지사항</div>
					<div class="submenu">
						<a href="/01_notice/list.do" target="_blank" rel="noopener noreferrer">본원 (전체)</a> <a
							href="/referral/referral_notice.do" target="_blank" rel="noopener noreferrer">협력센터 (전체)</a>
					</div>

					<div class="menu">협진의</div>
					<div class="submenu">
						<a href="${pageContext.request.contextPath}/referral/status.do"
							target="_blank" rel="noopener noreferrer">진료의뢰 현황</a> <a
							href="${pageContext.request.contextPath}/referral/statusAll.do"
							target="_blank" rel="noopener noreferrer">의뢰/회송 환자 결과 조회</a> <a
							href="${pageContext.request.contextPath}/referral/doctor.do"
							target="_blank" rel="noopener noreferrer">의료진 검색</a>
					</div>

					<div class="menu">회원정보 서비스</div>
					<div class="submenu">
						<a href="#" data-content="edit-info" role="button">정보 수정/탈퇴</a> <a
							href="${pageContext.request.contextPath}/referral/logout.do"
							onclick="return confirmLogout();">로그아웃</a>
					</div>
				</div>
			</div>

			<div class="mypage-content-area">
				<div id="content-home" class="content-box active">
					<h3>마이페이지에 오신 것을 환영합니다!</h3>
					<p>왼쪽 메뉴에서 원하는 서비스를 선택하세요.</p>
				</div>

				<div id="content-hospitalAll" class="content-box">
					<h3>본원 (전체) 공지사항</h3>
					<p>본원 공지사항 목록이 여기에 표시됩니다.</p>
				</div>
				<div id="content-collaboAll" class="content-box">
					<h3>협력센터 (전체) 공지사항</h3>
					<p>협력센터 공지사항 목록이 여기에 표시됩니다.</p>
				</div>
				<div id="content-referral-status" class="content-box">
					<h3>진료의뢰 현황</h3>
					<p>진료의뢰 현황 내역이 여기에 표시됩니다.</p>
				</div>
				<div id="content-patient-results" class="content-box">
					<h3>의뢰/회송 환자 결과 조회</h3>
					<p>의뢰/회송 환자 결과가 여기에 표시됩니다.</p>
				</div>
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
		function confirmLogout() {
			return confirm("로그아웃 하시겠습니까?");
		}

		document.addEventListener('DOMContentLoaded', function() {
			var mypageSidebar = document.querySelector('.mypage-sidebar');
			var menuLinks = mypageSidebar.querySelectorAll('a[data-content]');
			var contentBoxes = document
					.querySelectorAll('.mypage-content-area .content-box');
			var menus = mypageSidebar.querySelectorAll('.menu');

			function showContent(contentId) {
				menuLinks.forEach(function(link) {
					link.classList.remove('active');
				});
				contentBoxes.forEach(function(box) {
					box.classList.remove('active');
				});

				var targetContent = document.getElementById('content-'
						+ contentId);
				if (targetContent) {
					targetContent.classList.add('active');
					var activeLink = mypageSidebar
							.querySelector('a[data-content="' + contentId
									+ '"]');
					if (activeLink) {
						activeLink.classList.add('active');
					}
				} else {
					document.getElementById('content-home').classList
							.add('active');
				}
			}

			function toggleAccordion(targetMenu) {
				var submenu = targetMenu.nextElementSibling;
				var isActive = submenu.classList.contains('active');

				menus.forEach(function(item) {
					var otherSubmenu = item.nextElementSibling;
					if (otherSubmenu) {
						otherSubmenu.classList.remove('active');
					}
				});

				if (!isActive) {
					submenu.classList.add('active');
				}
			}

			mypageSidebar.addEventListener('click', function(e) {
				var target = e.target;

				if (target.tagName === 'A' && target.dataset.content) {
					e.preventDefault();
					var contentId = target.dataset.content;
					showContent(contentId);

					var parentSubmenu = target.closest('.submenu');
					if (parentSubmenu) {
						toggleAccordion(parentSubmenu.previousElementSibling);
					}
				}

				if (target.classList.contains('menu')) {
					toggleAccordion(target);
				}
			});

			showContent('home');
			menus[0].nextElementSibling.classList.add('active');
		});
	</script>
</body>
</html>

<jsp:include page="/WEB-INF/jsp/footer.jsp" />