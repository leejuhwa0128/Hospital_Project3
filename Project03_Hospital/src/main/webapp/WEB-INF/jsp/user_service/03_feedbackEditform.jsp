<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title> 고객의 소리 수정</title>
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
  고객의 소리 수정
</h2>

      <form action="${pageContext.request.contextPath}/03_feedback/edit.do" method="post" class="space-y-6">
        <input type="hidden" name="feedbackId" value="${feedback.feedbackId}" />

        <!-- 카테고리 -->
        <div>
          <label for="category" class="block text-sm font-medium text-gray-700 mb-1">카테고리</label>
          <select name="category" id="category" required
                  class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-800">
            <option value="칭찬" ${feedback.category == '칭찬' ? 'selected' : ''}>칭찬</option>
            <option value="불만" ${feedback.category == '불만' ? 'selected' : ''}>불만</option>
            <option value="제안" ${feedback.category == '제안' ? 'selected' : ''}>제안</option>
            <option value="문의" ${feedback.category == '문의' ? 'selected' : ''}>문의</option>
            <option value="기타" ${feedback.category == '기타' ? 'selected' : ''}>기타</option>
          </select>
        </div>

        <!-- 제목 -->
        <div>
          <label for="title" class="block text-sm font-medium text-gray-700 mb-1">제목</label>
          <input type="text" id="title" name="title" value="${feedback.title}" required
                 class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm focus:ring-2 focus:ring-blue-800" />
        </div>

        <!-- 내용 -->
        <div>
          <label for="content" class="block text-sm font-medium text-gray-700 mb-1">내용</label>
          <textarea id="content" name="content" rows="8" required
                    class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm focus:ring-2 focus:ring-blue-800">${feedback.content}</textarea>
        </div>

        <!-- 버튼 영역 -->
        <div class="flex gap-2 pt-4">
          <button type="submit"
                  class="px-4 py-2 bg-blue-800 text-white text-sm rounded hover:bg-blue-900">
            수정 완료
          </button>
          <button type="button" onclick="history.back()"
                  class="px-4 py-2 border border-gray-300 text-sm rounded hover:bg-gray-100">
            취소
          </button>
        </div>

      </form>

    </main>
  </div>

</body>
</html>
