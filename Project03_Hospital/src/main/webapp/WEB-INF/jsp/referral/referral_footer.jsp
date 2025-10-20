<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/referral_layout.css">

<div class="footer-dark">
	<div class="inner">
		<!-- 주소/영문표기/대표번호 -->
		<div class="footer-address">
			<div class="ko">[06251] 서울 강남구 역삼로 120 성보역삼빌딩 2층 MEDIPRIME
				협진병원센터</div>
			<div class="en">(2F, Seongbo Yeoksam Building, 120 Yeoksam-ro,
				Gangnam-gu, Seoul, Republic of Korea 06251)</div>
			<div class="tel">대표전화 : 1588-1588</div>
			<div class="footer-copy">COPYRIGHT (C) MEDIPRIME HOSPITAL</div>
		</div>
	</div>
</div>

<button type="button" id="btnTop" class="back-to-top" aria-label="맨 위로">
	<span class="caret">▲</span><span>TOP</span>
</button>

<script>
(function(){
  var btn = document.getElementById('btnTop');
  function onScroll(){
    if (window.scrollY > 200) btn.style.display = 'flex';
    else btn.style.display = 'none';
  }
  btn.addEventListener('click', function(){ window.scrollTo({top:0, behavior:'smooth'}); });
  document.addEventListener('scroll', onScroll, {passive:true});
  onScroll();
})();
</script>
