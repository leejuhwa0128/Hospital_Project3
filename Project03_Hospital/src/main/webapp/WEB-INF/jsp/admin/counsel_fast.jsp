<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>빠른예약 신청내역</title>

  <!-- 공통 CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css?v=2">

  <style>
    .chip.active {
      background: #4a2d2d !important;
      color: #ffffff !important;
    }

    .chip-gray {
      background: #e5e7eb !important;
      color: #1f2937 !important;
    }

    .chip-gray:hover {
      background: #d1d5db !important;
    }
  </style>
</head>
<body>

<div class="con_wrap bg_13">
  <h2>📋 빠른예약 신청내역</h2>

  <!-- ✅ 필터 버튼 영역 -->
  <c:set var="active" value="${empty activeStatus ? param.status : activeStatus}" />
  <form method="get" action="${pageContext.request.contextPath}/admin/fastReservationList.do" class="filter-group">
    <button type="submit" name="status" value=""
      class="chip ${empty active ? 'active' : 'chip-gray'}">전체</button>
    <button type="submit" name="status" value="대기"
      class="chip ${active == '대기' ? 'active' : 'chip-gray'}">대기</button>
    <button type="submit" name="status" value="완료"
      class="chip ${active == '완료' ? 'active' : 'chip-gray'}">완료</button>
    <button type="submit" name="status" value="보류"
      class="chip ${active == '보류' ? 'active' : 'chip-gray'}">보류</button>
  </form>

  <!-- ✅ 신청 리스트 테이블 -->
  <div class="board_list">
    <table class="detail-table">
      <thead>
        <tr>
          <th>신청번호</th>
          <th>전화번호</th>
          <th>신청일</th>
          <th>상태</th>
          <th>상태 변경</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="vo" items="${fastList}">
          <tr>
            <td>${vo.counselId}</td>
            <td>${vo.phone}</td>
            <td><fmt:formatDate value="${vo.createdAt}" pattern="yyyy-MM-dd HH:mm" /></td>
            <td>
              <c:choose>
                <c:when test="${vo.status == '완료'}"><span class="chip chip-green">완료</span></c:when>
                <c:when test="${vo.status == '대기'}"><span class="chip chip-gray">대기</span></c:when>
                <c:otherwise><span class="chip chip-red">${vo.status}</span></c:otherwise>
              </c:choose>
            </td>
            <td>
              <form action="${pageContext.request.contextPath}/admin/counsel/updateStatus.do" method="post" class="inline-form">
                <input type="hidden" name="counselId" value="${vo.counselId}" />
                <select name="status" style="padding: 4px 6px;">
                  <option value="대기"  ${vo.status == '대기'  ? 'selected' : ''}>대기</option>
                  <option value="완료" ${vo.status == '완료' ? 'selected' : ''}>완료</option>
                  <option value="보류"  ${vo.status == '보류'  ? 'selected' : ''}>보류</option>
                </select>
                <button type="submit" class="btn-action btn-save">적용</button>
              </form>
            </td>
          </tr>
        </c:forEach>

        <c:if test="${empty fastList}">
          <tr>
            <td colspan="5" style="text-align: center;">빠른예약 신청 내역이 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
