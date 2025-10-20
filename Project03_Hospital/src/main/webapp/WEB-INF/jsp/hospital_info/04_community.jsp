<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>지역 사회 협력 프로그램</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

  <!-- ✅ 전체 레이아웃 -->
  <div class="max-w-7xl mx-auto px-4 py-12 flex gap-6">

    <!-- ✅ 왼쪽 사이드바 -->
    <aside class="w-64 shrink-0">
      <jsp:include page="/WEB-INF/jsp/hospital_info/04_menu.jsp" />
    </aside>

    <!-- ✅ 메인 콘텐츠 -->
    <main class="flex-1">

      <h2 class="text-xl sm:text-2xl font-semibold text-black mb-8 border-b border-gray-200 pb-2">
        지역 사회 협력 프로그램
      </h2>

	<!-- 카드 목록 -->
	<div id="cardGrid" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
	  <c:forEach var="i" begin="1" end="6">
	    <div class="card bg-white border rounded-lg shadow hover:shadow-md transition">
	      <!-- ✅ 이미지 클릭 시 상세페이지 이동 -->
	      <a href="${pageContext.request.contextPath}/hospital_info/communityDetail.do?id=${i}&page=1">
	        <img src="<c:url value='/resources/images/community/card${i}.jpg'/>"
	             alt="썸네일 이미지 ${i}" class="w-full h-40 object-cover rounded-t-lg" />
	      </a>

	      <div class="p-4">
	        <!-- ✅ 제목 클릭 시 상세페이지 이동 -->
	        <h3 class="text-lg font-semibold text-gray-900">
	          <a href="${pageContext.request.contextPath}/hospital_info/communityDetail.do?id=${i}&page=1">
	            프로그램 ${i}
	          </a>
	        </h3>

	        <p class="text-sm text-gray-500 mt-1">
	          <c:choose>
	            <c:when test="${i == 1}">2025-03-12</c:when>
	            <c:when test="${i == 2}">2025-03-28</c:when>
	            <c:when test="${i == 3}">2025-04-05</c:when>
	            <c:when test="${i == 4}">2025-04-19</c:when>
	            <c:when test="${i == 5}">2025-05-03</c:when>
	            <c:when test="${i == 6}">2025-05-17</c:when>
	          </c:choose>
	        </p>

	        <p class="text-sm text-gray-700 mt-2">
	          <c:choose>
	            <c:when test="${i == 1}">만성질환 예방을 위한 식습관/운동 교육을 진행합니다.</c:when>
	            <c:when test="${i == 2}">낙상 예방 운동과 약물 복약지도를 제공합니다.</c:when>
	            <c:when test="${i == 3}">무료 혈압/혈당 측정 및 건강 상담을 제공합니다.</c:when>
	            <c:when test="${i == 4}">스트레스 및 우울 자가 관리 프로그램입니다.</c:when>
	            <c:when test="${i == 5}">건강 마라톤 행사에 구급 인력을 지원합니다.</c:when>
	            <c:when test="${i == 6}">보건 박람회 부스를 운영하고 CPR 체험을 제공합니다.</c:when>
	          </c:choose>
	        </p>
	      </div>
	    </div>
	  </c:forEach>
	</div>

</body>
</html>
