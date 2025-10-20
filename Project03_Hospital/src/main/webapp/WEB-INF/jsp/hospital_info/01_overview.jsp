<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>메디프라임병원 - 병원 개요</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    body {
      font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
    }
  </style>
</head>
<body class="bg-white text-gray-800">

  <div class="space-y-12 text-[16px] leading-relaxed">

    <!-- 병원 개요 -->
    <section class="pt-4">
      <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
  병원 개요
</h2>
 <br>
      <p class="text-gray-700 mb-2">
        MEDIPRIME은 환자 중심의 의료 서비스를 제공하며, 지역 사회 건강 증진에 기여하고자 설립되었습니다.
      </p>
      <p class="text-gray-600">
        최첨단 의료 시설과 최고의 의료진을 기반으로, 정확한 진단과 효과적인 치료를 통해
        환자분들의 빠른 회복과 건강한 삶을 되찾아 드리는 데 최선을 다하고 있습니다.
      </p>
    </section>

    <!-- 설립 목적 -->
    <section class="pt-10">
      <h3 class="text-xl font-semibold text-gray-800 mb-4">설립 목적</h3>
      <ul class="space-y-3 list-disc list-inside text-gray-700">
        <li>
          <strong>환자 중심의 의료 실현:</strong>
          환자 한 분 한 분의 의견을 경청하고 존중하며, 맞춤형 치료 계획을 통해 최상의 의료 경험을 제공합니다.
        </li>
        <li>
          <strong>최고 수준의 의료 서비스 제공:</strong>
          숙련된 의료진과 첨단 의료 장비를 도입하여, 질 높은 진료와 안전한 치료 환경을 구축합니다.
        </li>
        <li>
          <strong>지역 사회 건강 증진 기여:</strong>
          예방, 치료, 재활에 이르는 전반적인 의료 서비스를 제공하며 건강 교육과 캠페인을 운영합니다.
        </li>
        <li>
          <strong>연구와 혁신을 통한 의료 발전:</strong>
          끊임없는 연구와 기술 개발로 의료 서비스 질을 향상시키고 미래 의학 발전에 기여합니다.
        </li>
      </ul>
    </section>

    <!-- 주요 기능 -->
    <section class="pt-10">
      <h3 class="text-xl font-semibold text-gray-800 mb-6">주요 기능</h3>
      <div class="grid grid-cols-2 sm:grid-cols-3 gap-6 text-center">
        <div class="p-4 bg-gray-100 rounded-lg">
          <div class="text-3xl mb-2">🩺</div>
          <p class="font-medium text-gray-700">전문 진료과 운영</p>
        </div>
        <div class="p-4 bg-gray-100 rounded-lg">
          <div class="text-3xl mb-2">🔬</div>
          <p class="font-medium text-gray-700">종합 검진 센터</p>
        </div>
        <div class="p-4 bg-gray-100 rounded-lg">
          <div class="text-3xl mb-2">🚑</div>
          <p class="font-medium text-gray-700">응급 의료 시스템</p>
        </div>
        <div class="p-4 bg-gray-100 rounded-lg">
          <div class="text-3xl mb-2">🏥</div>
          <p class="font-medium text-gray-700">최첨단 의료 장비</p>
        </div>
        <div class="p-4 bg-gray-100 rounded-lg">
          <div class="text-3xl mb-2">🧘‍♂️</div>
          <p class="font-medium text-gray-700">재활 치료 및 물리치료</p>
        </div>
        <div class="p-4 bg-gray-100 rounded-lg">
          <div class="text-3xl mb-2">💪</div>
          <p class="font-medium text-gray-700">건강 증진 프로그램</p>
        </div>
      </div>
    </section>

  </div>

</body>
</html>
