<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>회원 로그인/회원가입</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
  body { font-family: 'Pretendard', 'Noto Sans KR', sans-serif; }
</style>
<script>
  const contextPath = "${pageContext.request.contextPath}";
</script>
</head>
<body class="bg-gray-50 min-h-screen flex flex-col items-center px-4">

  <main class="max-w-[600px] mx-auto px-4 py-12">
    <!-- ✅ 상단 제목 -->
    <div class="text-center mb-4">
      <h1 class="text-xl font-bold text-blue-900 mb-1">일반 회원 전용 페이지입니다</h1>
      <br>
      <p class="text-sm text-gray-600"></p>
    </div>

    <!-- ✅ 탭 버튼 -->
    <div class="flex justify-center gap-4 border-b border-gray-200 pb-2">
      <button id="loginTab"  onclick="showSection('loginSection')"
        class="tab-button px-3 pb-1 font-medium text-gray-500 hover:text-blue-900 border-b-2 border-transparent">로그인</button>
      <button id="signupTab" onclick="showSection('signupSection')"
        class="tab-button px-3 pb-1 font-medium text-gray-500 hover:text-blue-900 border-b-2 border-transparent">회원가입</button>
    </div>

    <!-- ✅ 로그인 섹션 -->
    <section id="loginSection"
      class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 space-y-5">
      <h2 class="text-xl font-bold text-blue-900">로그인</h2>
      <form action="${pageContext.request.contextPath}/patient/login.do" method="post" class="space-y-4">
        <input type="text"     name="patientUserId"   placeholder="아이디"   required class="w-full bg-gray-50 border border-gray-200 rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
        <input type="password" name="patientPassword" placeholder="비밀번호" required class="w-full bg-gray-50 border border-gray-200 rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
        <button type="submit" class="w-1/2 mx-auto block bg-blue-900 hover:bg-blue-800 text-white py-2 rounded font-medium transition mt-4">로그인</button>

        <div class="flex justify-center mt-4">
          <a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=8439ac1e9e2f3cf860f6ab16dbcd581a&redirect_uri=http://localhost:18080/user/kakaoLogin.do&state=patient">
            <img src="${pageContext.request.contextPath}/resources/images/etc/kakao_login.png" alt="카카오 로그인" />
          </a>
        </div>

        <div class="flex justify-center space-x-4 text-sm text-blue-600 mt-2">
          <a href="findIdForm.do" class="hover:underline">아이디 찾기</a><span>|</span>
          <a href="findPwForm.do" class="hover:underline">비밀번호 찾기</a>
        </div>

        <c:if test="${param.error == '1'}">
          <p class="text-red-600 text-sm text-center mt-2">아이디 또는 비밀번호가 잘못되었습니다.</p>
        </c:if>
      </form>
    </section>

    <!-- ✅ 회원가입 섹션 -->
    <section id="signupSection"
      class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 space-y-5 hidden">
      <h2 class="text-lg font-semibold text-blue-900">회원가입</h2>

      <form action="${pageContext.request.contextPath}/patient/signup.do" method="post" onsubmit="return validateAll()" class="space-y-4">
        <!-- 아이디 -->
        <div>
          <label class="block text-sm font-medium mb-1">아이디</label>
          <div class="flex gap-2">
            <input type="text" id="userId" name="patientUserId" required oninput="validateUserId()"
                   class="flex-1 bg-gray-50 border border-gray-200 rounded px-3 py-2 text-sm" />
            <button type="button" id="checkBtn" onclick="checkIdDuplicate()"
                    class="text-sm px-3 py-2 bg-gray-100 hover:bg-gray-200 border border-gray-300 rounded">중복확인</button>
          </div>
          <span id="idError" class="text-sm text-red-600 mt-1 block"></span>
        </div>

        <!-- 비밀번호 -->
        <div>
          <label class="block text-sm font-medium mb-1">비밀번호</label>
          <input type="password" id="pw" name="patientPassword" required oninput="validatePassword()"
                 class="w-full bg-gray-50 border border-gray-200 rounded px-3 py-2" />
          <span id="pwError" class="text-sm text-red-600 mt-1 block"></span>
        </div>

        <!-- 이름 -->
        <div>
          <label class="block text-sm font-medium mb-1">이름</label>
          <input type="text" id="name" name="patientName" required
                 oninput="validateField('name', /^[가-힣]+$/, '이름은 한글만 입력', 'nameError', 'name')"
                 class="w-full bg-gray-50 border border-gray-200 rounded px-3 py-2" />
          <span id="nameError" class="text-sm text-red-600 mt-1 block"></span>
        </div>

        <!-- 주민등록번호 -->
        <div>
          <label class="block text-sm font-medium mb-1">주민등록번호</label>
          <div class="flex gap-2">
            <input type="text" id="rrn1" maxlength="6" required
                   oninput="validateField('rrn1', /^\\d{6}$/, '', 'rrnError', 'rrn1'); checkRrnDuplicate()"
                   class="w-24 bg-gray-50 border border-gray-200 rounded px-2 py-2 text-center" />
            <span class="self-center">-</span>
            <input type="text" id="rrn2" maxlength="7" required
                   oninput="validateField('rrn2', /^\\d{7}$/, '', 'rrnError', 'rrn2'); checkRrnDuplicate()"
                   class="w-28 bg-gray-50 border border-gray-200 rounded px-2 py-2 text-center" />
          </div>
          <input type="hidden" name="patientRrn" id="rrn" />
          <span id="rrnError" class="text-sm text-red-600 mt-1 block"></span>
          <span id="rrnDuplicate" class="text-sm text-red-600 mt-1 block"></span>
        </div>

        <!-- 성별 -->
        <div>
          <label class="block text-sm font-medium mb-1">성별</label>
          <select name="patientGender" id="gender" class="w-full bg-gray-50 border border-gray-200 rounded px-3 py-2">
            <option value="남">남</option>
            <option value="여">여</option>
          </select>
        </div>

        <!-- 전화번호 -->
        <div>
          <label class="block text-sm font-medium mb-1">전화번호</label>
          <div class="flex gap-2">
            <input type="text" value="010" readonly
                   class="w-16 bg-gray-100 border border-gray-200 rounded px-2 py-2 text-center" />
            <input type="text" id="phone1" maxlength="4"
                   oninput="validateField('phone1', /^\\d{3,4}$/, '', 'phoneError', 'phone1'); checkPhoneDuplicate()"
                   class="w-20 bg-gray-50 border border-gray-200 rounded px-2 py-2 text-center" />
            <input type="text" id="phone2" maxlength="4"
                   oninput="validateField('phone2', /^\\d{4}$/, '', 'phoneError', 'phone2'); checkPhoneDuplicate()"
                   class="w-20 bg-gray-50 border border-gray-200 rounded px-2 py-2 text-center" />
          </div>
          <input type="hidden" name="patientPhone" id="phone" />
          <span id="phoneError" class="text-sm text-red-600 mt-1 block"></span>
          <span id="phoneDuplicate" class="text-sm text-red-600 mt-1 block"></span>
        </div>

        <!-- 이메일 -->
        <div>
          <label class="block text-sm font-medium mb-1">이메일</label>
          <div class="flex gap-2 items-center">
            <input type="text" id="emailPrefix" required oninput="validateEmailField()"
                   class="w-1/3 bg-gray-50 border border-gray-200 rounded px-3 py-1.5 text-sm h-9" />
            <span class="self-center">@</span>
            <select id="emailDomain" onchange="checkEmailDuplicate()"
                    class="w-1/3 bg-white border border-gray-200 rounded px-2 py-1.5 text-sm h-9">
              <option value="naver.com">naver.com</option>
              <option value="gmail.com">gmail.com</option>
              <option value="daum.net">daum.net</option>
              <option value="hanmail.net">hanmail.net</option>
            </select>
            <button type="button" id="checkEmailBtn" onclick="checkEmailDuplicate()"
                    class="text-sm px-3 py-1.5 bg-gray-100 hover:bg-gray-200 border border-gray-300 rounded whitespace-nowrap h-9">중복확인</button>
          </div>
          <input type="hidden" name="patientEmail" id="patientEmail" />
          <span id="emailError" class="text-sm text-red-600 mt-1 block"></span>
        </div>

        <!-- 제출 -->
        <button type="submit" class="w-1/2 mx-auto block bg-blue-900 hover:bg-blue-800 text-white py-2 rounded font-medium transition mt-4">
          회원가입
        </button>

        <c:if test="${not empty sessionScope.signupError}">
          <script>alert("${signupError}");</script>
          <c:remove var="signupError" scope="session" />
        </c:if>
      </form>
    </section>
  </main>

  <jsp:include page="/WEB-INF/jsp/footer.jsp" />
  <script src="${pageContext.request.contextPath}/resources/js/signup-validation.js"></script>
