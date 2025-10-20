<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>협력의 조회</title>

<!-- 공통 / 페이지 전용 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css">
</head>
<body>

  <h2>협력의사 목록</h2>

  <!-- 검색 영역 -->
  <div class="search-box">
    <form action="<c:url value='/admin/searchCoopUsers.do'/>" method="get" class="inline-form">
      <input type="text" name="keyword" placeholder="이름 또는 병원명 검색" value="${keyword}" />
      <button type="submit" class="btn">검색</button>
    </form>
  </div>

  <!-- 리스트 테이블 -->
  <table class="data-table">
    <thead>
      <tr>
        <th>아이디</th>
        <th>이름</th>
        <th>소속 병원</th>
        <th>전화번호</th>
        <th>이메일</th>
        <th>가입일</th>
        <th>관리</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="user" items="${coopUsers}">
        <tr>
          <td>${user.userId}</td>
          <td>${user.name}</td>
          <td>${user.hospitalName}</td>
          <td>${user.phone}</td>
          <td>${user.email}</td>
          <td><fmt:formatDate value="${user.regDate}" pattern="yyyy-MM-dd"/></td>
          <td>
            <a class="btn-action btn-view"
               href="<c:url value='/admin/coopDetail.do?userId=${user.userId}'/>">상세</a>
            <form action="<c:url value='/admin/deleteCoopUser.do'/>" method="post" class="inline-form">
              <input type="hidden" name="userId" value="${user.userId}">
              <button type="submit" class="btn-action btn-delete"
                onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
            </form>
            
          </td>
        </tr>
      </c:forEach>

      <c:if test="${empty coopUsers}">
        <tr>
          <td colspan="7">데이터가 없습니다.</td>
        </tr>
      </c:if>
    </tbody>
  </table>

  <!-- 페이징 -->
  <div class="pagination">
    <c:if test="${totalPages > 1}">
      <c:forEach var="i" begin="1" end="${totalPages}">
        <c:choose>
          <c:when test="${i == currentPage}">
            <strong>${i}</strong>
          </c:when>
          <c:otherwise>
            <c:choose>
              <c:when test="${not empty keyword}">
                <a href="<c:url value='/admin/searchCoopUsers.do?keyword=${keyword}&page=${i}&size=5'/>">${i}</a>
              </c:when>
              <c:otherwise>
                <a href="<c:url value='/admin/coopList.do?page=${i}&size=5'/>">${i}</a>
              </c:otherwise>
            </c:choose>
          </c:otherwise>
        </c:choose>
      </c:forEach>
    </c:if>
  </div>

</body>
</html>
