<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
  String iframe = request.getParameter("iframe");
  boolean isIframe = "true".equals(iframe);
%>

<% if (!isIframe) { %>
  <jsp:include page="/WEB-INF/jsp/header.jsp" />
<% } %>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>내가 작성한 고객의 소리</title>
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

      <!-- 타이틀 -->
      <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
  내가 작성한 고객의 소리
</h2>


      <!-- 테이블 -->
      <div class="overflow-x-auto">
        <table class="min-w-full text-sm text-left text-gray-700">
          <thead class="bg-gray-100 text-gray-900 font-semibold border-b">
            <tr>
              <th class="px-4 py-3 text-center w-16">번호</th>
              <th class="px-4 py-3 w-32">카테고리</th>
              <th class="px-4 py-3">제목</th>
              <th class="px-4 py-3 text-center w-32">작성일</th>
              <th class="px-4 py-3 text-center w-24">답변</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-100">
            <c:forEach var="fb" items="${feedbackList}" varStatus="status">
              <tr class="hover:bg-gray-50 transition">
                <td class="px-4 py-2 text-center">${status.index + 1}</td>
                <td class="px-4 py-2">${fb.category}</td>
                <td class="px-4 py-2">
                  <a href="${pageContext.request.contextPath}/03_feedback/detail.do?id=${fb.feedbackId}"
                     class="text-blue-700 hover:underline">
                    ${fb.title}
                  </a>
                </td>
                <td class="px-4 py-2 text-center">
                  <fmt:formatDate value="${fb.createdAt}" pattern="yyyy.MM.dd" />
                </td>
                <td class="px-4 py-2 text-center">
                  <c:choose>
                    <c:when test="${empty fb.reply}">
                      <span class="inline-block bg-red-100 text-red-600 text-xs font-medium px-2 py-1 rounded">❌ 미완료</span>
                    </c:when>
                    <c:otherwise>
                      <span class="inline-block bg-green-100 text-green-600 text-xs font-medium px-2 py-1 rounded">✅ 완료</span>
                    </c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>

            <c:if test="${empty feedbackList}">
              <tr>
                <td colspan="5" class="text-center text-gray-400 py-10 text-sm">
                  등록된 고객의 소리가 없습니다.
                </td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>

      <!-- 뒤로가기 버튼 -->
      <div class="mt-8 text-right">
        <a href="javascript:history.back()"
           class="inline-block px-4 py-2 border border-gray-300 rounded text-sm text-gray-700 hover:bg-gray-100">
          ← 뒤로가기
        </a>
      </div>

    </main>
  </div>

</body>

</html>
