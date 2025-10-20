<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>비회원 예약</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<style>
  .wrap {max-width:460px; margin:40px auto;}
  .page-title{ text-align:center; margin:0 0 22px; font-weight:900; font-size:28px; letter-spacing:-.3px; }

  form {padding:16px; border:1px solid #ddd; background:#fff; border-radius:10px;}
  label {display:block; margin:8px 0 6px; font-weight:600;}
  input {padding:10px; border:1px solid #ccc; border-radius:8px;}

 /* 한 줄 레이아웃 */
.rrn-box{
  display:flex; align-items:center; gap:6px; position:relative;
}

/* 앞자리 입력칸: 뒷자리 표시칸과 크기 동일 */
.rrn-box input[type="text"]{
  flex:1 1 0;                /* ← 두 칸을 동일 비율로 */
  height:40px;               /* ← 높이 통일 */
  padding:10px;
  border:1px solid #ccc;
  border-radius:8px;
  text-align:center;
  box-sizing:border-box;     /* 테두리/패딩 포함 계산 */
}

/* 구분용 하이픈 */
.rrn-sep{font-size:20px;font-weight:bold;color:#333;}

/* 뒷자리(가짜 표시 영역): 앞자리와 크기 동일 */
.pin-display{
  flex:1 1 0;                /* ← 두 칸을 동일 비율로 */
  height:40px;               /* ← 높이 통일 */
  border:1px solid #ccc;
  border-radius:8px;
  display:flex;align-items:center;justify-content:center;
  cursor:text;background:#fff;
  box-sizing:border-box;
}
  .pin-dots {display:flex; gap:8px;}
  .pin-dot {
    width:10px; height:10px; border-radius:999px; background:#d1d5db;
  }
  .pin-dot.filled { background:#111827; }

  /* 숨김 진짜 필드 */
  .visually-hidden {
    position:absolute !important; width:1px; height:1px; padding:0; margin:-1px;
    overflow:hidden; clip:rect(0,0,0,0); white-space:nowrap; border:0;
  }

  /* 작은 핀패드 (rrn2에서만 표시) */
  .pinpad-wrap {
    position:absolute; left:50%; transform:translateX(-50%);
    top:calc(100% + 8px);
    width:220px; padding:10px; border:1px solid #e5e7eb; background:#fff; border-radius:10px;
    box-shadow:0 10px 24px rgba(0,0,0,.08); display:none; z-index:1000;
  }
  .pinpad-grid { display:grid; grid-template-columns:repeat(3, 1fr); gap:6px; }
  .pinpad-grid button {
    padding:8px 0; border:1px solid #cbd5e1; background:#f8fafc; border-radius:8px;
    cursor:pointer; font-size:14px; font-weight:700;
    transition:background .12s ease, transform .05s ease;
  }
  .pinpad-grid button:hover{ background:#eef2ff; }
  .pinpad-grid button:active{ transform:translateY(1px); }
  .pinpad-ctrl { display:flex; gap:6px; margin-top:6px; }
  .pinpad-ctrl button {
    flex:1; padding:8px 0; border:1px solid #cbd5e1; background:#f8fafc; border-radius:8px;
    cursor:pointer; font-size:13px; font-weight:700;
  }
  .pinpad-ctrl .danger{ background:#fff1f2; border-color:#fecaca; }
  .pinpad-ctrl .primary{ background:#111827; color:#fff; border-color:#111827; }
  .pinpad-ctrl .primary:disabled{ opacity:.5; cursor:not-allowed; }

  /* 버튼 */
  .btn-row {display:flex; gap:8px; margin-top:14px;}
  .btn-row button {
    flex:1; padding:12px 14px; border:0; border-radius:10px;
    background:#2563eb; color:#fff; font-weight:700; cursor:pointer;
    transition:background .15s ease, transform .05s ease, opacity .15s ease;
  }
  .btn-row button:hover { background:#1d4ed8; }
  .btn-row button:active { transform:translateY(1px); }
  .btn-row button[disabled]{ opacity:.45; cursor:not-allowed; }

  /* 동의 영역 */
  .consent {margin-top:12px; padding:10px; background:#f9fafb; border:1px solid #e5e7eb; border-radius:10px;}
  .consent label{ display:flex; gap:8px; align-items:flex-start; font-weight:600; }
  .consent small{ display:block; color:#6b7280; font-weight:400; }

  .err {color:#b91c1c; margin:0 0 10px;}
  .msg {color:#065f46; margin:0 0 10px;}
  .hint {color:#666; font-size:12px;}
</style>
<script>
  /* ===== 공통 유틸 ===== */
  function onlyDigits(el, max) {
    el.value = (el.value || "").replace(/\D/g,"").slice(0,max);
  }
  function syncHidden() {
    const r1 = document.getElementById("rrn1").value;
    const r2 = document.getElementById("rrn2").value;
    document.getElementById("rrn").value = (r1 + r2); // 서버로 보낼 13자리
  }

  /* ===== 앞자리: 자동 숫자/포커스 ===== */
  function onRrn1Input(){
    const r1 = document.getElementById("rrn1");
    onlyDigits(r1, 6);
    if (r1.value.length === 6) openPinpad(); // 6자리 채우면 자동으로 뒷자리 패드 열기
    syncHidden();
  }

  /* ===== 뒷자리: 실제 값은 hidden(password) + 도트 표시 ===== */
  function updateDots(){
    const v = document.getElementById('rrn2').value;
    const dots = document.querySelectorAll('#pinDots .pin-dot');
    dots.forEach((d,i)=> d.classList.toggle('filled', i < v.length));
    document.getElementById('btnEnter').disabled = (v.length !== 7);
  }

  function preventKeyboardOnRrn2(e){
    // 뒷자리는 키보드 숫자 입력 막고, 삭제/탭/좌우키만 허용
    const allow = ['Tab','ArrowLeft','ArrowRight','Backspace','Delete','Escape'];
    if (allow.includes(e.key)) return;
    if (/^\d$/.test(e.key)) e.preventDefault();
  }

  /* ===== PIN Pad ===== */
  function shuffle(arr){
    for (let i = arr.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [arr[i], arr[j]] = [arr[j], arr[i]];
    }
    return arr;
  }
  function buildDigits(){
    const nums = shuffle(['0','1','2','3','4','5','6','7','8','9']);
    const box = document.getElementById('pinpadGrid');
    box.innerHTML = '';
    // 3x4(랜덤 1~9 + 0 + 공백 한 칸) 느낌으로 9개 + 0
    const order = nums; // 이미 섞임
    order.forEach(d=>{
      const b = document.createElement('button'); b.type='button';
      b.textContent = d; b.dataset.key = d;
      box.appendChild(b);
    });
  }

  function openPinpad(){
    const wrap = document.getElementById('pinpadWrap');
    buildDigits();
    wrap.style.display = 'block';
    // 포커스는 유지(마우스 클릭 위주)
  }
  function closePinpad(){
    document.getElementById('pinpadWrap').style.display = 'none';
  }

  function handlePadClick(e){
    const btn = e.target.closest('button');
    if(!btn) return;
    const key = btn.dataset.key;
    const r2  = document.getElementById('rrn2');

    if (key === 'back'){
      r2.value = r2.value.slice(0,-1);
    } else if (key === 'clear'){
      r2.value = '';
    } else if (key === 'enter'){
      if (r2.value.length === 7) closePinpad();
    } else if (/^\d$/.test(key)){
      if (r2.value.length < 7) r2.value += key;
      if (r2.value.length === 7) {
        // 7자리 다 채우면 자동 닫기
        closePinpad();
      }
    }
    updateDots();
    syncHidden();
  }

  // 동의 체크 → 버튼 활성화
  function toggleActions(){
    const ok = document.getElementById('agree').checked;
    document.getElementById('btnBook').disabled = !ok;
    document.getElementById('btnList').disabled = !ok;
  }

  function onSubmitForm(){
    const agree = document.getElementById('agree').checked;
    const name  = document.getElementById("name").value.trim();
    const rrn   = (document.getElementById("rrn").value || "").replace(/\D/g,"");

    if (!agree){ alert("개인정보 수집·이용에 동의해 주세요."); return false; }
    if (!name){ alert("이름을 입력하세요."); return false; }
    if (rrn.length !== 13){ alert("주민번호 13자리를 정확히 입력하세요."); return false; }
    return true;
  }

  document.addEventListener('DOMContentLoaded', function(){
    // 알림(플래시)
    const e1 = document.getElementById('__alert_error');
    if (e1) alert(e1.textContent || e1.innerText);
    const e2 = document.getElementById('__alert_msg');
    if (e2) alert(e2.textContent || e2.innerText);

    // 이벤트 바인딩
    document.getElementById('rrn1').addEventListener('input', onRrn1Input);
    document.getElementById('pinpadWrap').addEventListener('click', handlePadClick);
    document.getElementById('agree').addEventListener('change', toggleActions);

    // 키보드 막기(뒷자리)
    const r2 = document.getElementById('rrn2');
    r2.addEventListener('keydown', preventKeyboardOnRrn2);

    // 표시영역 클릭 → 핀패드 열기
    document.getElementById('pinDisplay').addEventListener('click', openPinpad);

    // 바깥 클릭 시 닫기(패드/표시영역 제외)
    document.addEventListener('pointerdown', function(e){
      const wrap = document.getElementById('pinpadWrap');
      const onWrap = wrap.contains(e.target);
      const onDisp = document.getElementById('pinDisplay').contains(e.target);
      if (!onWrap && !onDisp) closePinpad();
    });

    // ESC로 닫기
    document.addEventListener('keydown', function(e){
      if (e.key === 'Escape') closePinpad();
    });

    // 초기 상태
    toggleActions();
    updateDots();
    syncHidden();
  });
</script>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!-- 안전한 알림 처리 -->
<c:if test="${not empty error}">
  <span id="__alert_error" style="display:none;"><c:out value="${error}" /></span>
</c:if>
<c:if test="${not empty msg}">
  <span id="__alert_msg" style="display:none;"><c:out value="${msg}" /></span>
</c:if>

<div class="wrap">
  <h1 class="page-title">비회원 예약</h1>

  <c:if test="${not empty error}"><div class="err"><c:out value="${error}" /></div></c:if>
  <c:if test="${not empty msg}"><div class="msg"><c:out value="${msg}" /></div></c:if>

  <form method="post"
        action="${pageContext.request.contextPath}/reservation/guest-start.do"
        autocomplete="off"
        novalidate
        onsubmit="return onSubmitForm();">

    <label for="name">이름</label>
    <input id="name" type="text" name="name" required autocomplete="off" />

    <label>주민번호 <span class="hint">(앞 6자리 - 뒤 7자리)</span></label>
    <div class="rrn-box">
      <!-- 앞 6자리: 키보드 입력 허용 -->
      <input id="rrn1" type="text" inputmode="numeric" maxlength="6" placeholder="앞 6자리"
             autocomplete="off" autocapitalize="off" required />

      <span class="rrn-sep">-</span>

      <!-- 뒷 7자리: 가짜 표시(도트) + 진짜 값(숨김) -->
      <div id="pinDisplay" class="pin-display" role="button" aria-label="주민번호 뒷자리 입력">
        <div id="pinDots" class="pin-dots" aria-hidden="true">
          <span class="pin-dot"></span>
          <span class="pin-dot"></span>
          <span class="pin-dot"></span>
          <span class="pin-dot"></span>
          <span class="pin-dot"></span>
          <span class="pin-dot"></span>
          <span class="pin-dot"></span>
        </div>
      </div>
      <input id="rrn2" class="visually-hidden" type="password" maxlength="7" autocomplete="new-password" />

      <!-- 핀패드 -->
      <div id="pinpadWrap" class="pinpad-wrap" aria-label="숫자 핀패드">
        <div id="pinpadGrid" class="pinpad-grid"><!-- JS로 0~9 랜덤 배치 --></div>
        <div class="pinpad-ctrl" style="margin-top:8px;">
          <button type="button" data-key="back">←</button>
          <button type="button" data-key="clear" class="danger">지움</button>
          <button type="button" id="btnEnter" data-key="enter" class="primary" disabled>확인</button>
        </div>
      </div>
    </div>

    <!-- 개인정보 동의 -->
    <div class="consent">
      <label>
        <input type="checkbox" id="agree" />
        <span>
          개인정보 수집·이용에 동의합니다.
          <small>예약 처리 및 본인 확인을 위해 주민등록번호 앞/뒤 13자리를 일시적으로 사용합니다. 자세한 내용은 개인정보 처리방침을 참고하세요.</small>
        </span>
      </label>
    </div>

    <!-- 서버로 전송될 13자리 주민번호 -->
    <input type="hidden" name="rrn" id="rrn" />

    <div class="btn-row">
      <button type="submit" id="btnBook" name="mode" value="book" disabled>예약하기</button>
      <button type="submit" id="btnList" name="mode" value="list" disabled>예약내역조회</button>
    </div>

    <!-- 회원가입 이동 -->
    <div style="margin-top:8px;">
      <button type="button" style="width:100%; padding:12px 14px; border:0; border-radius:10px; background:#1e40af; color:#fff; font-weight:800; cursor:pointer;"
              onclick="location.href='<c:url value="/patient/selectForm.do?tab=signup"/>'">회원가입</button>
    </div>
  </form>
</div>

<jsp:include page="/WEB-INF/jsp/footer.jsp" />
</body>
</html>