</body>
</html>

<script>
/* ---------- 상태 ---------- */
let validationState = {
  userId:false, password:false, name:false,
  rrn1:false, rrn2:false, phone1:false, phone2:false,
  emailPrefix:false
};

/* ✅ 더 이상 입력칸을 disable 하지 않음 */
function updateButtonStates() {
  const ids = ['userId','pw','name','rrn1','rrn2','phone1','phone2','emailPrefix'];
  ids.forEach(id => { const el=document.getElementById(id); if (el) el.disabled = false; });
  toggleCheckButtons(); // 중복확인 버튼 활성/비활성만 유지
}

/* ---------- 개별 검증 ---------- */
function validateUserId(){
  const id   = document.getElementById("userId").value.trim();
  const err  = document.getElementById("idError");
  const ok   = /^[a-zA-Z0-9]{4,}$/.test(id);
  validationState.userId = ok;
  err.textContent = ok ? "" : "아이디는 영어/숫자 4자 이상이어야 합니다.";
  err.style.color = ok ? "" : "red";
  updateButtonStates();
}

function validatePassword(){
  const pw  = document.getElementById("pw").value.trim();
  const id  = document.getElementById("userId").value.trim();
  const err = document.getElementById("pwError");
  let ok = /^[a-zA-Z0-9]{4,}$/.test(pw) && pw !== id;
  validationState.password = ok;
  err.textContent = ok ? "" : (pw === id ? "아이디와 비밀번호는 같을 수 없습니다." : "비밀번호는 영어/숫자 4자 이상이어야 합니다.");
  err.style.color = ok ? "" : "red";
  updateButtonStates();
}

