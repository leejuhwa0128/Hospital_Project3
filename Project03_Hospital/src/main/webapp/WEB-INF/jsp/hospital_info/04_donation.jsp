<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>기부 안내</title>
<link rel="stylesheet" href="<c:url value='/resources/css/donation.css'/>">
</head>
<body>

<!-- ✅ 공통 헤더 -->
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<div class="donation-layout">

  <!-- ✅ 왼쪽 메뉴바 -->
  <aside class="sidebar">
    <jsp:include page="/WEB-INF/jsp/hospital_info/04_menu.jsp" />
  </aside>

  <!-- ✅ 메인 콘텐츠 -->
  <main class="donation-content">

    <!-- 메인 비주얼 -->
    <section class="hero">
      <h1>💙 따뜻한 나눔, 더 나은 미래</h1>
      <p>여러분의 후원은 환자와 지역사회에 희망을 전합니다.</p>
    </section>

    <!-- 기부 소개 -->
    <section class="intro">
      <h2>기부 소개</h2>
      <p>
        병원 발전기금은 환자의 치료환경 개선, 장학 지원, 의료 선교 및 연구 개발에 사용됩니다.  
        후원자님의 소중한 마음은 환자와 가족들에게 큰 힘이 됩니다.
      </p>
    </section>

    <!-- 참여 방법 -->
    <section class="guide">
      <h2>참여 방법</h2>
      <div class="cards">
        <div class="card">
          <h3>후원분야</h3>
          <ul>
            <li>발전기부금</li>
            <li>장학기부금</li>
            <li>건축기부금</li>
            <li>의료선교후원금</li>
          </ul>
        </div>
        <div class="card">
          <h3>후원 방법</h3>
          <ul>
            <li>온라인 / 계좌이체 / 카드</li>
            <li>팩스 / 이메일 약정</li>
            <li>방문 후원 (발전기금 사무국)</li>
          </ul>
        </div>
        <div class="card">
          <h3>후원자 예우</h3>
          <ul>
            <li>예우 프로그램 제공</li>
            <li>명예의 전당 기념</li>
          </ul>
        </div>
      </div>
    </section>

    <!-- 세제 혜택 -->
    <section class="benefit">
      <h2>세제 혜택</h2>
      <table class="benefit-table">
        <thead>
          <tr>
            <th>구분</th>
            <th>개인(세액공제)</th>
            <th>개인사업자(필요경비)</th>
            <th>법인(손금산입)</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>특례기부금</td>
            <td>소득금액 100% 한도 / 15%(초과분 30%)</td>
            <td>전액</td>
            <td>소득금액 50% 한도 내 전액</td>
          </tr>
          <tr>
            <td>일반기부금</td>
            <td>소득금액 30% 한도 / 15%(초과분 30%)</td>
            <td>30% 한도</td>
            <td>소득금액 10% 한도</td>
          </tr>
        </tbody>
      </table>
      <p class="note">※ 당해 연도 한도 초과분은 10년 이월공제 가능</p>
    </section>

    <!-- 개인정보 안내 -->
    <section class="privacy">
      <h2>개인정보 수집·이용 안내</h2>
      <ul>
        <li>수집 항목: 성명, 이메일, 연락처, 주소, 결제정보</li>
        <li>이용 목적: 영수증 발급, 예우 프로그램 안내, 기부금 처리</li>
        <li>보유 기간: 목적 달성 시까지(관계법령 별도 보관 제외)</li>
        <li class="warn">동의 거부 시 일부 서비스 이용이 제한될 수 있습니다.</li>
      </ul>
    </section>

    <!-- 후원하기 폼 -->
    <section class="donation-form-section">
      <h2>후원하기</h2>
      <form id="donationForm">
        <div class="field">
          <label for="amount">후원 금액(원)</label>
          <input type="number" id="amount" name="amount" min="1000" step="1000"
                 placeholder="예) 50000" required />
        </div>

        <div class="field">
          <label for="donorName">후원자명</label>
          <input type="text" id="donorName" name="donorName"
                 placeholder="홍길동" required />
        </div>

        <div class="field">
          <label for="email">연락 이메일</label>
          <input type="email" id="email" name="email"
                 placeholder="your@email.com" required />
        </div>

        <button type="button" id="btnDonate" class="btn-primary">후원하기</button>
      </form>
    </section>

    <!-- 문의처 -->
    <section class="contact">
      <h2>문의처</h2>
      <p><strong>발전기금사무국</strong><br>02-2228-1085~9 / fund1885@yuhs.ac</p>
    </section>

  </main>
</div>

<!-- ✅ Toss Payments V1 SDK -->
<script src="https://js.tosspayments.com/v1"></script>
<script>
document.getElementById("btnDonate").addEventListener("click", function () {
  const amount = parseInt(document.getElementById("amount").value);
  const donorName = document.getElementById("donorName").value.trim();
  const email = document.getElementById("email").value.trim();

  if (!amount || amount < 1000) {
    alert("1,000원 이상 입력해주세요.");
    return;
  }
  if (!donorName || !email) {
    alert("이름과 이메일을 입력해주세요.");
    return;
  }

  var clientKey = "${tossClientKey}";
  var orderId = "${orderId}";

  TossPayments(clientKey).requestPayment('카드', {
    amount: amount,
    orderId: orderId,
    orderName: donorName + "님의 후원",
    customerName: donorName,
    customerEmail: email,
    successUrl: window.location.origin 
                + "${pageContext.request.contextPath}/donation/success.do"
                + "?donorName=" + encodeURIComponent(donorName)
                + "&email=" + encodeURIComponent(email),
    failUrl: window.location.origin + "${pageContext.request.contextPath}/donation/fail.do"
  });
});
</script>
</body>
</html>
