<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>  공지사항</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-7xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-8">

    <!-- 왼쪽 메뉴 -->
    <aside class="w-full md:w-64">
      <jsp:include page="/WEB-INF/jsp/user_service/01_menu.jsp" />
    </aside>

    <!-- 본문 -->
    <main class="flex-1 bg-white rounded-lg shadow border border-gray-200 p-6">
    <!-- 타이틀 -->
    <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
  공지사항
</h2>

      <div class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200 text-sm text-gray-800">
          <thead class="bg-gray-100 text-left font-bold text-gray-900">
            <tr>
              <th class="px-4 py-3 w-16 text-center">번호</th>
              <th class="px-4 py-3">제목</th>
              <th class="px-4 py-3 w-36 text-center">작성일</th>
            </tr>
          </thead>

          <tbody class="divide-y divide-gray-100">
            <c:forEach var="notice" items="${noticeList}" varStatus="i">
              <tr class="hover:bg-gray-50 transition">
                <td class="px-4 py-2 text-center text-gray-800">${i.count}</td>
                <td class="px-4 py-2">
                  <a href="${pageContext.request.contextPath}/01_notice/detail.do?noticeId=${notice.noticeId}"
                     class="text-gray-800 hover:underline">
                    ${notice.title}
                  </a>
                </td>
                <td class="px-4 py-2 text-center text-gray-800">
                  <fmt:formatDate value="${notice.createdAt}" pattern="yyyy.MM.dd" />
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </main>
  </div>

</body>
</html>
