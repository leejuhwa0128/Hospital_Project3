<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>MEDIPRIME 병원 - 병원장 인사말</title>

<!-- Tailwind -->
<script src="https://cdn.tailwindcss.com"></script>

<!-- 서명용 폰트 -->
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap"
	rel="stylesheet">

<style>
.signature {
	font-family: 'Nanum Brush Script', cursive;
}
</style>
</head>

<body class="bg-white text-gray-800">

	<div class="max-w-7xl mx-auto px-4 py-12">
		<div class="grid grid-cols-1 lg:grid-cols-2 gap-10 items-start">

			<!-- 왼쪽 텍스트 -->
			<div class="space-y-8">
				<h3
					class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
					병원장 인사말</h3>


				<p class="text-blue-700 text-lg font-semibold leading-relaxed">
					건강한 사회를 실현하기 위해 끊임없는 혁신과 도전을 이어가며, 환자 여러분의 믿음에 보답하겠습니다.</p>

				<div class="text-gray-700 space-y-4 leading-relaxed">
					<p>
						존경하는 환자분들과 지역 사회 구성원 여러분,<br> MEDIPRIME 병원장 김핑구입니다.
					</p>
					<p>저희 병원은 ‘인류의 건강 증진’이라는 숭고한 목표 아래 설립되었으며, 전문 진료와 따뜻한 공감으로 환자
						중심의 의료 환경을 만들어가고 있습니다.</p>
					<p>최신 의료기술의 도입과 끊임없는 연구, 다학제 협진 시스템을 통해 환자분들께 최적화된 맞춤 진료를
						제공합니다.</p>
					<p>앞으로도 지역 사회와 함께 성장하며, 건강한 삶의 동반자가 될 것을 약속드립니다.</p>
				</div>

				<p class="text-xl mt-6 text-right signature text-gray-800">MEDIPRIME
					병원장 김핑구</p>
			</div>

			<!-- 오른쪽 이미지 -->
			<div class="flex justify-center lg:justify-end">
				<img
					src="${pageContext.request.contextPath}/resources/images/doc_reader.png"
					alt="병원장 김핑구" class="max-w-xs w-full h-auto rounded-md shadow" />
			</div>

		</div>
	</div>

</body>
</html>
