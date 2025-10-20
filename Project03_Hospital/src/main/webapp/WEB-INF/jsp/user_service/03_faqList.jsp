<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>❓ 자주 묻는 질문 (FAQ)</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">
	<div
		class="max-w-7xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-8">

		<!-- 왼쪽 메뉴 -->
		<aside class="w-full md:w-64">
			<jsp:include page="/WEB-INF/jsp/user_service/03_menu.jsp" />
		</aside>

		<!-- 본문 -->
		<main
			class="flex-1 bg-white rounded-lg shadow border border-gray-200 p-6">

			<!-- 제목 -->
			<h2
				class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
				자주 묻는 질문 (FAQ)</h2>


			<!-- 설명 -->
			<div
				class="border border-gray-200 rounded-md p-4 mb-6 bg-gray-50 text-sm text-gray-700 leading-relaxed">
				병원 이용 중 궁금한 점이 있으신가요? <br> 진료 예약, 외래 진료, 입퇴원 절차 등 고객님께서 자주 묻는
				질문들을 정리해두었습니다. <br> 문의 전 FAQ를 통해 빠르고 정확한 답변을 확인해 보세요.
			</div>

			<!-- 검색/필터 폼 -->
			<form class="flex flex-col sm:flex-row items-center gap-2 mb-6"
				method="get"
				action="${pageContext.request.contextPath}/03_faq/list.do">
				<select name="category"
					class="border border-gray-300 rounded px-3 py-2 text-sm">
					<option value="">전체</option>
					<option value="진료예약" ${param.category == '진료예약' ? 'selected' : ''}>진료예약</option>
					<option value="외래진료" ${param.category == '외래진료' ? 'selected' : ''}>외래진료</option>
					<option value="입퇴원" ${param.category == '입퇴원' ? 'selected' : ''}>입퇴원</option>
					<option value="서류발급" ${param.category == '서류발급' ? 'selected' : ''}>서류발급</option>
					<option value="병원안내" ${param.category == '병원안내' ? 'selected' : ''}>병원안내</option>
					<option value="기타" ${param.category == '기타' ? 'selected' : ''}>기타</option>
				</select> <input type="text" name="keyword" placeholder="검색어를 입력하세요"
					value="${param.keyword}"
					class="flex-1 border border-gray-300 rounded px-3 py-2 text-sm" />
				<button type="submit"
					class="bg-blue-800 text-white px-4 py-2 rounded text-sm hover:bg-blue-900">
					검색</button>
			</form>
			<!-- 카테고리 탭 -->
			<ul class="flex flex-wrap gap-2 mb-8 text-sm font-medium">
				<li><a href="${pageContext.request.contextPath}/03_faq/list.do"
					class="px-3 py-2 rounded ${empty param.category ? 'bg-blue-800 text-white' : 'bg-gray-100 text-gray-700'}">
						전체 </a></li>

				<!-- ✅ 문자열을 리스트로 변환해서 forEach의 items로 사용 -->
				<c:set var="categories"
					value="${fn:split('진료예약,외래진료,입퇴원,서류발급,병원안내,기타', ',')}" />

				<c:forEach var="cat" items="${categories}">
					<c:url var="catUrl" value="/03_faq/list.do">
						<c:param name="category" value="${cat}" />
					</c:url>
					<li><a href="${catUrl}"
						class="px-3 py-2 rounded ${param.category == cat ? 'bg-blue-800 text-white' : 'bg-gray-100 text-gray-700'}">
							${cat} </a></li>
				</c:forEach>
			</ul>


			<!-- FAQ 리스트 -->
			<c:forEach var="faq" items="${faqList}">
				<div class="border border-gray-200 rounded mb-4">
					<button
						class="faq-question w-full text-left px-4 py-3 font-semibold text-gray-800 bg-white hover:bg-gray-50 flex justify-between items-center">
						${faq.question} <span class="text-gray-500 text-sm">▼</span>
					</button>
					<div
						class="faq-answer hidden px-4 py-4 text-sm text-gray-700 border-t border-gray-100 bg-gray-50">
						${faq.answer}</div>
				</div>
			</c:forEach>

			<c:if test="${empty faqList}">
				<p class="text-sm text-gray-500 mt-6">등록된 FAQ가 없습니다.</p>
			</c:if>

			<!-- 페이지네이션 -->
			<c:set var="pageCount"
				value="${(totalCount / pageSize) + (totalCount % pageSize == 0 ? 0 : 1)}" />
			<c:if test="${pageCount > 1}">
				<div class="mt-8 flex justify-center gap-2">
					<c:forEach begin="1" end="${pageCount}" var="p">
						<c:url var="pageUrl" value="/03_faq/list.do">
							<c:param name="page" value="${p}" />
							<c:param name="category" value="${param.category}" />
							<c:param name="keyword" value="${param.keyword}" />
						</c:url>
						<a href="${pageUrl}"
							class="px-3 py-1 border rounded text-sm 
                ${p == currentPage ? 'bg-blue-800 text-white' : 'text-gray-700 hover:bg-gray-100'}">
							${p} </a>
					</c:forEach>
				</div>
			</c:if>

		</main>
	</div>

	<script>
    // 아코디언 기능
    document.addEventListener("DOMContentLoaded", function () {
      document.querySelectorAll(".faq-question").forEach(btn => {
        btn.addEventListener("click", () => {
          const answer = btn.nextElementSibling;
          const isOpen = !answer.classList.contains("hidden");

          // 모든 닫기
          document.querySelectorAll(".faq-answer").forEach(el => el.classList.add("hidden"));
          document.querySelectorAll(".faq-question span").forEach(icon => icon.textContent = "▼");

          // 열기
          if (!isOpen) {
            answer.classList.remove("hidden");
            btn.querySelector("span").textContent = "▲";
          }
        });
      });
    });
  </script>
</body>
</html>
