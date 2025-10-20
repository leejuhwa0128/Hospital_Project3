<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>ESG 활동 상세</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/esg_detail.css" />
</head>
<body>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<div class="main-container">
  <!-- 좌측 카테고리 -->
  <div class="sidebar">
    <jsp:include page="/WEB-INF/jsp/hospital_info/04_menu.jsp" />
  </div>

  <!-- 콘텐츠 -->
  <div class="content-area">
    <div class="esg-detail-page">
      <div class="esg-detail-card"><!-- ← 바깥 큰 카드 박스 -->


        <!-- 파라미터 기본값 -->
        <c:set var="idNum" value="${empty param.id ? 1 : param.id}"/>

        <!-- 공통 기본값 -->
        <c:set var="title" value="ESG 활동"/>
        <c:set var="date" value="2025-05-01"/>
        <c:url var="thumb" value="/resources/images/esg/env_energy.jpg"/>
        <c:set var="summary" value="지속 가능 경영을 위한 활동을 소개합니다."/>
        <c:set var="location" value="본원 및 지역사회"/>
        <c:set var="tags" value="지속가능경영, 병원ESG, 지역사회"/>
        <c:set var="badgeType" value="env"/> <!-- env | soc | gov -->

        <!-- id별 매핑 (예: 1~3=E, 4~6=S, 7~9=G) -->
        <c:choose>
          <c:when test="${idNum == 1}">
            <c:set var="title" value="병원 에너지 효율화"/>
            <c:set var="date" value="2025-03-20"/>
            <c:url var="thumb" value="/resources/images/esg/env_energy.jpg"/>
            <c:set var="summary" value="고효율 설비 도입과 에너지 모니터링을 통해 전력 사용량을 절감합니다."/>
            <c:set var="location" value="본원 시설 전반"/>
            <c:set var="tags" value="에너지, 고효율, 전력절감"/>
            <c:set var="badgeType" value="env"/>
          </c:when>
          <c:when test="${idNum == 2}">
            <c:set var="title" value="의료폐기물 저감·분리"/>
            <c:set var="date" value="2025-04-02"/>
            <c:url var="thumb" value="/resources/images/esg/env_waste.jpg"/>
            <c:set var="summary" value="배출 표준화와 분리수거 교육으로 폐기물 발생을 최소화합니다."/>
            <c:set var="location" value="전 부서"/>
            <c:set var="tags" value="폐기물, 분리배출, 교육"/>
            <c:set var="badgeType" value="env"/>
          </c:when>
          <c:when test="${idNum == 3}">
            <c:set var="title" value="물 사용 최적화"/>
            <c:set var="date" value="2025-04-18"/>
            <c:url var="thumb" value="/resources/images/esg/env_water.jpg"/>
            <c:set var="summary" value="회수·재활용 시스템으로 물 사용을 효율화합니다."/>
            <c:set var="location" value="시설관리팀"/>
            <c:set var="tags" value="물절약, 재활용, 설비"/>
            <c:set var="badgeType" value="env"/>
          </c:when>

          <c:when test="${idNum == 4}">
            <c:set var="title" value="지역사회 건강증진"/>
            <c:set var="date" value="2025-05-01"/>
            <c:url var="thumb" value="/resources/images/esg/social_volunteer.jpg"/>
            <c:set var="summary" value="무료검진·보건교육으로 지역사회 건강 형평성을 높입니다."/>
            <c:set var="location" value="지역 보건소·복지관"/>
            <c:set var="tags" value="무료검진, 보건교육, 형평성"/>
            <c:set var="badgeType" value="soc"/>
          </c:when>
          <c:when test="${idNum == 5}">
            <c:set var="title" value="직원 복지·안전 강화"/>
            <c:set var="date" value="2025-05-10"/>
            <c:url var="thumb" value="/resources/images/esg/social_staff.jpg"/>
            <c:set var="summary" value="안전교육과 복지 제도를 통해 근무환경을 개선합니다."/>
            <c:set var="location" value="전 부서"/>
            <c:set var="tags" value="안전, 복지, 교육"/>
            <c:set var="badgeType" value="soc"/>
          </c:when>
          <c:when test="${idNum == 6}">
            <c:set var="title" value="다양성·포용성"/>
            <c:set var="date" value="2025-05-16"/>
            <c:url var="thumb" value="/resources/images/esg/social_inclusion.jpg"/>
            <c:set var="summary" value="차별 없는 의료 접근성과 내부 포용 문화를 확산합니다."/>
            <c:set var="location" value="본원 / 협력기관"/>
            <c:set var="tags" value="포용, 다양성, 접근성"/>
            <c:set var="badgeType" value="soc"/>
          </c:when>

          <c:when test="${idNum == 7}">
            <c:set var="title" value="투명한 경영 공개"/>
            <c:set var="date" value="2025-06-01"/>
            <c:url var="thumb" value="/resources/images/esg/gov_transparency.jpg"/>
            <c:set var="summary" value="윤리규범과 감사 결과를 정기적으로 공개합니다."/>
            <c:set var="location" value="경영기획실"/>
            <c:set var="tags" value="투명경영, 윤리, 공시"/>
            <c:set var="badgeType" value="gov"/>
          </c:when>
          <c:when test="${idNum == 8}">
            <c:set var="title" value="환자정보보호"/>
            <c:set var="date" value="2025-06-12"/>
            <c:url var="thumb" value="/resources/images/esg/gov_security.jpg"/>
            <c:set var="summary" value="개인정보 보호 체계를 고도화하고 정기 점검을 시행합니다."/>
            <c:set var="location" value="정보보호팀"/>
            <c:set var="tags" value="보안, 개인정보, 점검"/>
            <c:set var="badgeType" value="gov"/>
          </c:when>
          <c:when test="${idNum == 9}">
            <c:set var="title" value="리스크 관리 체계"/>
            <c:set var="date" value="2025-06-20"/>
            <c:url var="thumb" value="/resources/images/esg/gov_risk.jpg"/>
            <c:set var="summary" value="의료·경영 리스크를 통합 관리하는 체계를 운영합니다."/>
            <c:set var="location" value="리스크관리위원회"/>
            <c:set var="tags" value="통합리스크, 관리체계, 위원회"/>
            <c:set var="badgeType" value="gov"/>
          </c:when>
        </c:choose>

