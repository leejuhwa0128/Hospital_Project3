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

<!-- ✅ 좌측 사이드바 공통 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/referral_sidebar.css?v=20250811">

<style>
/* ===== 레이아웃 ===== */
body{
  font-family:'맑은 고딕','Malgun Gothic',sans-serif;
  margin:0; padding:0; background:#fff;
}
.main-container{
  display:flex; gap:24px;
  max-width:1200px; margin:0 auto; padding:40px 20px;
}

/* ===== 본문 ===== */
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
  border:1px solid #eef2f7; border-radius:12px; overflow:hidden;
}
.detail-table th, .detail-table td{
  padding:12px 14px; font-size:14px; color:#333; text-align:left;
  border-top:1px solid #f1f4f9;
}
.detail-table tr:first-child th, .detail-table tr:first-child td{ border-top:0; }
.detail-table th{
  width:180px; background:#f6f9ff; font-weight:800; color:#0d1b2a;
}

/* 협진의 소견 */
.reply-content{
  margin-top:18px;
  padding:16px;
  border:1px solid #eaeef5;
  background:#fff;
  border-radius:10px;
  min-height:150px;
  line-height:1.7;
  white-space:pre-wrap;
  box-shadow:0 4px 12px rgba(0,0,0,.04);
}

/* 댓글 영역 */
.comment-list{
  margin-top:12px;
  display:grid; gap:12px;
}
.comment-item{
  padding:12px; border:1px solid #eaeef5; border-radius:10px; background:#fdfdfd;
}
.comment-item .comment-content{ margin-top:6px; line-height:1.7; color:#333; }

/* 버튼(댓글용) */
.comment-list .editBtn,
.comment-list .deleteBtn,
.edit-form button{
  appearance:none; -webkit-appearance:none;
  border:1px solid #dfe5ef; background:#fff; color:#222;
  border-radius:18px; padding:6px 12px; font-size:12px; cursor:pointer;
}
.comment-list .editBtn:hover,
.comment-list .deleteBtn:hover,
.edit-form button:hover{ background:#f6f9ff; }
.comment-list .deleteBtn{ border-color:#f4d6d6; }
.comment-list .deleteBtn:hover{ background:#ffecec; }

/* 뒤로가기 버튼 */
.back-btn{ margin-top:24px; text-align:center; }
.back-btn button{
  appearance:none; -webkit-appearance:none;
  padding:10px 20px; font-size:14px; border:0;
  background:#4CAF50; color:#fff; border-radius:22px; cursor:pointer;
  box-shadow:0 4px 12px rgba(0,0,0,.08);
}
.back-btn button:hover{ filter:brightness(.95); }

/* 반응형 */
@media (max-width:900px){
  .main-container{ flex-direction:column; }
  .detail-table th{ width:140px; }
}
</style>
</head>
<body>

<c:if test="${not empty param.msg}">
  <script>alert("${param.msg}");</script>
</c:if>

<div class="main-container">
  <!-- ✅ 좌측 사이드바 (공통 CSS 구조) -->
  <aside class="ref-sidebar">
    <h3>진료의뢰&조회</h3>
    <ul class="ref-side-menu">
      <li><a href="/referral/referral.do">진료의뢰 안내</a></li>
      <li><a class="is-active" href="/referral/status.do">진료의뢰 신청현황</a></li>
      <li><a href="/referral/statusAll.do">의뢰/회송 환자 결과 조회</a></li>
      <li><a href="/referral/doctor.do">의료진 검색</a></li>
    </ul>
  </aside>

  <!-- ✅ 상세정보 본문 (기능 그대로, 스타일만 개선) -->
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

      <!-- ✅ 협진의 소견 -->
      <h3 style="margin-top: 24px;">협진의 소견</h3>
      <div class="reply-content">
        <c:out value="${reply.replyContent}" escapeXml="false" />
      </div>

      <!-- ✅ 댓글 작성 -->
      <h3 style="margin-top: 24px;">댓글</h3>
      <form action="/referral/insertComment.do" method="post" onsubmit="return validateComment()">
        <input type="hidden" name="requestId" value="${request.requestId}" />
        <textarea name="commentText" id="commentContent" rows="5" style="width:100%;" placeholder="댓글을 입력하세요."></textarea>
        <div style="margin-top:10px; text-align:right;">
          <button type="submit" style="padding:10px 20px; font-size:14px; background-color:#2196F3; color:#fff; border:none; border-radius:22px; cursor:pointer;">
            댓글 작성
          </button>
        </div>
      </form>

      <!-- ✅ 기존 댓글 목록 -->
      <h3 style="margin-top: 24px;">작성된 댓글</h3>
      <div class="comment-list">
        <c:choose>
          <c:when test="${not empty comments}">
            <c:forEach var="comment" items="${comments}">
              <div class="comment-item" data-comment-id="${comment.commentId}">
                <!-- 행 상단 -->
                <div style="display:flex; justify-content:space-between; align-items:center;">
                  <div style="font-weight:700;">${comment.doctorName}</div>
                  <div>
                    <button class="editBtn" type="button">수정</button>
                    <button class="deleteBtn" type="button" onclick="deleteComment(${comment.commentId}, ${comment.requestId})">삭제</button>
                  </div>
                </div>

                <!-- 내용 -->
                <div class="comment-content">${comment.commentText}</div>

                <!-- 수정 폼 -->
                <div class="edit-form" style="display:none; margin-top:6px;">
                  <form action="/referral/updateComment.do" method="post">
                    <input type="hidden" name="commentId" value="${comment.commentId}">
                    <input type="hidden" name="requestId" value="${comment.requestId}">
                    <textarea name="commentText" style="width:100%; height:100px;">${comment.commentText}</textarea>
                    <div style="margin-top:6px; display:flex; gap:8px;">
                      <button type="submit">저장</button>
                      <button type="button" class="cancelBtn">취소</button>
                    </div>
                  </form>
                </div>

                <!-- 작성일 -->
                <div style="font-size:12px; color:#888; margin-top:6px;">
                  <fmt:formatDate value="${comment.commentAt}" pattern="yyyy-MM-dd HH:mm" />
                </div>
              </div>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <div style="color:#888;">등록된 댓글이 없습니다.</div>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- ✅ 뒤로가기 -->
      <div class="back-btn">
        <button onclick="history.back()">뒤로가기</button>
      </div>
    </div>
  </div>
</div>

<!-- 스크립트 (기존 로직 유지) -->
<script>
  function validateComment() {
    const content = document.getElementById("commentContent").value.trim();
    if (content === "") {
      alert("댓글 내용을 입력해주세요.");
      return false;
    }
    return true;
  }
  function deleteComment(commentId, requestId) {
    if (confirm("댓글을 삭제하시겠습니까?")) {
      location.href = "/referral/deleteComment.do?commentId=" + commentId + "&requestId=" + requestId;
    }
  }
  var editBtns = document.querySelectorAll('.editBtn');
  for (var i = 0; i < editBtns.length; i++) {
    editBtns[i].addEventListener('click', function () {
      var commentItem = this.closest('.comment-item');
      commentItem.querySelector('.comment-content').style.display = 'none';
      commentItem.querySelector('.edit-form').style.display = 'block';
    });
  }
  var cancelBtns = document.querySelectorAll('.cancelBtn');
  for (var i = 0; i < cancelBtns.length; i++) {
    cancelBtns[i].addEventListener('click', function () {
      var commentItem = this.closest('.comment-item');
      commentItem.querySelector('.comment-content').style.display = 'block';
      commentItem.querySelector('.edit-form').style.display = 'none';
    });
  }
</script>

<%@ include file="/WEB-INF/jsp/referral/referral_footer.jsp"%>
</body>
</html>
