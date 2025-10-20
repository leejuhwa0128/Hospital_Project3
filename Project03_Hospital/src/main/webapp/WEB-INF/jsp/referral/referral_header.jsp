<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="header-wrapper">
	<div class="header-top">
		<c:choose>
			<c:when test="${empty sessionScope.loginUser}">
				<a href="${pageContext.request.contextPath}/referral/auth.do">로그인</a>
        &nbsp;|&nbsp;
        <a
					href="${pageContext.request.contextPath}/referral/auth.do?mode=signup">회원가입</a>
			</c:when>
			<c:otherwise>
				<c:out
					value="${empty sessionScope.loginSuccessName 
                 ? sessionScope.loginUser.name 
                 : sessionScope.loginSuccessName}" />님 환영합니다! &nbsp;|&nbsp;
    <a
					href="${pageContext.request.contextPath}/referral/logout.do?returnUrl=/referral/main.do">로그아웃</a>
    &nbsp;|&nbsp;
    <c:choose>
					<c:when test="${sessionScope.loginUser.role eq 'doctor'}">
						<a href="${pageContext.request.contextPath}/user/doctorPage.do">마이페이지</a>
					</c:when>
					<c:when test="${sessionScope.loginUser.role eq 'coop'}">
						<a href="${pageContext.request.contextPath}/user/coopPage.do">마이페이지</a>
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath}/loginSelector.do">마이페이지</a>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</div>

	<div class="header-title">
		<img class="brand-logo-img"
			src="${pageContext.request.contextPath}/resources/images/referralLogo.png"
			alt="센터 로고"> <a
			href="${pageContext.request.contextPath}/referral/main.do">MEDIPRIME
			협진병원센터</a>
	</div>

	<ul class="nav-menu">
		<li><a
			href="${pageContext.request.contextPath}/referral/history.do">진료협력센터소개</a>
			<ul>
				<li><a
					href="${pageContext.request.contextPath}/referral/history.do">개요</a></li>
				<li><a
					href="${pageContext.request.contextPath}/referral/greeting.do">센터장
						인사말</a></li>
			</ul></li>

		<li><a
			href="${pageContext.request.contextPath}/referral/referral.do">진료의뢰&조회</a>
			<ul>
				<li><a
					href="${pageContext.request.contextPath}/referral/referral.do">진료의뢰
						안내</a></li>
				<li><a
					href="${pageContext.request.contextPath}/referral/status.do">진료의뢰
						신청현황</a></li>
				<li><a
					href="${pageContext.request.contextPath}/referral/statusAll.do">의뢰/회송
						환자 결과 조회</a></li>
				<li><a
					href="${pageContext.request.contextPath}/referral/doctor.do">의료진
						검색</a></li>
			</ul></li>

		<li><a
			href="${pageContext.request.contextPath}/referral/referral_notice.do">공지사항</a>
			<ul>
				<li><a
					href="${pageContext.request.contextPath}/referral/referral_notice.do">진료협력센터</a></li>
				<li><a
					href="${pageContext.request.contextPath}/01_notice/list.do"
					target="_blank" rel="noopener noreferrer">MEDIPRIME 병원</a></li>
			</ul></li>

		<li><a
			href="${pageContext.request.contextPath}/referral/referral_overview.do">진료협력네트워크</a>
			<ul>
				<li><a
					href="${pageContext.request.contextPath}/referral/referral_overview.do">운영개요</a></li>
				<li><a
					href="${pageContext.request.contextPath}/referral/referral_status.do">협력
						병원 현황</a></li>
			</ul></li>

		<li><a
			href="${pageContext.request.contextPath}/referral/referral_DepartmentInfo.do">진료과소개</a>
			<ul>
				<li><a
					href="${pageContext.request.contextPath}/referral/referral_DepartmentInfo.do">진료과
						소개</a></li>
			</ul></li>
	</ul>
</div>
