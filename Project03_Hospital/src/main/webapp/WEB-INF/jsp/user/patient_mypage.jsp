<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" />

<div class="mypage-wrapper">
	<h2>👤 <c:out value="${sessionScope.loginSuccessName}" />님의 마이페이지</h2>


	

	<ul class="mypage-menu">
  <li class="menu-group-title">📌 진료 관련 서비스</li>
  <li><a href="#">진료예약</a></li>
  <li><a href="#">진료예약확인</a></li>
  <li><a href="#">과거진료이력조회</a></li>
  <li><a href="#">진단서/증명서 발급</a></li>

  <li class="menu-group-title">📌 회원 문의 서비스</li>
  <li><a href="${pageContext.request.contextPath}/reservation/counsel/list.do">예약/진료 상담 내역</a></li>
  <li><a href="${pageContext.request.contextPath}/03_feedback/mylist.do">고객의 소리 내역</a></li>
  
  <li class="menu-group-title">📌 회원 정보 서비스</li>
  <li><a href="${pageContext.request.contextPath}/patient/editPatientForm.do">정보 수정/탈퇴</a></li>
  <li><a href="${pageContext.request.contextPath}/logout.do">로그아웃</a></li>
</ul>

</div>

