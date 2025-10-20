<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 컨텍스트 경로 먼저 설정 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!-- 헤더 포함 (ctx 이후) -->
<jsp:include page="/WEB-INF/jsp/referral/referral_header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>

<!-- 좌측 사이드바 전용 CSS (수정 페이지와 동일) -->
<link rel="stylesheet" href="${ctx}/resources/css/referral_sidebar.css?v=20250811" />

<style>
/* 페이지 레이아웃 */
.page { max-width:1200px; margin:0 auto; padding:24px 16px 40px;
        display:grid; grid-template-columns:220px 1fr; gap:32px;
        font-family:'맑은 고딕','Malgun Gothic',sans-serif; }
/* 본문 */
.main { min-width:0; }
.page-title { margin:0 0 14px; font-size:22px; font-weight:800;
              border-bottom:2px solid #000; padding-bottom:8px; }
/* 폼 카드 */
.form-card { background:#fff; border:1px solid #e7e7e7; border-radius:12px;
             padding:22px; box-shadow:0 4px 14px rgba(0,0,0,.04); }
.form-grid { display:grid; grid-template-columns:1fr; gap:18px; }
.label { display:flex; align-items:center; gap:6px; font-weight:700; color:#111; margin-bottom:8px; }
.input, .select, .textarea { width:100%; padding:12px 14px; border:1px solid #d9d9d9;
  border-radius:10px; font-size:14px; transition:border-color .15s, box-shadow .15s; background:#fff; color:#111; }
.input:focus, .select:focus, .textarea:focus { outline:none; border-color:#0b57d0; box-shadow:0 0 0 3px rgba(11,87,208,.12); }
.textarea { min-height:200px; line-height:1.6; resize:vertical; }
/* 버튼 */
.btn { appearance:none; border:0; cursor:pointer; border-radius:10px; padding:10px 18px; font-weight:800; }
.btn-primary { background:#0b57d0; color:#fff; }
.btn-primary:hover { background:#0a4dbb; }
/* 반응형 */
@media (max-width:920px) { .page { grid-template-columns:1fr; } }
</style>
</head>
<body>

<div class="page">
  <!-- 좌측 사이드바 -->
  <aside class="ref-sidebar">
    <h3>공지사항</h3>
    <ul class="ref-side-menu">
      <li><a href="${ctx}/referral/referral_notice.do" class="is-active">진료협력센터</a></li>
        <li><a href="${pageContext.request.contextPath}/01_notice/list.do" target="_blank" rel="noopener noreferrer">MEDIPRIME 병원</a></li>
    </ul>
  </aside>

  <!-- 본문 -->
  <main class="main">
    <h1 class="page-title">공지사항 작성</h1>

    <!-- 수정 JSP와 동일한 검증 흐름: novalidate + onsubmit -->
    <form class="form-card" action="${ctx}/referral/insertNotice.do" method="post"
          onsubmit="return submitContents();" novalidate>
      <input type="hidden" name="createdBy" value="${loginUser.userId}" />

      <div class="form-grid">
        <!-- 제목 -->
        <div>
          <label class="label" for="title">제목</label>
          <input id="title" name="title" type="text" class="input" required />
        </div>

        <!-- 내용 (SmartEditor 적용) -->
        <div>
          <label class="label" for="content">내용</label>
          <div id="smarteditor">
            <textarea id="content" name="content" rows="20" cols="20" style="width:700px" required></textarea>
          </div>
        </div>

        <!-- 대상 권한 -->
        <div>
          <label class="label" for="targetRole">대상 권한</label>
          <select id="targetRole" name="targetRole" class="select" required>
            <option value="all">전체</option>
            <option value="doctor">의사</option>
            <option value="coop">협진병원</option>
            <option value="doctor,coop">의사 + 협진병원</option>
          </select>
        </div>

        <!-- 버튼 -->
        <div>
          <button type="submit" class="btn btn-primary">작성 완료</button>
        </div>
      </div>
    </form>
  </main>
</div>

<!-- 푸터 -->
<jsp:include page="/WEB-INF/jsp/referral/referral_footer.jsp" />

<!-- jQuery 먼저 -->
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<!-- SmartEditor 필수 JS -->
<script src="${ctx}/smarteditor/js/lib/jindo2.all.js"></script>
<script src="${ctx}/smarteditor/js/HuskyEZCreator.js"></script>

<!-- SmartEditor 초기화 + 제목/내용 검증 (수정 JSP와 동일 동작) -->
<script>
  let oEditors = [];

  function smartEditor() {
    nhn.husky.EZCreator.createInIFrame({
      oAppRef: oEditors,
      elPlaceHolder: "content",           // textarea id
      sSkinURI: "${ctx}/smarteditor/SmartEditor2Skin.html",
      fCreator: "createSEditor2"
    });
  }

  function submitContents() {
    // 1) 제목 검사
    var $title = document.getElementById('title');
    var t = ($title.value || '').trim();
    if (!t) {
      alert('제목을 입력해주세요.');
      $title.focus();
      return false;
    }

    // 2) 에디터 내용 -> textarea 반영
    if (oEditors.getById && oEditors.getById["content"]) {
      oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
    }

    // 3) 내용 검사
    var $cont = document.getElementById('content');
    var v = ($cont.value || '').trim();
    if (!v) {
      alert('내용을 입력해주세요.');
      return false;
    }
    return true; // 검증 통과 시 제출
  }

  jQuery(function(){ smartEditor(); });
</script>

</body>
</html>
