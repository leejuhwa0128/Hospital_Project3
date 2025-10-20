<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/referral/referral_header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!-- 공통 레이아웃 + 좌측 사이드바 전용 CSS -->
<link rel="stylesheet"
	href="${ctx}/resources/css/referral_layout.css?v=20250811">
<link rel="stylesheet"
	href="${ctx}/resources/css/referral_sidebar.css?v=20250811">

<style>
/* 페이지 레이아웃 (좌:220 / 우:유동) */
.page {
	max-width: 1200px;
	margin: 0 auto;
	padding: 24px 16px 40px;
	display: grid;
	grid-template-columns: 220px 1fr;
	gap: 32px;
	font-family: '맑은 고딕', 'Malgun Gothic', sans-serif;
}

/* 본문 공통 */
.main {
	min-width: 0;
}

.breadcrumb {
	font-size: 12px;
	color: #666;
	margin-bottom: 10px
}

.page-title {
	margin: 0 0 14px;
	font-size: 22px;
	font-weight: 800;
	border-bottom: 2px solid #000;
	padding-bottom: 8px
}

/* 상세 카드 */
.detail-card {
	background: #fff;
	border: 1px solid #e7e7e7;
	border-radius: 12px;
	padding: 22px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, .04);
}

.meta {
	display: flex;
	flex-wrap: wrap;
	gap: 10px 16px;
	margin-bottom: 12px
}

.meta .chip {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	padding: 6px 10px;
	border: 1px solid #e5e5e5;
	border-radius: 999px;
	font-size: 12px;
	color: #333;
	background: #fbfbfb
}

.article {
	margin-top: 12px;
	padding-top: 12px;
	border-top: 1px dashed #e5e5e5;
	color: #111;
	font-size: 15px;
	line-height: 1.8;
	white-space: pre-line; /* 줄바꿈 표시 */
}

/* 버튼 영역 */
.actions {
	display: flex;
	gap: 10px;
	justify-content: flex-end;
	margin-top: 18px
}

.btn {
	appearance: none;
	border: 0;
	cursor: pointer;
	border-radius: 10px;
	padding: 10px 16px;
	font-weight: 800;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	text-decoration: none;
	min-width: 110px;
	justify-content: center;
}

.btn-primary {
	background: #0b57d0;
	color: #fff
}

.btn-primary:hover {
	background: #0a4dbb
}

.btn-danger {
	background: #e02424;
	color: #fff
}

.btn-danger:hover {
	background: #c81e1e
}

.btn-ghost {
	background: #f5f6f8;
	color: #111;
	border: 1px solid #e2e5ea
}

.btn-ghost:hover {
	background: #eceff3
}

/* 모바일 */
@media ( max-width :920px) {
	.page {
		grid-template-columns: 1fr
	}
}
.article { word-break: break-word; }
</style>
</head>
<body>

	<div class="page">
		<!-- 좌측 사이드바 (공통 CSS 사용) -->
		<aside class="ref-sidebar">
			<h3>공지사항</h3>
			<ul class="ref-side-menu">
				<li><a href="${ctx}/referral/referral_notice.do"
					class="is-active">진료협력센터</a></li>
			  <li><a href="${pageContext.request.contextPath}/01_notice/list.do" target="_blank" rel="noopener noreferrer">MEDIPRIME 병원</a></li>
			</ul>
		</aside>

		<!-- 본문 -->
		<main class="main">
			<div class="breadcrumb">Home &gt; 공지사항 &gt; 상세</div>
			<h1 class="page-title">
				<c:out value="${notice.title}" />
			</h1>

			<section class="detail-card">
				<div class="meta">
					<span class="chip">작성자 <strong><c:out
								value="${notice.createdBy}" /></strong></span> <span class="chip">작성일 <strong><fmt:formatDate
								value="${notice.createdAt}" pattern="yyyy-MM-dd" /></strong>
					</span>

				</div>
				<div class="article">
					<c:out value="${notice.content}" escapeXml="false" />
				</div>

				<div class="actions">
					<a class="btn btn-ghost" href="${ctx}/referral/referral_notice.do">←
						목록으로</a>
					<button type="button" class="btn btn-primary" onclick="onEdit()">수정하기</button>
					<button type="button" class="btn btn-danger" onclick="onDelete()">삭제</button>
				</div>
			</section>
		</main>
	</div>

	<!-- 삭제용 폼 (POST 권장) -->
	<form id="deleteForm" action="${ctx}/referral/deleteNotice.do"
		method="post" style="display: none">
		<input type="hidden" name="noticeId" value="${notice.noticeId}">
	</form>

	<%@ include file="/WEB-INF/jsp/referral/referral_footer.jsp"%>

	<script>
(function(){
  // 세션 로그인 유저 / 작성자
  const loginUser = "${loginUser != null ? loginUser.userId : ''}";
  const writer    = "${notice.createdBy}";
  const noticeId  = "${notice.noticeId}";
  const ctx       = "${ctx}";

  function isOwner(){ return loginUser && writer && (loginUser === writer); }

  window.onEdit = function(){
    if (!isOwner()){
      showModal("수정이 불가능합니다. 작성자만 수정할 수 있습니다.");
      return;
    }
    location.href = ctx + "/referral/editNoticeForm.do?noticeId=" + encodeURIComponent(noticeId);
  };

  window.onDelete = function(){
    if (!isOwner()){
      showModal("삭제가 불가능합니다. 작성자만 삭제할 수 있습니다.");
      return;
    }
    if (confirm("정말 이 공지사항을 삭제하시겠습니까? 삭제 후에는 되돌릴 수 없습니다.")){
      document.getElementById("deleteForm").submit();
    }
  };

  // 간단 모달
  window.showModal = function(msg){
    const wrap = document.createElement('div');
    wrap.style.cssText = "position:fixed;inset:0;background:rgba(0,0,0,.45);display:flex;align-items:center;justify-content:center;z-index:9999";
    wrap.innerHTML = `
      <div style="background:#fff;padding:20px 22px;border-radius:12px;min-width:260px;box-shadow:0 10px 24px rgba(0,0,0,.18);text-align:center">
        <p style="margin:0 0 14px;font-size:14px;color:#111;line-height:1.6;">${msg}</p>
        <button style="background:#0b57d0;color:#fff;border:0;border-radius:10px;padding:8px 16px;font-weight:800;min-width:100px;cursor:pointer" onclick="this.closest('div').parentNode.remove()">닫기</button>
      </div>`;
    document.body.appendChild(wrap);
  };
})();
</script>

</body>
</html>
