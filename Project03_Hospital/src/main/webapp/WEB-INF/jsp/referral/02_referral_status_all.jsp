<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/referral/referral_header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진료의뢰&조회 > 진료의뢰 신청현황</title>

<!-- 좌측 사이드바 공통 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/referral_sidebar.css?v=20250811">

<style>
/* 레이아웃 */
.main-container {
	display: flex;
	gap: 24px;
	max-width: 1200px;
	margin: 0 auto;
	padding: 40px 20px;
}

/* 본문 */
.content {
	flex-grow: 1;
}

.title {
	font-size: 28px;
	font-weight: bold;
	color: #000;
	border-bottom: 1px dashed #ccc;
	padding-bottom: 15px;
	margin-bottom: 16px;
}

/* 테이블 상단 컨트롤 */
.table-controls {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 12px;
	margin: 0 0 10px;
}

.table-controls .left {
	display: flex;
	align-items: center;
	gap: 8px;
}

.table-controls label {
	font-size: 13px;
	color: #333;
}

.table-controls select {
	border: 1px solid #dfe5ef;
	border-radius: 8px;
	padding: 6px 8px;
	font-size: 13px;
	background: #fff;
}

.table-controls .right {
	display: flex;
	align-items: center;
	gap: 8px;
}

.table-controls .right .meta {
	font-size: 13px;
	color: #555;
}

.table-controls button {
	background: #fff;
	color: #222;
	border: 1px solid #dfe5ef;
	border-radius: 16px;
	padding: 6px 10px;
	font-size: 12px;
	cursor: pointer;
	transition: background .15s ease;
}

.table-controls button:hover {
	background: #f6f9ff;
}

.table-controls button:disabled {
	opacity: .45;
	cursor: not-allowed;
}

/* 표 래퍼 */
.table-wrap {
	background: #fff;
	border: 1px solid #e6ebf1;
	border-radius: 12px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, .06);
	overflow: auto; /* 작은 화면에서 가로스크롤 */
}

/* 표 스타일 */
.data-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	min-width: 840px; /* 컬럼 많아도 깨지지 않게 */
}

.data-table thead th {
	background: #f6f9ff;
	color: #0d1b2a;
	font-weight: 800;
	font-size: 14px;
	padding: 12px 10px;
	border-bottom: 1px solid #e6ebf1;
	text-align: center;
	white-space: nowrap;
}

.data-table thead th:first-child {
	border-top-left-radius: 12px;
}

.data-table thead th:last-child {
	border-top-right-radius: 12px;
}

.data-table tbody td {
	padding: 12px 10px;
	font-size: 14px;
	color: #333;
	border-top: 1px solid #f0f3f7;
	text-align: center;
}

.data-table tbody tr:hover {
	background: #fafcff;
}

/* 내부 폼/버튼 */
.data-table td form {
	display: inline;
	margin: 0;
}

.data-table td button {
	background: #316BFF;
	color: #fff;
	border: 0;
	border-radius: 18px;
	padding: 8px 14px;
	font-weight: 700;
	font-size: 13px;
	cursor: pointer;
	transition: background .15s ease, transform .15s ease, box-shadow .15s
		ease;
	box-shadow: 0 4px 12px rgba(49, 107, 255, .25);
}

.data-table td button:hover {
	background: #1f50d4;
	transform: translateY(-1px);
}

