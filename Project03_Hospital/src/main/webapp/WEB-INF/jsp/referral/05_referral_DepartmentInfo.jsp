<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 컨텍스트 경로 먼저 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!-- 공통 헤더 -->
<jsp:include page="/WEB-INF/jsp/referral/referral_header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDIPRIME 협진병원 진료과 소개</title>

<!-- 좌측 사이드바 전용 CSS -->
<link rel="stylesheet" href="${ctx}/resources/css/referral_sidebar.css?v=20250811"/>

<style>
/* 페이지 레이아웃 */
.page{
  max-width:1200px; margin:0 auto; padding:24px 16px 64px;
  display:grid; grid-template-columns:220px 1fr; gap:32px;
  font-family:'맑은 고딕','Malgun Gothic',sans-serif; color:#000;
}

/* 본문 */
.main{min-width:0;}
.breadcrumb{font-size:12px; color:#666; margin-bottom:8px}
.page-title{margin:0 0 14px; font-size:22px; font-weight:800; border-bottom:2px solid #000; padding-bottom:8px}

.lead-card{
  background:#f6fbff; border:1px solid #d9ecff; color:#0b2e4f;
  border-radius:12px; padding:16px 18px; line-height:1.8; margin-bottom:18px;
}

/* 진료과 그리드 */
.dept-grid{
  display:grid; grid-template-columns:repeat(3, minmax(0,1fr)); gap:16px;
}
@media (max-width:980px){ .dept-grid{ grid-template-columns:repeat(2, minmax(0,1fr)); } }
@media (max-width:640px){ .dept-grid{ grid-template-columns:1fr; } }

.dept-card{
  background:#fff; border:1px solid #e7e7e7; border-radius:12px; padding:16px;
  box-shadow:0 4px 14px rgba(0,0,0,.04);
  display:flex; gap:14px; align-items:flex-start;
}
.dept-ico{font-size:22px; line-height:1}
.dept-body{min-width:0}
.dept-title{margin:0 0 6px; font-size:16px; font-weight:800}
.dept-desc{margin:0; font-size:13px; color:#333; line-height:1.6}

/* 섹션 */
.section{margin-top:26px}
.section h3{margin:0 0 10px; font-size:18px; font-weight:800}
.kv-list{margin:0; padding-left:18px; line-height:1.9; font-size:14px}
.note{
  background:#fffaf2; border:1px solid #ffe1b2; color:#7a4b00;
  border-radius:10px; padding:12px 14px; font-size:13px; margin-top:10px;
}

.badge{background:#eef3ff; color:#0b57d0; border:1px solid #d9e2ff; padding:4px 10px; border-radius:999px; font-weight:700; font-size:12px}

/* 반응형 */
@media (max-width:920px){ .page{grid-template-columns:1fr} }
</style>
</head>
<body>

<div class="page">
  <!-- 좌측 사이드바 (공통 CSS 적용) -->
  <aside class="ref-sidebar">
    <h3>진료과소개</h3>
    <ul class="ref-side-menu">
      <li><a href="${ctx}/referral/referral_DepartmentInfo.do" class="is-active">진료과 소개</a></li>
    </ul>
  </aside>

  <!-- 본문 -->
  <main class="main">
    <div class="breadcrumb">Home &gt; 진료과소개 &gt; 진료과 소개</div>
    <h1 class="page-title">진료과 소개</h1>

    <div class="lead-card">
      MEDIPRIME 협진병원센터는 환자 특성에 맞춘 <b>전문 진료과</b>를 기반으로,
      협력병원과의 유기적 네트워크를 통해 <b>신속·정확한 의뢰·회신</b> 서비스를 제공합니다.
      중증 질환의 빠른 연계부터 지역사회로의 안전한 회송까지, 끊김 없는 치료 여정을 지원합니다.
    </div>

    <!-- 대표 진료과 -->
    <section class="section">
      <h3>대표 진료과 <span class="badge">주요 과목</span></h3>
      <div class="dept-grid">
        <div class="dept-card">
          <div class="dept-ico">🩺</div>
          <div class="dept-body">
            <p class="dept-title">내과</p>
            <p class="dept-desc">소화기·호흡기·내분비·순환기 등 내과 전 분야의 통합 진료와 만성질환 관리.</p>
          </div>
        </div>
        <div class="dept-card">
          <div class="dept-ico">🧠</div>
          <div class="dept-body">
            <p class="dept-title">신경외과</p>
            <p class="dept-desc">뇌·척추 질환의 수술 및 중재 치료, 신경계 응급 환자 신속 연계.</p>
          </div>
        </div>
        <div class="dept-card">
          <div class="dept-ico">🦴</div>
          <div class="dept-body">
            <p class="dept-title">정형외과</p>
            <p class="dept-desc">관절·척추·외상 분야 중심의 수술/재활 협진, 스포츠 손상 진료.</p>
          </div>
        </div>
        <div class="dept-card">
          <div class="dept-ico">🫀</div>
          <div class="dept-body">
            <p class="dept-title">흉부외과/심장내과</p>
            <p class="dept-desc">허혈성 심질환, 판막질환, 부정맥 등 심장혈관계 질환의 단계별 치료.</p>
          </div>
        </div>
        <div class="dept-card">
          <div class="dept-ico">👶</div>
          <div class="dept-body">
            <p class="dept-title">소아청소년과</p>
            <p class="dept-desc">예방접종·성장 평가·소아 급성 질환 진료 및 필요 시 상급 연계.</p>
          </div>
        </div>
        <div class="dept-card">
          <div class="dept-ico">🌸</div>
          <div class="dept-body">
            <p class="dept-title">산부인과</p>
            <p class="dept-desc">여성 건강, 임신·분만·부인종양 등 전문 진료 및 고위험 산모 협진.</p>
          </div>
        </div>
        <div class="dept-card">
          <div class="dept-ico">🩹</div>
          <div class="dept-body">
            <p class="dept-title">외과</p>
            <p class="dept-desc">복부·유방·내분비 등 수술적 치료, 수술 전·후 회송 관리 프로토콜 운영.</p>
          </div>
        </div>
        <div class="dept-card">
          <div class="dept-ico">🧴</div>
          <div class="dept-body">
            <p class="dept-title">피부과</p>
            <p class="dept-desc">만성 피부질환, 피부 종양, 레이저/피부외과 협진.</p>
          </div>
        </div>
        <div class="dept-card">
          <div class="dept-ico">🧬</div>
          <div class="dept-body">
            <p class="dept-title">종양센터(다학제)</p>
            <p class="dept-desc">암 환자 다학제 협진, 신속 진단·치료 계획 수립, 의뢰기관과 결과 공유.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- 협진 연계 안내 -->
    <section class="section">
      <h3>협진 연계 안내</h3>
      <ul class="kv-list">
        <li><b>의뢰</b> : 협력기관 전용 회선을 통해 예약·의뢰 (중증 환자 <b>당일·신속 진료</b> 우선 연계)</li>
        <li><b>진료</b> : 전담 코디네이터 배정, 검사·입원·수술까지 일정 원스톱 조율</li>
        <li><b>회신</b> : 환자 동의하에 <b>진료결과·검사결과</b> 신속 회신 (협진시스템/보안메일)</li>
        <li><b>회송</b> : 급성기 치료 종료 후 연고지 협력기관으로 안전 회송 및 추적관리</li>
      </ul>
      <div class="note">협진 문의: <b>02-1234-5678</b> (평일/토요일 09:00~18:00)</div>
    </section>
  </main>
</div>

<!-- 공통 푸터 -->
<jsp:include page="/WEB-INF/jsp/referral/referral_footer.jsp" />

</body>
</html>
