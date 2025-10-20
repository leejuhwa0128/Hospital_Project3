<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 컨텍스트 경로 먼저 설정 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!-- 공통 헤더 -->
<jsp:include page="/WEB-INF/jsp/referral/referral_header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>진료협력네트워크 - 운영개요</title>

<!-- 좌측 사이드바 전용 CSS -->
<link rel="stylesheet" href="${ctx}/resources/css/referral_sidebar.css?v=20250811"/>

<style>
/* 페이지 레이아웃 */
.page{
  max-width:1200px; margin:0 auto; padding:24px 16px 64px;
  display:grid; grid-template-columns:220px 1fr; gap:32px;
  font-family:'맑은 고딕','Malgun Gothic',sans-serif;
}

/* 본문 영역 */
.main{min-width:0;}
.breadcrumb{font-size:12px; color:#666; margin-bottom:8px}
.page-title{margin:0 0 16px; font-size:22px; font-weight:800; border-bottom:2px solid #000; padding-bottom:8px}

/* 섹션 카드 */
.section{
  background:#fff; border:1px solid #e7e7e7; border-radius:12px;
  padding:20px; margin-bottom:18px; box-shadow:0 4px 14px rgba(0,0,0,.04);
}
.section h3{margin:0 0 10px; font-size:18px}
.section .lead{margin:0; color:#111; line-height:1.8}
.kv{font-weight:800}

/* 리스트/스텝 */
.ul{margin:8px 0 0 18px; padding:0}
.ul li{margin:4px 0; line-height:1.7}
.steps{display:grid; grid-template-columns:repeat(1,minmax(0,1fr)); gap:8px; margin-top:8px}
@media (min-width: 800px){ .steps{grid-template-columns:repeat(3,minmax(0,1fr))} }
.step{
  border:1px dashed #cfd4dc; border-radius:10px; padding:10px 12px; background:#f9fbff;
  font-size:14px
}
.step .num{display:inline-block; min-width:22px; height:22px; border-radius:999px; text-align:center; line-height:22px; font-weight:800; background:#0b57d0; color:#fff; margin-right:6px}

/* 5단계 흐름 */
.flow{display:grid; grid-template-columns:repeat(1,minmax(0,1fr)); gap:10px}
@media (min-width: 900px){ .flow{grid-template-columns:repeat(5,1fr)} }
.flow-item{
  border:1px solid #e7e7e7; border-radius:12px; padding:14px; text-align:center; background:#fcfcff
}
.flow-item .tit{font-weight:800; margin-bottom:6px}

/* 강조 박스 */
.note{
  background:#f6fbff; border:1px solid #d9ecff; border-radius:12px; padding:14px; line-height:1.7; color:#0b2e4f
}
</style>
</head>
<body>

<div class="page">
  <!-- 좌측 사이드바 -->
  <aside class="ref-sidebar">
    <h3>진료협력네트워크</h3>
    <ul class="ref-side-menu">
      <li><a href="${ctx}/referral/referral_overview.do" class="is-active">운영개요</a></li>
      <li><a href="${ctx}/referral/referral_status.do">협력병원 현황</a></li>
    </ul>
  </aside>

  <!-- 본문 -->
  <main class="main">
    <div class="breadcrumb">Home &gt; 진료협력네트워크 &gt; 운영개요</div>
    <h1 class="page-title">운영개요</h1>

    <!-- 인트로 -->
    <section class="section">
      <p class="lead">
        <span class="kv">진료 협력 네트워크</span>는 지역 의료기관과의 상호 협력을 통해
        바람직한 의료전달체계를 구축하고, 환자 이동의 불편을 최소화하여
        <b>신속·정확·연속성 있는 진료</b>를 실현합니다.
      </p>
    </section>

    <!-- 1. 회원의료기관 -->
    <section class="section">
      <h3>1. 회원의료기관</h3>
      <ul class="ul">
        <li><b>대상</b> : MEDIPRIME와 진료교류를 희망하는 의원/병원</li>
      </ul>
      <div class="steps">
        <div class="step"><span class="num">1</span> 온라인/오프라인 신청</div>
        <div class="step"><span class="num">2</span> 기본 정보 확인 및 등록</div>
        <div class="step"><span class="num">3</span> 회원 승인 및 안내 발송</div>
      </div>
    </section>

    <!-- 2. 협력의료기관 -->
    <section class="section">
      <h3>2. 협력의료기관</h3>
      <ul class="ul">
        <li><b>대상</b> : 진료 의뢰·회신이 활발하고 연계 치료가 필요한 의료기관</li>
        <li><b>선정 기준</b>
          <ul class="ul">
            <li>의뢰/회송의 연속성 및 적정성</li>
            <li>응급·중증환자 협력 실적</li>
            <li>교육/연수 참여도 및 피드백</li>
          </ul>
        </li>
      </ul>
      <div class="steps">
        <div class="step"><span class="num">1</span> 추천/자체 신청</div>
        <div class="step"><span class="num">2</span> 내부 심사 및 협의</div>
        <div class="step"><span class="num">3</span> 협약 체결(상·하반기)</div>
      </div>
    </section>

    <!-- 3. 협력병원 -->
    <section class="section">
      <h3>3. 협력병원</h3>
      <ul class="ul">
        <li><b>대상</b> : 전속 전문의 9인 이상 · 200병상 이상 병원, 종합병원, 지역거점 공공보건의료기관</li>
        <li><b>심사 요건</b>
          <ul class="ul">
            <li>진료협력 전담 창구/담당자 지정</li>
            <li>중환자 전원·역회송 체계 보유</li>
            <li>환자/보호자 안내 및 회신 동의 절차 운영</li>
          </ul>
        </li>
      </ul>
      <div class="steps">
        <div class="step"><span class="num">1</span> 신청서 접수</div>
        <div class="step"><span class="num">2</span> 서류심사·사전 방문</div>
        <div class="step"><span class="num">3</span> 내부심사·승인 후 협약</div>
      </div>
    </section>

    <!-- 지원 사항 -->
    <section class="section">
      <h3>◆ 진료협력 네트워크 지원 사항</h3>
      <p class="kv" style="margin:8px 0 6px">공통</p>
      <ul class="ul">
        <li>의뢰 환자 <b>신속 예약</b> 지원 및 전용 상담 채널 제공</li>
        <li>환자 동의 하에 <b>진료결과·검사결과 회신</b> (검사, 입원·수술 여부 포함)</li>
        <li>협력기관 안내 자료 배포, 정기 교육·연수 초청</li>
      </ul>
      <p class="kv" style="margin:14px 0 6px">협력의료기관/협력병원 추가</p>
      <ul class="ul">
        <li>우수 협력기관 표창 및 홈페이지 명시</li>
        <li>협력회원 <b>전용 예약 창구</b>·상담 라인</li>
        <li>세미나·간담회 초청, 전공의 연수 프로그램</li>
        <li>전문의 <b>1:1 협의 채널</b> 운영</li>
      </ul>
    </section>

    <!-- 운영 프로세스 -->
    <section class="section">
      <h3>운영 프로세스</h3>
      <div class="flow" style="margin-top:8px">
        <div class="flow-item"><div class="tit">1. 의뢰</div><div>협력기관 전용 채널로 의뢰</div></div>
        <div class="flow-item"><div class="tit">2. 예약</div><div>신속 예약 및 사전 안내</div></div>
        <div class="flow-item"><div class="tit">3. 진료</div><div>전문의 진료·검사</div></div>
        <div class="flow-item"><div class="tit">4. 회신</div><div>환자 동의 후 결과 회신</div></div>
        <div class="flow-item"><div class="tit">5. 회송</div><div>지역 병·의원으로 연계</div></div>
      </div>
    </section>

    <!-- 문의 -->
    <section class="section">
      <h3>문의</h3>
      <div class="note">
        협력 가입/협약/교육 관련 문의 : 02-1234-1234<br />
        의뢰·예약·회신 관련 전담 창구 : 02-1234-5678 (평일 09:00~18:00)
      </div>
    </section>
  </main>
</div>

<!-- 공통 푸터 -->
<jsp:include page="/WEB-INF/jsp/referral/referral_footer.jsp" />

</body>
</html>
