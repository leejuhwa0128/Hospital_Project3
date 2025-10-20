<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>칭찬릴레이</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-6xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-8">

    <!-- 사이드 메뉴 -->
    <aside class="w-full md:w-64">
      <jsp:include page="/WEB-INF/jsp/user_service/03_menu.jsp" />
    </aside>

    <!-- 본문 영역 -->
    <main class="flex-1 bg-white rounded-lg shadow border border-gray-200 p-6">

      <!-- 제목 -->
      <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
  칭찬 릴레이
</h2>


      <!-- 설명 -->
      <div class="border border-gray-200 bg-gray-50 rounded p-4 text-sm text-gray-700 mb-8 leading-relaxed">
        칭찬릴레이 게시판은 우리병원에서 있었던 크고 작은 칭찬이야기, 따뜻한 이야기, 감동적인 이야기를 게시하여 함께 공유하며 따뜻한 감동을 고객 여러분과 나누기 위해 만들었습니다.<br>
        여러분들의 많은 관심과 참여 부탁드립니다.
      </div>

      <!-- 상단 버튼 영역 -->
      <div class="flex justify-between items-center mb-4">
        <span class="text-sm text-gray-600">총 <strong>${praiseList.size()}</strong>개</span>
        <a href="/03_praise/writeForm.do"
           class="inline-block px-4 py-2 bg-blue-800 text-white text-sm rounded hover:bg-blue-900">
          ✏️ 칭찬글 작성
        </a>
      </div>

      <!-- 테이블 -->
      <div class="overflow-x-auto">
        <table class="min-w-full text-sm border border-gray-200 rounded">
          <thead class="bg-gray-100 text-gray-900 font-semibold">
            <tr>
              <th class="px-4 py-3 w-16 text-center border-b">번호</th>
              <th class="px-4 py-3 text-left border-b">제목</th>
              <th class="px-4 py-3 w-36 text-center border-b">등록일</th>
              <th class="px-4 py-3 w-24 text-center border-b">조회수</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-100">
            <c:choose>
              <c:when test="${empty praiseList}">
                <tr>
                  <td colspan="4" class="text-center text-gray-500 py-8">등록된 칭찬글이 없습니다.</td>
                </tr>
              </c:when>
              <c:otherwise>
 <!-- 게시글 번호 시작값 계산 -->
<c:set var="rowNumber" value="${(currentPage - 1) * pageSize}" />

<c:forEach var="praise" items="${praiseList}" varStatus="loop">
  <tr class="hover:bg-gray-50 transition">
    <!-- 번호: (현재 페이지 - 1) * 페이지당 수 + 현재 인덱스 + 1 -->
    <td class="text-center text-gray-600 px-4 py-2">${rowNumber + loop.index + 1}</td>
    <td class="px-4 py-2 text-left">
      <a href="/03_praise/detail.do?praiseId=${praise.praiseId}"
         class="text-blue-800 hover:underline">
        <c:out value="${praise.title}" />
      </a>
    </td>
    <td class="text-center px-4 py-2">
      <fmt:formatDate value="${praise.createdAt}" pattern="yyyy.MM.dd" />
    </td>
    <td class="text-center px-4 py-2">${praise.viewCount}</td>
  </tr>
</c:forEach>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>
      
      <!-- ✅ 페이지네이션 추가 시작 -->
      <c:if test="${totalPage > 1}">
        <div class="mt-8 flex justify-center gap-2">
          <c:forEach begin="1" end="${totalPage}" var="p">
            <c:url var="pageUrl" value="/03_praise/list.do">
              <c:param name="page" value="${p}" />
            </c:url>
<a href="${pageUrl}"
   class="px-3 py-1 border rounded text-sm 
          ${p == currentPage ? 'bg-blue-800 text-white' : 'text-gray-700 hover:bg-gray-100'}">
  ${p}
</a>
          </c:forEach>
        </div>
      </c:if>
      <!-- ✅ 페이지네이션 추가 끝 -->

    </main>
  </div>

</body>
</html>
