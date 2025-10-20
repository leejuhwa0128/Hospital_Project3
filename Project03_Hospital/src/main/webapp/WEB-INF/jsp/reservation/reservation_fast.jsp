<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>빠른예약 신청</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

<main class="max-w-3xl mx-auto px-4 py-10">

  <!-- ✅ 신청 성공 알림 -->
  <c:if test="${not empty sessionScope.fastSuccess}">
    <div class="bg-green-50 border-l-4 border-green-500 text-green-800 p-4 rounded mb-6">
      ✅ 빠른예약 신청이 완료되었습니다. <br>
      평일 기준 <strong>24시간 이내</strong> (주말·공휴일 제외) 상담원이 연락드립니다.
    </div>
    <c:remove var="fastSuccess" scope="session" />
  </c:if>

  <!-- 제목 -->
  <h1 class="text-2xl font-bold text-center text-blue-900 mb-4">간편예약 (빠른예약 신청)</h1>

  <!-- 안내문 -->
  <p class="text-sm text-gray-700 bg-white shadow p-5 rounded-lg mb-8 leading-6">
    환자 또는 보호자분의 전화번호를 남기시면, 상담원이 친절하게 예약을 도와드리겠습니다.<br>
    <strong class="text-blue-900">상담시간</strong> : 평일 08:30 ~ 17:30 / 토요일 08:30 ~ 12:30 (공휴일 제외)<br>
    의뢰서를 발급받으신 경우 등록하시면 더 신속하고 정확한 예약안내가 가능합니다.
  </p>

  <form action="/reservation/fast/submit.do" method="post" class="bg-white shadow p-6 rounded-lg space-y-6">
    <!-- 전화번호 입력 -->
    <div>
      <label for="phone" class="block font-semibold text-blue-900 mb-2">휴대폰 번호</label>
      <div class="flex gap-2">
        <input type="text" name="phone1" maxlength="3" required class="border rounded px-3 py-2 w-20 text-center" />
        <span class="self-center">-</span>
        <input type="text" name="phone2" maxlength="4" required class="border rounded px-3 py-2 w-24 text-center" />
        <span class="self-center">-</span>
        <input type="text" name="phone3" maxlength="4" required class="border rounded px-3 py-2 w-24 text-center" />
      </div>
    </div>

    <!-- 개인정보 동의 -->
    <div>
      <h4 class="font-semibold text-blue-900 mb-2">개인정보 수집·이용 동의</h4>
      <div class="bg-gray-50 border border-gray-200 p-4 rounded text-sm space-y-3">
        <p>
          <strong>수집항목</strong><br>
          1. 의뢰서 미등록자 : 휴대폰 번호<br>
          2. 의뢰서 등록자 : 휴대폰 번호, 요양급여(진료)의뢰서 내용(주민등록번호, 주소, 진료 의뢰기관 정보, 진료 정보, 건강보험 또는 의료급여 정보)
        </p>
        <p>
          <strong>목적</strong> : 진료 예약 진행을 위한 정보<br>
          <strong>보유기간</strong> : 예약 진료 완료 시까지
        </p>
        <p>
          위 항목에 대한 개인정보 수집·이용에 <strong class="text-red-600">동의</strong>하셔야 빠른예약 신청이 가능합니다.<br>
          본 정보는 간편예약 신청 이외의 용도로는 사용되지 않습니다.
        </p>
        <div class="flex items-center gap-2">
          <input type="radio" name="agree" value="yes" required class="h-4 w-4" />
          <label>동의합니다.</label>
        </div>
      </div>
    </div>

    <!-- 제출 버튼 -->
    <div class="text-center">
      <button type="submit"
        class="bg-blue-900 hover:bg-blue-800 text-white font-medium px-8 py-3 rounded-lg shadow">
        신청
      </button>
    </div>
  </form>
</main>

</body>
</html>
<jsp:include page="/WEB-INF/jsp/footer.jsp" />
