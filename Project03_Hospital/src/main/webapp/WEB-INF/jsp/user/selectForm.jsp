<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>관계자 로그인/회원가입</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    body { font-family: 'Pretendard', 'Noto Sans KR', sans-serif; }
  </style>
  <script>
    const contextPath = "${pageContext.request.contextPath}";
  </script>
</head>
<body class="bg-gray-50 min-h-screen flex flex-col items-center px-4">

<main class="max-w-[600px] w-full px-4 py-12">

  <!-- 상단 제목 -->
  <div class="text-center mb-6">
    <h1 class="text-xl font-bold text-blue-900 mb-2">관계자 전용 페이지입니다</h1>
  </div>

  <!-- 탭 -->
  <div class="flex justify-center gap-4 border-b border-gray-200 pb-2 mb-4">
    <button id="loginTab" onclick="showSection('loginSection')"
      class="tab-button px-3 pb-1 font-medium text-gray-500 hover:text-blue-900 border-b-2 border-transparent">로그인</button>
    <button id="signupTab" onclick="showSection('signupSection')"
      class="tab-button px-3 pb-1 font-medium text-gray-500 hover:text-blue-900 border-b-2 border-transparent">회원가입</button>
  </div>

  <!-- 로그인 섹션 -->
  <section id="loginSection" class="bg-white border border-gray-200 rounded-xl shadow-sm p-6 space-y-5">
    <h2 class="text-xl font-bold text-blue-900">로그인</h2>
    <form action="${pageContext.request.contextPath}/user/login.do" method="post" class="space-y-4">
      <input type="text" name="userId" placeholder="아이디" required
        class="w-full bg-gray-50 border border-gray-200 rounded px-4 py-2 text-sm" />
      <input type="password" name="password" placeholder="비밀번호" required
        class="w-full bg-gray-50 border border-gray-200 rounded px-4 py-2 text-sm" />

       <p class="text-sm text-gray-500 mt-2">
        ※ 관리자의 승인 후 사용이 가능합니다. 최대 24시간 소요될 수 있습니다.
      </p>

      <button type="submit"
        class="w-1/2 mx-auto block bg-blue-900 hover:bg-blue-800 text-white py-2 rounded font-medium mt-4">
        로그인
      </button>

      <c:if test="${not empty sessionScope.loginError}">
        <p class="text-red-600 text-sm text-center mt-2">${sessionScope.loginError}</p>
        <c:remove var="loginError" scope="session" />
      </c:if>
    </form>
  </section>

  <!-- 회원가입 섹션 -->
  <section id="signupSection" class="bg-white border border-gray-200 rounded-xl shadow-sm p-6 space-y-5 hidden">
    <h2 class="text-xl font-bold text-blue-900">회원가입</h2>
    <form action="${pageContext.request.contextPath}/user/signup.do" method="post" enctype="multipart/form-data" class="space-y-4">

      <!-- 아이디 -->
      <div>
        <label class="block text-sm font-medium mb-1">아이디</label>
        <input type="text" name="userId" required
          class="w-full bg-gray-50 border border-gray-200 rounded px-3 py-2 text-sm" />
      </div>

      <!-- 비밀번호 -->
      <div>
        <label class="block text-sm font-medium mb-1">비밀번호</label>
        <input type="password" name="password" required
          class="w-full bg-gray-50 border border-gray-200 rounded px-3 py-2 text-sm" />
      </div>

      <!-- 이름 -->
      <div>
        <label class="block text-sm font-medium mb-1">이름</label>
        <input type="text" name="name" required
          class="w-full bg-gray-50 border border-gray-200 rounded px-3 py-2 text-sm" />
      </div>

      <!-- 주민등록번호 -->
      <div>
        <label class="block text-sm font-medium mb-1">주민등록번호</label>
        <div class="flex gap-2">
          <input type="text" name="rrn1" maxlength="6" required
            class="w-24 bg-gray-50 border border-gray-200 rounded px-2 py-2 text-center text-sm" />
          <span class="self-center">-</span>
          <input type="text" name="rrn2" maxlength="7" required
            class="w-28 bg-gray-50 border border-gray-200 rounded px-2 py-2 text-center text-sm" />
        </div>
      </div>

      <!-- 성별 -->
      <div>
        <label class="block text-sm font-medium mb-1">성별</label>
        <select name="gender" class="w-full bg-gray-50 border border-gray-200 rounded px-3 py-2 text-sm">
          <option value="남">남</option>
          <option value="여">여</option>
        </select>
      </div>

      <!-- 전화번호 -->
      <div>
        <label class="block text-sm font-medium mb-1">전화번호</label>
        <div class="flex gap-2">
          <input type="text" value="010" readonly class="w-16 bg-gray-100 border border-gray-200 rounded px-2 py-2 text-center text-sm" />
          <input type="text" name="phone1" maxlength="4" required class="w-20 bg-gray-50 border border-gray-200 rounded px-2 py-2 text-center text-sm" />
          <input type="text" name="phone2" maxlength="4" required class="w-20 bg-gray-50 border border-gray-200 rounded px-2 py-2 text-center text-sm" />
        </div>
      </div>

      <!-- 이메일 -->
      <div>
        <label class="block text-sm font-medium mb-1">이메일</label>
        <div class="flex gap-2 items-center">
          <input type="text" name="emailPrefix" placeholder="이메일 아이디"
            class="w-1/2 bg-gray-50 border border-gray-200 rounded px-3 py-2 text-sm" />
          <select name="emailDomain"
            class="w-1/2 bg-white border border-gray-200 rounded px-3 py-2 text-sm">
            <option value="naver.com">@naver.com</option>
            <option value="daum.net">@daum.net</option>
            <option value="gmail.com">@gmail.com</option>
          </select>
        </div>
      </div>

      <!-- 프로필 이미지 -->
      <div>
        <label class="block text-sm font-medium mb-1">프로필 이미지</label>
        <input type="file" name="profileImage" accept="image/*" class="w-full text-sm" />
      </div>

      <!-- 전문 진료 분야 -->
      <div>
        <label class="block text-sm font-medium mb-1">전문 진료 분야</label>
        <input type="text" name="specialty" placeholder="예: 내분비 질환, 갑상선 등"
          class="w-full bg-gray-50 border border-gray-200 rounded px-3 py-2 text-sm" />
      </div>

      <!-- 역할 선택 -->
      <div>
        <label class="block text-sm font-medium mb-1">역할</label>
        <select name="role" id="role" onchange="onRoleChange()"
          class="w-full bg-white border border-gray-200 rounded px-3 py-2 text-sm" required>
          <option value="">역할 선택</option>
          <option value="doctor">의사 (본원)</option>
          <option value="coop">협력의</option>
        </select>
      </div>

      <!-- 협력의: 병원 선택 -->
      <div id="hospitalSelectSection" class="hidden">
        <label class="block text-sm font-medium mb-1">소속 병원</label>
        <select name="hospitalId" onchange="document.getElementById('hospitalIdHidden').value=this.value"
          class="w-full bg-white border border-gray-200 rounded px-3 py-2 text-sm">
          <option value="">병원 선택</option>
          <c:forEach var="h" items="${hospitalList}">
            <option value="${h.hospitalId}">${h.name}</option>
          </c:forEach>
        </select>
      </div>
      <input type="hidden" name="hospitalId" id="hospitalIdHidden" />

      <!-- 의사: 진료과 선택 -->
      <div id="deptSection" class="hidden">
        <label class="block text-sm font-medium mb-1">진료과</label>
        <select name="deptId"
          class="w-full bg-white border border-gray-200 rounded px-3 py-2 text-sm">
          <option value="">진료과 선택</option>
          <c:forEach var="d" items="${deptList}">
            <option value="${d.deptId}">${d.name}</option>
          </c:forEach>
        </select>
      </div>

      <!-- 설명 -->
      <p class="text-sm text-gray-500 mt-2">
        ※ 관리자의 승인 후 사용이 가능합니다. 최대 24시간 소요될 수 있습니다.
      </p>

      <!-- 제출 버튼 -->
      <button type="submit"
        class="w-1/2 mx-auto block bg-blue-900 hover:bg-blue-800 text-white py-2 rounded font-medium mt-4">
        회원가입 신청
      </button>

      <c:if test="${not empty signupError}">
        <p class="text-red-600 text-sm text-center mt-2">${signupError}</p>
      </c:if>

      <c:if test="${not empty sessionScope.signupMessage}">
        <script>alert("${signupMessage}");</script>
        <c:remove var="signupMessage" scope="session" />
      </c:if>
    </form>
  </section>