function validateField(id, regex, msg, errId, stateKey){
  const val = document.getElementById(id).value.trim();
  const err = document.getElementById(errId);
  const ok  = regex.test(val);
  validationState[stateKey] = ok;
  err.textContent = ok ? "" : msg;
  err.style.color = ok ? "" : "red";
  updateButtonStates();
}

function toggleCheckButtons(){
  const userIdValid = /^[a-zA-Z0-9]{4,}$/.test(document.getElementById("userId").value);
  const emailValid  = /^[a-zA-Z0-9._%+-]+$/.test(document.getElementById("emailPrefix").value);
  document.getElementById("checkBtn").disabled       = !userIdValid;
  document.getElementById("checkEmailBtn").disabled  = !emailValid;
}

/* ---------- 중복확인 ---------- */
function checkIdDuplicate(){
  const id = document.getElementById("userId").value.trim();
  const error = document.getElementById("idError");
  if (!/^[a-zA-Z0-9]{4,}$/.test(id)){
    error.textContent = "아이디 형식이 올바르지 않습니다."; error.style.color="red"; return;
  }
  fetch(contextPath + "/patient/checkId.do?userId=" + encodeURIComponent(id))
    .then(r=>r.text()).then(t=>{
      const duplicated = t.trim() === "true";
      if (duplicated){
        error.textContent = "❌ 이미 등록된 아이디입니다."; error.style.color = "red";
        validationState.userId = false;
      } else {
        error.textContent = "✅ 사용 가능한 아이디입니다."; error.style.color = "green";
        validationState.userId = true;
      }
      updateButtonStates();
    });
}

function checkEmailDuplicate(){
  const prefix = document.getElementById("emailPrefix").value.trim();
  const domain = document.getElementById("emailDomain").value;
  const email  = prefix + "@" + domain;
  const error  = document.getElementById("emailError");
  document.getElementById("patientEmail").value = email;

  if (!/^[a-zA-Z0-9._%+-]+$/.test(prefix)){
    error.textContent = "이메일 형식이 올바르지 않습니다."; error.style.color="red";
    validationState.emailPrefix = false; return;
  }
  fetch(contextPath + "/patient/checkEmail.do?email=" + encodeURIComponent(email))
    .then(r=>r.text()).then(t=>{
      const duplicated = t.trim() === "true";
      if (duplicated){
        error.textContent = "❌ 이미 등록된 이메일입니다."; error.style.color="red";
        validationState.emailPrefix = false;
      } else {
        error.textContent = "✅ 사용 가능한 이메일입니다."; error.style.color="green";
        validationState.emailPrefix = true;
      }
      updateButtonStates();
    });
}

function validateEmailField(){
  const prefix = document.getElementById("emailPrefix").value.trim();
  const error  = document.getElementById("emailError");
  const ok     = /^[a-zA-Z0-9._%+-]+$/.test(prefix);
  validationState.emailPrefix = ok;
  error.textContent = ok ? "" : "이메일 형식이 올바르지 않습니다.";
  error.style.color = ok ? "" : "red";
  toggleCheckButtons();
  updateButtonStates();
}

