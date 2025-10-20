<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>👍 칭찬글 작성</title>
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

       <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
  칭찬글 작성
</h2>



      <form action="${pageContext.request.contextPath}/03_praise/write.do" method="post" class="space-y-6">

        <!-- 제목 -->
        <div>
          <label for="title" class="block text-sm font-medium text-gray-700 mb-1">제목</label>
          <input type="text" id="title" name="title" required
                 class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-600" />
        </div>

        <!-- 내용 -->
        <div>
          <label for="content" class="block text-sm font-medium text-gray-700 mb-1">내용</label>
          <textarea id="content" name="content" rows="10" required
                    class="w-full px-4 py-2 border border-gray-300 rounded resize-none focus:outline-none focus:ring-2 focus:ring-blue-600"></textarea>
        </div>

        <!-- 버튼 영역 -->
        <div class="text-right space-x-2">
          <button type="submit"
                  class="px-5 py-2 bg-blue-800 text-white rounded hover:bg-blue-900 text-sm">
            등록
          </button>
          <button type="button" onclick="history.back()"
                  class="px-5 py-2 border border-gray-300 rounded text-sm text-gray-700 hover:bg-gray-100">
            취소
          </button>
        </div>
      </form>

    </main>
  </div>

</body>
</html>
