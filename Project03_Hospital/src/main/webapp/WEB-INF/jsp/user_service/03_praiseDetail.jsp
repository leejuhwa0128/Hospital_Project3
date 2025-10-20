<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title> 칭찬릴레이</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-6xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-8">

    <!-- 사이드 메뉴 -->
    <aside class="w-full md:w-64">
      <jsp:include page="/WEB-INF/jsp/user_service/03_menu.jsp" />
    </aside>

    <!-- 본문 -->
    <main class="flex-1 bg-white rounded-lg shadow border border-gray-200 p-6">

      <!-- 헤더 -->
      <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
 칭찬 릴레이
</h2>


      <!-- 제목 및 메타정보 -->
      <div class="mb-6 border-b border-gray-200 pb-4">
        <h3 class="text-xl font-semibold text-gray-800 mb-2 break-words">
          <c:out value="${praise.title}" />
        </h3>
        <div class="text-sm text-gray-500">
          작성일: <fmt:formatDate value="${praise.createdAt}" pattern="yyyy.MM.dd HH:mm" />
          &nbsp;|&nbsp;
          조회수: <c:out value="${praise.viewCount}" />
        </div>
      </div>

      <!-- 본문 내용 -->
      <div class="prose prose-sm max-w-full text-gray-800 leading-relaxed whitespace-pre-line">
        <c:out value="${praise.content}" />
      </div>
<!-- 버튼 영역 -->
<!-- 버튼 영역 -->
<div class="mt-10 flex flex-wrap justify-end gap-2">
  <!-- 목록 버튼 -->
  <a href="${pageContext.request.contextPath}/03_praise/list.do"
     class="inline-flex items-center justify-center w-28 h-10 bg-blue-800 text-white text-sm rounded hover:bg-blue-900">
    목록으로
  </a>

  <c:if test="${loginUser.patientUserId eq praise.patientUserId}">
    <!-- 수정 버튼 -->
    <a href="${pageContext.request.contextPath}/03_praise/editForm.do?praiseId=${praise.praiseId}"
       class="inline-flex items-center justify-center w-28 h-10 bg-blue-800 text-white text-sm rounded hover:bg-blue-900">
      수정
    </a>

    <!-- 삭제 버튼 -->
    <form action="${pageContext.request.contextPath}/03_praise/delete.do" method="post"
          onsubmit="return confirm('정말 삭제하시겠습니까?');">
      <input type="hidden" name="praiseId" value="${praise.praiseId}" />
      <button type="submit"
              class="inline-flex items-center justify-center w-28 h-10 bg-blue-800 text-white text-sm rounded hover:bg-blue-900">
        삭제
      </button>
    </form>
  </c:if>
</div>



    </main>
  </div>

</body>
</html>
