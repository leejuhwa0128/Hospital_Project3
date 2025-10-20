<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp" />

<!-- ✅ 검색창 -->
<div class="max-w-screen-xl mx-auto px-4 sm:px-6 lg:px-8 mt-8">
  <div class="flex justify-end">
    <form action="${pageContext.request.contextPath}/search/result.do" method="get" class="flex items-center">
      <input 
        type="text" 
        name="keyword" 
        value="${searchKeyword}" 
        placeholder="통합 검색..." 
        class="w-full sm:w-96 px-4 py-2 text-sm border border-gray-300 rounded-l-md shadow focus:outline-none focus:ring-2 focus:ring-blue-500"
      />
      <button 
        type="submit" 
        class="px-4 py-2 bg-blue-600 text-white rounded-r-md hover:bg-blue-700 transition">
        🔍
      </button>
    </form>
  </div>
</div>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>병원 메인페이지</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-white text-gray-800 font-sans">

<section class="relative max-w-screen-xl mx-auto mt-8">
    <div id="main-carousel" class="relative overflow-hidden rounded-xl shadow-lg h-[400px]" data-carousel="slide">
        <div class="hidden duration-700 ease-in-out" data-carousel-item>
            <img src="${pageContext.request.contextPath}/resources/images/mainback.png" class="absolute w-full h-full object-cover" />
        </div>
        <div class="hidden duration-700 ease-in-out" data-carousel-item>
            <img src="${pageContext.request.contextPath}/resources/images/banner2.png" class="absolute w-full h-full object-cover" />
        </div>
        <div class="hidden duration-700 ease-in-out" data-carousel-item>
            <img src="${pageContext.request.contextPath}/resources/images/banner3.png" class="absolute w-full h-full object-cover" />
        </div>
        <button type="button" class="absolute top-1/2 left-4 -translate-y-1/2 p-2 bg-white/70 rounded-full shadow" data-carousel-prev>
            <span class="text-xl text-gray-700">&lt;</span>
        </button>
        <button type="button" class="absolute top-1/2 right-4 -translate-y-1/2 p-2 bg-white/70 rounded-full shadow" data-carousel-next>
            <span class="text-xl text-gray-700">&gt;</span>
        </button>
    </div>
</section>

<section class="max-w-screen-xl mx-auto mt-16 px-4">
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
        <a href="${pageContext.request.contextPath}/reservation/fast.do" class="group bg-white rounded-xl shadow hover:shadow-md transition-all p-6 flex flex-col items-start">
            <div class="text-3xl text-blue-600 mb-3 group-hover:scale-110 transition">📅</div>
            <h4 class="text-lg font-semibold">빠른 예약</h4>
            <p class="mt-2 text-sm text-gray-600">쉽고 빠르게 진료 예약을 할 수 있습니다.</p>
        </a>
        <a href="${pageContext.request.contextPath}/department/list.do" class="group bg-white rounded-xl shadow hover:shadow-md transition-all p-6 flex flex-col items-start">
            <div class="text-3xl text-green-600 mb-3 group-hover:scale-110 transition">🏥</div>
            <h4 class="text-lg font-semibold">진료과 검색</h4>
            <p class="mt-2 text-sm text-gray-600">진료과 및 센터를 확인해보세요.</p>
        </a>
        <a href="${pageContext.request.contextPath}/doctor/list.do" class="group bg-white rounded-xl shadow hover:shadow-md transition-all p-6 flex flex-col items-start">
            <div class="text-3xl text-rose-500 mb-3 group-hover:scale-110 transition">👨‍⚕️</div>
            <h4 class="text-lg font-semibold">의료진 검색</h4>
            <p class="mt-2 text-sm text-gray-600">의료진 정보를 간편하게 확인하세요.</p>
        </a>
        <a href="${pageContext.request.contextPath}/reservation/guide.do" class="group bg-white rounded-xl shadow hover:shadow-md transition-all p-6 flex flex-col items-start">
            <div class="text-3xl text-indigo-500 mb-3 group-hover:scale-110 transition">📖</div>
            <h4 class="text-lg font-semibold">진료안내</h4>
            <p class="mt-2 text-sm text-gray-600 leading-snug">진료시간 및 외래 진료 안내<br>☎ 0507-1401-8061</p>
        </a>
    </div>
