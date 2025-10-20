<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/referral/referral_header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진료의뢰&조회 > 신청 상세</title>

<!-- 좌측 사이드바 공통 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/referral_sidebar.css?v=20250811">

<style>
/* 레이아웃 */
body{
  font-family:'맑은 고딕','Malgun Gothic',sans-serif;
  margin:0; padding:0; background:#fff;
}
.main-container{
  display:flex; gap:24px;
  max-width:1200px; margin:0 auto; padding:40px 20px;
}

/* 본문 */
.content{ flex-grow:1; }

/* 상세 카드 */
.detail-container{
  background:#fff;
  border:1px solid var(--line, #e6ebf1);
  border-radius:14px;
  box-shadow:0 8px 24px rgba(0,0,0,.06);
  padding:24px 22px;
}
.detail-container h2{
  text-align:center; font-size:22px; margin:0 0 18px; color:#111;
}

/* 상세 표 */
.detail-table{
  width:100%; border-collapse:separate; border-spacing:0;
  overflow:hidden; border-radius:12px; border:1px solid #eef2f7;
}
.detail-table th, .detail-table td{
  padding:12px 14px; font-size:14px; color:#333; text-align:left;
  border-top:1px solid #f1f4f9;
}
.detail-table tr:first-child th, .detail-table tr:first-child td{ border-top:0; }
.detail-table th{
  width:180px; background:#f6f9ff; font-weight:800; color:#0d1b2a;
}

/* 에디터 영역 간격 */
#smarteditor{ margin-top:18px; }

/* 버튼 */
input[type="submit"]{
  appearance:none; -webkit-appearance:none;
  border:0; border-radius:22px; padding:10px 18px;
  font-weight:800; font-size:13px; cursor:pointer;
  margin-top:14px; margin-right:8px;
  transition:background .15s ease, transform .15s ease, box-shadow .15s ease;
  box-shadow:0 4px 12px rgba(0,0,0,.08);
  background:#316BFF; color:#fff;
}
input[type="submit"]:hover{ transform:translateY(-1px); }
input[type="submit"][value="거절"]{
  background:#e74c3c;
}
input[type="submit"][value="거절"]:hover{
  background:#d03f31;
}

/* 반응형 */
@media (max-width:900px){
  .main-container{ flex-direction:column; }
  .detail-table th{ width:140px; }
}
</style>
</head>
<body>

  <div class="main-container">
    <!-- ✅ 좌측 사이드바 (공통 CSS 적용) -->
    <aside class="ref-sidebar">
      <h3>진료의뢰&조회</h3>
      <ul class="ref-side-menu">
        <li><a href="/referral/referral.do">진료의뢰 안내</a></li>
        <li><a class="is-active" href="/referral/status.do">진료의뢰 신청현황</a></li>
        <li><a href="/referral/statusAll.do">의뢰/회송 환자 결과 조회</a></li>
        <li><a href="/referral/doctor.do">의료진 검색</a></li>
      </ul>
    </aside>

    <!-- ✅ 상세정보 본문 (기능 동일, 스타일만 개선) -->
    <div class="content">
      <div class="detail-container">
        <h2>진료의뢰 상세 정보</h2>

        <table class="detail-table">
          <tr>
            <th>담당의</th>
            <td>${request.doctorName}</td>
          </tr>
          <tr>
            <th>담당병원</th>
            <td>${request.hospitalName}</td>
          </tr>
          <tr>
            <th>환자명</th>
            <td>${request.patientName}</td>
          </tr>
          <tr>
            <th>주민등록번호</th>
            <td>
              <c:choose>
                <c:when test="${not empty request.rrn && fn:length(request.rrn) >= 7}">
                  ${fn:substring(request.rrn, 0, 6)}-*******
                </c:when>
                <c:otherwise>비공개</c:otherwise>
              </c:choose>
            </td>
          </tr>
          <tr>
            <th>진료과</th>
            <td>${request.departmentName}</td>
          </tr>
          <tr>
            <th>협진의</th>
            <td>${request.userName}</td>
          </tr>
          <tr>
            <th>증상</th>
            <td>${request.symptoms}</td>
          </tr>
          <tr>
            <th>협진 사유</th>
            <td>${request.reason}</td>
          </tr>
          <tr>
            <th>희망일</th>
            <td><fmt:formatDate value="${request.hopeDate}" pattern="yyyy-MM-dd"/></td>
          </tr>
        </table>

        <!-- 회신 작성 폼 (기능 변경 없음) -->
        <form action="/referral/insertReply.do" method="post" onsubmit="return submitContents()">
          <input type="hidden" name="requestId" value="${request.requestId}" />
          <input type="hidden" name="actionType" id="actionType" value="작성" />

          <!-- 스마트에디터 영역 -->
          <div id="smarteditor">
            <textarea name="replyContent" id="editorTxt" rows="20" cols="20" placeholder="소견을 입력해주세요." style="width: 700px"></textarea>
          </div>

          <!-- 작성 / 거절 버튼 -->
          <input type="submit" value="작성" onclick="setAction('작성')" />
          <input type="submit" value="거절" onclick="setAction('거절')" />
        </form>
      </div>
    </div>
  </div>

  <%@ include file="/WEB-INF/jsp/referral/referral_footer.jsp"%>

  <!-- ✅ jQuery -->
  <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

  <!-- ✅ jindo (nhn 객체 포함됨) -->
  <script type="text/javascript" src="/smarteditor/js/lib/jindo2.all.js"></script>

  <!-- ✅ SmartEditor 생성기 -->
  <script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js"></script>

  <!-- ✅ SmartEditor 초기화 (원본 로직 그대로) -->
  <script>
    let oEditors = [];
    function smartEditor() {
      console.log("naver smartEditor");
      nhn.husky.EZCreator.createInIFrame({
        oAppRef : oEditors,
        elPlaceHolder : "editorTxt",
        sSkinURI : "/smarteditor/SmartEditor2Skin.html",
        fCreator : "createSEditor2"
      });
    }

    function submitContents() {
      oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
      return true;
    }

    // actionType 설정
    function setAction(type) { document.getElementById("actionType").value = type; }

    function submitContents() {
      oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
      let content = document.getElementById("editorTxt").value;
      if (!content || content.trim() === "") {
        alert("소견 내용을 입력해주세요.");
        return false;
      }
      return true;
    }

    jQuery(document).ready(function(){ smartEditor(); });
  </script>
</body>
</html>
