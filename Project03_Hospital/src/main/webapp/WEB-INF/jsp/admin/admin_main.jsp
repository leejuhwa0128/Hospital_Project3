<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>관리자 메인</title>

<!-- ✅ 실제 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/test/layout.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/test/layout02.css" />

<!-- ✅ JS -->
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/design.js"></script>

<style>
.top_bar .top_right {
	display: flex;
	align-items: center;
	gap: 20px;
}

.top_bar .top_right .option {
	width: 36px;
	height: 36px;
}

.top_bar .top_right .option img {
	width: 100%;
	height: 100%;
	object-fit: contain;
}

.top_bar .top_right .profile {
	width: 36px;
	height: 36px;
	line-height: 36px;
	font-size: 15px;
	text-align: center;
	border-radius: 50%;
	background-color: #f36461;
	color: #fff;
	font-weight: 600;
}

.top_bar .top_right .name {
	font-size: 15px;
	color: #2b2b2b;
	font-weight: 500;
}

.top_bar .top_right .logout-btn {
	background-color: #f36461;
	color: #fff;
	padding: 8px 16px;
	border-radius: 6px;
	font-weight: 600;
	font-size: 14px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.top_left span {
	font-size: 15px;
	color: #436dff;
	font-weight: 600;
}
</style>
</head>

<body>
	<c:if test="${empty loginAdmin}">
		<script>
      alert("로그인이 필요합니다.");
      location.href = "<c:url value='/resources/index.jsp' />";
    </script>
	</c:if>

	<div class="body_wrap">
		<!-- ✅ 사이드 메뉴 -->
		<div class="menu bg_1">
			<div class="title bor_1">
				<a href="<c:url value='/admin/dashboard.do'/>" target="contentFrame">MEDIPRIME병원</a>
			</div>
			<div class="gnb_box">
				<ul class="gnb_1st">
					<li class="have_sub"><a href="#">사용자 관리</a>
						<ul class="gnb_2nd">
							<li><a href="<c:url value='/admin/patientList.do'/>"
								target="contentFrame">환자 관리</a></li>
							<li><a href="<c:url value='/admin/doctorList.do'/>"
								target="contentFrame">의사 관리</a></li>
							<li><a href="<c:url value='/admin/coopList.do'/>"
								target="contentFrame">협력의 관리</a></li>
							<li><a href="<c:url value='/admin/pendingList.do'/>"
								target="contentFrame">가입 승인 대기</a></li>
						</ul></li>
					<li class="have_sub"><a href="#">병원 관리</a>
						<ul class="gnb_2nd">
							<li><a
								href="<c:url value='/admin_board/medicalNoticeManage.do'/>"
								target="contentFrame">의료진 공지사항</a></li>
							<li><a href="<c:url value='/admin/allReferrals.do'/>"
								target="contentFrame">협진 내역</a></li>
						</ul></li>
					<li class="have_sub"><a href="#">예약/상담 관리</a>
						<ul class="gnb_2nd">
							<li><a href="<c:url value='/admin/reservationCalendar.do'/>"
								target="contentFrame">예약 현황</a></li>
							<li><a href="<c:url value='/admin/fastReservationList.do'/>"
								target="contentFrame">빠른예약 신청</a></li>
							<li><a href="<c:url value='/admin/counselList.do'/>"
								target="contentFrame">상담 내역</a></li>
						</ul></li>
					<li class="have_sub"><a href="#">게시판 관리</a>
						<ul class="gnb_2nd">
							<li><a href="<c:url value='/admin_board/pressManage.do'/>"
								target="contentFrame">언론보도</a></li>
							<li><a href="<c:url value='/admin_board/recruitManage.do'/>"
								target="contentFrame">채용공고</a></li>
							<li><a href="<c:url value='/admin_board/newsManage.do'/>"
								target="contentFrame">병원소식</a></li>
							<li><a href="<c:url value='/admin_board/noticeManage.do'/>"
								target="contentFrame">공지사항</a></li>
							<li><a href="<c:url value='/admin_board/lectureManage.do'/>"
								target="contentFrame">강좌/행사</a></li>
							<li><a href="<c:url value='/admin_board/faqManage.do'/>"
								target="contentFrame">FAQ</a></li>
							<li><a href="<c:url value='/admin/donations/list.do'/>"
      						 target="contentFrame"> 기부 관리</a></li>	
							<li><a
								href="<c:url value='/admin_board/feedbackManage.do'/>"
								target="contentFrame">고객의 소리</a></li>
							<li><a href="<c:url value='/admin_board/praiseManage.do'/>"
								target="contentFrame">칭찬 릴레이</a></li>
							<li><a href="<c:url value='/admin_board/activityLogs.do'/>"
								target="contentFrame">사용자 로그</a></li>
						</ul></li>
				</ul>
			</div>
		</div>

		<!-- ✅ 콘텐츠 -->
		<div class="content">
			<div class="top_bar bg_w">
				<div class="top_left">
					<span id="sessionTimer">남은 시간: 02:00:00</span>
				</div>
				<div class="top_right">
					<a href="#" class="option"> <img
						src="${pageContext.request.contextPath}/resources/images/test/top_option.png"
						alt="옵션" />
					</a>
					<div style="display: flex; align-items: center;">
						<span class="profile">관</span> <span class="name"><c:out
								value="${loginAdmin.name}" />님</span>
					</div>
					<a href="javascript:logout();" class="logout-btn"> <img
						src="${pageContext.request.contextPath}/resources/images/test/doctor_noti.png"
						alt="" width="14" /> 로그아웃
					</a>
				</div>
			</div>

			<div class="con_wrap bg_13">
				<iframe name="contentFrame"
					src="<c:url value='/admin/dashboard.do'/>"
					style="width: 100%; height: calc(100vh - 130px); border: none;"></iframe>
			</div>
		</div>
	</div>

	<!-- ✅ 세션 타이머 JS -->
	<script>
    const logoutUrl = "${pageContext.request.contextPath}/admin/logoutSession.do";
    let remainingSeconds = 7200;

    function formatTime(seconds) {
      const hrs = Math.floor(seconds / 3600);
      const mins = Math.floor((seconds % 3600) / 60);
      const secs = seconds % 60;
      return [hrs, mins, secs].map(n => n < 10 ? '0' + n : n).join(":");
    }

    function updateTimer() {
      const el = document.getElementById("sessionTimer");
      if (el) el.textContent = "남은 시간: " + formatTime(remainingSeconds);
      if (--remainingSeconds <= 0) location.href = logoutUrl;
    }

    function logout() {
      if (confirm("로그아웃 하시겠습니까?")) {
        location.href = logoutUrl;
      }
    }

    document.addEventListener("DOMContentLoaded", function () {
      updateTimer();
      setInterval(updateTimer, 1000);
    });
  </script>
</body>
</html>
