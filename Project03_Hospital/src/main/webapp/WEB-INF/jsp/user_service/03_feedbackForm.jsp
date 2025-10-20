<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>고객의 소리 작성</title>
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
  고객의 소리 작성
</h2>

      <form action="${pageContext.request.contextPath}/03_feedback/write.do"
            method="post"
            class="space-y-6">

        <!-- 필드 반복 -->
        <div>
          <label for="category" class="block text-sm font-medium text-gray-700 mb-1">카테고리</label>
          <select id="category" name="category" required
                  class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-800">
            <option value="칭찬">칭찬</option>
            <option value="불만">불만</option>
            <option value="제안">제안</option>
            <option value="문의">문의</option>
            <option value="기타">기타</option>
          </select>
        </div>

        <div>
          <label for="title" class="block text-sm font-medium text-gray-700 mb-1">제목</label>
          <input type="text" id="title" name="title" required
                 class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm focus:ring-2 focus:ring-blue-800" />
        </div>

        <div>
          <label for="content" class="block text-sm font-medium text-gray-700 mb-1">내용</label>
          <textarea id="content" name="content" rows="8" required
                    class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm focus:ring-2 focus:ring-blue-800"></textarea>
        </div>

        <div>
          <label for="senderName" class="block text-sm font-medium text-gray-700 mb-1">보호자 성함</label>
          <input type="text" id="senderName" name="senderName"
                 class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm" />
        </div>

        <div>
          <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">연락처</label>
          <input type="text" id="phone" name="phone" placeholder="예: 010-1234-5678"
                 class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm" />
        </div>

        <div>
          <label for="email" class="block text-sm font-medium text-gray-700 mb-1">이메일</label>
          <input type="email" id="email" name="email"
                 class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm" />
        </div>

        <div>
          <label for="relation" class="block text-sm font-medium text-gray-700 mb-1">관계</label>
          <input type="text" id="relation" name="relation" placeholder="예: 본인, 보호자 등"
                 class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm" />
        </div>

        <div>
          <label for="birthDate" class="block text-sm font-medium text-gray-700 mb-1">생년월일</label>
          <input type="text" id="birthDate" name="birthDate" placeholder="예: 1990-01-01"
                 class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm" />
        </div>

        <div>
          <label for="hospitalNo" class="block text-sm font-medium text-gray-700 mb-1">병원 번호</label>
          <input type="text" id="hospitalNo" name="hospitalNo"
                 class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm" />
        </div>

        <div>
          <label for="writerName" class="block text-sm font-medium text-gray-700 mb-1">작성자 이름</label>
          <input type="text" id="writerName" name="writerName" required
                 class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm" />
        </div>

        <div>
          <label for="writerPw" class="block text-sm font-medium text-gray-700 mb-1">비밀번호</label>
          <input type="password" id="writerPw" name="writerPw" maxlength="10" required
                 class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm" />
        </div>

        <!-- 버튼 -->
        <div class="flex gap-2 pt-4">
          <button type="submit"
                  class="px-4 py-2 bg-blue-800 text-white text-sm rounded hover:bg-blue-900">
            등록
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