/* 반응형 */
@media ( max-width : 900px) {
	.main-container {
		flex-direction: column;
	}
	.title {
		font-size: 24px;
	}
	.table-controls {
		flex-wrap: wrap;
		gap: 6px;
	}
}
</style>
</head>
<body>
	<c:if test="${not empty param.msg}">
		<script>alert("${param.msg}");</script>
	</c:if>

	<div class="main-container">
		<!-- ✅ 좌측 사이드바 (공통 CSS 적용) -->
		<aside class="ref-sidebar">
			<h3>진료의뢰&조회</h3>
			<ul class="ref-side-menu">
				<li><a href="/referral/referral.do">진료의뢰 안내</a></li>
				<li><a href="/referral/status.do">진료의뢰 신청현황</a></li>
				<li><a class="is-active" href="/referral/statusAll.do">의뢰/회송 환자 결과 조회</a></li>
				<li><a href="/referral/doctor.do">의료진 검색</a></li>
			</ul>
		</aside>

		<!-- ✅ 본문 콘텐츠 -->
		<div class="content">
			<div class="title">진료의뢰 신청현황</div>

			<!-- ▶ 테이블 상단: 보기개수 & 페이지 이동(프론트 전용) -->
			<div class="table-controls">
				<div class="left">
					<label for="pageSizeSelect">표시 개수</label> <select
						id="pageSizeSelect" aria-label="페이지당 표시 개수">
						<option value="1">1개</option>
						<option value="5">5개</option>
						<option value="10" selected>10개</option>
					</select>
				</div>
				<div class="right">
					<button type="button" id="prevBtn" aria-label="이전 페이지">이전</button>
					<span class="meta" id="pageInfo">1 / 1</span>
					<button type="button" id="nextBtn" aria-label="다음 페이지">다음</button>
				</div>
			</div>

			<div class="table-wrap">
				<table class="data-table" id="statusTable">
					<thead>
						<tr>
							<th>번호</th>
							<th>진료과</th>
							<th>담당의</th>
							<th>요청자</th>
							<th>담당병원</th>
							<th>요청일</th>
							<th>확인</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="request" items="${requests}" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${request.departmentName}</td>
								<td>${request.doctorName}</td>
								<td>${request.userName}</td>
								<td>${request.hospitalName}</td>
								<td><fmt:formatDate value="${request.createdAt}"
										pattern="yyyy-MM-dd" /></td>
								<td><c:choose>
										<c:when test="${request.replyExists}">
											<form action="/referral/02_referral_status_history.do"
												method="get">
												<input type="hidden" name="requestId"
													value="${request.requestId}" />
												<button type="submit">확인</button>
											</form>
										</c:when>
										<c:otherwise>
											<span>미작성</span>
										</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

		</div>
	</div>

	<c:if test="${unauthorized}">
		<script>
      window.onload = function() {
        alert("접근 권한이 없습니다. 협력 병원(coop) 계정으로 로그인해주세요.");
        history.back();
      };
    </script>
	</c:if>

	<%@ include file="/WEB-INF/jsp/referral/referral_footer.jsp"%>

	<!-- ▶ 프론트 전용 페이징 스크립트 (백엔드 변경 없음) -->
	<script>
    (function(){
      const tbody = document.querySelector('#statusTable tbody');
      if (!tbody) return;

      const allRows = Array.from(tbody.querySelectorAll('tr'));
      const total = allRows.length;

      const pageSizeSelect = document.getElementById('pageSizeSelect');
      const prevBtn = document.getElementById('prevBtn');
      const nextBtn = document.getElementById('nextBtn');
      const pageInfo = document.getElementById('pageInfo');
      const countInfo = document.getElementById('countInfo');

      // 이전 선택 유지(선택사항)
      const savedSize = localStorage.getItem('statusPageSize');
      if (savedSize && ['1','5','10'].includes(savedSize)) {
        pageSizeSelect.value = savedSize;
      }

      let pageSize = parseInt(pageSizeSelect.value, 10);
      let currentPage = 1;

      function render(){
        const pageCount = Math.max(1, Math.ceil(total / pageSize));
        if (currentPage > pageCount) currentPage = pageCount;

        const start = (currentPage - 1) * pageSize;
        const end = Math.min(start + pageSize, total);

        // tbody 갱신
        tbody.innerHTML = '';
        const frag = document.createDocumentFragment();
        for (let i = start; i < end; i++) frag.appendChild(allRows[i]);
        tbody.appendChild(frag);

        // 정보/버튼 상태
        pageInfo.textContent = `${currentPage} / ${pageCount}`;
        countInfo.textContent = `총 ${total}건`;
        prevBtn.disabled = (currentPage <= 1);
        nextBtn.disabled = (currentPage >= pageCount);
      }

      pageSizeSelect.addEventListener('change', function(){
        pageSize = parseInt(this.value, 10) || 10;
        localStorage.setItem('statusPageSize', String(pageSize));
        currentPage = 1;
        render();
      });

      prevBtn.addEventListener('click', function(){
        if (currentPage > 1) {
          currentPage--;
          render();
        }
      });

      nextBtn.addEventListener('click', function(){
        const pageCount = Math.max(1, Math.ceil(total / pageSize));
        if (currentPage < pageCount) {
          currentPage++;
          render();
        }
      });

      render();
    })();
  </script>
</body>
</html>
