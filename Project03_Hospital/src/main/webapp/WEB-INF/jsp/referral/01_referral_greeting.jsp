<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/referral/referral_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDIPRIME 협진센터장 인사말</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/referral_sidebar.css?v=20250811">

<style>
body{margin:0;padding:0}
.container{
  max-width:1200px; margin:40px auto;
  font-family:'맑은 고딕','Malgun Gothic',sans-serif; color:#000;
  display:flex; gap:24px;
}
.main-content{flex:1; padding:0 6px}
.header{border-bottom:2px solid #000; padding-bottom:10px; margin-bottom:30px}
.header h2{font-size:20px; color:#000; margin:6px 0 0}
.path{font-size:12px; color:#666}
.content{display:flex; gap:30px}
.photo{flex-shrink:0}
.photo img{width:160px; border:1px solid #ddd}
.message{flex:1}
.message h3{font-size:18px; margin:0 0 12px; color:#000}
.message p{font-size:14px; line-height:1.85; margin:0 0 12px}
.message ul{margin:12px 0 0; padding-left:18px}
.message li{font-size:14px; line-height:1.9; margin:4px 0}
.signature{
  text-align:right; font-weight:700; margin-top:26px; font-size:15px; color:#000
}
.signature span{font-family:serif; font-size:16px}

@media (max-width:900px){
  .container{flex-direction:column}
  .content{flex-direction:column}
  .photo img{width:140px}
}
</style>
</head>
<body>
  <div class="container">
    <!-- 좌측 메뉴 (사이드바) -->
    <aside class="ref-sidebar">
      <h3>진료협력센터소개</h3>
      <ul class="ref-side-menu">
        <li><a href="/referral/history.do">개요</a></li>
        <li><a class="is-active" href="/referral/greeting.do">센터장 인사말</a></li>
      </ul>
    </aside>

    <!-- 오른쪽 본문 -->
    <main class="main-content">
      <div class="header">
        <div class="path">Home &gt; 진료협력센터소개 &gt; 센터장 인사말</div>
        <h2>센터장 인사말</h2>
      </div>

      <section class="content">
        <figure class="photo">
          <img src="${pageContext.request.contextPath}/resources/images/centerking.jpg" alt="MEDIPRIME 진료협진센터장 사진">
        </figure>

        <div class="message">
          <h3>MEDIPRIME 협진병원센터 홈페이지를 방문해 주셔서 감사합니다.</h3>

          <p>
            MEDIPRIME 협진병원센터는 전국 협력의료기관과 긴밀한 네트워크를 구축하여
            환자분들께 보다 안전하고 연속성 있는 의료서비스를 제공하고자 합니다.
            저희는 전문성과 신뢰를 바탕으로 <b>환자 중심의 진료</b>를 실현하며,
            의뢰·회송 전 과정에서 파트너 기관과의 원활한 협력을 최우선으로 두고 있습니다.
          </p>

          <p>
            또한, 진료결과 회신 및 정보 연계(EMR/문서 표준화)를 단계적으로 고도화하여
            의뢰기관과의 정보 격차를 줄이고 치료의 일관성과 효율을 높이고 있습니다.
            신속하고 정확한 커뮤니케이션, 치료 경과의 투명한 공유를 통해
            환자 안전과 치료 효과를 향상시키겠습니다.
          </p>

          <ul>
            <li>환자 중심의 협진·회송 체계 확립</li>
            <li>정보 연계 표준화와 품질관리 강화</li>
            <li>신속한 회신과 책임진료 실천</li>
          </ul>

          <p>
            앞으로도 MEDIPRIME 협진병원센터는 협력의료기관과의 상생을 통해
            지역사회 건강 증진에 기여하겠습니다. 지속적인 소통과 신뢰를 바탕으로
            더 나은 의료경험을 만들어 가겠습니다.
          </p>

          <p class="signature">
            MEDIPRIME 진료협진센터장 <span>이기탁 교수</span>
          </p>
        </div>
      </section>
    </main>
  </div>
</body>
</html>

<%@ include file="/WEB-INF/jsp/referral/referral_footer.jsp" %>
