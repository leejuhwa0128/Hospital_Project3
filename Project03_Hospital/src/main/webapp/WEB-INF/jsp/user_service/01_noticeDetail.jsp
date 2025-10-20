<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>공지사항 상세</title>
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
  <h2 class="text-2xl font-semibold text-gray-900 mb-2">${notice.title}</h2>
  <p class="absolute top-0 right-0 text-sm text-gray-500">
    <fmt:formatDate value="${notice.createdAt}" pattern="yyyy.MM.dd" />
  </p>
</div>


      <!-- 본문 내용 -->
      <div class="text-sm text-gray-800 leading-relaxed whitespace-pre-line">
        ${notice.content}
      </div>

      <!-- 목록 버튼 -->
      <div class="mt-8 text-right">
        <a href="${pageContext.request.contextPath}/01_notice/list.do"
           class="inline-block px-4 py-2 border border-gray-300 rounded text-sm text-gray-700 hover:bg-gray-100">
          목록으로
        </a>
      </div>

    </main>
  </div>

</body>
</html>
