<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="isIframe" value="${param.iframe eq 'true'}" />

<%-- 헤더는 iframe 아닐 때만 출력 --%>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원 정보 수정</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
    }
  </style>
</head>

<body class="bg-gray-50">
  <main class="relative max-w-[1000px] mx-auto mt-12 mb-24 p-10 bg-white shadow-lg rounded-xl">

    <!-- ❌ X 닫기 버튼 (iframe일 때만 노출) -->
    <c:if test="${isIframe}">
      <button onclick="window.parent.document.getElementById('modal-edit').classList.remove('active')"
              class="absolute top-4 right-4 text-2xl text-gray-400 hover:text-red-600 z-50">
        &times;
      </button>
    </c:if>

    <h2 class="text-2xl font-bold text-blue-900 text-center mb-10">회원 정보 수정</h2>

    <form action="${pageContext.request.contextPath}/patient/updatePatient.do"
          method="post"
          onsubmit="return validateAndSubmit(this)"
          class="space-y-8">

      <!-- 숨겨진 정보 -->
      <input type="hidden" name="patientNo" value="${loginUser.patientNo}" />
      <input type="hidden" name="patientUserId" value="${loginUser.patientUserId}" />

      <!-- 기본 정보 -->
      <section>
        <h3 class="text-lg font-semibold text-blue-800 mb-3">기본 정보</h3>
        <div class="space-y-4">
          <div>
            <label class="block mb-1 text-sm text-gray-700">이름</label>
            <input type="text" value="${loginUser.patientName}" readonly
                   class="w-full px-4 py-2 border border-gray-300 rounded-md bg-gray-100 text-gray-700" />
          </div>
          <div>
            <label class="block mb-1 text-sm text-gray-700">성별</label>
            <select name="patientGender" class="w-full px-4 py-2 border border-gray-300 rounded-md">
              <option value="남성" ${loginUser.patientGender == '남성' ? 'selected' : ''}>남성</option>
              <option value="여성" ${loginUser.patientGender == '여성' ? 'selected' : ''}>여성</option>
            </select>
          </div>
        </div>
      </section>

      <!-- 이메일 -->
      <section>
        <h3 class="text-lg font-semibold text-blue-800 mb-3">이메일 변경</h3>
        <p class="text-sm text-gray-500 mb-2">
          현재 이메일: <strong>${loginUser.patientEmail}</strong>
        </p>
        <div class="flex items-center gap-2">
          <input type="text" id="emailPrefix" class="w-1/2 px-3 py-2 border border-gray-300 rounded-md" placeholder="example" />
          <span>@</span>
          <select id="emailDomain" class="w-1/3 px-2 py-2 border border-gray-300 rounded-md">
            <option value="naver.com">naver.com</option>
            <option value="gmail.com">gmail.com</option>
            <option value="daum.net">daum.net</option>
            <option value="hanmail.net">hanmail.net</option>
          </select>
        </div>
        <input type="hidden" name="patientEmail" id="fullEmail" />
      </section>

      <!-- 전화번호 -->
      <section>
        <h3 class="text-lg font-semibold text-blue-800 mb-3">전화번호 변경</h3>
        <p class="text-sm text-gray-500 mb-2">
          현재 전화번호: <strong>${loginUser.patientPhone}</strong>
        </p>
        <div class="flex items-center gap-2">
          <input type="text" id="phoneStart" value="010" readonly
                 class="w-16 px-3 py-2 border border-gray-300 rounded-md bg-gray-100 text-center" />
          <span>-</span>
          <input type="text" id="phone1" maxlength="4"
                 class="w-20 px-3 py-2 border border-gray-300 rounded-md" placeholder="1234" />
          <span>-</span>
          <input type="text" id="phone2" maxlength="4"
                 class="w-20 px-3 py-2 border border-gray-300 rounded-md" placeholder="5678" />
        </div>
        <input type="hidden" name="patientPhone" id="fullPhone" />
      </section>

      <!-- 비밀번호 변경 -->
      <section>
        <h3 class="text-lg font-semibold text-blue-800 mb-3">비밀번호 변경</h3>
        <p class="text-sm text-gray-500 mb-4">
          ※ 입력하신 비밀번호는 SHA-512 방식으로 안전하게 암호화되어 저장됩니다.
        </p>
        <div class="space-y-3">
          <input type="password" name="currentPassword" placeholder="현재 비밀번호"
                 class="w-full px-4 py-2 border border-gray-300 rounded-md" />
          <input type="password" name="newPassword" placeholder="새 비밀번호"
                 class="w-full px-4 py-2 border border-gray-300 rounded-md" />
          <input type="password" name="confirmPassword" placeholder="새 비밀번호 확인"
                 class="w-full px-4 py-2 border border-gray-300 rounded-md" />
        </div>
      </section>

      <!-- 수정 버튼 -->
      <div class="flex justify-center gap-4 mt-10">
        <button type="submit" class="bg-blue-800 text-white px-6 py-2 rounded-md hover:bg-blue-900 transition">
          수정 완료
        </button>
        <button type="button" onclick="history.back();"
                class="px-6 py-2 border border-gray-400 text-gray-700 rounded-md hover:bg-gray-100 transition">
          취소
        </button>
      </div>
    </form>

    <!-- 회원 탈퇴 -->
    <div class="mt-16 pt-6 border-t border-gray-200 text-center">
      <p class="text-sm text-red-600 mb-3">
        ※ 회원 탈퇴 시 모든 정보는 삭제되며, <strong>되돌릴 수 없습니다.</strong>
      </p>
      <form action="${pageContext.request.contextPath}/patient/delete.do" method="post"
            onsubmit="return confirm('정말 탈퇴하시겠습니까? 탈퇴 후에는 계정 정보를 복구할 수 없습니다.');">
        <button type="submit" class="bg-red-600 hover:bg-red-700 text-white px-5 py-2 rounded-md">
          회원 탈퇴
        </button>
      </form>
    </div>

    <!-- 에러 메시지 -->
    <c:if test="${not empty errorMsg}">
      <script>alert('${errorMsg}');</script>
    </c:if>
  </main>

  <%-- 푸터는 iframe 아닐 때만 출력 --%>
 

  <script>
    function validateAndSubmit(form) {
      const currentPwd = form.currentPassword.value.trim();
      const newPwd = form.newPassword.value.trim();
      const confirmPwd = form.confirmPassword.value.trim();

      const wantsToChangePassword = currentPwd || newPwd || confirmPwd;
      if (wantsToChangePassword) {
        if (!currentPwd || !newPwd || !confirmPwd) {
          alert("비밀번호 변경 시 모든 항목을 입력해주세요.");
          return false;
        }
        if (newPwd !== confirmPwd) {
          alert("새 비밀번호와 확인이 일치하지 않습니다.");
          return false;
        }
      }

      const emailPrefix = document.getElementById("emailPrefix").value.trim();
      const emailDomain = document.getElementById("emailDomain").value;
      document.getElementById("fullEmail").value = emailPrefix && emailDomain ? `${emailPrefix}@${emailDomain}` : "";

      const phone1 = document.getElementById("phone1").value.trim();
      const phone2 = document.getElementById("phone2").value.trim();
      if (phone1 || phone2) {
        if (!phone1 || !phone2) {
          alert("전화번호를 모두 입력해주세요.");
          return false;
        }
        document.getElementById("fullPhone").value = "010" + phone1 + phone2;
      } else {
        document.getElementById("fullPhone").value = "${loginUser.patientPhone}";
      }

      return true;
    }
  </script>
</body>
</html>
