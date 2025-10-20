<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/WEB-INF/jsp/referral/referral_header.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>협진의료진 소개</title>
<link rel="stylesheet"
  href="${pageContext.request.contextPath}/resources/css/referral_sidebar.css?v=20250811">

<style>
/* ===== 레이아웃 ===== */
.container{
  max-width:1200px;
  margin:40px auto;
  display:flex;
  gap:24px;
  font-family:'맑은 고딕','Malgun Gothic',sans-serif;
  color:#000;
  padding:0 16px;
}
.main-content{flex:1; padding:0 6px}

/* ===== 본문 헤더 ===== */
.header{
  display:flex; align-items:flex-end; justify-content:space-between;
  border-bottom:2px solid #000;
  padding-bottom:10px; margin-bottom:24px;
  font-size:22px; font-weight:800; color:#000;
}

/* ===== 카드 그리드 ===== */
.doctor-list{
  display:grid;
  grid-template-columns:repeat(auto-fill, minmax(260px, 1fr));
  gap:18px;
}

/* ===== 의사 카드 ===== */
.doctor-card{
  background:#fff;
  border:1px solid var(--line);
  border-radius:12px;
  padding:16px;
  box-shadow:0 4px 10px rgba(0,0,0,.04);
  transition:transform .15s ease, box-shadow .15s ease, border-color .15s ease;
}
.doctor-card:hover{
  transform:translateY(-2px);
  box-shadow:0 10px 24px rgba(0,0,0,.08);
  border-color:#e2e8f0;
}
.doctor-card h4{
  margin:0 0 10px; font-size:18px; color:#111;
}
.doctor-card p{
  margin:0 0 6px; font-size:14px; color:var(--muted);
}
.doctor-card p strong{ color:#333; }

/* ===== 반응형 ===== */
@media (max-width:900px){
  .container{flex-direction:column; gap:18px}
  .doctor-list{grid-template-columns:repeat(auto-fill, minmax(220px, 1fr))}
}
</style>
</head>
<body>

<div class="container">

  <!-- ✅ 좌측 사이드바 (요청 고정 코드 그대로) -->
  <aside class="ref-sidebar">
    <h3>진료의뢰&조회</h3>
    <ul class="ref-side-menu">
      <li><a href="/referral/referral.do">진료의뢰 안내</a></li>
      <li><a href="/referral/status.do">진료의뢰 신청현황</a></li>
      <li><a href="/referral/statusAll.do">의뢰/회송 환자 결과 조회</a></li>
      <li><a class="is-active" href="/referral/doctor.do">의료진 검색</a></li>
    </ul>
  </aside>

  <!-- ✅ 본문 콘텐츠 -->
  <div class="main-content">
    <div class="header">협진의료진 소개</div>

    <div class="doctor-list">
      <c:forEach var="doctor" items="${coopDoctors}">
        <div class="doctor-card">
          <h4>${doctor.name} 교수</h4>
          <p>진료과: <strong>${doctor.departmentName}</strong></p>
          <p>소속: <strong>${doctor.hospitalName}</strong></p>
        </div>
      </c:forEach>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/jsp/referral/referral_footer.jsp"%>
</body>
</html>
