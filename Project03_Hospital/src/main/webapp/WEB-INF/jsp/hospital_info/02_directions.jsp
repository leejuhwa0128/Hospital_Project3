<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>병원 오시는 길</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_KAKAO_API_KEY&libraries=services"></script>
</head>
<body class="bg-gray-50 text-gray-800">
  <div class="max-w-7xl mx-auto px-4 py-12">
    <div >

      <!-- 타이틀 -->
      <h2 class="text-xl sm:text-2xl font-semibold text-black mb-6 border-b border-gray-200 pb-2">
         병원 오시는 길
      </h2>

      <!-- 지하철 -->
      <section class="mb-8">
        <h3 class="text-lg font-bold text-gray-800 mb-3">지하철 이용안내</h3>
        <ul class="space-y-2 text-sm text-gray-700">
          <li>
            <span class="inline-block bg-green-500 text-white px-2 py-1 rounded text-xs mr-2">2호선</span>
            강남역 4번 출구 도보 5분 (약 381m)
          </li>
          <li>
            <span class="inline-block bg-red-600 text-white px-2 py-1 rounded text-xs mr-2">신분당선</span>
            강남역 4번 출구 도보 5분
          </li>
        </ul>
      </section>

      <!-- 버스 -->
      <section class="mb-8">
        <h3 class="text-lg font-bold text-gray-800 mb-3">버스 이용 안내</h3>
        <ul class="space-y-2 text-sm text-gray-700">
          <li>
            <span class="inline-block bg-blue-600 text-white px-2 py-1 rounded text-xs mr-2">간선</span>
            레미안아파트.파이낸셜뉴스 (22-008, 22-007), 수험서초지점 (22-131)
          </li>
          <li>
            <span class="inline-block bg-red-500 text-white px-2 py-1 rounded text-xs mr-2">직행</span>
            레미안아파트.파이낸셜뉴스 (22-008, 22-007)
          </li>
        </ul>
      </section>

      <!-- 도보 -->
      <section class="mb-8">
        <h3 class="text-lg font-bold text-gray-800 mb-3">도보 안내</h3>
        <p class="text-sm text-gray-700">
          강남역 4번 출구 → 직진 → 역삼초등학교 방향 → <strong>역삼로 120 성보역삼빌딩</strong> 2층
        </p>
      </section>

      <!-- 자가용 -->
      <section class="mb-8">
        <h3 class="text-lg font-bold text-gray-800 mb-3">자가용 이용 안내</h3>
        <p class="text-sm text-gray-700">
          강남대로 → 역삼로 진입 → <strong>성보역삼빌딩</strong> (건물 앞 주차장 30분 무료)
        </p>
      </section>

      <!-- 지도 -->
      <section class="mt-10">
        <div id="map" class="w-full h-96 rounded-lg border"></div>
      </section>

    </div>
  </div>

  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a9e06158c7e549a32c22909270166dd2&autoload=false"></script>
<script>
  kakao.maps.load(function () {
    const container = document.getElementById('map');
    const options = {
    		center: new kakao.maps.LatLng(37.4936151530608, 127.032670618986), // 역삼초
      level: 3
    };
    const map = new kakao.maps.Map(container, options);
    const marker = new kakao.maps.Marker({
      position: options.center,
      map: map
    });
  });
</script>

</body>
</html>