</main>

<jsp:include page="/WEB-INF/jsp/footer.jsp" />

<script>
function showSection(sectionId) {
  const loginTab = document.getElementById("loginTab");
  const signupTab = document.getElementById("signupTab");
  const login = document.getElementById("loginSection");
  const signup = document.getElementById("signupSection");

  if (sectionId === "loginSection") {
    loginTab.classList.add("text-blue-900", "border-blue-900");
    loginTab.classList.remove("text-gray-500", "border-transparent");
    signupTab.classList.remove("text-blue-900", "border-blue-900");
    signupTab.classList.add("text-gray-500", "border-transparent");

    login.classList.remove("hidden");
    signup.classList.add("hidden");
  } else {
    signupTab.classList.add("text-blue-900", "border-blue-900");
    signupTab.classList.remove("text-gray-500", "border-transparent");
    loginTab.classList.remove("text-blue-900", "border-blue-900");
    loginTab.classList.add("text-gray-500", "border-transparent");

    signup.classList.remove("hidden");
    login.classList.add("hidden");
  }
}

function onRoleChange() {
  const role = document.getElementById("role").value;
  const dept = document.getElementById("deptSection");
  const hosp = document.getElementById("hospitalSelectSection");
  const hidden = document.getElementById("hospitalIdHidden");

  if (role === "doctor") {
    dept.classList.remove("hidden");
    hosp.classList.add("hidden");
    hidden.value = "1";
  } else if (role === "coop") {
    dept.classList.add("hidden");
    hosp.classList.remove("hidden");
    hidden.value = "";
  } else {
    dept.classList.add("hidden");
    hosp.classList.add("hidden");
    hidden.value = "";
  }
}

window.onload = function () {
  showSection("loginSection");
};
</script>

</body>
</html>
