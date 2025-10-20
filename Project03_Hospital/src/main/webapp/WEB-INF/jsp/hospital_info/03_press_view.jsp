<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>언론보도 상세보기</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-7xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-10">

    <!-- 좌측 메뉴 -->
    <aside class="w-full md:w-64 bg-white rounded-lg shadow border border-gray-200">
      <jsp:include page="/WEB-INF/jsp/hospital_info/03_menu.jsp" />
    </aside>

    <!-- 본문 콘텐츠 -->
    <main class="flex-1 bg-white rounded-lg shadow p-6 border border-gray-200">
      
      <!-- 제목 -->
      <h1 class="text-xl sm:text-2xl font-bold text-gray-900 mb-2">
        ${event.title}
      </h1>

      <!-- 날짜 및 기자명 -->
      <div class="text-sm text-gray-500 mb-6">
        <fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd" />
        <span class="mx-2">|</span>
        기자: <span class="text-gray-700">${event.reporter}</span>
      </div>

<div class="mb-6">
  <c:choose>
    <c:when test="${not empty event.thumbnailPath}">
      <img src="<c:url value='/resources/images/press/${event.thumbnailPath}'/>" 
           alt="썸네일" class="w-full max-h-[400px] object-cover rounded border" />
    </c:when>
    <c:otherwise>
      <img src="${pageContext.request.contextPath}/resources/press/default-thumb.png" 
           alt="기본 이미지" class="w-full max-h-[400px] object-cover rounded border" />
    </c:otherwise>
  </c:choose>
</div>

      <!-- 본문 -->
      <div class="prose max-w-none text-gray-700 text-[15px] leading-relaxed">
        <c:out value="${event.description}" escapeXml="false" />
      </div>

      <!-- 버튼 -->
      <div class="mt-10 text-right">
        <a href="${pageContext.request.contextPath}/03_press.do"
           class="inline-block px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded hover:bg-blue-700 transition">
          ← 목록으로 돌아가기
        </a>
      </div>

    </main>
  </div>

</body>
</html>