/* 주민번호 중복 확인 */
function checkRrnDuplicate(){
  const rrn = (document.getElementById("rrn1").value + document.getElementById("rrn2").value).trim();
  if (rrn.length !== 13) return;
  fetch(contextPath + "/patient/checkRrn.do?rrn=" + encodeURIComponent(rrn))
    .then(res=>res.text())
    .then(result=>{
      const el = document.getElementById("rrnDuplicate");
      if (result.trim() === "duplicated"){
        el.textContent = "❌ 이미 등록된 주민등록번호입니다. 다시 확인해주세요.";
        el.style.color = "red";
        validationState.rrn1 = validationState.rrn2 = false;
      } else {
        el.textContent = "✅ 사용 가능한 주민등록번호입니다.";
        el.style.color = "green";
        validationState.rrn1 = validationState.rrn2 = true;
      }
      updateButtonStates(); // ✅ 이제도 입력칸 disable 안함
    });
}

/* 전화번호 중복 확인 */
function checkPhoneDuplicate(){
  const phone = "010" + document.getElementById("phone1").value + document.getElementById("phone2").value;
  if (phone.length !== 11) return;
  fetch(contextPath + "/patient/checkPhone.do?phone=" + encodeURIComponent(콜))
    .then(res=>res.text())
    .then(result=>{
      const el = document.getElementById("phoneDuplicate");
      if (result.trim() === "duplicated"){
        el.textContent = "❌ 이미 등록된 전화번호입니다. 다시 확인해주세요.";
        el.style.color = "red";
        validationState.phone1 = validationState.phone2 = false;
      } else {
        el.textContent = "✅ 사용 가능한 전화번호입니다.";
        el.style.color = "green";
        validationState.phone1 = validationState.phone2 = true;
      }
      updateButtonStates(); // ✅ disable 안함
    });
}

/* ---------- 제출 ---------- */
function validateAll(){
  // hidden 필드 구성
  const emailPrefix = document.getElementById("emailPrefix").value;
  const emailDomain = document.getElementById("emailDomain").value;
  document.getElementById("rrn").value   = document.getElementById("rrn1").value + document.getElementById("rrn2").value;
  document.getElementById("phone").value = "010" + document.getElementById("phone1").value + document.getElementById("phone2").value;
  document.getElementById("patientEmail").value = emailPrefix + "@" + emailDomain;
  if (!isFormValidNow()){
       alert("회원가입을 실패했습니다. 다시 확인해주세요.");
       return false;
     }
     return true;
   }

/* ---------- UI 탭 ---------- */
function showSection(id){
  const loginTab  = document.getElementById('loginTab');
  const signupTab = document.getElementById('signupTab');
  const login     = document.getElementById('loginSection');
  const signup    = document.getElementById('signupSection');

  if (id === 'loginSection'){
    loginTab.classList.add("text-blue-900","border-blue-900");
    loginTab.classList.remove("text-gray-500","border-transparent");
    signupTab.classList.remove("text-blue-900","border-blue-900");
    signupTab.classList.add("text-gray-500","border-transparent");
    login.classList.remove("hidden"); signup.classList.add("hidden");
  } else {
    signupTab.classList.add("text-blue-900","border-blue-900");
    signupTab.classList.remove("text-gray-500","border-transparent");
    loginTab.classList.remove("text-blue-900","border-blue-900");
    loginTab.classList.add("text-gray-500","border-transparent");
    signup.classList.remove("hidden"); login.classList.add("hidden");
  }
}

window.onload = function(){
  const urlParams = new URLSearchParams(window.location.search);
  const success   = urlParams.get('signup');
  showSection('loginSection');
  if (success === 'true') alert("🎉 회원가입을 축하합니다! 로그인 화면으로 이동합니다.");
  updateButtonStates(); // ✅ 처음에도 모두 enable
};

function isFormValidNow() {
     const id    = document.getElementById("userId").value.trim();
     const pw    = document.getElementById("pw").value.trim();
     const name  = document.getElementById("name").value.trim();
     const rrn1  = document.getElementById("rrn1").value.trim();
     const rrn2  = document.getElementById("rrn2").value.trim();
     const ph1   = document.getElementById("phone1").value.trim();
     const ph2   = document.getElementById("phone2").value.trim();
     const emailPrefix = document.getElementById("emailPrefix").value.trim();

     const okId   = /^[a-zA-Z0-9]{4,}$/.test(id);
     const okPw   = /^[a-zA-Z0-9]{4,}$/.test(pw) && pw !== id;
     const okName = /^[가-힣]+$/.test(name);
     const okR1   = /^\d{6}$/.test(rrn1);
     const okR2   = /^\d{7}$/.test(rrn2);
     const okP1   = /^\d{3,4}$/.test(ph1);
     const okP2   = /^\d{4}$/.test(ph2);
     const okEm   = /^[a-zA-Z0-9._%+-]+$/.test(emailPrefix);

     return okId && okPw && okName && okR1 && okR2 && okP1 && okP2 && okEm;
   }




</script>
