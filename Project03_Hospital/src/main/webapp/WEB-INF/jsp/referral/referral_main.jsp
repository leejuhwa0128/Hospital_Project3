<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDIPRIME 협진 병원 센터</title>

<!-- 헤더/푸터/네비 전용 공통 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/referral_layout.css?v=20250811" />

<style>
.quick-panels {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 24px;
	max-width: 1200px;
	margin: 40px auto;
	padding: 0 16px;
}

.panel {
	position: relative;
	display: block;
	padding: 28px;
	border-radius: 14px;
	min-height: 200px;
	text-decoration: none;
	transition: .2s;
	box-shadow: 0 2px 10px rgba(0, 0, 0, .04);
	overflow: hidden;
}

.panel h3 {
	margin: 0 0 12px;
	font-size: 20px;
	font-weight: 700
}

.panel p {
	margin: 0;
	line-height: 1.6;
	font-size: 14px;
	opacity: .95
}

.panel .ico {
	display: block;
	font-size: 26px;
	opacity: .9;
	margin-bottom: 10px
}

.panel::after {
	content: "";
	position: absolute;
	inset: 0;
	background: linear-gradient(120deg, transparent 30%, rgba(255, 255, 255, .35)
		50%, transparent 70%);
	transform: translateX(-120%);
	transition: transform .5s ease
}

.panel:hover::after {
	transform: translateX(120%)
}

.panel:hover {
	transform: translateY(-2px);
	box-shadow: 0 8px 18px rgba(0, 0, 0, .08)
}

.panel--green {
	background: #2E8B57;
	color: #fff
}

.panel--blue {
	background: #1E90FF;
	color: #fff
}

.panel--purple {
	background: #6A0DAD;
	color: #fff
}

.panel--lavender {
	background: #E6E6FA;
	color: #222;
	border: 1px solid #ddd
}

@media ( max-width :1024px) {
	.quick-panels {
		grid-template-columns: repeat(2, 1fr)
	}
}

@media ( max-width :560px) {
	.quick-panels {
		grid-template-columns: 1fr
	}
}
/* ====== 공지사항(4칸 레이아웃) - 간격/보더 보강 ====== */
.notice-quad {
  max-width: 1200px;
  margin: 40px auto 0;
  padding: 0 16px;

  display: grid;
  grid-template-columns: repeat(2, minmax(0,1fr));
  grid-template-areas:
    "head card1"
    "card2 card3";
   margin-bottom: 140px; 
  /* 행(위아래)과 열(좌우) 간격을 동일하게 40px로 설정 */
  row-gap: 40px;
  column-gap: 40px;

  align-items: start;
}

/* 좌상(제목/탭) 영역도 공지 카드와 같은 상단 두꺼운 선과 패딩 적용 */
.notice-selector {
  grid-area: head;

  /* 카드와 동일한 패딩 */
  padding: 22px 56px 22px 0;

  /* 카드와 같은 상단 굵은 보더 */
  border-top: 2px solid #0a0a0a;

  display: flex;
  flex-direction: column;
  justify-content: center;

  /* 카드와 최소 높이 통일 */
  min-height: 110px;
  
  border-top: 0; 
}

/* 제목/설명 */
.notice-title {
  margin: 0 0 8px;
  font-size: 36px;
  font-weight: 800;
  letter-spacing: -.02em;
  color: var(--ink);
}

.notice-desc {
  margin: 0 18px 18px 0;
  color: var(--muted);
  line-height: 1.6;
  font-size: 13px;
}

/* 탭(세그먼트) */
.notice-tabs {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  background: #f1f3f5;
  border-radius: 999px;
  padding: 4px;
}

.notice-tabs .tab-btn {
  appearance: none;
  border: 0;
  cursor: pointer;
  padding: 10px 14px;
  border-radius: 999px;
  background: transparent;
  color: #111;
  font-weight: 700;
  font-size: 14px;
  opacity: .7;
  transition: .2s;
}

.notice-tabs .tab-btn.is-active {
  background: #111;
  color: #fff;
  opacity: 1;
}

.notice-tabs .more {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  margin-left: 4px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: #e9ecef;
  color: #111;
  text-decoration: none;
  font-weight: 700;
}

.notice-tabs .more::before {
  content: "+";
}

/* 공지 카드 3개 영역 */
.notice-slot{
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;
  min-height: 110px;
  padding: 22px 56px 22px 0;   /* 오른쪽 화살표 공간 확보 */
  border-top: 2px solid #0a0a0a;
  color: #111;
  text-decoration: none;
  background: transparent;
  transition: .15s ease;
}
/* ▶ 원형 화살표(우측 상단) — 두 번째 스샷 스타일 */
.notice-slot::after{
  content: "\2192";            /* → */
  position: absolute;
  top: 14px;                   /* 상단 여백 */
  right: 0;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  display: grid;
  place-items: center;
  background: #0a0a0a;
  color: #fff;
  font-size: 20px;
  box-shadow: 0 6px 14px rgba(0,0,0,.12);
  transition: transform .15s ease, background .2s ease;
}
.notice-slot:hover::after{
  transform: translateX(2px);
  background: #111;
}

