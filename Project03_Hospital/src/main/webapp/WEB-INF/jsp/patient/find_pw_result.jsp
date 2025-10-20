<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>임시 비밀번호 발급</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
    }
  </style>
</head>
<body class="bg-gray-50">

<main class="max-w-md mx-auto mt-24 bg-white border border-gray-200 shadow-md rounded-xl p-8 text-center">

  <h2 class="text-2xl font-bold text-blue-900 mb-6">임시 비밀번호 발급</h2>

  <form>
    <c:choose>
      <c:when test="${not empty tempPw}">
        <p class="text-lg mb-3">
          임시 비밀번호는 <strong class="text-blue-800">${tempPw}</strong>입니다.
        </p>
        <p class="text-sm text-gray-700">
          로그인 후 <span class="font-semibold text-red-600">비밀번호를 꼭 변경</span>해주세요.
        </p>
      </c:when>
      <c:otherwise>
        <p class="text-red-600 text-sm font-medium">
          ❌ 일치하는 정보가 없습니다.
        </p>
      </c:otherwise>
    </c:choose>
  </form>

  <div class="mt-6">
    <a href="selectForm.do"
       class="inline-block text-sm text-blue-800 hover:underline">
      ← 돌아가기
    </a>
  </div>

</main>

</body>
</html>
