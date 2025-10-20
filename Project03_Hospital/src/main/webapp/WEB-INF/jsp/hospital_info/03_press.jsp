<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>언론보도</title>
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

      <!-- 본문 콘텐츠 -->
      <main
         class="flex-1 bg-white rounded-lg shadow p-6 border border-gray-200">

         <!-- 섹션 제목 -->
         <h1
            class="text-xl sm:text-2xl font-bold text-gray-900 mb-8 border-b pb-2">
            언론보도</h1>

         <!-- 카드 그리드 -->
         <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <c:forEach var="event" items="${events}">
               <div
                  class="flex bg-white border border-gray-200 rounded-lg shadow-sm overflow-hidden hover:shadow-md transition">

                  <!-- 썸네2일 -->
                  <div class="w-32 h-32 bg-gray-100 flex-shrink-0 overflow-hidden">
                     <c:choose>
                        <c:when test="${not empty event.thumbnailPath}">
                           <img
                              src="<c:url value='/resources/images/press/${event.thumbnailPath}'/>"
                              alt="썸네일" class="object-cover w-full h-full">
                        </c:when>
                        <c:otherwise>
                           <img
                              src="<c:url value='/resources/images/press/default-thumb.png'/>"
                              alt="기본 이미지" class="object-cover w-full h-full">
                        </c:otherwise>
                     </c:choose>
                  </div>

                  <!-- 정보 -->
                  <div class="flex flex-col justify-between p-4 flex-1">
                     <div>
                        <h3
                           class="text-md font-semibold text-gray-900 mb-1 line-clamp-2">
                           ${event.title}</h3>
                        <p class="text-sm text-gray-500 mb-2">
                           <fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd" />
                           <br />기자명: <span class="text-gray-600">${event.reporter}</span>
                        </p>
                     </div>
                     <div>
                        <a
                           href="${pageContext.request.contextPath}/03_press_view.do?eventId=${event.eventId}"
                           class="text-sm text-blue-600 hover:underline font-medium">
                           자세히 보기 → </a>
                     </div>
                  </div>
               </div>
            </c:forEach>
         </div>

         <!-- 페이징 -->
         <div class="mt-10 flex justify-center">
            <nav
               class="inline-flex gap-1 items-center text-sm font-medium text-gray-600">
               <c:if test="${currentPage > 1}">
                  <a href="?page=${currentPage - 1}"
                     class="px-3 py-1 border rounded hover:bg-gray-100">&laquo;</a>
               </c:if>

               <c:forEach begin="1" end="${totalPages}" var="i">
                  <c:choose>
                     <c:when test="${i == currentPage}">
                        <span
                           class="px-3 py-1 border border-blue-600 bg-blue-50 text-blue-600 rounded">${i}</span>
                     </c:when>
                     <c:otherwise>
                        <a href="?page=${i}"
                           class="px-3 py-1 border rounded hover:bg-gray-100">${i}</a>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>

               <c:if test="${currentPage < totalPages}">
                  <a href="?page=${currentPage + 1}"
                     class="px-3 py-1 border rounded hover:bg-gray-100">&raquo;</a>
               </c:if>
            </nav>
         </div>

      </main>
   </div>

</body>
</html>
