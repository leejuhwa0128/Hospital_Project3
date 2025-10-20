<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>상담 내역</title>

  <!-- ✅ 공통 스타일 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css?v=2">

  <style>
    /* chip 강제 강조 색상 */
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
    <h2>📨 상담 내역</h2>

    <!-- ✅ 상태 필터 값 -->
    <c:set var="active" value="${empty activeStatus ? param.status : activeStatus}" />

    <!-- ✅ 필터 그룹 -->
    <form method="get" action="${pageContext.request.contextPath}/admin/counselList.do" class="filter-group">
      <button type="submit" name="status" value=""
        class="chip ${empty active ? 'active' : 'chip-gray'}">전체</button>
      <button type="submit" name="status" value="대기"
        class="chip ${active == '대기' ? 'active' : 'chip-gray'}">대기</button>
      <button type="submit" name="status" value="이메일 답변 완료"
        class="chip ${active == '이메일 답변 완료' ? 'active' : 'chip-gray'}">이메일 답변 완료</button>
      <button type="submit" name="status" value="전화 답변 완료"
        class="chip ${active == '전화 답변 완료' ? 'active' : 'chip-gray'}">전화 답변 완료</button>
    </form>

    <!-- ✅ 상담 리스트 테이블 -->
    <div class="board_list">
      <table class="detail-table">
        <thead>
          <tr>
            <th>번호</th>
            <th>신청자</th>
            <th>제목</th>
            <th>상태</th>
            <th>신청일</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty counsels}">
              <tr><td colspan="6" style="text-align: center;">데이터가 없습니다.</td></tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="vo" items="${counsels}" varStatus="st">
                <tr>
                  <td>${st.count}</td>
                  <td><c:out value="${vo.patientName}" /></td>
                  <td class="t_left"><c:out value="${vo.subject}" /></td>
                  <td>
                    <c:choose>
                      <c:when test="${vo.status eq '대기'}">
                        <span class="chip chip-gray">대기</span>
                      </c:when>
                      <c:when test="${vo.status eq '이메일 답변 완료'}">
                        <span class="chip chip-blue">이메일 답변 완료</span>
                      </c:when>
                      <c:when test="${vo.status eq '전화 답변 완료'}">
                        <span class="chip chip-green">전화 답변 완료</span>
                      </c:when>
                      <c:otherwise>
                        <span class="chip chip-gray"><c:out value="${vo.status}" /></span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td><fmt:formatDate value="${vo.createdAt}" pattern="yyyy-MM-dd" /></td>
                  <td>
                    <form class="inline-form"
                          action="${pageContext.request.contextPath}/admin/counsel/detail.do"
                          method="get">
                      <input type="hidden" name="counselId" value="${vo.counselId}" />
                      <button type="submit" class="btn-action btn-view">상세보기</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>

    <!-- ✅ 페이징 필요 시 여기에 -->
    <%-- 
    <div class="pagination">
      <c:forEach var="i" begin="1" end="총 페이지 수">
        <a href="..." class="page-btn ${i == currentPage ? 'active' : ''}">${i}</a>
      </c:forEach>
    </div>
    --%>

  </div>
</body>
</html>
