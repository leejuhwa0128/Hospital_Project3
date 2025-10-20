<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 찾기</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
    }
  </style>
</head>
<body class="bg-gray-50">

<main class="max-w-md mx-auto mt-24 bg-white border border-gray-200 shadow-md rounded-xl p-8">

  <h2 class="text-2xl font-bold text-blue-900 text-center mb-6">비밀번호 찾기</h2>

  <form action="findPw.do" method="post" class="space-y-5">

    <!-- 아이디 -->
    <div>
      <label class="block mb-1 font-medium text-gray-800">아이디</label>
      <input type="text" name="patientUserId" required
             class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-800" />
    </div>

    <!-- 주민등록번호 -->
    <div>
      <label class="block mb-1 font-medium text-gray-800">주민등록번호</label>
      <input type="text" name="patientRrn" required
             placeholder="숫자만 입력"
             class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-800" />
    </div>

    <!-- 버튼 -->
    <div class="pt-4">
      <button type="submit"
              class="w-full bg-blue-800 text-white py-2 rounded-md hover:bg-blue-900 transition">
        비밀번호 찾기
      </button>
    </div>
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
