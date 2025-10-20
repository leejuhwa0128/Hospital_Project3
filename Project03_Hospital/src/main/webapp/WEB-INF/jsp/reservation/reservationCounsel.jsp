<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>예약 / 진료 상담</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

<main class="max-w-3xl mx-auto px-4 py-10">
  
  <!-- 제목 -->
  <h1 class="text-2xl font-bold text-center text-blue-900 mb-6">예약 / 진료 상담</h1>

  <!-- 성공 메시지 -->
  <c:if test="${param.success == 'true'}">
    <div class="bg-green-50 border-l-4 border-green-500 text-green-800 p-4 rounded mb-6">
      상담 신청이 완료되었습니다. 담당자가 확인 후 연락드릴 예정입니다.
    </div>
  </c:if>

  <!-- 안내 박스 -->
  <div class="bg-white p-6 rounded-lg shadow mb-8 text-sm leading-6">
    예약 및 진료 상담은 본원을 처음 방문하거나 예약 관련 문의가 있으신 분들을 위해 운영됩니다.<br>
    아래 항목을 빠짐없이 작성해 주시면, 담당자가 이메일 또는 전화로 연락드릴 예정입니다.<br>
    비회원은 상담 내역을 조회할 수 없습니다.<br>
    <span class="text-blue-900 font-semibold">정확하고 빠른 상담을 위해 내용을 구체적으로 입력해 주세요.</span>
  </div>

  <!-- 상담 신청 폼 -->
  <form action="/reservation/counsel/submit.do" method="post" class="bg-white p-6 rounded-lg shadow space-y-5">
    
    <!-- 이름 -->
    <div>
      <label for="patientName" class="block mb-1 font-medium text-blue-900">이름</label>
      <input type="text" id="patientName" name="patientName" placeholder="홍길동" required
             class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-blue-900 focus:outline-none">
    </div>

    <!-- 이메일 -->
    <div>
      <label for="email" class="block mb-1 font-medium text-blue-900">이메일</label>
      <input type="email" id="email" name="email" placeholder="example@email.com" required
             class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-blue-900 focus:outline-none">
    </div>

    <!-- 전화번호 -->
    <div>
      <label for="phone" class="block mb-1 font-medium text-blue-900">전화번호</label>
      <input type="text" id="phone" name="phone" placeholder="010-1234-5678" required
             class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-blue-900 focus:outline-none">
    </div>

    <!-- 상담 제목 -->
    <div>
      <label for="subject" class="block mb-1 font-medium text-blue-900">상담 제목</label>
      <input type="text" id="subject" name="subject" placeholder="예: 진료 일정 문의" required
             class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-blue-900 focus:outline-none">
    </div>

    <!-- 상담 내용 -->
    <div>
      <label for="message" class="block mb-1 font-medium text-blue-900">상담 내용</label>
      <textarea id="message" name="message" placeholder="상담 받고자 하는 내용을 자세히 입력해 주세요." required rows="5"
                class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-blue-900 focus:outline-none"></textarea>
    </div>

    <!-- 버튼 -->
    <div class="flex gap-3">
      <button type="submit" class="bg-blue-900 hover:bg-blue-800 text-white font-medium px-6 py-2 rounded-lg shadow">
        상담 신청
      </button>

      <c:if test="${not empty sessionScope.loginUser}">
        <a href="${pageContext.request.contextPath}/reservation/counsel/list.do"
           class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-medium px-6 py-2 rounded-lg shadow text-center">
          상담 목록
        </a>
      </c:if>
    </div>
  </form>
</main>

</body>
</html>
