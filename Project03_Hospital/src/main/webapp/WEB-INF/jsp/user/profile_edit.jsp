<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>정보 수정</title>
  <style>
    .wrap{max-width:860px;margin:30px auto;background:#fff;border:1px solid #e5e7eb;border-radius:12px;padding:24px}
    .title{font-size:22px;font-weight:700;margin-bottom:8px}
    .grid{display:grid;grid-template-columns:1fr 2fr;gap:14px 16px;align-items:center}
    .input, select{width:100%;box-sizing:border-box;padding:10px 12px;border:1px solid #d1d5db;border-radius:8px}
    .row{display:flex;gap:8px;align-items:center}
    .actions{display:flex;gap:10px;margin-top:22px}
    .btn{padding:10px 16px;border-radius:8px;border:1px solid #d1d5db;background:#fff;cursor:pointer}
    .btn.primary{background:#1d4ed8;color:#fff;border-color:#1d4ed8}
    .hint{font-size:12px;color:#6b7280}
    .divider{height:1px;background:#e5e7eb;margin:22px 0}
    .section-title{font-weight:700;margin:8px 0 4px}
    .error{color:#b91c1c;font-size:12px;margin-top:6px;display:none}
  </style>
</head>
<body>
<div class="wrap">
  <div class="title">정보 수정</div>

  <c:set var="loginUser" value="${sessionScope.loginUser}" />
  <c:set var="role" value="${loginUser.role}" />

  <form id="profileForm" action="${pageContext.request.contextPath}/user/updateProfile.do" method="post" autocomplete="off">
    <div class="grid">
      <label>아이디</label>
      <input class="input" type="text" name="userId" value="${loginUser.userId}" readonly />

      <label>이름</label>
      <input class="input" type="text" name="name" value="${loginUser.name}" readonly />

      <label>연락처</label>
      <div class="row">
        <input class="input" style="max-width:90px" type="text" value="010" readonly />
        <span>-</span>
        <input class="input" style="max-width:120px" type="text" id="phone2" maxlength="4"
               value="${empty loginUser.phone ? '' : loginUser.phone.split('-')[1]}" />
        <span>-</span>
        <input class="input" style="max-width:120px" type="text" id="phone3" maxlength="4"
               value="${empty loginUser.phone ? '' : loginUser.phone.split('-')[2]}" />
      </div>
      <input type="hidden" name="phone" id="phone" />
      <div></div><div class="hint">예) 010-1234-5678</div>

      <label>이메일</label>
      <input class="input" type="email" name="email" value="${loginUser.email}" required />

      <label>협력병원</label>
      <select class="input" name="hospitalId" required>
        <option value="">병원 선택</option>
        <c:forEach var="h" items="${hospitalList}">
          <option value="${h.hospitalId}" ${loginUser.hospitalId == h.hospitalId ? 'selected' : ''}>
            ${h.name}
          </option>
        </c:forEach>
      </select>

      <label>진료과(부서)</label>
      <select class="input" name="deptId">
        <option value="">선택</option>
        <c:forEach var="d" items="${departmentList}">
          <option value="${d.deptId}" ${loginUser.deptId == d.deptId ? 'selected' : ''}>
            ${d.name}
          </option>
        </c:forEach>
      </select>
    </div>

    <!-- ▼▼▼ 추가: 비밀번호 변경(선택) 섹션 ▼▼▼ -->
    <div class="divider"></div>
    <div class="section-title">비밀번호 변경 (선택)</div>
    <div class="grid">
      <label>현재 비밀번호</label>
      <input class="input" type="password" name="currentPassword" id="currentPassword" autocomplete="current-password" />

      <label>새 비밀번호</label>
      <input class="input" type="password" name="newPassword" id="newPassword" autocomplete="new-password" />

      <label>새 비밀번호 확인</label>
      <input class="input" type="password" name="confirmPassword" id="confirmPassword" autocomplete="new-password" />

      <div></div>
      <div class="hint">* 비밀번호를 변경하지 않으려면 이 영역을 비워두세요. (최소 8자)</div>
      <div></div>
      <div id="pwError" class="error">오류 메시지</div>
    </div>
    <!-- ▲▲▲ 추가 끝 ▲▲▲ -->

    <div class="actions">
      <button type="submit" class="btn primary">저장</button>
      <a class="btn" href="${pageContext.request.contextPath}/user/${role eq 'doctor' ? 'doctorPage.do' : 'coopPage.do'}">취소</a>
    </div>

    <input type="hidden" name="role" value="${role}" />
  </form>
</div>

<script>
  // 전화번호 합치기
  (function(){
    var p2 = document.getElementById('phone2');
    var p3 = document.getElementById('phone3');
    var hidden = document.getElementById('phone');
    function sync(){ hidden.value = (p2.value && p3.value) ? ('010-' + p2.value.trim() + '-' + p3.value.trim()) : ''; }
    p2.addEventListener('input', sync);
    p3.addEventListener('input', sync);
    sync();
  })();

  // 비밀번호 검증 (선택 입력 시에만)
  (function(){
    var form = document.getElementById('profileForm');
    var cur = document.getElementById('currentPassword');
    var nw  = document.getElementById('newPassword');
    var cf  = document.getElementById('confirmPassword');
    var err = document.getElementById('pwError');

    function showError(msg){
      err.textContent = msg;
      err.style.display = 'block';
    }
    function clearError(){
      err.textContent = '';
      err.style.display = 'none';
    }

    form.addEventListener('submit', function(e){
      clearError();
      var hasAny = (cur.value || nw.value || cf.value);

      if (!hasAny) return; // 비밀번호 변경 안 함

      // 현재/새/확인 모두 입력 요구
      if (!cur.value || !nw.value || !cf.value) {
        e.preventDefault();
        showError('현재/새/확인 비밀번호를 모두 입력하세요.');
        return;
      }
      if (nw.value.length < 8) {
        e.preventDefault();
        showError('새 비밀번호는 최소 8자 이상이어야 합니다.');
        return;
      }
      if (nw.value !== cf.value) {
        e.preventDefault();
        showError('새 비밀번호 확인이 일치하지 않습니다.');
        return;
      }
      if (cur.value === nw.value) {
        e.preventDefault();
        showError('현재 비밀번호와 다른 새 비밀번호를 입력하세요.');
        return;
      }
    });
  })();
</script>
</body>
</html>
