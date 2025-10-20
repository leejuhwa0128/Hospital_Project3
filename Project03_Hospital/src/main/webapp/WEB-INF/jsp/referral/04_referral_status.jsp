<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 컨텍스트 경로 먼저 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!-- 공통 헤더 -->
<jsp:include page="/WEB-INF/jsp/referral/referral_header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>진료협력네트워크 &gt; 협력병원 현황</title>

<!-- 좌측 사이드바 전용 CSS -->
<link rel="stylesheet" href="${ctx}/resources/css/referral_sidebar.css?v=20250811"/>

<style>
/* 페이지 레이아웃 */
.page{
  max-width:1200px; margin:0 auto; padding:24px 16px 64px;
  display:grid; grid-template-columns:220px 1fr; gap:32px;
  font-family:'맑은 고딕','Malgun Gothic',sans-serif;
}

/* 본문 */
.main{min-width:0;}
.breadcrumb{font-size:12px; color:#666; margin-bottom:8px}
.page-title{margin:0 0 14px; font-size:22px; font-weight:800; border-bottom:2px solid #000; padding-bottom:8px}
.lead-card{
  background:#f6fbff; border:1px solid #d9ecff; color:#0b2e4f;
  border-radius:12px; padding:14px; line-height:1.7; margin-bottom:16px;
}

/* 테이블 카드 */
.card{
  background:#fff; border:1px solid #e7e7e7; border-radius:12px;
  padding:0; box-shadow:0 4px 14px rgba(0,0,0,.04);
}
.card-head{
  display:flex; align-items:center; justify-content:space-between;
  padding:14px 16px; border-bottom:1px solid #eee;
}
.card-title{margin:0; font-size:16px; font-weight:800}
.badge{background:#eef3ff; color:#0b57d0; border:1px solid #d9e2ff; padding:4px 10px; border-radius:999px; font-weight:700; font-size:12px}
.table-wrap{overflow-x:auto}

/* 표 */
.table{
  width:100%; border-collapse:collapse; min-width:720px;
}
.table th, .table td{
  padding:12px; border-bottom:1px solid #eee; text-align:center; font-size:14px;
}
.table thead th{
  background:#f7f8fa; font-weight:800; border-bottom:1px solid #e5e7eb;
}
.table tbody tr:hover{background:#fafcff}

/* 링크 */
a.link{color:#0b57d0; text-decoration:none}
a.link:hover{text-decoration:underline}

/* 반응형 */
@media (max-width: 920px){
  .page{grid-template-columns:1fr}
  .page-title{font-size:20px}
}
</style>
</head>
<body>

<div class="page">
  <!-- 왼쪽 사이드바 (referral_sidebar.css 사용) -->
  <aside class="ref-sidebar">
    <h3>진료협력네트워크</h3>
    <ul class="ref-side-menu">
      <li><a href="${ctx}/referral/referral_overview.do">운영개요</a></li>
      <li><a href="${ctx}/referral/referral_status.do" class="is-active">협력병원 현황</a></li>
    </ul>
  </aside>

  <!-- 본문 -->
  <main class="main">
    <div class="breadcrumb">Home &gt; 진료협력네트워크 &gt; 협력병원 현황</div>
    <h1 class="page-title">협력병원 현황</h1>

    <div class="lead-card">
      MEDIPRIME 협진병원과 진료 협력 관계를 맺고 있는 기관 목록입니다.
      지역별 거점 병·의원과의 연계를 통해 신속한 의뢰·회신·회송 체계를 운영합니다.
    </div>

    <section class="card">
      <div class="card-head">
        <h2 class="card-title">협력기관 목록</h2>
        <span class="badge">총 ${fn:length(hospitalList)}곳</span>
      </div>

      <div class="table-wrap">
        <table class="table">
          <thead>
            <tr>
              <th style="width:72px">번호</th>
              <th>병원명</th>
              <th>주소</th>
              <th style="width:140px">전화번호</th>
              <th style="width:200px">링크</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="hospital" items="${hospitalList}" varStatus="st">
              <tr>
                <td>${st.index + 1}</td>
                <td>${hospital.name}</td>
                <td style="text-align:left">${hospital.address}</td>
                <td>
                  <c:choose>
                    <c:when test="${not empty hospital.phone}">
                      <a class="link" href="tel:${hospital.phone}">${hospital.phone}</a>
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${not empty hospital.website}">
                      <a class="link" href="${hospital.website}" target="_blank" rel="noopener noreferrer">
                        방문하기
                      </a>
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty hospitalList}">
              <tr>
                <td colspan="5" style="color:#666; padding:24px">등록된 협력병원이 없습니다.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </section>
  </main>
</div>

<!-- 공통 푸터 -->
<jsp:include page="/WEB-INF/jsp/referral/referral_footer.jsp" />

</body>
</html>
