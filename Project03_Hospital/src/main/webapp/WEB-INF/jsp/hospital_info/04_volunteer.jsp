<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>의료 봉사 활동</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    .modal-open { overflow: hidden; }
  </style>
</head>
<body class="bg-gray-50 text-gray-800">

<div class="max-w-7xl mx-auto px-4 py-12">
<h2 class="text-xl sm:text-2xl font-semibold text-black mb-8 border-b border-gray-200 pb-2">
      의료 봉사 활동
    </h2>

  <!-- 타이틀 -->
  <div class="mb-10 text-center">
    <p class="mt-2 text-gray-600">
      국내외 취약 지역을 대상으로 의료 봉사를 실천하고 있습니다.<br/>
      의료진과 자원봉사자들이 함께 건강한 사회를 만들기 위해 노력하고 있습니다.
    </p>
  </div>

  <!-- 카드 목록 -->
  <div id="cardGrid" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">

    <!-- 카드 반복 -->
    <c:forEach var="i" begin="1" end="12">
      <div class="card bg-white border rounded-lg shadow hover:shadow-md transition">
        <div class="card-thumbnail">
          <img src="<c:url value='/resources/images/volunteer/thumbnail${i}.jpg'/>" alt="썸네일 이미지 ${i}" class="w-full h-40 object-cover rounded-t-lg" />
        </div>
        <div class="p-4">
          <h3 class="text-lg font-semibold text-gray-900">의료 봉사 활동 ${i}</h3>
          <p class="text-sm text-gray-500 mt-1">
            <c:choose>
              <c:when test="${i == 1}">2025-08-01</c:when>
              <c:when test="${i == 2}">2025-08-05</c:when>
              <c:when test="${i == 3}">2025-08-10</c:when>
              <c:when test="${i == 4}">2025-08-12</c:when>
              <c:when test="${i == 5}">2025-08-15</c:when>
              <c:when test="${i == 6}">2025-08-20</c:when>
              <c:when test="${i == 7}">2025-08-25</c:when>
              <c:when test="${i == 8}">2025-08-30</c:when>
              <c:when test="${i == 9}">2025-09-01</c:when>
              <c:when test="${i == 10}">2025-09-05</c:when>
              <c:when test="${i == 11}">2025-09-10</c:when>
              <c:when test="${i == 12}">2025-09-15</c:when>
            </c:choose>
          </p>
          <p class="text-sm text-gray-700 mt-2">
            <c:choose>
              <c:when test="${i == 1}">국내 외진 지역에서 의료 봉사를 진행하며 건강을 나누는 활동입니다.</c:when>
              <c:when test="${i == 2}">봉사자들이 함께 참여한 의료 봉사로 환자들의 치료를 지원하였습니다.</c:when>
              <c:when test="${i == 3}">필요한 의료 장비를 제공하며 봉사 활동을 했습니다.</c:when>
              <c:when test="${i == 4}">원격지의 어린이들에게 의료 서비스를 제공하는 봉사 활동입니다.</c:when>
              <c:when test="${i == 5}">장애인을 위한 무료 건강 검진을 제공한 봉사 활동입니다.</c:when>
              <c:when test="${i == 6}">결핵 환자들을 위한 의료 봉사 및 치료 지원 활동입니다.</c:when>
              <c:when test="${i == 7}">산간 지역으로 가서 직접 진료를 하며 봉사하는 활동입니다.</c:when>
              <c:when test="${i == 8}">응급환자를 위한 의료봉사를 통해 환자들의 생명을 구했습니다.</c:when>
              <c:when test="${i == 9}">무료 건강 검진 및 예방 접종 활동을 진행했습니다.</c:when>
              <c:when test="${i == 10}">장애인을 위한 의료 서비스 및 재활 치료를 제공하는 봉사입니다.</c:when>
              <c:when test="${i == 11}">기초 의료 서비스를 제공하는 봉사활동으로 지역사회를 지원합니다.</c:when>
              <c:when test="${i == 12}">의료 진료와 보건 교육을 병행해 지역의 지속 가능한 건강 개선을 돕습니다.</c:when>
            </c:choose>
          </p>
          <div class="mt-3">
            <!-- 🔽 새창 대신 모달로 오픈 -->
            <a href="#" 
               class="detail-link text-blue-600 hover:underline text-sm font-medium"
               data-id="${i}">상세 보기 →</a>
          </div>
        </div>
      </div>
    </c:forEach>

  </div>

  <!-- 페이지네이션 -->
  <div id="pagination" class="flex justify-center items-center gap-2 mt-10 text-sm font-medium"></div>
</div>

