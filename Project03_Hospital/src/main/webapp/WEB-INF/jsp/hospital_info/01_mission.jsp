<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>미션 · 비전</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    body {
      font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
    }
  </style>
</head>
<body class="bg-white text-gray-800">

  <div class="max-w-7xl mx-auto px-4 py-12">
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-10 items-start">

      <!-- 왼쪽: 미션/비전 텍스트 -->
      <div class="space-y-10">
        <!-- 미션 -->
        <section>
         <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
   미션 (Mission)
</h2> <br>
         
          <p class="text-blue-700 text-lg font-semibold mb-2">
            최고의 의료 서비스로 환자의 건강과 행복을 최우선으로 생각하며,<br>
            지역 사회의 건강 증진에 기여합니다.
          </p>
          <p class="text-gray-700">
            MEDIPRIME의 존재 이유이자 궁극적인 목표입니다.<br>
            환자 한 분 한 분의 건강과 삶의 질 향상을 위해 모든 역량을 집중하고,<br>
            나아가 지역 주민 전체의 건강 파트너가 되는 것을 사명으로 삼습니다.
          </p>
        </section>

        <!-- 비전 -->
        <section>
         <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
   비전 (Vision)
</h2> <br>
         
          <p class="text-blue-700 text-lg font-semibold mb-2">
            환자 중심의 스마트 의료 시스템을 선도하는 신뢰받는 병원입니다.
          </p>
          <p class="text-gray-700">
            미션을 달성하기 위한 구체적인 미래상입니다.<br>
            최신 기술을 접목한 스마트 의료 시스템을 통해 의료 서비스의 질을 높이고,<br>
            지역 사회로부터 가장 신뢰받는 병원이 되고자 합니다.
          </p>
        </section>
      </div>

      <!-- 오른쪽: 강조 컬럼 -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-1 gap-6">
        <!-- 카드 1 -->
        <div class="bg-gray-50 border border-gray-200 rounded-lg p-6 shadow hover:shadow-md transition">
          <div class="text-4xl mb-3">🧑‍⚕️</div>
          <h3 class="text-lg font-bold text-gray-800 mb-1">환자 중심</h3>
          <p class="text-gray-600 text-sm">의견을 존중하고 최적화된 의료 제공</p>
        </div>

        <!-- 카드 2 -->
        <div class="bg-gray-50 border border-gray-200 rounded-lg p-6 shadow hover:shadow-md transition">
          <div class="text-4xl mb-3">🔬</div>
          <h3 class="text-lg font-bold text-gray-800 mb-1">혁신 기술</h3>
          <p class="text-gray-600 text-sm">최신 기술을 적극 도입하여 스마트 의료 실현</p>
        </div>

        <!-- 카드 3 -->
        <div class="bg-gray-50 border border-gray-200 rounded-lg p-6 shadow hover:shadow-md transition">
          <div class="text-4xl mb-3">🤝</div>
          <h3 class="text-lg font-bold text-gray-800 mb-1">지역 신뢰</h3>
          <p class="text-gray-600 text-sm">정직하고 투명한 진료로 신뢰받는 병원 구축</p>
        </div>
      </div>

    </div>
  </div>

</body>
</html>
