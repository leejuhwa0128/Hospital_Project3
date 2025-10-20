<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/WEB-INF/jsp/referral/referral_header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>협진 관계자 로그인/회원가입</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/selectform.css">

<style>
.helper-links {
	margin-top: 10px;
	text-align: right;
	font-size: 0.9rem;
}

.helper-links .sep {
	margin: 0 6px;
	color: #aaa;
}

.modal {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, .4);
	z-index: 999;
	display: none;
	justify-content: center;
	align-items: center;
}

.modal-content {
	background: #fff;
	padding: 30px;
	border-radius: 10px;
	text-align: center;
}

.modal-content button {
	margin-top: 15px;
	padding: 8px 16px;
}

.tab-buttons {
	display: flex;
	gap: 8px;
	justify-content: center;
	margin: 12px 0;
}

.form-container {
	max-width: 560px;
	margin: 0 auto;
}

.input-inline {
	display: flex;
	align-items: center;
	gap: 8px;
}

.primary-btn {
	margin-top: 10px;
}

.error-text {
	color: #d33;
	margin-top: 10px;
}
</style>

<script>
    function showSection(sectionId) {
      var signup = document.getElementById("signupSection");
      var login  = document.getElementById("loginSection");
      if (signup) signup.style.display = "none";
      if (login)  login.style.display  = "none";
      var target = document.getElementById(sectionId);
      if (target) target.style.display = "block";
    }

    function closeSignupModal() {
      var m = document.getElementById("signupSuccessModal");
      if (m) m.style.display = "none";
      location.href = '${pageContext.request.contextPath}/referral/auth.do';
    }

    function checkDuplicateId() {
      const el = document.getElementById("userId");
      const userId = (el ? el.value.trim() : "");
      if (!userId) { alert("아이디를 입력해주세요."); return; }
      fetch("${pageContext.request.contextPath}/referral/checkId.do?userId=" + encodeURIComponent(userId))
        .then(r => r.json())
        .then(data => {
          if (data && data.exists) {
            var d = document.getElementById("duplicateModal");
            if (d) d.style.display = "flex";
          } else {
            var a = document.getElementById("availableModal");
            if (a) a.style.display = "flex";
          }
        });
    }
    function closeDuplicateModal(){ var d=document.getElementById("duplicateModal"); if(d) d.style.display="none"; }
    function closeAvailableModal(){ var a=document.getElementById("availableModal"); if(a) a.style.display="none"; }

    window.onload = function () {
      const urlParams = new URLSearchParams(window.location.search);
      const mode = urlParams.get("mode");
      if (mode === "signup") showSection("signupSection");
      else showSection("loginSection");

      const signupSuccess = "${signupSuccess}";
      if (signupSuccess && signupSuccess !== "") {
        var m = document.getElementById("signupSuccessModal");
        if (m) m.style.display = "flex";
      }
    };
  </script>
</head>

