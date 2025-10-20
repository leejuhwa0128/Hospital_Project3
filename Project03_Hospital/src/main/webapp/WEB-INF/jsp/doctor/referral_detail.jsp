<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>진료의뢰 상세 정보</title>
  <!-- ✅ Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-900 p-6">

  <!-- ✅ 가운데 카드 박스 시작 -->
  <div class="max-w-3xl mx-auto bg-white rounded-lg shadow p-6">

    <h2 class="text-2xl font-semibold mb-6">진료의뢰 상세 정보</h2>

    <table class="w-full border border-gray-200 rounded-lg overflow-hidden mb-8">
      <tbody class="divide-y divide-gray-200">
        <tr class="bg-white hover:bg-gray-50">
          <th class="w-40 px-4 py-3 bg-gray-100 text-left font-medium">담당의</th>
          <td class="px-4 py-3">${loginUser.name}</td>
        </tr>
        <tr class="bg-white hover:bg-gray-50">
          <th class="px-4 py-3 bg-gray-100 text-left font-medium">담당병원</th>
          <td class="px-4 py-3">${request.hospitalName}</td>
        </tr>
        <tr class="bg-white hover:bg-gray-50">
          <th class="px-4 py-3 bg-gray-100 text-left font-medium">환자명</th>
          <td class="px-4 py-3">${request.patientName}</td>
        </tr>
        <tr class="bg-white hover:bg-gray-50">
          <th class="px-4 py-3 bg-gray-100 text-left font-medium">주민등록번호</th>
          <td class="px-4 py-3">${request.rrn}</td>
        </tr>
        <tr class="bg-white hover:bg-gray-50">
          <th class="px-4 py-3 bg-gray-100 text-left font-medium">진료과</th>
          <td class="px-4 py-3"><c:out value="${request.departmentName}" default="${request.department}" /></td>
        </tr>
        <tr class="bg-white hover:bg-gray-50">
          <th class="px-4 py-3 bg-gray-100 text-left font-medium">협진의</th>
          <td class="px-4 py-3">${request.userName}</td>
        </tr>
        <tr class="bg-white hover:bg-gray-50">
          <th class="px-4 py-3 bg-gray-100 text-left font-medium">증상</th>
          <td class="px-4 py-3">${request.symptoms}</td>
        </tr>
        <tr class="bg-white hover:bg-gray-50">
          <th class="px-4 py-3 bg-gray-100 text-left font-medium">협진 사유</th>
          <td class="px-4 py-3">${request.reason}</td>
        </tr>
        <tr class="bg-white hover:bg-gray-50">
          <th class="px-4 py-3 bg-gray-100 text-left font-medium">희망일</th>
          <td class="px-4 py-3">
            <fmt:formatDate value="${request.hopeDate}" pattern="yyyy-MM-dd" />
          </td>
        </tr>
      </tbody>
    </table>

    <h3 class="text-xl font-semibold mb-2">협진의 소견</h3>
    <c:choose>
      <c:when test="${reply != null}">
        <textarea readonly class="w-full h-48 p-3 border border-gray-300 rounded-lg bg-gray-100 resize-none mb-6">${reply.cleanReplyContent}</textarea>
      </c:when>
      <c:otherwise>
        <p class="text-gray-500 mb-6">아직 회신이 없습니다.</p>
      </c:otherwise>
    </c:choose>

    <h3 class="text-xl font-semibold mb-3">댓글</h3>

    <form action="/referral2/addComment.do" method="post" class="mb-6 space-y-3">
      <input type="hidden" name="requestId" value="${request.requestId}" />
      <textarea name="commentText" placeholder="댓글을 입력하세요." class="w-full h-32 p-3 border border-gray-300 rounded-lg resize-none"></textarea>
      <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">댓글 작성</button>
    </form>

    <c:forEach var="comment" items="${comments}">
      <div class="border border-gray-300 rounded-md p-4 bg-white mb-4 shadow-sm" id="box-${comment.commentId}">
        <div class="text-sm text-gray-500 mb-2">
          <span class="font-medium">${comment.doctorId}</span>
          <c:if test="${loginUser.userId == comment.doctorId}">(나)</c:if>
          |
          <fmt:formatDate value="${comment.commentAt}" pattern="yyyy-MM-dd HH:mm" />
        </div>
        <div id="text-${comment.commentId}" class="whitespace-pre-line">${comment.commentText}</div>

        <c:if test="${loginUser.userId == comment.doctorId}">
          <div class="mt-3 text-right space-x-2">
            <form action="/referral2/deleteComment.do" method="post" class="inline">
              <input type="hidden" name="commentId" value="${comment.commentId}" />
              <input type="hidden" name="requestId" value="${request.requestId}" />
              <button type="submit" class="px-3 py-1 text-sm bg-red-500 text-white rounded hover:bg-red-600 transition">삭제</button>
            </form>
            <button type="button" class="px-3 py-1 text-sm bg-yellow-400 text-white rounded hover:bg-yellow-500 transition"
              onclick="showEditForm(${comment.commentId})">수정</button>
          </div>
        </c:if>
      </div>
    </c:forEach>

    <a href="/referral2/received.do" class="inline-block mt-4 px-4 py-2 bg-gray-500 text-white rounded hover:bg-gray-600 transition">뒤로가기</a>

  </div> <!-- ✅ 가운데 카드 박스 끝 -->

  <script>
    const contextPath = '${pageContext.request.contextPath}';
    const requestId = '${request.requestId}';

    function escapeHtml(text) {
      if (!text) return '';
      return text
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;')
        .replace(/\n/g, '<br/>');
    }

    function unescapeHtml(text) {
      if (!text) return '';
      return text
        .replace(/<br\/>/g, '\n')
        .replace(/&#39;/g, "'")
        .replace(/&quot;/g, '"')
        .replace(/&gt;/g, '>')
        .replace(/&lt;/g, '<')
        .replace(/&amp;/g, '&');
    }

    function showEditForm(commentId) {
      const textEl = document.getElementById("text-" + commentId);
      const rawText = textEl ? unescapeHtml(textEl.innerHTML.trim()) : '';
      const escapedForJs = rawText.replace(/\\/g, "\\\\").replace(/'/g, "\\'").replace(/\n/g, "\\n");

      const formHtml = [];
      formHtml.push('<form action="' + contextPath + '/referral2/updateComment.do" method="post" class="space-y-3">');
      formHtml.push('<input type="hidden" name="commentId" value="' + commentId + '" />');
      formHtml.push('<input type="hidden" name="requestId" value="' + requestId + '" />');
      formHtml.push('<textarea name="commentText" rows="3" class="w-full p-2 border border-gray-300 rounded">' + rawText + '</textarea>');
      formHtml.push('<div class="text-right space-x-2">');
      formHtml.push('<button type="submit" class="px-3 py-1 bg-blue-600 text-white rounded hover:bg-blue-700 transition">수정완료</button>');
      formHtml.push('<button type="button" class="px-3 py-1 bg-gray-400 text-white rounded hover:bg-gray-500 transition" onclick="cancelEdit(' + commentId + ', \'' + escapedForJs + '\')">취소</button>');
      formHtml.push('</div>');
      formHtml.push('</form>');

      document.getElementById("box-" + commentId).innerHTML = formHtml.join('\n');
    }

    function cancelEdit(commentId, originalText) {
      const box = document.getElementById("box-" + commentId);
      const html = [];
      html.push('<div id="text-' + commentId + '" class="whitespace-pre-line">' + escapeHtml(originalText) + '</div>');
      html.push('<div class="mt-3 text-right space-x-2">');
      html.push('<form action="' + contextPath + '/referral2/deleteComment.do" method="post" class="inline">');
      html.push('<input type="hidden" name="commentId" value="' + commentId + '" />');
      html.push('<input type="hidden" name="requestId" value="' + requestId + '" />');
      html.push('<button type="submit" class="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600 transition">삭제</button>');
      html.push('</form>');
      html.push('<button type="button" class="px-3 py-1 bg-yellow-400 text-white rounded hover:bg-yellow-500 transition" onclick="showEditForm(' + commentId + ')">수정</button>');
      html.push('</div>');
      box.innerHTML = html.join('\n');
    }
  </script>

</body>
</html>