/* 슬롯 위치 지정 */
#slot1 { grid-area: card1; }
#slot2 { grid-area: card2; }
#slot3 { grid-area: card3; }

/* 공지 카드 내부 텍스트 간격 통일 */
.notice-slot .badge{
  margin: 0 0 10px;
  font-size: 13px;
  font-weight: 700;
  color: #2b5bd7;              /* 배지(병원명) 색 */
}
.notice-slot .title{
  margin: 0 0 10px;
  font-size: 24px;             /* 타이틀 크게 */
  font-weight: 800;
  line-height: 1.45;
}
.notice-slot .date{
  margin: 0;
  font-size: 13px;
  color: #8a8a8a;
}

/* 공지 그리드 간격 통일 */
.notice-grid {
  column-gap: 40px; /* 좌우 간격 40px로 통일 */
  row-gap: 40px; /* 위아래 간격 40px로 통일 */
  align-items: stretch;
}

/* 반응형 조정 */
@media (max-width: 900px) {
  .notice-quad {
    gap: 80px;
  }
  .notice-title {
    font-size: 28px;
  }
  .notice-slot {
    padding-right: 48px;
  }
  .notice-slot::after {
    width: 32px;
    height: 32px;
    font-size: 16px;
    top: 14px;
  }
}

/* 모바일 고정 CTA */
.quick-cta {
  position: fixed;
  left: 12px;
  right: 12px;
  bottom: 12px;
  z-index: 50;
  background: #003366;
  color: #fff;
  border-radius: 12px;
  display: flex;
  justify-content: space-between;
  padding: 10px 14px;
  box-shadow: 0 10px 24px rgba(0, 0, 0, .15);
  font-size: 14px;
}

.quick-cta a {
  color: #fff;
  text-decoration: none;
  font-weight: 700;
}

@media (min-width: 1025px) {
  .quick-cta {
    display: none;
  }
}
/* ====== 메인 배너 ====== */
.hero-wrap{
  max-width:1200px;
  margin:24px auto 0;
  padding:0 16px;          /* quick-panels와 동일한 좌우 여백 */
}
.hero-img{
  width:100%;
  height:700px;            /* 필요 시 조절 */
  display:block;
  border-radius:16px;
  object-fit:cover;        /* 이미지 비율 깨지지 않게 채우기 */
  box-shadow:0 8px 24px rgba(0,0,0,.08);
}
@media (max-width:900px){ .hero-img{ height:300px; } }
@media (max-width:560px){ .hero-img{ height:220px; } }
</style>
</head>
<body>

	<%@ include file="/WEB-INF/jsp/referral/referral_header.jsp"%>
<!-- 메인 배너 -->
<div class="hero-wrap">
  <img
    src="${pageContext.request.contextPath}/resources/images/ReferralMain.png"
    alt="MEDIPRIME 진료협력센터 메인 배너"
    class="hero-img">
</div>
	<!-- 빠른 진입 패널 -->
	<div class="quick-panels">
		<a href="${pageContext.request.contextPath}/main.do" target="_blank" rel="noopener noreferrer"
			class="panel panel--green"> <span class="ico" aria-hidden="true">🏥</span>
			<h3>MEDIPRIME 병원</h3>
			<p>본원 홈페이지로 이동합니다.</p>
		</a> <a
			href="${pageContext.request.contextPath}/referral/referral_status.do"
			class="panel panel--blue"> <span class="ico" aria-hidden="true">🤝</span>
			<h3>협력병원 검색</h3>
			<p>MEDIPRIME 병원과 함께하는 협력 병원들을 확인하세요.</p>
		</a> <a href="${pageContext.request.contextPath}/referral/doctor.do"
			class="panel panel--purple"> <span class="ico" aria-hidden="true">👨‍⚕️</span>
			<h3>의료진 검색</h3>
			<p>원하는 의료진 정보를 간편하게 찾아볼 수 있습니다.</p>
		</a> <a href="${pageContext.request.contextPath}/referral/referral.do"
			class="panel panel--lavender"> <span class="ico"
			aria-hidden="true">🕑</span>
			<h3>진료안내</h3>
			<p>
				진료시간 및 외래진료 안내를 확인하세요.<br>대표번호 : 1588-1588
			</p>
		</a>
	</div>

	<!-- 공지사항 4칸 -->
