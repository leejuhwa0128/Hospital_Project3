<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>고객의 소리</title>
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
  고객의 소리
</h2>


      <!-- 설명 -->
      <div class="border border-gray-200 rounded-md p-4 mb-6 bg-gray-50 text-sm text-gray-700 leading-relaxed">
        고객님의 소중한 의견은 우리병원의 발전과 개선을 위한 중요한 밑거름이 됩니다.<br />
        칭찬, 제안, 건의, 불만 등 다양한 의견을 자유롭게 남겨주시면 정성껏 검토 후 답변해 드리겠습니다.
      </div>

      <!-- 버튼 그룹 -->
      <div class="flex justify-end gap-3 mb-6">
        <a href="${pageContext.request.contextPath}/03_feedback/mylist.do"
           class="px-4 py-2 bg-gray-100 hover:bg-gray-200 text-sm rounded border border-gray-300">
          내가 작성한 글
        </a>
        <a href="${pageContext.request.contextPath}/03_feedback/write.do"
           class="px-4 py-2 bg-blue-800 hover:bg-blue-900 text-white text-sm rounded">
          ✏️ 작성
        </a>
      </div>

      <!-- 테이블 -->
      <div class="overflow-x-auto">
        <table class="min-w-full text-sm text-left text-gray-700">
          <thead class="bg-gray-100 text-gray-900 font-semibold border-b">
            <tr>
              <th class="px-4 py-3 text-center w-16">번호</th>
              <th class="px-4 py-3 w-32">카테고리</th>
              <th class="px-4 py-3">내용</th>
              <th class="px-4 py-3 text-center w-32">작성일</th>
              <th class="px-4 py-3 text-center w-24">답변</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-100">
            <c:forEach var="feedback" items="${feedbackList}">
              <tr class="hover:bg-gray-50 transition">
                <td class="px-4 py-2 text-center">${feedback.rowNumber}</td>
                <td class="px-4 py-2">${feedback.category}</td>
                <td class="px-4 py-2">
                  <a href="${pageContext.request.contextPath}/03_feedback/detail.do?id=${feedback.feedbackId}"
                     class="text-blue-700 hover:underline">
                    ${feedback.title}
                  </a>
                </td>
                <td class="px-4 py-2 text-center">
                  <fmt:formatDate value="${feedback.createdAt}" pattern="yyyy.MM.dd" />
                </td>
                <td class="px-4 py-2 text-center">
                  <c:choose>
                    <c:when test="${empty feedback.reply}">
                      <span class="inline-block bg-red-100 text-red-600 text-xs font-medium px-2 py-1 rounded">❌ 미완료</span>
                    </c:when>
                    <c:otherwise>
                      <span class="inline-block bg-green-100 text-green-600 text-xs font-medium px-2 py-1 rounded">✅ 완료</span>
                    </c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <!-- 페이지네이션 -->
      <c:if test="${totalPage > 1}">
        <div class="mt-8 flex justify-center gap-2">
          <c:forEach begin="1" end="${totalPage}" var="p">
            <c:url var="pageUrl" value="/03_feedback/list.do">
              <c:param name="page" value="${p}" />
              <c:param name="category" value="${category}" />
            </c:url>
            <a href="${pageUrl}"
               class="px-3 py-1 border rounded text-sm 
                      ${p == page ? 'bg-blue-800 text-white' : 'text-gray-700 hover:bg-gray-100'}">
              ${p}
            </a>
          </c:forEach>
        </div>
      </c:if>

    </main>
  </div>

</body>
</html>
