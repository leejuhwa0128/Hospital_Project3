<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
  :root{
    --ink:#0f172a; --muted:#64748b; --line:#e2e8f0; --card:#fff;
    --bg:#f8fafc; --primary:#2563eb; --primary-ink:#fff; --shadow:0 8px 24px rgba(15,23,42,.08)
  }
  body{background:var(--bg); font:15px/1.65 system-ui,-apple-system,Segoe UI,Roboto,Arial; color:var(--ink)}
  .qn-wrap{max-width:1040px; margin:24px auto; padding:0 16px}
  .qn-card{background:var(--card); border:1px solid var(--line); border-radius:14px; box-shadow:var(--shadow); overflow:hidden}
  .qn-head{padding:18px 20px; border-bottom:1px solid var(--line)}
  .qn-head h3{margin:0; font-size:18px}
  .grid{display:grid; grid-template-columns:1fr 1fr; gap:16px; padding:18px 20px}
  .row{display:contents}
  .box{border:1px solid var(--line); border-radius:12px; padding:14px 16px; background:#fff}
  .static{background:#f9fafb}
  .static h4{margin:0 0 8px; font-size:15px}
  .static ul{margin:0; padding-left:18px}
  .ta{width:100%; min-height:110px; resize:vertical; border:1px solid var(--line); border-radius:10px; padding:12px 12px; outline:none}
  .ta:focus{box-shadow:0 0 0 4px rgba(37,99,235,.12); border-color:#93c5fd}
  .actions{display:flex; justify-content:center; gap:12px; padding:18px 20px; background:#fbfdff; border-top:1px solid var(--line)}
  .btn{appearance:none; border:0; border-radius:10px; padding:12px 18px; font-weight:700; cursor:pointer}
  .btn-primary{background:var(--primary); color:var(--primary-ink)}
  @media (max-width:900px){ .grid{grid-template-columns:1fr} }
</style>

<div class="qn-wrap">
  <form id="qnForm"
        method="post"
        action="${pageContext.request.contextPath}/questionnaire/save-and-reserve.do"
        onsubmit="return buildQnContent() && (typeof checkQnParams==='function' ? checkQnParams() : true);"
        class="qn-card">

    <div class="qn-head"><h3>문진표 작성</h3></div>

    <!-- 예약 파라미터 (네가 쓰던 이름 유지) -->
    <input type="hidden" name="department"      value="${deptName}">
    <input type="hidden" name="deptId"          value="${deptId}">
    <input type="hidden" name="doctorId"        value="${doctorId}">
    <input type="hidden" name="scheduleId"      value="${scheduleId}">
    <input type="hidden" name="reservationDate" value="${reservationDate}">
    <input type="hidden" name="reservationTime" value="${reservationTime}">
    <input type="hidden" name="status"          value="${status}">
    <!-- 서버에 보낼 최종 본문 -->
    <textarea id="content" name="content" hidden></textarea>

    <div class="grid">
      <!-- 1 -->
      <div class="box static">
        <h4>1) 현재 복용 중인 약</h4>
        <ul>
          <li>처방약</li>
          <li>건강기능식품/한약</li>
        </ul>
      </div>
      <div class="box"><textarea id="ans1" class="ta" placeholder="예) 고혈압약 암로* 5mg 아침 1정, 오메가3 1캡슐"></textarea></div>

      <!-- 2 -->
      <div class="box static">
        <h4>2) 알레르기</h4>
        <ul>
          <li>약물</li><li>음식</li><li>라텍스/기타</li>
          <li>아나필락시스(예/아니오) 및 상세</li>
        </ul>
      </div>
      <div class="box"><textarea id="ans2" class="ta" placeholder="예) 페니실린 발진, 새우 두드러기, 아나필락시스 없음"></textarea></div>

      <!-- 3 -->
      <div class="box static">
        <h4>3) 과거 병력 · 수술 · 입원</h4>
        <ul><li>주요 질환/연도</li><li>수술/입원 내역</li><li>기타</li></ul>
      </div>
      <div class="box"><textarea id="ans3" class="ta" placeholder="예) 당뇨 2020~ / 2023년 담낭절제 수술"></textarea></div>

      <!-- 4 -->
      <div class="box static">
        <h4>4) 가족력</h4>
        <ul><li>고혈압/당뇨/심근경색/뇌졸중/암/정신건강</li><li>기타</li></ul>
      </div>
      <div class="box"><textarea id="ans4" class="ta" placeholder="예) 부: 고혈압, 모: 당뇨"></textarea></div>

      <!-- 5 -->
      <div class="box static">
        <h4>5) 생활습관</h4>
        <ul>
          <li>흡연(현재/과거/비흡연, 일일 개비, 기간)</li>
          <li>음주(빈도/양)</li>
          <li>운동(주 몇 회, 강도)</li>
          <li>수면(평균 시간, 질)</li>
          <li>카페인(종류/일일 섭취량)</li>
        </ul>
      </div>
      <div class="box"><textarea id="ans5" class="ta" placeholder="예) 비흡연 / 주1회 맥주 2캔 / 주3회 걷기 30분 / 6시간 / 아메리카노 1잔"></textarea></div>

      <!-- 6 -->
      <div class="box static">
        <h4>6) 감염/노출</h4>
        <ul>
          <li>최근 2주 발열·기침 등 감기 증상(예/아니오)</li>
          <li>해외/병원 방문(장소/일자)</li>
          <li>확진자/환자 접촉(예/아니오)</li>
        </ul>
      </div>
      <div class="box"><textarea id="ans6" class="ta" placeholder="예) 증상 없음 / 병원 방문 無 / 접촉 無"></textarea></div>

      <!-- 7 -->
      <div class="box static">
        <h4>7) 여성(해당 시)</h4>
        <ul>
          <li>임신 여부/주수</li><li>수유 여부</li>
          <li>마지막 생리일(LMP)</li><li>산부인과 특이사항</li>
        </ul>
      </div>
      <div class="box"><textarea id="ans7" class="ta" placeholder="예) 해당 없음 / 또는 상세 기입"></textarea></div>
    </div>

    <div class="actions">
      <button type="submit" class="btn btn-primary">문진표 저장하기</button>
    </div>
  </form>
</div>

<script>
  // 제출 전에 오른쪽 답변들을 하나의 content 문자열로 합쳐 서버로 보냄
  function buildQnContent(){
    var get = function(id){
      var el = document.getElementById(id);
      return el ? (el.value || "").trim() : "";
    };

    var content =
      "1) 현재 복용 중인 약\n" +
      get('ans1') + "\n\n" +
      "2) 알레르기\n" +
      get('ans2') + "\n\n" +
      "3) 과거 병력 · 수술 · 입원\n" +
      get('ans3') + "\n\n" +
      "4) 가족력\n" +
      get('ans4') + "\n\n" +
      "5) 생활습관\n" +
      get('ans5') + "\n\n" +
      "6) 감염/노출\n" +
      get('ans6') + "\n\n" +
      "7) 여성(해당 시)\n" +
      get('ans7') + "\n";

    document.getElementById('content').value = content;

    // 최소 입력 체크 (전부 공백이면 막기)
    if (!content.replace(/\s/g, '').length) {
      alert('문진 내용을 입력해 주세요.');
      return false;
    }
    return true;
  }
</script>