<body>
	<br>
	<div class="tab-buttons">
		<button type="button" onclick="showSection('loginSection')">로그인</button>
		<button type="button" onclick="showSection('signupSection')">회원가입</button>
	</div>

	<!-- 로그인 -->
	<div id="loginSection" class="form-container" style="display: none;">
		<h3>협진 관계자 로그인</h3>

		<form id="coopLoginForm"
			action="${pageContext.request.contextPath}/referral/login2.do"
			method="post">
			<input type="text" name="userId" placeholder="아이디" required /> <input
				type="password" name="password" placeholder="비밀번호" required />

			<!-- v3 토큰 전송용 (기본) -->
			<input type="hidden" name="recaptcha_v3" id="recaptcha_v3" />

			<!-- v2 폴백: requireCaptcha=true일 때만 노출 (명시 렌더용) -->
			<c:if test="${requireCaptcha}">
				<!-- onload 콜백 + explicit 렌더, 한국어 UI -->
				<script
					src="https://www.google.com/recaptcha/api.js?onload=onRecaptchaLoad&render=explicit&hl=ko"
					async defer></script>
				<div id="recaptchaV2Container" style="margin: 12px 0;"></div>
				<script>
          // 전역에서 사용할 v2 widget id
          var recaptchaV2WidgetId = null;
          function onRecaptchaLoad() {
            var el = document.getElementById('recaptchaV2Container');
            if (el && window.grecaptcha && grecaptcha.render) {
              recaptchaV2WidgetId = grecaptcha.render(el, {
                'sitekey': '${captchaV2SiteKey}'
                // 'callback': function(token){ ... } // 필요시 사용
              });
              // console.log('v2 widget id:', recaptchaV2WidgetId);
            }
          }
        </script>
			</c:if>

			<button type="submit" class="primary-btn">로그인</button>
			<a href="<c:url value='/referral/findId.do'/>">아이디 찾기</a> 
			<span class="sep">|</span> 
			<a href="<c:url value='/referral/findPw.do'/>">비밀번호 찾기</a>
		</form>

		<c:if test="${not empty sessionScope.loginError}">
			<p class="error-text">${sessionScope.loginError}</p>
			<c:remove var="loginError" scope="session" />
		</c:if>
	</div>

	<!-- 회원가입 -->
	<div id="signupSection" class="form-container" style="display: none;">
		<h3>관계자 회원가입</h3>
		<form action="${pageContext.request.contextPath}/referral/signup.do"
			method="post">
			<label>아이디</label>
			<div class="input-inline">
				<input type="text" name="userId" id="userId" required />
				<button type="button" onclick="checkDuplicateId()">중복확인</button>
			</div>

			<label>비밀번호</label> <input type="password" name="password" required />

			<label>이름</label> <input type="text" name="name" required /> <label
				for="rrn1">주민등록번호</label>
			<div class="input-inline">
				<input type="text" id="rrn1" name="rrn1" maxlength="6"
					placeholder="앞 6자리" required /> <span>-</span> <input type="text"
					id="rrn2" name="rrn2" maxlength="7" placeholder="뒤 7자리" required />
			</div>
			<input type="hidden" name="rrn" id="rrn" />

			<div class="form-row">
				<label>성별</label> <select name="gender" style="width: 80px;">
					<option value="남">남</option>
					<option value="여">여</option>
				</select>
			</div>

			<div class="form-row">
				<label>전화번호</label>
				<div class="input-inline">
					<input type="text" value="010" readonly style="width: 50px;" /> <span>-</span>
					<input type="text" name="phone2" maxlength="4" style="width: 80px;" />
					<span>-</span> <input type="text" name="phone3" maxlength="4"
						style="width: 80px;" />
				</div>
				<input type="hidden" name="phone" id="phone" />
			</div>

			<label>이메일</label>
			<div class="input-inline">
				<input type="text" name="emailId" placeholder="이메일 아이디" required />
				<select name="emailDomain">
					<option value="@naver.com">@naver.com</option>
					<option value="@daum.net">@daum.net</option>
					<option value="@gmail.com">@gmail.com</option>
				</select>
			</div>
			<input type="hidden" name="email" id="email" /> <label>협력병원
				선택</label> <select name="hospitalId" required>
				<option value="">병원 선택</option>
				<c:forEach var="h" items="${hospitalList}">
					<option value="${h.hospitalId}">${h.name}</option>
				</c:forEach>
			</select> <input type="hidden" name="role" value="coop" />
			<button type="submit" class="primary-btn">회원가입</button>
		</form>

		<c:if test="${not empty signupError}">
			<p class="error-text">${signupError}</p>
		</c:if>
	</div>

	<!-- 회원가입 성공 모달 -->
	<div id="signupSuccessModal" class="modal">
		<div class="modal-content">
			<p>회원가입이 완료되었습니다.</p>
			<button onclick="closeSignupModal()">확인</button>
		</div>
	</div>

	<!-- 중복 아이디 모달 -->
	<div id="duplicateModal" class="modal">
		<div class="modal-content">
			<p>이미 사용 중인 아이디입니다.</p>
			<button onclick="closeDuplicateModal()">확인</button>
		</div>
	</div>

	<!-- 사용 가능한 아이디 모달 -->
	<div id="availableModal" class="modal">
		<div class="modal-content">
			<p>사용 가능한 아이디입니다.</p>
			<button onclick="closeAvailableModal()">확인</button>
		</div>
	</div>

	<script>
    // 회원가입 폼 합치기 로직
    document.addEventListener("DOMContentLoaded", function () {
      var signupForm = document.querySelector("#signupSection form");
      if (!signupForm) return;

      signupForm.addEventListener("submit", function () {
        var rrn1 = (document.getElementById("rrn1") || {}).value || "";
        var rrn2 = (document.getElementById("rrn2") || {}).value || "";
        var phone2 = (document.querySelector("input[name='phone2']") || {}).value || "";
        var phone3 = (document.querySelector("input[name='phone3']") || {}).value || "";
        var emailId = (document.querySelector("input[name='emailId']") || {}).value || "";
        var emailDomain = (document.querySelector("select[name='emailDomain']") || {}).value || "";

        var rrnEl   = document.getElementById("rrn");
        var phoneEl = document.getElementById("phone");
        var emailEl = document.getElementById("email");

        if (rrnEl)   rrnEl.value   = (rrn1.trim() + rrn2.trim());
        if (phoneEl) phoneEl.value = ("010-" + phone2.trim() + "-" + phone3.trim());
        if (emailEl) emailEl.value = (emailId.trim() + emailDomain);
      });
    });
  </script>

	<!-- v2가 안 보일 때만(v2 컨테이너 없음) v3 토큰 생성 -->
	<c:if test="${not requireCaptcha}">
		<script
			src="https://www.google.com/recaptcha/api.js?render=${captchaV3SiteKey}"></script>
		<script>
      (function () {
        var form = document.getElementById('coopLoginForm');
        if (!form) return;

        form.addEventListener('submit', function (e) {
          // v2 컨테이너가 있으면 v3 실행 금지
          if (document.getElementById('recaptchaV2Container')) return;

          e.preventDefault();
          if (!window.grecaptcha || !grecaptcha.ready) {
            alert('보안 스크립트 로드 중입니다. 잠시 후 다시 시도하세요.');
            return;
          }
          grecaptcha.ready(function () {
            grecaptcha.execute('${captchaV3SiteKey}', {action: 'login'}).then(function (token) {
              var hidden = document.getElementById('recaptcha_v3');
              if (hidden) hidden.value = token;
              form.submit();
            });
          });
        });
      })();
    </script>
	</c:if>

</body>
</html>

<jsp:include page="/WEB-INF/jsp/referral/referral_footer.jsp" />
