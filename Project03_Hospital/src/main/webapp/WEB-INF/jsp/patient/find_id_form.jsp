<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>아이디 찾기</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
    }
  </style>
</head>
<body class="bg-gray-50">

  <!-- ✅ 메인 콘텐츠 (상단 여백 추가됨) -->
  <main class="max-w-md mx-auto mt-24 bg-white border border-gray-200 shadow-md rounded-xl p-8">

    <h2 class="text-2xl font-bold text-blue-900 text-center mb-6">아이디 찾기</h2>

    <form action="findId.do" method="post" class="space-y-5">

      <!-- 이름 입력 -->
      <div>
        <label for="patientName" class="block text-sm font-medium text-gray-700 mb-1">이름</label>
        <input type="text" id="patientName" name="patientName" required
               class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-blue-900 focus:outline-none" />
      </div>

      <!-- 전화번호 입력 -->
      <div>
        <label for="patientPhone" class="block text-sm font-medium text-gray-700 mb-1">전화번호</label>
        <input type="text" id="patientPhone" name="patientPhone" placeholder="01012345678" required
               class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-blue-900 focus:outline-none" />
      </div>

      <!-- 제출 버튼 -->
      <button type="submit"
              class="w-full bg-blue-900 text-white py-2 rounded hover:bg-blue-800 transition font-medium">
        아이디 찾기
      </button>
    </form>

    <!-- 돌아가기 -->
    <div class="mt-6 text-center">
      <a href="selectForm.do" class="text-sm text-blue-800 hover:underline">
        ← 돌아가기
      </a>
    </div>
  </main>

</body>
</html>