</section>

<section class="max-w-screen-xl mx-auto mt-20 px-4 grid md:grid-cols-2 gap-8">
    <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
        <div class="flex justify-between items-center border-b pb-3 mb-4">
            <h3 class="text-lg font-bold text-gray-800">📰 언론보도</h3>
            <a href="${pageContext.request.contextPath}/03_press.do" class="text-blue-600 text-sm hover:underline">더보기</a>
        </div>
        <ul class="divide-y text-sm text-gray-700">
            <c:forEach var="press" items="${pressList}">
                <li class="flex justify-between py-2">
                    <a href="${pageContext.request.contextPath}/03_press_view.do?eventId=${press.eventId}" class="hover:text-blue-600 truncate w-3/4">
                        ${press.title}
                    </a>
                    <span class="text-xs text-gray-400 whitespace-nowrap">
                        <fmt:formatDate value="${press.createdAt}" pattern="yyyy-MM-dd" />
                    </span>
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
        <div class="flex justify-between items-center border-b pb-3 mb-4">
            <h3 class="text-lg font-bold text-gray-800">📢 공지사항</h3>
            <a href="${pageContext.request.contextPath}/01_notice/list.do" class="text-blue-600 text-sm hover:underline">더보기</a>
        </div>
        <ul class="divide-y text-sm text-gray-700">
            <c:forEach var="notice" items="${noticeList}">
                <li class="flex justify-between py-2">
                    <a href="${pageContext.request.contextPath}/01_notice/detail.do?noticeId=${notice.noticeId}" class="hover:text-blue-600 truncate w-3/4">
                        ${notice.title}
                    </a>
                    <span class="text-xs text-gray-400 whitespace-nowrap">
                        <fmt:formatDate value="${notice.createdAt}" pattern="yyyy-MM-dd" />
                    </span>
                </li>
            </c:forEach>
        </ul>
    </div>
</section>

<section class="max-w-screen-xl mx-auto mt-24 mb-16 px-4">
    <h3 class="text-2xl font-bold text-gray-800 mb-4 border-b pb-2">위치</h3>
    <div id="categoryBar" class="flex flex-wrap items-center gap-2 mb-3">
        <button data-cat="HOSPITAL" class="cat-btn px-3 py-1.5 rounded-lg border text-sm bg-blue-600 text-white">MEDIPRIME 병원</button>
        <button data-cat="PM9" class="cat-btn px-3 py-1.5 rounded-lg border text-sm hover:bg-gray-100">약국</button>
        <button data-cat="PK6" class="cat-btn px-3 py-1.5 rounded-lg border text-sm hover:bg-gray-100">주차장</button>
        <button data-cat="OL7" class="cat-btn px-3 py-1.5 rounded-lg border text-sm hover:bg-gray-100">주유소</button>
        <div class="ml-auto flex items-center gap-2">
            <label for="radius" class="text-sm text-gray-600">검색 반경</label>
            <select id="radius" class="px-2 py-1.5 rounded-lg border text-sm">
                <option value="300">300m</option>
                <option value="500" selected>500m</option>
                <option value="700">700m</option>
                <option value="1000">1km</option>
            </select>
            <button id="resetBtn" class="px-3 py-1.5 rounded-lg border text-sm hover:bg-gray-100">초기화</button>
        </div>
    </div>
    <div id="map" class="w-full h-96 rounded-xl shadow-md border border-gray-200"></div>
    <p id="resultText" class="mt-2 text-sm text-gray-500"></p>
    <div class="mt-2 flex justify-end">
        <button id="btnDirections"
            class="inline-flex items-center gap-2 px-4 py-2 rounded-full shadow-md border border-gray-200 bg-white hover:bg-gray-50 text-gray-800 text-sm">
            <svg id="chevIcon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" class="transition-transform">
                <path d="M4 6l4 4 4-4" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
            </svg>
            <span>오시는 길 안내</span>
        </button>
    </div>
    <div id="directionsPanel"
        class="hidden mt-3 rounded-lg border border-gray-200 shadow bg-white p-6 text-sm text-gray-700 space-y-8">
        <section>
            <h3 class="text-lg font-bold text-gray-800 mb-3">지하철 이용안내</h3>
            <ul class="space-y-2">
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
        <section>
            <h3 class="text-lg font-bold text-gray-800 mb-3">버스 이용 안내</h3>
            <ul class="space-y-2">
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
        <section>
            <h3 class="text-lg font-bold text-gray-800 mb-3">도보 안내</h3>
            <p>
                강남역 4번 출구 → 직진 → 역삼초등학교 방향 →
                <strong>역삼로 120 성보역삼빌딩</strong> 2층
            </p>
        </section>
        <section>
            <h3 class="text-lg font-bold text-gray-800 mb-3">자가용 이용 안내</h3>
            <p>
                강남대로 → 역삼로 진입 → <strong>성보역삼빌딩</strong> (건물 앞 주차장 30분 무료)
            </p>
        </section>
    </div>
