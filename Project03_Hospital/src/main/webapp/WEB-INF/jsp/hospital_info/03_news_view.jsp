<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>병원 소식 상세</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

<div class="max-w-7xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-10">
  
  <!-- 좌측 메뉴 -->
  <aside class="w-full md:w-64 bg-white rounded-lg shadow border border-gray-200">
    <jsp:include page="/WEB-INF/jsp/hospital_info/03_menu.jsp" />
  </aside>

  <!-- 메인 콘텐츠 -->
  <main class="flex-1 bg-white rounded-lg shadow p-6 border border-gray-200">
    
    <!-- 제목 -->
    <h1 class="text-xl sm:text-2xl font-bold text-gray-900 mb-4">
      <c:out value="${event.title}" />
    </h1>

    <!-- 날짜 및 조회수 -->
    <div class="text-sm text-gray-500 mb-6 border-b pb-2">
      <fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd" />
      <c:if test="${not empty event.viewCount}">
        · 조회 <c:out value="${event.viewCount}" />
      </c:if>
    </div>

    <!-- 본문 내용 -->
    <div class="prose max-w-none text-sm text-gray-800 leading-relaxed">
      <c:out value="${event.description}" escapeXml="false" />
    </div>

    <!-- 목록으로 버튼 -->
    <div class="mt-10 text-right">
      <a href="${pageContext.request.contextPath}/03_news.do"
         class="inline-block px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded hover:bg-blue-700 transition">
        목록으로
      </a>
    </div>

  </main>
</div>

</body>
</html>
