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
  <title>내 상담 신청 내역</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

<main class="max-w-3xl mx-auto px-4 py-10">
  <!-- 제목 -->
  <c:if test="${sessionScope.loginSuccessName != null and not empty sessionScope.loginSuccessName}">
    <h1 class="text-2xl font-bold text-blue-900 mb-6 text-center">
      ${sessionScope.loginSuccessName}님의 상담 신청 내역
    </h1>
  </c:if>

  <!-- 비회원 메시지 -->
  <c:if test="${sessionScope.loginSuccessName == null || empty sessionScope.loginSuccessName}">
    <div class="bg-red-100 text-red-700 border border-red-300 p-4 rounded text-center">
      비회원은 상담 내역을 조회할 수 없습니다.
    </div>
  </c:if>

  <!-- 상담 목록 -->
  <c:if test="${sessionScope.loginSuccessName != null and not empty sessionScope.loginSuccessName}">
    <c:choose>
      <c:when test="${empty counselList}">
        <p class="text-center text-gray-500 mt-10">신청한 상담 내역이 없습니다.</p>
      </c:when>
      <c:otherwise>
        <div class="overflow-x-auto mt-6">
          <table class="w-full table-auto border border-gray-300 rounded-lg shadow-sm bg-white">
            <thead class="bg-gray-100 text-gray-700 text-sm">
              <tr>
                <th class="py-3 px-4 border-b">번호</th>
                <th class="py-3 px-4 border-b text-left">제목</th>
                <th class="py-3 px-4 border-b">상태</th>
                <th class="py-3 px-4 border-b">신청일</th>
              </tr>
            </thead>
            <tbody class="text-sm text-gray-800">
              <c:forEach var="c" items="${counselList}" varStatus="status">
                <tr class="hover:bg-gray-50">
                  <td class="py-2 px-4 text-center">${status.count}</td>
                  <td class="py-2 px-4 text-left">${c.subject}</td>
                  <td class="py-2 px-4 text-center">
                    <c:choose>
                      <c:when test="${c.status eq '완료'}">
                        <span class="bg-green-100 text-green-700 px-2 py-1 rounded text-xs font-medium">완료</span>
                      </c:when>
                      <c:when test="${c.status eq '대기'}">
                        <span class="bg-yellow-100 text-yellow-700 px-2 py-1 rounded text-xs font-medium">대기</span>
                      </c:when>
                      <c:when test="${c.status eq '보류'}">
                        <span class="bg-red-100 text-red-700 px-2 py-1 rounded text-xs font-medium">보류</span>
                      </c:when>
                      <c:otherwise>
                        <span class="bg-gray-100 text-gray-700 px-2 py-1 rounded text-xs font-medium">${c.status}</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="py-2 px-4 text-center">
                    <fmt:formatDate value="${c.createdAt}" pattern="yyyy-MM-dd" />
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:otherwise>
    </c:choose>
  </c:if>

  <!-- 뒤로가기 버튼 -->
  <div class="mt-10 text-right">
    <a href="javascript:history.back()"
       class="inline-block bg-gray-300 hover:bg-gray-400 text-gray-800 text-sm font-medium px-5 py-2 rounded">
      ← 
    </a>
  </div>
</main>

</body>
</html>
