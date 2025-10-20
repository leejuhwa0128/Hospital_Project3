<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>조직도</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-5xl mx-auto px-4 py-12">
    <!-- 제목 -->
    <div class="mb-8">
     <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
  조직도
</h2>

    </div>

    <!-- 조직도 이미지 -->
    <div class="mb-8 flex justify-center">
      <img 
        src="${pageContext.request.contextPath}/resources/images/orgchart.png"
        alt="조직도 예시"
        class="max-w-full h-auto rounded-lg border border-gray-200 shadow-sm"
      />
    </div>

    <!-- 설명 텍스트 -->
    <p class="text-gray-700 text-base leading-relaxed text-center">
      환자 중심의 효율적인 의료 서비스 제공을 위해 조직이 구성되어 있습니다.
    </p>
  </div>

</body>
</html>
