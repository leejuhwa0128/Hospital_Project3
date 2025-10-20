<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>고객 서비스</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-7xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-10">

    <!-- 왼쪽 사이드 메뉴 -->
    <aside class="w-full md:w-64 bg-white rounded-lg shadow border border-gray-200">
      <jsp:include page="/WEB-INF/jsp/user_service/02_menu.jsp" />
    </aside>

    <!-- 오른쪽 콘텐츠 -->
    <main class="flex-1 bg-white rounded-lg shadow p-6 border border-gray-200">
      <div class="intro-content">
        <%
          String target = request.getParameter("page");
          if (target == null) target = "02_faq.jsp";  // 기본 페이지
        %>
        <jsp:include page="/WEB-INF/jsp/user_service/${target}" />
      </div>
    </main>

  </div>

</body>
</html>