<div class="notice-quad">
  <!-- 좌상: 제목/설명/탭 -->
  <section class="notice-selector">
    <h2 class="notice-title">공지사항</h2>
    <p class="notice-desc">고객감동을 최우선으로 하는 MEDIPRIME 협진병원센터에서 고객님들께 전해드립니다.</p>

    <div class="notice-tabs" role="tablist" aria-label="공지 카테고리">
      <button type="button" class="tab-btn is-active" data-filter="center">진료협력센터</button>
      <button type="button" class="tab-btn" data-filter="hospital">MEDIPRIME</button>
      <a id="noticeMore"
         href="#" class="more" aria-label="더보기"></a>
    </div>
  </section>

  <!-- 우상/좌하/우하: 공지 슬롯 3개 -->
  <a id="slot1" class="notice-slot" href="javascript:void(0)">
    <span class="badge"></span>
    <div class="title"></div>
    <div class="date"></div>
  </a>
  <a id="slot2" class="notice-slot is-thin" href="javascript:void(0)">
    <span class="badge"></span>
    <div class="title"></div>
    <div class="date"></div>
  </a>
  <a id="slot3" class="notice-slot is-thin" href="javascript:void(0)">
    <span class="badge"></span>
    <div class="title"></div>
    <div class="date"></div>
  </a>

  <!-- 협력센터 공지 (숨김 저장소) -->
  <div id="centerData" style="display:none">
    <c:forEach items="${latestNotices}" var="n">
      <c:url var="centerUrl" value="/referral/noticeDetail.do">
        <c:param name="noticeId" value="${n.noticeId}" />
      </c:url>
      <a class="notice-card" href="${centerUrl}">
        <span class="badge">진료협력센터</span>
        <div class="title"><c:out value="${n.title}" /></div>
        <div class="date"><fmt:formatDate value="${n.createdAt}" pattern="yyyy-MM-dd" /></div>
      </a>
    </c:forEach>
  </div>

  <!-- MEDIPRIME 공지 (HOSPITAL_NOTICES / 숨김 저장소) -->
  <div id="hospitalData" style="display:none">
    <c:forEach items="${latestHospitalNotices}" var="h">
      <%-- 병원 상세 경로는 프로젝트에 맞게 수정 --%>
      <c:url var="hospitalUrl" value="/01_notice/detail.do">
        <c:param name="noticeId" value="${h.noticeId}" />
      </c:url>
      <a class="notice-card" href="${hospitalUrl}">
        <span class="badge">MEDIPRIME</span>
        <div class="title"><c:out value="${h.title}" /></div>
        <div class="date"><fmt:formatDate value="${h.createdAt}" pattern="yyyy-MM-dd" /></div>
      </a>
    </c:forEach>
  </div>
</div>

	<!-- 모바일 고정 CTA -->
	<div class="quick-cta">
		<span>상담이 필요하신가요?</span> <a href="tel:15881588">1588-1588 전화하기</a>
	</div>

	<%@ include file="/WEB-INF/jsp/referral/referral_footer.jsp"%>

<script>
(function(){
  var ctx   = '${pageContext.request.contextPath}';
  var tabs  = [].slice.call(document.querySelectorAll('.notice-tabs .tab-btn'));
  var more  = document.getElementById('noticeMore');
  var slots = ['slot1','slot2','slot3'].map(function(id){ return document.getElementById(id); });

  // 각 탭의 데이터 소스
  var source = {
    center:   [].slice.call(document.querySelectorAll('#centerData .notice-card')),
    hospital: [].slice.call(document.querySelectorAll('#hospitalData .notice-card'))
  };
  
  var LIST_URL = {
		    center:   ctx + '/referral/referral_notice.do?tab=center',
		    hospital: ctx + '/01_notice/list.do'   // 병원 공지 전체 목록(프로젝트 경로에 맞게)
		  };

  function fill(filter){
    // 탭 상태
    tabs.forEach(function(t){ t.classList.toggle('is-active', t.dataset.filter === filter); });
    // 더보기 링크
       more.href = LIST_URL[filter] || '#';
    if (filter === 'hospital') {
      // 병원 공지는 새창을 원하면 켜고, 동일창 원하면 아래 두 줄 제거
      more.setAttribute('target','_blank');
      more.setAttribute('rel','noopener noreferrer');
    } else {
      more.removeAttribute('target');
      more.removeAttribute('rel');
    }

    // 해당 소스에서 3건만
    var list = (source[filter] || []).slice(0, 3);

    // 슬롯 채우기
    slots.forEach(function(slot, i){
      var a = list[i];
      if(!a){ slot.style.display = 'none'; return; }
      slot.style.display = '';
      slot.href = a.getAttribute('href');
      slot.querySelector('.badge').textContent = a.querySelector('.badge').textContent;
      slot.querySelector('.title').textContent = a.querySelector('.title').textContent;
      slot.querySelector('.date').textContent  = a.querySelector('.date').textContent;
    });
  }

  tabs.forEach(function(btn){ btn.addEventListener('click', function(){ fill(btn.dataset.filter); }); });
  fill('center'); // 초기
})();
</script>

</body>
</html>
