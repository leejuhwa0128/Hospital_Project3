<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>병원 연혁</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white text-gray-800">

  <div class="max-w-7xl mx-auto px-4 py-12">
    <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
  병원 연혁
</h2>

    <!-- 연도 탭 -->
    <div class="flex flex-wrap gap-2 mb-10">
      <button class="tab-button active px-4 py-2 text-sm font-medium rounded-md border bg-indigo-800 text-white border-indigo-800 hover:bg-indigo-900 transition"
              data-year="2021~">2021~현재</button>
      <button class="tab-button px-4 py-2 text-sm font-medium rounded-md border border-gray-300 text-gray-700 hover:bg-gray-100 transition"
              data-year="2011~2020">2011~2020</button>
      <button class="tab-button px-4 py-2 text-sm font-medium rounded-md border border-gray-300 text-gray-700 hover:bg-gray-100 transition"
              data-year="2001~2010">2001~2010</button>
      <button class="tab-button px-4 py-2 text-sm font-medium rounded-md border border-gray-300 text-gray-700 hover:bg-gray-100 transition"
              data-year="1968~2000">1968~2000</button>
    </div>

    <!-- 타임라인 카드 전체 -->
    <div class="timeline-wrapper space-y-12">

      <!-- ✅ 2025년 -->
      <div class="year-card" data-year="2021~">
        <h3 class="text-xl font-semibold text-gray-900 mb-4">2025년</h3>
        <div class="border-l-2 border-indigo-800 pl-6 space-y-6">
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">03월 미래의학 연구센터 착공, 비대면 진료 플랫폼 구축 등 진행 중</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">07월 강남구 우수 의료기관 표창, 취약계층 의료비 지원 확대</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">08월 응급의료센터 심정지 대응 시스템 고도화</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">09월 병원 내 약제 자동 분배 시스템 도입</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">12월 서울대학교병원과 진료협력 협약 체결</p></div>
        </div>
      </div>

      <!-- ✅ 2023년 -->
      <div class="year-card" data-year="2021~">
        <h3 class="text-xl font-semibold text-gray-900 mb-4">2023년</h3>
        <div class="border-l-2 border-indigo-800 pl-6 space-y-6">
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">03월 소화기 내시경 장비 전면 교체 완료</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">06월 병원 고객만족도 조사 1위</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">07월 건강검진센터 리뉴얼 및 개인 맞춤형 정밀 검진 프로그램 도입</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">10월 국내 5대 보험사와 협진 계약 체결</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">11월 AI 기반 의료 영상 분석 시스템 도입</p></div>
        </div>
      </div>

      <!-- ✅ 2019년 -->
      <div class="year-card" data-year="2011~2020">
        <h3 class="text-xl font-semibold text-gray-900 mb-4">2019년</h3>
        <div class="border-l-2 border-indigo-800 pl-6 space-y-6">
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">02월 첨단 로봇 수술 시스템 도입</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">05월 최신 심장초음파기기 도입</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">06월 의료서비스 친절도 개선 프로젝트</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">10월 응급의료센터 확장</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">11월 관절센터 특수재활치료실 신설</p></div>
        </div>
      </div>

      <!-- ✅ 2015년 -->
      <div class="year-card" data-year="2011~2020">
        <h3 class="text-xl font-semibold text-gray-900 mb-4">2015년</h3>
        <div class="border-l-2 border-indigo-800 pl-6 space-y-6">
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">03월 병동 리모델링</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">06월 해외 의료진 연수 프로그램 시작</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">08월 간호간병통합서비스 병동 운영</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">10월 자동화 분석 시스템 구축</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">12월 스마트 병원 시스템 1단계 도입</p></div>
        </div>
      </div>

      <!-- ✅ 2007년 -->
      <div class="year-card" data-year="2001~2010">
        <h3 class="text-xl font-semibold text-gray-900 mb-4">2007년</h3>
        <div class="border-l-2 border-indigo-800 pl-6 space-y-6">
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">03월 의료기관 인증평가 획득</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">04월 CT 영상 PACS 구축</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">06월 정형외과 병동 분리 운영</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">09월 암 통합 치료 센터 확장</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">11월 감염관리 프로그램 강화</p></div>
        </div>
      </div>

      <!-- ✅ 2000년 -->
      <div class="year-card" data-year="1968~2000">
        <h3 class="text-xl font-semibold text-gray-900 mb-4">2000년</h3>
        <div class="border-l-2 border-indigo-800 pl-6 space-y-6">
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">07월 주요 진료과 정식 진료 개시</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">08월 전산 시스템 구축</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">10월 MEDIPRIME 병원 개원</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">11월 안내창구 운영 개시</p></div>
          <div class="relative"><div class="absolute -left-3 top-1.5 w-2 h-2 bg-indigo-800 rounded-full"></div><p class="ml-4 text-gray-700">12월 MRI, CT 도입</p></div>
        </div>
      </div>

    </div>
  </div>

  <!-- ✅ 연도 탭 기능 JS -->
  <script>
    const tabs = document.querySelectorAll('.tab-button');
    const cards = document.querySelectorAll('.year-card');

    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        tabs.forEach(t => {
          t.classList.remove('bg-indigo-800', 'text-white', 'border-indigo-800');
          t.classList.add('bg-white', 'text-gray-700', 'border-gray-300');
        });

        tab.classList.remove('bg-white', 'text-gray-700', 'border-gray-300');
        tab.classList.add('bg-indigo-800', 'text-white', 'border-indigo-800');

        const year = tab.dataset.year;
        cards.forEach(card => {
          card.style.display = card.dataset.year === year ? 'block' : 'none';
        });
      });
    });

    window.addEventListener('DOMContentLoaded', () => {
      const activeYear = document.querySelector('.tab-button.active')?.dataset.year;
      cards.forEach(card => {
        card.style.display = card.dataset.year === activeYear ? 'block' : 'none';
      });
    });
  </script>

</body>
</html>
