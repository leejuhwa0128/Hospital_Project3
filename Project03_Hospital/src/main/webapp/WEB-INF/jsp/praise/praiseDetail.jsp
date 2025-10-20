<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><c:out value="${praise.title}"/> - 칭찬릴레이</title>
</head>
<body>

<h1>칭찬릴레이</h1>
<h2><c:out value="${praise.title}"/></h2>

<div>
        <span>작성일: <fmt:formatDate value="${praise.createdAt}" pattern="yyyy.MM.dd HH:mm"/></span> |
    <span>조회수: <c:out value="${praise.viewCount}"/></span>
</div>
<hr>
<div>
    <p><c:out value="${praise.content}" escapeXml="false"/></p>
</div>
<hr>
<button onclick="location.href='/praise/list.do'">목록으로</button>

   

<%-- 로그인한 사용자와 글 작성자가 동일할 때만 버튼 표시 --%>
<c:if test="${loginUser.patientUserId eq praise.patientUserId}">
    <button onclick="location.href='/praise/editForm.do?praiseId=${praise.praiseId}'">수정</button>
    <form action="/praise/delete.do" method="post" style="display:inline;">
        <input type="hidden" name="praiseId" value="${praise.praiseId}">
        <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
    </form>
</c:if>


</body>
</html>