<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>진료과 찾기</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

	<div class="max-w-screen-xl mx-auto px-4 py-12">

		<!-- 타이틀 -->
		<h1 class="text-3xl font-extrabold text-center mb-10">진료과 찾기</h1>

		<!-- 검색 폼 -->
		<form action="${pageContext.request.contextPath}/department/list.do"
			method="get"
			class="flex flex-col sm:flex-row items-center gap-4 justify-center mb-12">

			<input type="text" name="keyword"
				value="${fn:escapeXml(param.keyword)}"
				placeholder="진료과 또는 질병명을 입력해주세요"
				class="w-full sm:w-96 px-4 py-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 text-base" />

			<button type="submit"
				class="px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white text-base font-semibold rounded-md transition">
				검색</button>
		</form>

		<!-- 진료과 그리드 (4개씩 정렬) -->
		<div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-5">
			<c:forEach var="d" items="${departments}">
				<c:if
					test="${d.deptId ne '002' and d.deptId ne '000' and d.deptId ne '999' and d.deptId ne 'D1'}">

					<a
						href="${pageContext.request.contextPath}/department/detail.do?deptId=${d.deptId}"
						class="group flex flex-col items-center justify-center text-center bg-white px-4 py-6 rounded-xl shadow hover:bg-blue-50 transition border border-gray-200 h-32">

						<%-- 기본 아이콘(없으면 medical.png 사용) --%> <c:set var="iconFile"
							value="medical.png" /> <%-- 과별 아이콘 매핑 --%> <c:choose>
							<%-- 내과 계열 --%>
							<c:when test="${d.name eq '감염내과'}">
								<c:set var="iconFile" value="virus.png" />
							</c:when>
							<c:when test="${d.name eq '내과'}">
								<c:set var="iconFile" value="medical.png" />
							</c:when>
							<c:when test="${d.name eq '내분비내과'}">
								<c:set var="iconFile" value="pancreas.png" />
							</c:when>
							<c:when test="${d.name eq '소화기내과'}">
								<c:set var="iconFile" value="stomach.png" />
							</c:when>
							<c:when test="${d.name eq '호흡기내과'}">
								<c:set var="iconFile" value="lungs.png" />
							</c:when>
							<c:when test="${d.name eq '신장내과'}">
								<c:set var="iconFile" value="kidneys.png" />
							</c:when>
							<c:when test="${d.name eq '신경과'}">
								<c:set var="iconFile" value="nervous-system.png" />
							</c:when>
							<c:when test="${d.name eq '피부과'}">
								<c:set var="iconFile" value="skin.png" />
							</c:when>

							<%-- 외과 계열 --%>
							<c:when test="${d.name eq '갑상선내분비외과'}">
								<c:set var="iconFile" value="thyroid.png" />
							</c:when>
							<c:when test="${d.name eq '대장항문외과'}">
								<c:set var="iconFile" value="intestine.png" />
							</c:when>
							<c:when test="${d.name eq '위장관외과'}">
								<c:set var="iconFile" value="digestive-system.png" />
							</c:when>
							<c:when test="${d.name eq '일반외과'}">
								<c:set var="iconFile" value="scalpel.png" />
							</c:when>
							<c:when test="${d.name eq '정형외과'}">
								<c:set var="iconFile" value="fracture.png" />
							</c:when>
							<c:when test="${d.name eq '흉부외과'}">
								<c:set var="iconFile" value="heart.png" />
							</c:when>
							<c:when test="${d.name eq '유방외과'}">
								<c:set var="iconFile" value="ribbon.png" />
							</c:when>
							<c:when test="${d.name eq '이비인후과'}">
								<c:set var="iconFile" value="otorhinolaryngology.png" />
							</c:when>

							<%-- 소아·산부인과 등 --%>
							<c:when test="${d.name eq '소아청소년과'}">
								<c:set var="iconFile" value="baby-teeth.png" />
							</c:when>
							<c:when test="${d.name eq '산부인과'}">
								<c:set var="iconFile" value="pregnancy.png" />
							</c:when>

							<%-- 응급 --%>
							<c:when test="${d.name eq '응급의학과'}">
								<c:set var="iconFile" value="ambulance.png" />
							</c:when>
						</c:choose> <img
						src="${pageContext.request.contextPath}/resources/images/icon/department/${iconFile}"
						alt="${d.name}" class="w-12 h-12 mb-3 object-contain" /> <span
						class="text-lg font-semibold text-gray-800 group-hover:text-blue-700">
							${d.name} </span>
					</a>

				</c:if>
			</c:forEach>
		</div>

	</div>

</body>
</html>
