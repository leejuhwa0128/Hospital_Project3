<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>아이디 찾기 결과</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
    }
  </style>
</head>
<body class="bg-gray-50 py-12">

  <main class="max-w-md mx-auto mt-24 bg-white border border-gray-200 shadow-md rounded-xl p-8">
    
    <h2 class="text-2xl font-bold text-blue-900 mb-6">아이디 찾기 결과</h2>

    <c:choose>
      <c:when test="${not empty foundId}">
        <p class="text-gray-700 text-lg mb-6">
          고객님의 아이디는 <span class="font-bold text-blue-800">${foundId}</span> 입니다.
        </p>
      </c:when>
      <c:otherwise>
        <p class="text-red-600 text-base font-medium mb-6">
          ❌ 일치하는 정보가 없습니다.
        </p>
      </c:otherwise>
    </c:choose>
	<div class="mt-6 text-center">
    <a href="selectForm.do"
       class="inline-block px-6 py-2 bg-blue-900 text-white rounded hover:bg-blue-800 transition text-sm font-medium">
      돌아가기
    </a>
    </div>
  </main>

</body>
</html>