<!-- 모달(오버레이) -->
<div id="detailModal" class="hidden fixed inset-0 z-50 overflow-y-auto">
  <!-- 배경 -->
  <div id="modalBackdrop" class="fixed inset-0 bg-black/50"></div>

  <!-- 다이얼로그: 중앙 정렬 + 여백 -->
  <div class="relative min-h-full flex items-start justify-center p-4 sm:p-6">
    <!-- 컨텐트 박스: 최대 높이 + 내부 스크롤 -->
    <div class="relative w-full max-w-5xl bg-white rounded-xl shadow-lg border border-gray-200 overflow-hidden">
      <div class="flex items-center justify-between px-4 py-3 border-b">
        <strong class="text-gray-900" id="modalTitle">의료 봉사 활동 상세</strong>
        <button id="modalClose"
                class="w-8 h-8 rounded-full hover:bg-gray-100 flex items-center justify-center text-gray-500"
                aria-label="닫기">✕</button>
      </div>

      <!-- 스크롤 가능한 바디 -->
      <div id="modalBody"
           class="modal-scroll px-0">  <!-- 핵심: modal-scroll 클래스 -->
        <div id="modalLoading" class="py-16 text-center text-gray-500">
          불러오는 중...
        </div>
        <div id="modalContent" class="hidden"></div>
      </div>
    </div>
  </div>
</div>


<style>
  /* 모달이 열린 동안 배경 스크롤 잠금 */
  .modal-open { overflow: hidden; }

  /* 모달 내부 컨텐츠 스크롤 가능 */
  .modal-scroll {
    max-height: 80vh;              /* 화면의 80% 높이까지만 */
    overflow-y: auto;              /* 내부 스크롤 */
    -webkit-overflow-scrolling: touch; /* iOS 부드러운 스크롤 */
    overscroll-behavior: contain;  /* 바운스 시 배경 스크롤 방지 */
  }
</style>



<!-- JS: 페이지네이션 + 모달 AJAX -->
<script>
(function () {
  // ========= 페이지네이션 =========
  var cards = Array.prototype.slice.call(document.querySelectorAll('#cardGrid .card'));
  var perPage = 6;
  var totalPages = Math.ceil(cards.length / perPage);

  var params = new URLSearchParams(window.location.search);
  var current = parseInt(params.get('page') || '1', 10);
  if (!isFinite(current) || current < 1) current = 1;
  if (current > totalPages) current = totalPages;

  function renderPager() {
    var start = (current - 1) * perPage;
    var end = start + perPage;

    for (var i = 0; i < cards.length; i++) cards[i].style.display = 'none';
    for (var j = start; j < end && j < cards.length; j++) cards[j].style.display = '';

    var pagEl = document.getElementById('pagination');
    pagEl.innerHTML = '';

    function makeHref(page){ return '?page=' + page; }
    function makeBtn(page, opts){
      var a = document.createElement('a');
      a.href = makeHref(page);
      a.textContent = opts.label;
      a.className = 'px-3 py-1 border rounded ' +
        (opts.active ? 'bg-blue-600 text-white border-blue-600 ' : 'hover:bg-gray-100 ') +
        (opts.disabled ? 'pointer-events-none text-gray-400 ' : '');
      a.addEventListener('click', function(e){
        e.preventDefault();
        if (opts.disabled) return;
        current = page;
        history.replaceState(null, '', makeHref(page));
        renderPager();
        window.scrollTo({ top: 0, behavior: 'auto' });
      });
      return a;
    }

    pagEl.appendChild(makeBtn(current - 1, { label: '«', disabled: current === 1 }));
    for (var p = 1; p <= totalPages; p++) {
      pagEl.appendChild(makeBtn(p, { label: String(p), active: p === current }));
    }
    pagEl.appendChild(makeBtn(current + 1, { label: '»', disabled: current === totalPages }));
  }

  renderPager();

  // ========= 모달 AJAX =========
  var CTX = '${pageContext.request.contextPath}';
  var modal = document.getElementById('detailModal');
  var modalBackdrop = document.getElementById('modalBackdrop');
  var modalClose = document.getElementById('modalClose');
  var modalTitle = document.getElementById('modalTitle');
  var modalLoading = document.getElementById('modalLoading');
  var modalContent = document.getElementById('modalContent');

  function openModal(id) {
    // 초기 상태
    modalTitle.textContent = '의료 봉사 활동 상세 #' + id;
    modalLoading.classList.remove('hidden');
    modalContent.classList.add('hidden');
    modalContent.innerHTML = '';

    // 표시
    modal.classList.remove('hidden');
    document.documentElement.classList.add('modal-open');

    // 데이터 로드
    var url = CTX + '/hospital_info/volunteer/detail.do?id=' + encodeURIComponent(id) + '&embed=1';
    fetch(url, { credentials: 'same-origin' })
      .then(function(res){ return res.text(); })
      .then(function(html){
        modalContent.innerHTML = html;
        modalLoading.classList.add('hidden');
        modalContent.classList.remove('hidden');
      })
      .catch(function(){
        modalLoading.textContent = '불러오는 중 오류가 발생했습니다.';
      });
  }

  function closeModal() {
    modal.classList.add('hidden');
    document.documentElement.classList.remove('modal-open');
    modalContent.innerHTML = '';
  }

  // 이벤트 바인딩(위임)
  document.getElementById('cardGrid').addEventListener('click', function(e){
    var link = e.target.closest('.detail-link');
    if (!link) return;
    e.preventDefault();
    var id = link.getAttribute('data-id');
    if (!id) return;
    openModal(id);
  });

  modalBackdrop.addEventListener('click', closeModal);
  modalClose.addEventListener('click', closeModal);
  document.addEventListener('keydown', function(e){
    if (e.key === 'Escape') closeModal();
  });
})();
</script>

</body>
</html>
