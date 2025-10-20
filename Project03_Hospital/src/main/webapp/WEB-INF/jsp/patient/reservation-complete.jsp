<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>예약완료 및 확인</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <style>
    :root{--text:#111827;--muted:#6b7280;--line:#e5e7eb;--bg:#f8fafc;--card:#fff;--primary:#2563eb;--primary-ink:#fff}
    *{box-sizing:border-box}
    body{margin:0;background:var(--bg);font:14px/1.6 system-ui,-apple-system,Segoe UI,Roboto,Arial}
    .wrap{max-width:980px;margin:28px auto;padding:20px}
    .panel{background:var(--card);border:1px solid var(--line);border-radius:10px;box-shadow:0 4px 16px rgba(0,0,0,.04)}
    .head{padding:28px 32px 0}
    .head h1{margin:0 0 24px;font-size:28px;font-weight:800;color:var(--text)}
    .confirm{display:flex;align-items:center;justify-content:center;gap:16px;padding:10px 32px 24px;border-bottom:1px solid var(--line)}
    .check{width:64px;height:64px;border-radius:50%;border:3px solid #93c5fd;display:grid;place-items:center;flex:0 0 64px}
    .check::after{content:"";width:20px;height:10px;border-left:4px solid #60a5fa;border-bottom:4px solid #60a5fa;transform:rotate(-45deg);display:block;margin-top:-2px}
    .confirm .msg{font-size:22px;font-weight:700;color:#111}

    /* 메인 그리드: 라벨/값 × 2열 */
    .grid{display:grid;grid-template-columns:180px 1fr 180px 1fr;row-gap:0;border-top:1px solid var(--line)}
    .row{display:contents}
    .cell{padding:16px 24px;border-bottom:1px solid var(--line)}
    .label{color:var(--muted);background:#fcfcfd}
    .value{color:#111}

    /* QR (오른쪽 고정, 세로 3행 span) */
    .qr-holder{grid-column:3 / span 2; grid-row: span 3; padding:16px 24px; display:flex; align-items:flex-start; gap:12px}
    .qr-code{width:128px;height:128px}
    .qr-code canvas,.qr-code img{width:128px;height:128px;image-rendering:pixelated}
    .qr-hint{font-size:12px;color:#6b7280}

    /* 오시는 길 */
    .route{padding:8px 24px 24px;border-top:1px solid var(--line)}
    .route h2{margin:18px 0 12px;font-size:20px;font-weight:800;color:var(--text)}
    .route-grid{display:grid;grid-template-columns:1.2fr .8fr;gap:18px}
    .route .card{border:1px solid var(--line);border-radius:10px;background:#fff}
    .route .card .card-head{padding:12px 16px;border-bottom:1px solid var(--line);font-weight:700}
    .route .card .card-body{padding:14px 16px}
    .kv{display:grid;grid-template-columns:90px 1fr;gap:8px}
    .kv .k{color:var(--muted)}
    .kv .v{color:#111}
    .mini-map img{width:100%;height:auto;display:block;border-radius:8px;border:1px solid var(--line)}
    .hint{margin-top:8px;color:#6b7280;font-size:12px}

    /* 버튼 */
    .rc-actions{display:flex !important;justify-content:center;gap:12px;padding:18px 24px}
    .rc-btn{display:inline-flex !important;align-items:center;gap:8px;padding:12px 18px;border:0;border-radius:8px;cursor:pointer;
            background:var(--primary);color:var(--primary-ink) !important;font-weight:700;text-decoration:none}
    .rc-btn:active{transform:translateY(1px)}
    .rc-fab{position:fixed;right:24px;bottom:24px;z-index:2147483647;display:inline-flex !important;align-items:center;gap:8px;
            padding:12px 16px;border-radius:9999px;background:var(--primary);color:#fff !important;text-decoration:none;
            box-shadow:0 8px 24px rgba(0,0,0,.2)}

    @media (max-width:900px){
      .grid{grid-template-columns:160px 1fr}
      .route-grid{grid-template-columns:1fr}
      .qr-holder{grid-column:1 / -1; grid-row:auto; justify-content:flex-start} /* 모바일에선 아래로 */
    }

    /* 인쇄 */
    @media print{
      @page { size:A4; margin:12mm; }
      .rc-actions,.rc-fab,header,footer,nav,.site-header,.site-footer,#header,#footer{display:none !important}
      body{background:#fff}
      .wrap{max-width:none;margin:0;padding:0}
      .panel{box-shadow:none;border:0}
      .head{padding:0 0 12px}
      .grid .cell{padding:10px 12px}
      .mini-map img{-webkit-print-color-adjust:exact; print-color-adjust:exact}
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
  <div class="wrap">
    <div class="panel">
      <div class="head"><h1>예약완료 및 확인</h1></div>

      <div class="confirm">
        <div class="check"></div>
        <div class="msg">인터넷 진료예약 접수가 완료되었습니다.</div>
      </div>

      <!-- 정보영역 -->
      <div class="grid">
        <!-- 1행: 예약자 / 환자번호 -->
        <div class="row">
          <div class="cell label">예약자</div>
          <div class="cell value"><c:out value="${reservation.patientName}"/></div>
          <div class="cell label">환자번호</div>
          <div class="cell value"><c:out value="${reservation.patientNo}"/></div>
        </div>

        <!-- 형식화 변수 -->
        <fmt:formatNumber var="patientNo8" value="${reservation.patientNo}" pattern="00000000"/>
        <fmt:formatDate var="dateOnly" value="${reservation.reservationDate}" pattern="yy-MM-dd"/>
        <fmt:formatDate var="timeOnly" value="${reservation.reservationDate}" pattern="HH:mm"/>

        <!-- 2행: 진료과 + (오른쪽) QR 시작 -->
        <div class="row">
          <div class="cell label">진료과</div>
          <div class="cell value"><c:out value="${reservation.departmentName}"/></div>

          <!-- QR: 오른쪽 두 칸 차지 & 아래 두 행까지 세로로 span -->
          <div class="cell qr-holder">
            <div id="qrCode" class="qr-code" data-code="${patientNo8}"></div>
            <div class="qr-hint">앱 또는 키오스크에서 스캔하세요.</div>
          </div>
        </div>

        <!-- 3행: 의료진 (오른쪽은 위 QR이 차지) -->
        <div class="row">
          <div class="cell label">의료진</div>
          <div class="cell value"><c:out value="${reservation.doctorName}"/></div>
        </div>

        <!-- 4행: 예약일 (오른쪽은 위 QR이 차지) -->
        <div class="row">
          <div class="cell label">예약일</div>
          <div class="cell value">
            <c:choose>
              <c:when test="${not empty reservation.scheduleTime}">
                ${dateOnly} ${reservation.scheduleTime}
              </c:when>
              <c:otherwise>
                ${dateOnly} ${timeOnly}
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div><!-- /grid -->

      <!-- 오시는 길 -->
      <div class="route">
        <h2>오시는 길</h2>
        <div class="route-grid">
          <div class="card">
            <div class="card-head">정보</div>
            <div class="card-body">
              <div class="kv" style="margin-bottom:10px;">
                <div class="k">주소</div>
                <div class="v">서울특별시 강남구 역삼로 120 2층 (역삼동, 성보역삼빌딩)</div>
                <div class="k">연락처</div>
                <div class="v">대표전화 : 02-6255-8002<br/>팩스 : 02-566-1460</div>
                <div class="k">지하철</div>
                <div class="v">2호선 <strong>강남역 4번 출구</strong> 도보 약 381m</div>
                <div class="k">버스</div>
                <div class="v">
                  간선: 래미안아파트·파이낸셜뉴스(22-008, 22-007), 수협서초지점(22-131)<br/>
                  직행: 래미안아파트·파이낸셜뉴스(22-008, 22-007)
                </div>
              </div>
              <div class="hint">※ 네비게이션은 “역삼로 120 성보역삼빌딩”으로 검색하세요.</div>
            </div>
          </div>

          <div class="card">
            <div class="card-head">간단 약도</div>
            <div class="card-body mini-map">
              <img src="${cPath}/resources/images/capmap.png" alt="오시는 길 약도" loading="lazy"/>
              <div class="hint">※ 약도는 개략도이며 실제와 다를 수 있습니다.</div>
            </div>
          </div>
        </div>
      </div>

 <!-- 하단 버튼 -->
<div class="rc-actions">
  <c:choose>
    <c:when test="${not empty sessionScope.loginUser and not empty sessionScope.loginUser.patientNo}">
      <a class="rc-btn" href="${cPath}/reservation/my.do">예약내역조회</a>
    </c:when>

    <c:when test="${not empty sessionScope.guestPatientNo}">
      <a class="rc-btn" href="${cPath}/reservation/guest-start.do">예약내역조회</a>
    </c:when>

    <c:otherwise>
      <a class="rc-btn" href="${cPath}/reservation/guest-start.do}">예약내역조회</a>
    </c:otherwise>
  </c:choose>

  <a class="rc-btn" href="#" onclick="window.print();return false;">인쇄</a>
</div><!-- /rc-actions -->

</div><!-- /panel -->
</div><!-- /wrap -->


<!-- QRCode JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
<script>
  (function(){
    var el = document.querySelector('#qrCode');
    if(!el) return;
    var code = el.getAttribute('data-code') || '';
    if(!/^\d{8}$/.test(code)){ code = (code||'').toString().padStart(8,'0'); }
    new QRCode(el, { text: code, width: 128, height: 128, correctLevel: QRCode.CorrectLevel.M });
  })();
</script>

<jsp:include page="/WEB-INF/jsp/footer.jsp" />
</body>
</html>


  