</section>

<script>
    (function () {
        var btn = document.getElementById('btnDirections');
        var panel = document.getElementById('directionsPanel');
        var chev = document.getElementById('chevIcon');
        btn.addEventListener('click', function () {
            if (panel.classList.contains('hidden')) {
                panel.classList.remove('hidden');
                chev.style.transform = 'rotate(180deg)';
            } else {
                panel.classList.add('hidden');
                chev.style.transform = 'rotate(0deg)';
            }
        });
    })();
</script>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a9e06158c7e549a32c22909270166dd2&autoload=false&libraries=services"></script>
<script>
    kakao.maps.load(function () {
        // ===== 기본 설정 =====
        var centerLatLng = new kakao.maps.LatLng(37.4936151530608, 127.032670618986);
        var map = new kakao.maps.Map(document.getElementById('map'), { center: centerLatLng, level: 3 });
        // 병원 마커
        var hospitalMarker = new kakao.maps.Marker({ position: centerLatLng, map: map });
        var hospitalInfo = new kakao.maps.InfoWindow({
            content: '<div style="padding:6px 10px;font-size:12px;"> MEDIPRIME 병원</div>'
        });
        // 호버 시에만 열기
        kakao.maps.event.addListener(hospitalMarker, 'mouseover', function () {
            hospitalInfo.open(map, hospitalMarker);
        });
        kakao.maps.event.addListener(hospitalMarker, 'mouseout', function () {
            hospitalInfo.close();
        });
        // ===== 카테고리 정의 =====
        var categoryMap = {
            'HOSPITAL': { code: 'HP8', label: '해당 병원' },
            'PM9': { code: 'PM9', label: '약국' },
            'PK6': { code: 'PK6', label: '주차장' },
            'OL7': { code: 'OL7', label: '주유소' }
        };
        // ===== 아이콘 SVG(Data URL) =====
        var ICONS = {
            PM9: 'data:image/svg+xml;charset=UTF-8,' +
                encodeURIComponent('<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32">' +
                    '<path d="M16 1C9 1 3.8 6.2 3.8 13.2c0 8.3 8.8 15.1 11.3 17 2.5-1.9 11.3-8.7 11.3-17C26.4 6.2 21.2 1 16 1z" fill="#10b981"/>' +
                    '<rect x="9" y="12" width="14" height="8" rx="2" fill="white"/>' +
                    '<rect x="15" y="10" width="2" height="12" fill="white"/>' +
                    '</svg>'),
            PK6: 'data:image/svg+xml;charset=UTF-8,' +
                encodeURIComponent('<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32">' +
                    '<path d="M16 1C9 1 3.8 6.2 3.8 13.2c0 8.3 8.8 15.1 11.3 17 2.5-1.9 11.3-8.7 11.3-17C26.4 6.2 21.2 1 16 1z" fill="#3b82f6"/>' +
                    '<text x="16" y="19" text-anchor="middle" font-family="Arial" font-size="12" fill="white" font-weight="700">P</text>' +
                    '</svg>'),
            OL7: 'data:image/svg+xml;charset=UTF-8,' +
                encodeURIComponent('<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32">' +
                    '<path d="M16 1C9 1 3.8 6.2 3.8 13.2c0 8.3 8.8 15.1 11.3 17 2.5-1.9 11.3-8.7 11.3-17C26.4 6.2 21.2 1 16 1z" fill="#f59e0b"/>' +
                    '<path d="M11 12h10v8H11z" fill="white"/>' +
                    '<circle cx="13" cy="16" r="1.5" fill="#f59e0b"/>' +
                    '<path d="M21 12l2 3v5h-2z" fill="white"/>' +
                    '</svg>'),
            DEFAULT: 'data:image/svg+xml;charset=UTF-8,' +
                encodeURIComponent('<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32">' +
                    '<path d="M16 1C9 1 3.8 6.2 3.8 13.2c0 8.3 8.8 15.1 11.3 17 2.5-1.9 11.3-8.7 11.3-17C26.4 6.2 21.2 1 16 1z" fill="#ef4444"/>' +
                    '<path d="M12 12h8v8h-8z" fill="white"/>' +
                    '<rect x="15" y="9" width="2" height="14" fill="white"/>' +
                    '</svg>')
        };
        function getMarkerImage(catKey) {
            var src = ICONS[catKey] || ICONS.DEFAULT;
            var size = new kakao.maps.Size(32, 32);
            var options = { offset: new kakao.maps.Point(16, 32) };
            return new kakao.maps.MarkerImage(src, size, options);
        }
        // ===== Places 서비스 =====
        var places = new kakao.maps.services.Places();
        // ===== 마커/오버레이 관리 =====
        var placeMarkers = [];
        var resultText = document.getElementById('resultText');
        function clearPlaceMarkers() {
            for (var i = 0; i < placeMarkers.length; i++) {
                placeMarkers[i].setMap(null);
            }
            placeMarkers = [];
        }
        function buildInfoHTML(place, label) {
            var html = '<div style="padding:8px 10px;max-width:240px;">';
            html += '<div style="font-weight:700;font-size:13px;margin-bottom:4px;">' + (place.place_name || '') + '</div>';
            if (place.road_address_name) {
                html += '<div style="font-size:12px;color:#555;">' + place.road_address_name + '</div>';
            } else if (place.address_name) {
                html += '<div style="font-size:12px;color:#555;">' + place.address_name + '</div>';
            }
            if (place.phone) {
                html += '<div style="font-size:12px;color:#777;margin-top:4px;">' + place.phone + '</div>';
            }
            if (place.place_url) {
                html += '<div style="margin-top:8px;"><a href="' + place.place_url +
                    '" target="_blank" rel="noopener" style="font-size:12px;color:#2563eb;text-decoration:underline;"></a></div>';
            }
            if (label) {
                html += '<div style="margin-top:6px;font-size:11px;color:#6b7280;">' + label + '</div>';
            }
            html += '</div>';
            return html;
        }
        function addPlaceMarker(place, catKey) {
            var pos = new kakao.maps.LatLng(place.y, place.x);
            var marker = new kakao.maps.Marker({
                position: pos,
                map: map,
                image: getMarkerImage(catKey)
            });
            var iw = new kakao.maps.InfoWindow({
                content: buildInfoHTML(place, categoryMap[catKey] ? categoryMap[catKey].label : '')
            });
            // 클릭 시: 새창으로 카카오맵 상세 열기
            kakao.maps.event.addListener(marker, 'click', function () {
                if (place.place_url) {
                    window.open(place.place_url, '_blank', 'noopener');
                }
            });
            // 마우스오버 시 간단 정보 표시, 마우스아웃 시 닫기
            kakao.maps.event.addListener(marker, 'mouseover', function () {
                iw.open(map, marker);
            });
            kakao.maps.event.addListener(marker, 'mouseout', function () {
                iw.close();
            });
            placeMarkers.push(marker);
            return marker;
        }
        function fitToMarkers() {
            if (placeMarkers.length === 0) return;
            var bounds = new kakao.maps.LatLngBounds();
            for (var i = 0; i < placeMarkers.length; i++) {
                bounds.extend(placeMarkers[i].getPosition());
            }
            bounds.extend(centerLatLng);
            map.setBounds(bounds, 20, 20, 20, 20);
        }
        // ===== 카테고리 검색 =====
        function searchCategory(catKey) {
            var radiusEl = document.getElementById('radius');
            var radius = parseInt(radiusEl.value, 10);
            if (isNaN(radius)) radius = 500;
            if (catKey === 'HOSPITAL') {
                clearPlaceMarkers();
                map.setLevel(3);
                map.panTo(centerLatLng);
                return;
            }
            var info = categoryMap[catKey];
            if (!info) return;
            clearPlaceMarkers();
            resultText.textContent = info.label + ' 검색 중…';
            places.categorySearch(info.code, function (data, status) {
                if (status === kakao.maps.services.Status.OK) {
                    for (var i = 0; i < data.length; i++) addPlaceMarker(data[i], catKey);
                    fitToMarkers();
                    resultText.textContent = info.label + ' ' + data.length + '곳을 표시했습니다';
                } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                    resultText.textContent = info.label + ' 결과가 없습니다. 반경을 넓혀보세요.';
                } else {
                    resultText.textContent = '검색 중 오류가 발생했습니다.';
                }
            }, {
                location: centerLatLng,
                radius: radius,
                sort: kakao.maps.services.SortBy.DISTANCE
            });
        }
        // ===== UI 바인딩 =====
        var bar = document.getElementById('categoryBar');
        bar.addEventListener('click', function (e) {
            var btn = e.target.closest('.cat-btn');
            if (!btn) return;
            var all = bar.querySelectorAll('.cat-btn');
            for (var i = 0; i < all.length; i++) {
                all[i].classList.remove('bg-blue-600', 'text-white');
            }
            btn.classList.add('bg-blue-600', 'text-white');
            var catKey = btn.getAttribute('data-cat');
            searchCategory(catKey);
        });
        document.getElementById('radius').addEventListener('change', function () {
            var active = document.querySelector('.cat-btn.bg-blue-600');
            if (active) searchCategory(active.getAttribute('data-cat'));
        });
        document.getElementById('resetBtn').addEventListener('click', function () {
            clearPlaceMarkers();
            map.setLevel(3);
            map.panTo(centerLatLng);
            resultText.textContent = '지도와 마커를 초기화했습니다.';
            var all = bar.querySelectorAll('.cat-btn');
            for (var i = 0; i < all.length; i++) {
                all[i].classList.remove('bg-blue-600', 'text-white');
            }
        });
    });
</script>

<c:if test="${not empty sessionScope.kakaoSignup}">
    <script>
        if (confirm("카카오 회원가입이 완료되었습니다.\n카카오 로그인 회원은 정보를 반드시 수정해 주세요")) {
            window.location.href = "${pageContext.request.contextPath}/user/patientPage.do";
        }
    </script>
    <c:remove var="kakaoSignup" scope="session" />
</c:if>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const input = document.getElementById("menuSearchInput");
    const searchBtn = document.getElementById("menuSearchButton");
    
    // 검색 버튼 클릭 시 폼 제출
    searchBtn.addEventListener("click", (e) => {
        // 폼 제출 방지
        e.preventDefault(); 
        const query = input.value.trim();
        if (query.length < 2) {
            alert("두 글자 이상 입력해 주세요.");
            return;
        }
        
        // 검색 결과를 보여주는 페이지로 이동 (HeaderController의 search.do 호출)
        window.location.href = "${pageContext.request.contextPath}/search/result.do?keyword=" + encodeURIComponent(query);
    });
});
</script>

</body>
</html>
<jsp:include page="/WEB-INF/jsp/footer.jsp" />