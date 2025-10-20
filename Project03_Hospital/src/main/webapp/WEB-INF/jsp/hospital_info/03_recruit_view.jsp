<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>채용공고 상세</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">
  <div class="max-w-7xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-10">

    <!-- 좌측 메뉴 -->
    <aside class="w-full md:w-64 bg-white rounded-lg shadow border border-gray-200">
      <jsp:include page="/WEB-INF/jsp/hospital_info/03_menu.jsp" />
    </aside>

    <!-- 우측 콘텐츠 -->
    <main class="flex-1">
      <div class="bg-white rounded-lg shadow border border-gray-200 overflow-hidden">

      
        <!-- 본문 섹션 -->
        <div class="px-6 py-8 space-y-8">

          <!-- 공고 제목 -->
          <h2 class="text-2xl font-semibold text-gray-800 border-b border-gray-200 pb-2">
            ${event.title}
          </h2>

          <!-- 세부 정보 박스 -->
          <div class="bg-gray-50 border border-gray-200 rounded-lg p-6 grid grid-cols-1 sm:grid-cols-2 gap-4 text-sm text-gray-700">
            <div>
              <span class="font-medium text-gray-600">📌 분야:</span>
              <span class="ml-1 text-gray-800">${event.subCategory}</span>
            </div>
            <div>
              <span class="font-medium text-gray-600">📍 근무지:</span>
              <span class="ml-1 text-gray-800">${event.workLocation}</span>
            </div>
            <div>
              <span class="font-medium text-gray-600">🗓️ 기간:</span>
              <span class="ml-1 text-gray-800">
                <fmt:formatDate value="${event.startDate}" pattern="yyyy-MM-dd" />
                ~
                <fmt:formatDate value="${event.endDate}" pattern="yyyy-MM-dd" />
              </span>
            </div>
            <div>
              <span class="font-medium text-gray-600">✍️ 작성일:</span>
              <span class="ml-1 text-gray-800">
                <fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd" />
              </span>
            </div>
          </div>

          <!-- 내용 -->
          <div>
            
            <div class="prose max-w-none text-gray-800">
              ${event.description}
            </div>
          </div>

          <!-- 목록으로 -->
          <div class="pt-6">
            <a href="${pageContext.request.contextPath}/03_recruit.do"
               class="inline-flex items-center text-sm font-medium text-blue-600 hover:underline">
              ← 목록으로 돌아가기
            </a>
          </div>

        </div>
      </div>
    </main>
  </div>
</body>
</html>
