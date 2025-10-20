<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>병원 소식</title>
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
    
    <!-- 페이지 타이틀 -->
    <h2 class="text-xl sm:text-2xl font-semibold text-black mb-8 border-b border-gray-200 pb-2">
       병원 소식
    </h2>

    <!-- 카드 그리드 -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
      <c:forEach var="event" items="${events}">
        <div class="bg-white border border-gray-200 rounded-lg shadow-sm hover:shadow-md transition p-5 flex flex-col justify-between h-full">
          <div class="mb-4">
            <h3 class="text-base font-bold text-gray-900 hover:text-blue-600 mb-2">
              <a href="${pageContext.request.contextPath}/03_news_view.do?eventId=${event.eventId}">
                <c:out value="${event.title}"/>
              </a>
            </h3>
            <div class="text-sm text-gray-500 mb-2">
              <fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd"/>
              <c:if test="${not empty event.viewCount}">
                · 조회 <c:out value="${event.viewCount}"/>
              </c:if>
            </div>
            <p class="text-sm text-gray-700">
              <c:out value="${fn:length(event.description) > 150 
                ? fn:substring(event.description,0,150).concat('…') 
                : event.description}" />
            </p>
          </div>
        </div>
      </c:forEach>
    </div>

    <!-- 페이징 -->
    <nav class="flex justify-center items-center space-x-1 text-sm" aria-label="pagination">
      <ul class="inline-flex items-center -space-x-px">
        <!-- first -->
        <li>
          <c:choose>
            <c:when test="${currentPage == 1}">
              <span class="px-3 py-1 text-gray-300">&laquo;</span>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/03_news.do?page=1" class="px-3 py-1 hover:text-blue-600">&laquo;</a>
            </c:otherwise>
          </c:choose>
        </li>
        <!-- prev -->
        <li>
          <c:choose>
            <c:when test="${currentPage == 1}">
              <span class="px-3 py-1 text-gray-300">&lsaquo;</span>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/03_news.do?page=${currentPage - 1}" class="px-3 py-1 hover:text-blue-600">&lsaquo;</a>
            </c:otherwise>
          </c:choose>
        </li>

        <!-- numbered pages -->
        <c:forEach begin="1" end="${totalPages}" var="i">
          <li>
            <c:choose>
              <c:when test="${i == currentPage}">
                <span class="px-3 py-1 bg-blue-600 text-white font-semibold rounded">${i}</span>
              </c:when>
              <c:otherwise>
                <a href="${pageContext.request.contextPath}/03_news.do?page=${i}" class="px-3 py-1 hover:text-blue-600">${i}</a>
              </c:otherwise>
            </c:choose>
          </li>
        </c:forEach>

        <!-- next -->
        <li>
          <c:choose>
            <c:when test="${currentPage == totalPages}">
              <span class="px-3 py-1 text-gray-300">&rsaquo;</span>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/03_news.do?page=${currentPage + 1}" class="px-3 py-1 hover:text-blue-600">&rsaquo;</a>
            </c:otherwise>
          </c:choose>
        </li>
        <!-- last -->
        <li>
          <c:choose>
            <c:when test="${currentPage == totalPages}">
              <span class="px-3 py-1 text-gray-300">&raquo;</span>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/03_news.do?page=${totalPages}" class="px-3 py-1 hover:text-blue-600">&raquo;</a>
            </c:otherwise>
          </c:choose>
        </li>
      </ul>
    </nav>

  </main>
</div>

</body>
</html>
