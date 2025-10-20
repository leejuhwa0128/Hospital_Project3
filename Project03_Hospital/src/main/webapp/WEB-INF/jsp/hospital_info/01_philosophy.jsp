<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>진료과 운영 철학</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <style>
    /* 모달 애니메이션 */
    .modal-overlay {
      display: none;
    }
    .modal-overlay.show {
      display: flex;
    }
  </style>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-6xl mx-auto px-4 py-12">
    <!-- 타이틀 -->
    <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-6 border-b border-gray-200 pb-2">
  진료과 운영 철학
</h2>
<p class="text-gray-700 mb-10">
      MEDIPRIME의 모든 진료과는 환자 중심의 가치를 최우선으로 삼아 운영됩니다.
    </p>

    <!-- 카드 그리드 -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
      <div class="bg-white rounded-lg shadow border border-gray-200 p-6 cursor-pointer hover:shadow-md transition" onclick="openModal(0)">
        <i class="fas fa-user-md text-indigo-600 text-3xl mb-3"></i>
        <h3 class="text-lg font-semibold mb-2">환자 중심의 맞춤형 진료</h3>
        <p class="text-sm text-gray-600">모든 진료의 시작은 환자 존중에서 시작</p>
      </div>

      <div class="bg-white rounded-lg shadow border border-gray-200 p-6 cursor-pointer hover:shadow-md transition" onclick="openModal(1)">
        <i class="fas fa-flask text-purple-600 text-3xl mb-3"></i>
        <h3 class="text-lg font-semibold mb-2">최고의 전문성과 끊임없는 연구</h3>
        <p class="text-sm text-gray-600">각 진료과는 해당 분야의 최고 전문성을 갖춘 의료진으로 구성</p>
      </div>

      <div class="bg-white rounded-lg shadow border border-gray-200 p-6 cursor-pointer hover:shadow-md transition" onclick="openModal(2)">
        <i class="fas fa-stethoscope text-green-600 text-3xl mb-3"></i>
        <h3 class="text-lg font-semibold mb-2">다학제적 협진을 통한 통합 의료</h3>
        <p class="text-sm text-gray-600">진료과 간 긴밀한 협력을 통해 복합적인 질환에 효과적인 통합 진료를 제공</p>
      </div>

      <div class="bg-white rounded-lg shadow border border-gray-200 p-6 cursor-pointer hover:shadow-md transition" onclick="openModal(3)">
        <i class="fas fa-heartbeat text-red-600 text-3xl mb-3"></i>
        <h3 class="text-lg font-semibold mb-2">예방과 건강 증진을 위한 노력</h3>
        <p class="text-sm text-gray-600">정기 검진과 건강 교육을 통해 삶의 질을 향상</p>
      </div>

      <div class="bg-white rounded-lg shadow border border-gray-200 p-6 cursor-pointer hover:shadow-md transition" onclick="openModal(4)">
        <i class="fas fa-hospital text-gray-600 text-3xl mb-3"></i>
        <h3 class="text-lg font-semibold mb-2">안전하고 쾌적한 진료 환경 조성</h3>
        <p class="text-sm text-gray-600">감염 예방과 최신 장비 관리를 통해 안전한 진료 환경을 유지</p>
      </div>
    </div>
  </div>

  <!-- ✅ 모달 -->
  <div id="modal" class="modal-overlay fixed inset-0 bg-black bg-opacity-50 z-50 items-center justify-center">
    <div class="bg-white rounded-lg shadow-lg max-w-md w-full mx-4">
      <div class="flex justify-between items-center px-6 py-4 border-b">
        <h3 id="modal-title" class="text-lg font-semibold text-gray-800">제목</h3>
        <button onclick="closeModal()" class="text-gray-400 hover:text-gray-700 text-xl font-bold">&times;</button>
      </div>
      <div class="p-6 text-gray-700 text-sm leading-relaxed" id="modal-description">
        내용
      </div>
    </div>
  </div>

  <!-- ✅ JS -->
  <script>
    const data = [
      {
        title: '환자 중심의 맞춤형 진료',
        desc: '모든 진료의 시작은 환자 존중에서 시작'
      },
      {
        title: '최고의 전문성과 끊임없는 연구',
        desc: '각 진료과는 해당 분야의 최고 전문성을 갖춘 의료진으로 구성'
      },
      {
        title: '다학제적 협진을 통한 통합 의료',
        desc: '진료과 간 긴밀한 협력을 통해 복합적인 질환에 효과적인 통합 진료를 제공'
      },
      {
        title: '예방과 건강 증진을 위한 노력',
        desc: '정기 검진과 건강 교육을 통해 질병의 조기 발견과 예방에 힘쓰며, 건강한 삶을 영위하도록 지원'
      },
      {
        title: '안전하고 쾌적한 진료 환경 조성',
        desc: '쾌적하고 청결한 환경 속에서 감염 예방과 최신 장비 관리를 통해 안전한 진료 환경을 유지'
      }
    ];

    function openModal(index) {
      document.getElementById('modal-title').innerText = data[index].title;
      document.getElementById('modal-description').innerText = data[index].desc;
      document.getElementById('modal').classList.add('show');
    }

    function closeModal() {
      document.getElementById('modal').classList.remove('show');
    }
  </script>
</body>
</html>
