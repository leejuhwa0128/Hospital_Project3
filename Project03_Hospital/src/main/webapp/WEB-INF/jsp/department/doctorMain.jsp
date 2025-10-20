<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:url value="/resources/images/default-doctor.png"
	var="defaultDoctorImg" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>의료진 찾기</title>
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.css"
	rel="stylesheet" />
</head>
<body class="bg-gray-50 text-gray-800">

	<!-- 공통 헤더 -->
	<jsp:include page="/WEB-INF/jsp/header.jsp" />

	<main class="max-w-screen-xl mx-auto px-4 py-10">
		<h1 class="text-2xl font-bold text-center mb-8">의료진 찾기</h1>

		<!-- 검색 폼 -->
		<form action="${ctx}/doctor/list.do" method="get"
			class="bg-white p-6 rounded-lg shadow flex flex-col md:flex-row gap-4 items-end mb-10">

			<!-- 진료과 선택 -->
			<div class="w-full md:w-1/6">
				<label for="deptId" class="block text-sm font-medium mb-1">진료과</label>
				<select id="deptId" name="deptId"
					class="w-full text-sm rounded-md border-gray-300 focus:ring-blue-500 focus:border-blue-500">
					<option value="">전체</option>

					<!-- 진료과 분류 -->
					<optgroup label="내과">
						<c:forEach var="dept" items="${departments}">
							<c:if test="${dept.description == '내과'}">
								<option value="${dept.deptId}"
									<c:if test="${param.deptId == dept.deptId}">selected</c:if>>
									${dept.name}</option>
							</c:if>
						</c:forEach>
					</optgroup>

					<optgroup label="외과">
						<c:forEach var="dept" items="${departments}">
							<c:if test="${dept.description == '외과'}">
								<option value="${dept.deptId}"
									<c:if test="${param.deptId == dept.deptId}">selected</c:if>>
									${dept.name}</option>
							</c:if>
						</c:forEach>
					</optgroup>

					<optgroup label="기타">
						<c:forEach var="dept" items="${departments}">
							<c:if
								test="${dept.description != '내과' && dept.description != '외과' && dept.description != null}">
								<option value="${dept.deptId}"
									<c:if test="${param.deptId == dept.deptId}">selected</c:if>>
									${dept.name}</option>
							</c:if>
						</c:forEach>
					</optgroup>
				</select>
			</div>

			<!-- 검색어 입력 -->
			<div class="w-full md:w-8/12">
				<label for="keyword" class="block text-sm font-medium mb-1">검색어</label>
				<input id="keyword" name="keyword" type="text"
					value="${fn:escapeXml(param.keyword)}"
					placeholder="의료진명 또는 질병명을 입력하세요"
					class="w-full text-sm rounded-md border-gray-300 focus:ring-blue-500 focus:border-blue-500" />
			</div>

			<!-- 검색 버튼 -->
			<!-- 검색 버튼 -->
			<div class="w-full md:w-auto">
				<label class="sr-only">검색</label>
				<button type="submit"
					class="flex items-center gap-2 px-4 py-2 text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 rounded-md">
					<svg xmlns="http://www.w3.org/2000/svg" fill="none"
						viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
						class="w-5 h-5">
    <path stroke-linecap="round" stroke-linejoin="round"
							d="M21 21l-4.35-4.35m0 0A7.5 7.5 0 103.75 3.75a7.5 7.5 0 0012.9 12.9z" />
  </svg>

				</button>

			</div>

		</form>

		<!-- 검색 결과 없음 메시지: 검색 조건이 있고 doctorList가 비어 있을 때 -->
		<!-- ✅ 검색 결과 없음: 검색 조건이 있을 때만 메시지 출력 -->
<c:if test="${(not empty param.keyword or not empty param.deptId) and fn:length(doctorList) == 0}">
	<div class="bg-white p-10 text-center rounded-lg shadow">
		<div class="flex justify-center mb-4">
			<svg xmlns="http://www.w3.org/2000/svg"
				class="w-12 h-12 text-blue-400" fill="none" viewBox="0 0 24 24"
				stroke="currentColor">
				<path stroke-linecap="round" stroke-linejoin="round"
					stroke-width="2"
					d="M8 10h.01M12 14v2m0-6h.01M16 10h.01M12 2a10 10 0 100 20 10 10 0 000-20z" />
			</svg>
		</div>
		<p class="text-gray-600">
			검색 결과가 없습니다.<br />의료진 이름 또는 질병명으로 검색해보세요.
		</p>
	</div>
</c:if>

<!-- ✅ 전체 목록 또는 검색 결과 출력 -->
<c:if test="${fn:length(doctorList) > 0}">
	<div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
		<c:forEach var="doc" items="${doctorList}">
			<c:set var="imgFile"
				value="${empty doc.profileImagePath ? doc.doctorId.concat('.png') : doc.profileImagePath}" />
			<c:url value="/resources/images/doctor/${imgFile}" var="imgSrc" />

			<a href="${ctx}/doctor/detail.do?doctorId=${doc.doctorId}"
				class="bg-white rounded-lg shadow hover:shadow-md transition p-4 flex flex-col">
				<div class="w-full aspect-[5/7] overflow-hidden rounded-md bg-gray-100 mb-3">
					<img src="${imgSrc}" alt="${doc.name}"
						onerror="this.onerror=null;this.src='${defaultDoctorImg}';"
						class="w-full h-full object-cover" />
				</div>
				<h4 class="text-base font-bold truncate">${doc.name}</h4>
				<p class="text-sm text-blue-600 mt-1">${doc.deptName}</p>
				<p class="text-sm text-gray-500 mt-1 truncate">${doc.specialty}</p>
			</a>
		</c:forEach>
	</div>
</c:if>



	</main>

	<jsp:include page="/WEB-INF/jsp/footer.jsp" />
</body>
</html>
