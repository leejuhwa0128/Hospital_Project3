<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>지역 사회 협력 프로그램 - 상세</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/04_community_detail.css" />
</head>
<body>

<!-- ✅ 공통 헤더 -->
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<div class="main-container">
  <!-- ✅ 좌측 카테고리 (목록 페이지와 동일 메뉴 사용) -->
  <div class="sidebar">
    <jsp:include page="/WEB-INF/jsp/hospital_info/04_menu.jsp" />
  </div>

  <!-- ✅ 콘텐츠 영역 -->
  <div class="content-area">
    <div class="community-page"><!-- ✔ 목록과 동일한 바깥 래퍼 -->
      <div class="community-page-card"><!-- ✔ 목록과 동일한 큰 카드 (max-width 1400 / padding 40px 기준) -->

        <!-- 파라미터 기본값 -->
        <c:set var="idNum" value="${empty param.id ? 1 : param.id}"/>
        <c:set var="pageNum" value="${empty param.page ? 1 : param.page}"/>

        <!-- 기본값 -->
        <c:set var="title" value="지역 사회 협력 프로그램"/>
        <c:set var="date" value="2025-04-01"/>
        <c:url var="thumb" value="/resources/img/community/prog_health_class.jpg"/>
        <c:set var="summary" value="주민 건강 증진과 복지 향상을 위한 다양한 협력 프로그램을 운영합니다."/>
        <c:set var="location" value="본원 · 지역사회"/>
        <c:set var="tags" value="건강강좌, 무료검진, 지역협력"/>

        <!-- id별 예시 매핑 -->
        <c:choose>
          <c:when test="${idNum == 1}">
            <c:set var="title" value="건강 강좌 – 생활습관 개선"/>
            <c:set var="date" value="2025-04-10"/>
            <c:url var="thumb" value="/resources/images/community/card1.jpg"/>
            <c:set var="summary" value="생활습관 개선을 주제로 심뇌혈관 질환 예방 교육을 진행했습니다."/>
            <c:set var="location" value="본원 대강당"/>
            <c:set var="tags" value="건강강좌, 예방, 교육"/>
          </c:when>
          <c:when test="${idNum == 2}">
            <c:set var="title" value="무료 검진 데이"/>
            <c:set var="date" value="2025-04-20"/>
            <c:url var="thumb" value="/resources/images/community/card2.jpg"/>
            <c:set var="summary" value="혈압·혈당·체성분 등 기초 검진과 상담을 제공했습니다."/>
            <c:set var="location" value="지역 복지관"/>
            <c:set var="tags" value="무료검진, 상담, 보건소연계"/>
          </c:when>
          <c:when test="${idNum == 3}">
            <c:set var="title" value="지역 행사 의료지원"/>
            <c:set var="date" value="2025-05-02"/>
            <c:url var="thumb" value="/resources/images/community/card3.jpg"/>
            <c:set var="summary" value="지역 축제 현장에서 응급의료 및 안전지원을 제공했습니다."/>
            <c:set var="location" value="시민공원"/>
            <c:set var="tags" value="응급지원, 안전, 지역행사"/>
          </c:when>
          <c:when test="${idNum == 4}">
            <c:set var="title" value="지역 행사 의료지원"/>
            <c:set var="date" value="2025-04-19"/>
            <c:url var="thumb" value="/resources/images/community/card4.jpg"/>
            <c:set var="summary" value="스트레스 및 우울 자가 관리 프로그램을 제공했습니다."/>
            <c:set var="location" value="시민공원"/>
            <c:set var="tags" value="응급지원, 안전, 지역행사"/>
          </c:when>
          
          <c:when test="${idNum == 5}">
            <c:set var="title" value="지역 행사 의료지원"/>
            <c:set var="date" value="2025-05-02"/>
            <c:url var="thumb" value="/resources/images/community/card5.jpg"/>
            <c:set var="summary" value="건강 마라톤 행사에 구급 인력을 지원 했습니다."/>
            <c:set var="location" value="시민공원"/>
            <c:set var="tags" value="응급지원, 안전, 지역행사"/>
          </c:when>
          
          <c:when test="${idNum == 6}">
            <c:set var="title" value="지역 행사 의료지원"/>
            <c:set var="date" value="2025-05-17"/>
            <c:url var="thumb" value="/resources/images/community/card6.jpg"/>
            <c:set var="summary" value="보건 박람회 부스를 운영하고 CPR 체험을 제공 합니다."/>
            <c:set var="location" value="시민공원"/>
            <c:set var="tags" value="응급지원, 안전, 지역행사"/>
          </c:when>
          
          
          
        </c:choose>

        <!-- 헤더 -->
        <div class="detail-header">
          <div class="thumb-wrap">
            <img src="${thumb}" alt="${title}" />
          </div>
          <div class="meta">
            <h1>${title}</h1>
            <div class="meta-line">
              <span class="date">${date}</span>
              <span class="dot">•</span>
              <span class="loc">${location}</span>
            </div>
            <div class="tags">
              <c:forEach var="t" items="${fn:split(tags, ',')}">
                <span class="tag"><c:out value="${fn:trim(t)}"/></span>
              </c:forEach>
            </div>
            <p class="summary">${summary}</p>
          </div>
        </div>

        <!-- 본문 -->
        <div class="detail-body">
          <!-- 네모 카드(호버) 1: 진행 개요 -->
          <div class="info-card lift">
            <h2>프로그램 개요</h2>
            <p>
              지역과 함께 성장하기 위해 건강 강좌, 무료 검진, 행사 의료지원 등 다양한 협력 프로그램을
              정기적으로 운영합니다.
            </p>
            <ul class="check-list">
              <li>연 4회 이상 정기 건강강좌</li>
              <li>취약계층 대상 무료 검진·상담</li>
              <li>지역 행사 의료/안전 지원</li>
            </ul>
          </div>

          <!-- 네모 카드(호버) 2: 일정/장소 요약 -->
          <div class="info-grid">
            <div class="ibox lift">
              <span class="label">진행일</span>
              <span class="value">${date}</span>
            </div>
            <div class="ibox lift">
              <span class="label">장소</span>
              <span class="value">${location}</span>
            </div>
            <div class="ibox lift">
              <span class="label">담당</span>
              <span class="value">지역협력센터</span>
            </div>
            <div class="ibox lift">
              <span class="label">문의</span>
              <span class="value">02-1234-5678</span>
            </div>
          </div>

        <!-- ✅ 우하단 ‘목록’ 버튼 -->
        <div class="detail-nav only-list">
          <!-- 뒤로가기 우선, 없으면 04_community.do 로 -->
          <a id="btnBackList" class="btn" href="${pageContext.request.contextPath}/04_community.do?page=${pageNum}">목록</a>
        </div>

      </div>
    </div>
  </div>
</div>

<script>
(function(){
  const a = document.getElementById('btnBackList');
  const fallback = '${pageContext.request.contextPath}/04_community.do?page=${pageNum}';
  a.addEventListener('click', function(e){
    // 히스토리 있으면 뒤로가기
    if (document.referrer && document.referrer.indexOf(location.origin) === 0) {
      e.preventDefault();
      history.back();
    }
  });
})();
</script>

</body>
</html>
