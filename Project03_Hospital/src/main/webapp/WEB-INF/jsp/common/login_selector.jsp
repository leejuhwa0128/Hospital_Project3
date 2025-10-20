<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원 유형 선택</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

<!-- 👇 전체 콘텐츠 wrapper: 헤더 아래 정렬 -->
<div class="max-w-3xl mx-auto px-4 py-16">

  <!-- 제목 -->
  <div class="text-center mb-10">
    <h1 class="text-3xl font-bold text-blue-900 mb-2">회원 유형을 선택하세요</h1>
    <p class="text-sm text-gray-600">가입하려는 회원 유형을 선택해 주세요.</p>
  </div>

  <!-- 카드 선택 -->
  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
    
    <!-- 일반 회원 -->
    <form action="${pageContext.request.contextPath}/patient/selectForm.do" method="get">
      <button type="submit" class="w-full text-left p-6 bg-white rounded-xl shadow hover:shadow-md border hover:border-blue-800 transition cursor-pointer">
        <h2 class="text-xl font-semibold text-blue-800 mb-2">🙋 일반 </h2>
        <p class="text-sm text-gray-600">
          병원 이용 고객 전용입니다.
        </p>
      </button>
    </form>

    <!-- 관계자 -->
    <form action="${pageContext.request.contextPath}/user/selectForm.do" method="get">
      <button type="submit" class="w-full text-left p-6 bg-white rounded-xl shadow hover:shadow-md border hover:border-blue-800 transition cursor-pointer">
        <h2 class="text-xl font-semibold text-blue-800 mb-2">🏥 관계자</h2>
        <p class="text-sm text-gray-600">
          관계자 전용입니다.
          
        </p>
      </button>
    </form>

  </div>

  <!-- ✅ 탈퇴 후 알림 -->
  <c:if test="${param.deleted == '1'}">
    <script>
      alert('회원 탈퇴가 완료되었습니다.');
    </script>
  </c:if>
</div>

</body>
</html>
