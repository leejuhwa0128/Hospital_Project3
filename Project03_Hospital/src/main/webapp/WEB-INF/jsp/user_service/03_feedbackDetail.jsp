<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<%
    boolean isAdmin = false;
    Object loginUser = session.getAttribute("loginUser");

    if (loginUser != null && loginUser instanceof com.hospital.vo.UserVO) {
        com.hospital.vo.UserVO user = (com.hospital.vo.UserVO) loginUser;
        if ("admin".equals(user.getRole())) {
            isAdmin = true;
        }
    }
    request.setAttribute("isAdmin", isAdmin);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>고객의 소리 상세보기</title>
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

      <!-- 제목 -->
      <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
  고객의 소리 상세보기
</h2>

      <!-- 상세 정보 테이블 -->
      <div class="space-y-6">

        <!-- 카테고리 & 작성일 -->
        <div class="grid sm:grid-cols-2 gap-4 text-sm">
          <div>
            <p class="text-gray-500 font-medium">카테고리</p>
            <p class="text-gray-800">${feedback.category}</p>
          </div>
          <div>
            <p class="text-gray-500 font-medium">작성일</p>
            <p class="text-gray-800"><fmt:formatDate value="${feedback.createdAt}" pattern="yyyy.MM.dd HH:mm" /></p>
          </div>
        </div>

        <!-- 제목 -->
        <div>
          <p class="text-gray-500 font-medium">제목</p>
          <p class="text-gray-900 font-semibold">${feedback.title}</p>
        </div>

        <!-- 내용 -->
        <div>
          <p class="text-gray-500 font-medium mb-1">내용</p>
          <div class="bg-gray-50 border border-gray-200 rounded p-4 text-sm whitespace-pre-line text-gray-800">
            ${feedback.content}
          </div>
        </div>

        <!-- 답변 -->
        <c:if test="${not empty feedback.reply}">
          <div>
            <p class="text-gray-500 font-medium mb-1">답변</p>
            <div class="bg-blue-50 border border-blue-200 rounded p-4 text-sm whitespace-pre-line text-gray-800">
              ${feedback.reply}
            </div>
          </div>
        </c:if>

      </div>

      <!-- 버튼 영역 -->
      <div class="mt-10 flex flex-wrap gap-2">
        <!-- 목록 버튼 -->
        <a href="${pageContext.request.contextPath}/03_feedback/list.do"
           class="px-4 py-2 border border-gray-300 rounded text-sm hover:bg-gray-100">
          목록으로
        </a>

        <!-- 관리자 답변 버튼 -->
        <c:if test="${isAdmin and empty feedback.reply}">
          <a href="${pageContext.request.contextPath}/03_feedback/reply.do?id=${feedback.feedbackId}"
             class="px-4 py-2 bg-blue-800 text-white rounded text-sm hover:bg-blue-900">
            답변하기
          </a>
        </c:if>

        <!-- 수정/삭제 버튼 -->
        <c:choose>
          <c:when test="${sessionScope.loginUser != null and (sessionScope.loginUser.patientUserId == feedback.patientUserId or isAdmin)}">
            <a href="${pageContext.request.contextPath}/03_feedback/edit.do?id=${feedback.feedbackId}"
               class="px-4 py-2 border border-gray-300 rounded text-sm hover:bg-gray-100">
              수정
            </a>
            
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/03_feedback/checkPassword.do?feedbackId=${feedback.feedbackId}&mode=edit"
               class="px-4 py-2 border border-gray-300 rounded text-sm hover:bg-gray-100">
              수정
            </a>
            
          </c:otherwise>
        </c:choose>
      </div>

    </main>
  </div>

</body>
</html>