<!-- 헤더 -->
        <div class="detail-header">
          <div class="thumb-wrap">
            <img src="${thumb}" alt="${title}" />
          </div>

          <div class="meta">
            <!-- ✅ 배지를 제목 왼쪽에 붙이는 행 -->
            <div class="title-row">
              <span class="badge ${badgeType}">
                <c:choose>
                  <c:when test="${badgeType == 'env'}">E</c:when>
                  <c:when test="${badgeType == 'soc'}">S</c:when>
                  <c:otherwise>G</c:otherwise>
                </c:choose>
              </span>
              <h1>${title}</h1>
            </div>

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
          <h2>활동 개요</h2>
          <p>
            병원의 핵심 가치인 환자 건강과 안전을 바탕으로, 환경(E), 사회(S), 지배구조(G) 각 영역에서
            지속 가능한 개선 활동을 실행합니다.
          </p>

          <h3>주요 실행 항목</h3>
          <ul class="hover-list">
            <li class="mini-card">성과 측정 지표(KPI) 수립 및 모니터링</li>
            <li class="mini-card">부서별 실행 체크리스트 운영</li>
            <li class="mini-card">내·외부 이해관계자 커뮤니케이션 강화</li>
          </ul>

          <!-- ✅ 섹션 카드 2: 정보 박스 (hover 적용) -->
          <div class="section-card hover-card">
            <div class="info-box">
              <div class="ibox-item">
                <span class="label">진행일</span>
                <span class="value">${date}</span>
              </div>
              <div class="ibox-item">
                <span class="label">장소</span>
                <span class="value">${location}</span>
              </div>
              <div class="ibox-item">
                <span class="label">담당</span>
                <span class="value">ESG 추진단</span>
              </div>
              <div class="ibox-item">
                <span class="label">문의</span>
                <span class="value">02-1234-5678</span>
              </div>
            </div>
          </div>
        </div>

        <!-- ✅ 우하단 ‘목록’ 버튼만 -->
        <div class="detail-nav only-list">
          <a class="btn" href="<c:url value='/hospital_info/esg/list.do'>
                                   <c:param name='page' value='${empty param.page ? 1 : param.page}'/>
                                 </c:url>">목록</a>
        </div>

      </div>
    </div>
  </div>
</div>

</body>
</html>