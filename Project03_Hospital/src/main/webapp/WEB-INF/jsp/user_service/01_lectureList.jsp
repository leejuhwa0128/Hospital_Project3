<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>🎓 강좌 및 행사 안내</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-7xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-8">

    <!-- 왼쪽 메뉴 -->
    <aside class="w-full md:w-64">
      <jsp:include page="/WEB-INF/jsp/user_service/01_menu.jsp" />
    </aside>

    <!-- 오른쪽 콘텐츠 -->
    <main class="flex-1 bg-white rounded-lg shadow border border-gray-200 p-6">

      <!-- 타이틀 -->
          <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
  강좌 및 행사 안내
</h2>


      <!-- 카테고리 필터 -->
      <div class="mb-6 flex flex-wrap gap-2">
        <a href="?category=전체"
           class="px-4 py-2 rounded border text-sm font-medium
           ${currentCategory == '전체' ? 'bg-blue-600 text-white' : 'bg-gray-100 text-gray-800 hover:bg-gray-200'}">
          전체
        </a>
        <a href="?category=강좌"
           class="px-4 py-2 rounded border text-sm font-medium
           ${currentCategory == '강좌' ? 'bg-red-600 text-white' : 'bg-gray-100 text-gray-800 hover:bg-gray-200'}">
          강좌
        </a>
        <a href="?category=교육"
           class="px-4 py-2 rounded border text-sm font-medium
           ${currentCategory == '교육' ? 'bg-green-600 text-white' : 'bg-gray-100 text-gray-800 hover:bg-gray-200'}">
          교육
        </a>
        <a href="?category=행사"
           class="px-4 py-2 rounded border text-sm font-medium
           ${currentCategory == '행사' ? 'bg-yellow-500 text-gray-900' : 'bg-gray-100 text-gray-800 hover:bg-gray-200'}">
          행사
        </a>
        <a href="?category=기타"
           class="px-4 py-2 rounded border text-sm font-medium
           ${currentCategory == '기타' ? 'bg-gray-600 text-white' : 'bg-gray-100 text-gray-800 hover:bg-gray-200'}">
          기타
        </a>
      </div>

      <!-- 카드 목록 -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <c:forEach var="item" items="${lectureList}">

          <!-- 카테고리 색상 매핑 -->
          <c:set var="categoryColor">
            <c:choose>
              <c:when test="${item.category == '강좌'}">bg-red-600</c:when>
              <c:when test="${item.category == '교육'}">bg-green-600</c:when>
              <c:when test="${item.category == '행사'}">bg-yellow-500 text-gray-900</c:when>
              <c:when test="${item.category == '기타'}">bg-gray-600</c:when>
              <c:otherwise>bg-indigo-500</c:otherwise>
            </c:choose>
          </c:set>

          <!-- 카드 -->
          <a href="${pageContext.request.contextPath}/01_lecture/view.do?eventId=${item.eventId}"
             class="block bg-white border border-gray-200 rounded-lg shadow-sm hover:shadow-md transition p-5">

            <span class="inline-block text-xs font-semibold text-white px-2 py-1 rounded mb-3 ${categoryColor}">
              ${item.category}
            </span>

            <h3 class="text-base font-semibold text-gray-900 mb-2 line-clamp-2">
              ${item.title}
            </h3>

            <div class="text-sm text-gray-500">
              <c:choose>
                <c:when test="${not empty item.startDateStr and not empty item.endDateStr}">
                  ${item.startDateStr} ~ ${item.endDateStr}
                </c:when>
                <c:otherwise>
                  ${item.eventDateStr}
                </c:otherwise>
              </c:choose>
            </div>

          </a>
        </c:forEach>
      </div>

    </main>
  </div>
</body>
</html>
