<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>협력 병원 목록</title>
  <link rel="stylesheet" href="/css/common.css">
  <link rel="stylesheet" href="/css/partners.css">
</head>
<body>

<div class="section-box hospital-partners">
  <h2>협력 병원 목록</h2>

  <!-- 검색 및 필터 -->
  <div class="filter-box">
    <select id="regionSelect">
      <option value="전체">전체</option>
      <option value="서울특별시">서울특별시</option>
      <option value="경기도">경기도</option>
      <option value="부산광역시">부산광역시</option>
      <option value="대구광역시">대구광역시</option>
      <!-- 필요시 지역 추가 -->
    </select>
    <input type="text" id="searchInput" placeholder="병원명을 입력하세요">
    <button onclick="renderHospitals()">검색</button>
  </div>

  <!-- 병원 목록 -->
  <div class="hospital-list" id="hospitalList"></div>

  <!-- 페이지네이션 -->
  <div class="pagination" id="pagination"></div>
</div>

<!-- ✅ 병원 데이터 & 렌더링 스크립트 -->
<script>
const hospitals = [
  { region: '서울특별시', name: '서울대병원', address: '서울 종로구 대학로 101', phone: '02-2072-2114' },
  { region: '서울특별시', name: '삼성서울병원', address: '서울 강남구 일원로 81', phone: '02-3410-2114' },
  { region: '경기도', name: '분당서울대병원', address: '경기 성남시 분당구 구미로173번길 82', phone: '031-787-1114' },
  { region: '부산광역시', name: '부산대병원', address: '부산 서구 구덕로 179', phone: '051-240-7000' },
  { region: '대구광역시', name: '계명대동산병원', address: '대구 중구 달구벌대로 1035', phone: '053-258-7114' },
  { region: '서울특별시', name: '이화여자대학교서울병원', address: '서울 서대문구 통일로 130', phone: '1522-7000' },
  { region: '서울특별시', name: '서울아산병원', address: '서울 송파구 올림픽로43길 88', phone: '1688-7575' },
  { region: '서울특별시', name: '세브란스병원', address: '서울 서대문구 연세로 50', phone: '1599-1004' },
  { region: '서울특별시', name: '서울성모병원', address: '서울 서초구 반포대로 222', phone: '1588-1511' },
  { region: '서울특별시', name: '한양대병원', address: '서울 성동구 왕십리로 222-1', phone: '02-2290-8114' }
  // 👉 필요한 만큼 추가 가능
];

let currentPage = 1;
const itemsPerPage = 6;

function renderHospitals() {
  const region = document.getElementById('regionSelect').value;
  const keyword = document.getElementById('searchInput').value.trim().toLowerCase();

  const filtered = hospitals.filter(h =>
    (region === '전체' || h.region === region) &&
    h.name.toLowerCase().includes(keyword)
  );

  const start = (currentPage - 1) * itemsPerPage;
  const paginated = filtered.slice(start, start + itemsPerPage);

  const hospitalList = document.getElementById('hospitalList');
  hospitalList.innerHTML = paginated.map(h => `
    <div class="card">
      <h3>${h.name}</h3>
      <p><strong>주소:</strong> ${h.address}</p>
      <p><strong>연락처:</strong> ${h.phone}</p>
    </div>
  `).join('');

  renderPagination(filtered.length);
}

function renderPagination(totalItems) {
  const totalPages = Math.ceil(totalItems / itemsPerPage);
  const pagination = document.getElementById('pagination');
  pagination.innerHTML = '';

  for (let i = 1; i <= totalPages; i++) {
    const btn = document.createElement('button');
    btn.innerText = i;
    btn.className = i === currentPage ? 'active' : '';
    btn.onclick = () => {
      currentPage = i;
      renderHospitals();
    };
    pagination.appendChild(btn);
  }
}

window.onload = () => {
  renderHospitals();
};
</script>

</body>
</html>
