<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>병원 둘러보기</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

	<div class="max-w-5xl mx-auto px-4 py-12">
		<!-- 제목 -->
		<h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
  병원 둘러보기
</h2>



		<!-- 설명 -->


		<!-- 비디오 플레이어 -->
		<div
			class="aspect-w-16 aspect-h-9 w-full rounded-lg overflow-hidden shadow border border-gray-200">
			<video class="w-full h-full object-cover" autoplay muted loop
				playsinline controls
				poster="${pageContext.request.contextPath}/resources/images/tour_thumbnail.jpg">
				<source
					src="${pageContext.request.contextPath}/resources/video/hospital_intro.mp4"
					type="video/mp4">
				브라우저가 동영상을 지원하지 않습니다.
			</video>
		</div>
		<br>


		<p class="text-gray-700 leading-relaxed mb-8">
			본 병원의 주요 시설 및 진료 환경을 미리 체험해보실 수 있습니다.<br> 아래 영상을 통해 병원의 내부 구조를
			확인해보세요.
		</p>
	</div>

</body>
</html>
