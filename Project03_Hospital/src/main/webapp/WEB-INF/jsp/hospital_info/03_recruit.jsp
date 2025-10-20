<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>채용공고</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

	<div
		class="max-w-7xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-10">

		<!-- 좌측 메뉴 -->
		<aside
			class="w-full md:w-64 bg-white rounded-lg shadow border border-gray-200">
			<jsp:include page="/WEB-INF/jsp/hospital_info/03_menu.jsp" />
		</aside>

		<!-- 우측 콘텐츠 -->
		<main
			class="flex-1 bg-white rounded-lg shadow p-6 border border-gray-200">

			  <h2 class="text-xl sm:text-2xl font-semibold text-black mb-8 border-b border-gray-200 pb-2">
       채용 공고
    </h2>
			<!-- 카테고리 필터 -->
			<div class="flex flex-wrap gap-3 mb-8">
				<a href="?subCategory="
					class="px-4 py-2 rounded-full border 
          ${empty subCategory ? 'bg-blue-600 text-white' : 'bg-gray-100 text-gray-700 hover:bg-gray-200'}">
					전체 </a> <a href="?subCategory=의사직"
					class="px-4 py-2 rounded-full border 
          ${subCategory eq '의사직' ? 'bg-blue-600 text-white' : 'bg-gray-100 text-gray-700 hover:bg-gray-200'}">
					의사직 </a> <a href="?subCategory=간호사직"
					class="px-4 py-2 rounded-full border 
          ${subCategory eq '간호사직' ? 'bg-blue-600 text-white' : 'bg-gray-100 text-gray-700 hover:bg-gray-200'}">
					간호사직 </a> <a href="?subCategory=의료기사직"
					class="px-4 py-2 rounded-full border 
          ${subCategory eq '의료기사직' ? 'bg-blue-600 text-white' : 'bg-gray-100 text-gray-700 hover:bg-gray-200'}">
					의료기사직 </a> <a href="?subCategory=의료지원직"
					class="px-4 py-2 rounded-full border 
          ${subCategory eq '의료지원직' ? 'bg-blue-600 text-white' : 'bg-gray-100 text-gray-700 hover:bg-gray-200'}">
					의료지원직 </a>
			</div>

			<!-- 공고 목록 -->
			<div class="grid gap-6">
				<c:forEach var="item" items="${recruitList}">
					<div
						class="border border-gray-200 rounded-lg p-5 hover:shadow transition">
						<div class="text-lg font-semibold text-gray-900 mb-1">
							${item.title}</div>
						<div class="text-sm text-gray-600 space-y-1">
							<div>
								분야: <span class="text-gray-800">${item.subCategory}</span>
							</div>
							<div>
								기간:
								<fmt:formatDate value="${item.startDate}" pattern="yyyy-MM-dd" />
								~
								<fmt:formatDate value="${item.endDate}" pattern="yyyy-MM-dd" />
							</div>
							<div>
								작성일:
								<fmt:formatDate value="${item.createdAt}" pattern="yyyy-MM-dd" />
							</div>
						</div>
						<div class="mt-3 text-right">
							<!-- 변경 -->
							<a
								href="${pageContext.request.contextPath}/03_recruit_view.do?eventId=${item.eventId}"
								class="text-blue-600 hover:underline text-sm font-medium">
								자세히 보기 → </a>
						</div>
					</div>
				</c:forEach>
			</div>

			<!-- 페이지네이션 -->
			<div class="mt-10 flex justify-center space-x-1 text-sm font-medium">
				<c:if test="${currentPage > 1}">
					<a href="?page=${currentPage - 1}&subCategory=${subCategory}"
						class="px-3 py-1 border rounded hover:bg-gray-100">&laquo;</a>
				</c:if>

				<c:forEach begin="1" end="${totalPages}" var="i">
					<c:choose>
						<c:when test="${i == currentPage}">
							<span class="px-3 py-1 bg-blue-600 text-white rounded">${i}</span>
						</c:when>
						<c:otherwise>
							<a href="?page=${i}&subCategory=${subCategory}"
								class="px-3 py-1 border rounded hover:bg-gray-100">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:if test="${currentPage < totalPages}">
					<a href="?page=${currentPage + 1}&subCategory=${subCategory}"
						class="px-3 py-1 border rounded hover:bg-gray-100">&raquo;</a>
				</c:if>
			</div>

		</main>
	</div>

</body>
</html>
