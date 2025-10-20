<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>병원 층별 안내</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    function showFloor(floorId) {
      // 모든 이미지 숨기기
      document.querySelectorAll('.floor-map').forEach(el => el.classList.add('hidden'));
      document.getElementById(floorId).classList.remove('hidden');

      // 버튼 상태 초기화
      document.querySelectorAll('.floor-tab').forEach(btn => btn.classList.remove('bg-blue-600', 'text-white'));
      document.getElementById("btn-" + floorId).classList.add('bg-blue-600', 'text-white');
    }

    window.onload = () => {
      showFloor('floor1'); // 기본값: 1층
    };
  </script>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-7xl mx-auto px-4 py-12">
    <div>
      
      <!-- 타이틀 -->
      <h2 class="text-xl sm:text-2xl font-semibold text-black mb-6 border-b border-gray-200 pb-2">
         층별 시설 안내
      </h2>

      <!-- 탭 버튼 -->
      <div class="flex space-x-2 mb-6">
        <button id="btn-floorB1" onclick="showFloor('floorB1')" class="floor-tab px-4 py-2 border border-gray-300 rounded hover:bg-gray-100 text-sm font-medium">
          B1
        </button>
        <button id="btn-floor1" onclick="showFloor('floor1')" class="floor-tab px-4 py-2 border border-gray-300 rounded hover:bg-gray-100 text-sm font-medium">
          1F
        </button>
        <button id="btn-floor2" onclick="showFloor('floor2')" class="floor-tab px-4 py-2 border border-gray-300 rounded hover:bg-gray-100 text-sm font-medium">
          2F
        </button>
        <button id="btn-floor3" onclick="showFloor('floor3')" class="floor-tab px-4 py-2 border border-gray-300 rounded hover:bg-gray-100 text-sm font-medium">
          3F
        </button>
      </div>

      <!-- 이미지 영역 -->
      <div class="space-y-6">
        <div id="floorB1" class="floor-map hidden">
          <img src="${pageContext.request.contextPath}/resources/images/floor_b1.png" alt="지하 1층 안내도" class="w-full rounded border">
        </div>

        <div id="floor1" class="floor-map hidden">
          <img src="${pageContext.request.contextPath}/resources/images/floor_01.png" alt="1층 안내도" class="w-full rounded border">
        </div>

        <div id="floor2" class="floor-map hidden">
          <img src="${pageContext.request.contextPath}/resources/images/floor_02.png" alt="2층 안내도" class="w-full rounded border">
        </div>

        <div id="floor3" class="floor-map hidden">
          <img src="${pageContext.request.contextPath}/resources/images/floor_03.png" alt="3층 안내도" class="w-full rounded border">
        </div>
      </div>

    </div>
  </div>

</body>
</html>
