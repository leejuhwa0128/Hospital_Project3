<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>🔒 비밀번호 확인</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-6xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-8">

    <!-- 좌측 메뉴 -->
    <aside class="w-full md:w-64">
      <jsp:include page="/WEB-INF/jsp/user_service/03_menu.jsp" />
    </aside>

    <!-- 본문 -->
    <main class="flex-1 bg-white rounded-lg shadow border border-gray-200 p-6">

      <!-- 제목 -->
      <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
  비밀번호 확인
</h2>

      <p class="text-sm text-gray-600 mb-6">
        본인 확인을 위해 비밀번호를 입력해주세요.
      </p>

      <!-- 비밀번호 확인 폼 -->
      <form 
        action="${pageContext.request.contextPath}/03_feedback/passwordCheck.do"
        method="post"
        class="space-y-6 max-w-sm">

        <!-- 숨겨진 필드 -->
        <input type="hidden" name="feedbackId" value="${feedbackId}" />
        <input type="hidden" name="mode" value="${mode}" />

        <!-- 비밀번호 입력 -->
        <div>
          <input type="password" name="writerPw" id="writerPw"
                 autocomplete="new-password" required
                 class="w-full px-4 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-600" />
        </div>

        <!-- 에러 메시지 -->
        <c:if test="${not empty error}">
          <p class="text-red-600 text-sm">${error}</p>
        </c:if>

        <!-- 버튼 영역 -->
        <div class="flex gap-2">
          <button type="submit"
                  class="px-4 py-2 bg-blue-800 text-white text-sm font-medium rounded hover:bg-blue-900">
            확인
          </button>
          <button type="button"
                  onclick="history.back()"
                  class="px-4 py-2 border border-gray-300 text-sm rounded hover:bg-gray-100">
            취소
          </button>
        </div>
      </form>
    </main>
  </div>

</body>
</html>
