<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>${event.title} - 강좌/행사 안내</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-6xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-8">

    <!-- 왼쪽 메뉴 -->
    <aside class="w-full md:w-64">
      <jsp:include page="/WEB-INF/jsp/user_service/01_menu.jsp" />
    </aside>

    <!-- 본문 영역 -->
    <main class="flex-1 bg-white rounded-lg shadow border border-gray-200 p-6">

      <!-- 제목 + 작성일 -->
      <div class="mb-6 border-b border-gray-200 pb-4 relative">
        <h2 class="text-2xl font-semibold text-gray-900 mb-2">${event.title}</h2>
        <p class="absolute top-0 right-0 text-sm text-gray-500">
          <fmt:formatDate value="${event.createdAt}" pattern="yyyy.MM.dd" />
        </p>
      </div>

      <!-- 메타 정보 -->
      <div class="flex flex-wrap gap-4 text-sm text-gray-600 mb-6">
        <div>
          <strong class="text-gray-800">카테고리:</strong>
          <span class="inline-block px-2 py-1 rounded text-white text-xs font-medium
            <c:choose>
              <c:when test="${event.category == '강좌'}">bg-blue-600</c:when>
              <c:when test="${event.category == '교육'}">bg-green-600</c:when>
              <c:when test="${event.category == '행사'}">bg-yellow-500 text-gray-900</c:when>
              <c:when test="${event.category == '기타'}">bg-gray-600</c:when>
              <c:otherwise>bg-indigo-500</c:otherwise>
            </c:choose>">
            ${event.category}
          </span>
        </div>

        <div>
          <strong class="text-gray-800">일정:</strong>
          <c:choose>
            <c:when test="${not empty event.startDateStr and not empty event.endDateStr}">
              ${event.startDateStr} ~ ${event.endDateStr}
            </c:when>
            <c:otherwise>
              ${event.eventDateStr}
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <!-- 본문 내용 -->
      <div class="text-sm text-gray-800 leading-relaxed whitespace-pre-line">
        ${event.description}
      </div>

      <!-- 목록 버튼 -->
      <div class="mt-8 text-right">
        <a href="${pageContext.request.contextPath}/01_lecture/list.do"
           class="inline-block px-4 py-2 border border-gray-300 rounded text-sm text-gray-700 hover:bg-gray-100">
          목록으로
        </a>
      </div>

    </main>
  </div>

</body>
</html>
