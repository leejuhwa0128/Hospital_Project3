<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/referral/referral_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항</title>
  <c:set var="ctx" value="${pageContext.request.contextPath}" />
  <link rel="stylesheet" href="${ctx}/resources/css/referral_sidebar.css?v=20250811" />
  <style>
    body { margin:0; padding:0; font-family:'Malgun Gothic', sans-serif; }
    .container { display:flex; gap:24px; max-width:1200px; margin:0 auto; padding:24px 16px; }
    .content { flex:1; }
    .page-header { border-bottom:2px solid #000; padding-bottom:10px; margin-bottom:18px; }
    .page-header h2 { margin:6px 0 0; font-size:20px; color:#000; }
    .path { font-size:12px; color:#666; }
    .page-actions { display:flex; justify-content:flex-end; margin-bottom:12px; }
    .btn-write {
      background:#1e4fff; color:#fff; border:none; border-radius:8px;
      padding:10px 16px; font-weight:700; cursor:pointer; font-size:14px;
    }
    .btn-write:hover { background:#1747e0; }
    .table-controls {
      display:flex; justify-content:space-between; align-items:center;
      flex-wrap:wrap; gap:12px; margin: 10px 0;
    }
    .table-controls .left,
    .table-controls .right { display:flex; align-items:center; gap:8px; }
    .table-controls label { font-size:13px; color:#333; }
    .table-controls select,
    .table-controls input[type="text"] {
      border:1px solid #dfe5ef; border-radius:8px; padding:6px 8px;
      font-size:13px; background:#fff;
    }
    .table-controls .right .meta,
    .total-count { font-size:13px; color:#555; }
    .table-controls button {
      background:#fff; color:#222; border:1px solid #dfe5ef;
      border-radius:16px; padding:6px 10px; font-size:12px; cursor:pointer;
      transition: background .15s ease;
    }
    .table-controls button:hover { background:#f6f9ff; }
    .table-controls button:disabled { opacity:.45; cursor:not-allowed; }
    .table-wrap { width:100%; overflow:auto; border:1px solid #e6e6e6; border-radius:10px; }
    .notice-table { width:100%; border-collapse:collapse; min-width:720px; }
    .notice-table thead th {
      background:#f6f7fb; color:#111; font-weight:800; border-bottom:1px solid #e6e6e6;
      padding:12px 10px; text-align:center;
    }
    .notice-table tbody td {
      border-top:1px solid #f0f0f0; padding:13px 10px;
      text-align:center; vertical-align:middle;
    }
    .notice-table tbody tr:hover { background:#fafbff; }
    .notice-table .col-no{ width:80px; }
    .notice-table .col-date{ width:160px; }
    .notice-table .col-writer{ width:160px; }
    .notice-table .col-title{ text-align:left; }
    .notice-table .col-title a {
      color:#222; text-decoration:none; display:inline-block;
      max-width:100%; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;
    }
    .notice-table .col-title a:hover { text-decoration:underline; }
    .empty { text-align:center; color:#666; padding:40px 10px; }
    @media (max-width:900px){ .container{ flex-direction:column; } }
  </style>
</head>
<body>
  <div class="container">
    <aside class="ref-sidebar">
      <h3>공지사항</h3>
      <ul class="ref-side-menu">
        <li><a href="${ctx}/referral/referral_notice.do" class="is-active">진료협력센터</a></li>
        <li><a href="${ctx}/01_notice/list.do" target="_blank">MEDIPRIME 병원</a></li>
      </ul>
    </aside>
    <main class="content">
      <div class="page-header">
        <div class="path">Home &gt; 공지사항</div>
        <h2>공지사항</h2>
      </div>
      <div class="page-actions">
        <a href="${ctx}/referral/createNoticeForm.do" class="btn-write">+ 작성하기</a>
      </div>
      <div class="table-controls">
        <div class="left">
          <label for="pageSizeSelect">표시 개수</label>
          <select id="pageSizeSelect">
            <option value="1">1개</option>
            <option value="5">5개</option>
            <option value="10" selected>10개</option>
          </select>
        </div>
        <div class="right">
          <input type="text" id="searchInput" placeholder="제목, 작성일, 작성자.." />
          <button id="prevBtn">이전</button>
          <span class="meta" id="pageInfo">1 / 1</span>
          <button id="nextBtn">다음</button>
        </div>
      </div>
      <div class="table-wrap">
        <table class="notice-table" id="noticeTable">
          <thead>
            <tr>
              <th class="col-no">번호</th>
              <th class="col-title">제목</th>
              <th class="col-date">작성일</th>
              <th class="col-writer">작성자</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="notice" items="${notices}" varStatus="st">
              <tr>
                <td class="col-no"><c:out value="${st.index + 1}" /></td>
                <td class="col-title"><a href="${ctx}/referral/noticeDetail.do?noticeId=${notice.noticeId}"><c:out value="${notice.title}" /></a></td>
                <td class="col-date"><fmt:formatDate value="${notice.createdAt}" pattern="yyyy-MM-dd" /></td>
                <td class="col-writer"><c:out value="${notice.createdBy}" /></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </main>
  </div>
<script>
(function(){
  const table = document.getElementById('noticeTable');
  const tbody = table.querySelector('tbody');
  const rows = Array.from(tbody.querySelectorAll('tr'));
  const pageSizeSelect = document.getElementById('pageSizeSelect');
  const searchInput = document.getElementById('searchInput');
  const prevBtn = document.getElementById('prevBtn');
  const nextBtn = document.getElementById('nextBtn');
  const pageInfo = document.getElementById('pageInfo');
  const totalCountEl = document.querySelector('.total-count');

  let currentPage = 1;
  let pageSize = parseInt(pageSizeSelect.value);
  let filteredRows = [...rows];

  function render(){
    const pageCount = Math.max(1, Math.ceil(filteredRows.length / pageSize));
    if (currentPage > pageCount) currentPage = pageCount;
    const start = (currentPage - 1) * pageSize;
    const end = start + pageSize;
    tbody.innerHTML = '';
    const frag = document.createDocumentFragment();
    for(let i = start; i < end && i < filteredRows.length; i++) frag.appendChild(filteredRows[i]);
    tbody.appendChild(frag);
    pageInfo.textContent = `${currentPage} / ${pageCount}`;
    totalCountEl.textContent = `총 ${filteredRows.length}건의 공지사항이 검색되었습니다.`;
    prevBtn.disabled = (currentPage <= 1);
    nextBtn.disabled = (currentPage >= pageCount);
  }

  pageSizeSelect.addEventListener('change', function(){
    pageSize = parseInt(this.value);
    currentPage = 1;
    render();
  });
  searchInput.addEventListener('input', function(){
    const keyword = this.value.toLowerCase();
    filteredRows = rows.filter(row => row.textContent.toLowerCase().includes(keyword));
    currentPage = 1;
    render();
  });
  prevBtn.addEventListener('click', function(){ if (currentPage > 1) { currentPage--; render(); } });
  nextBtn.addEventListener('click', function(){ const max = Math.ceil(filteredRows.length / pageSize); if (currentPage < max) { currentPage++; render(); } });
  render();
})();
</script>
</body>
</html>
<%@ include file="/WEB-INF/jsp/referral/referral_footer.jsp"%>
