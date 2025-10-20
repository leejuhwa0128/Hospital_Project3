<%-- /WEB-INF/jsp/praise/praiseEdit.jsp --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>칭찬글 수정</title>
</head>
<body>

<h1>칭찬글 수정</h1>
<form action="/praise/edit.do" method="post">
    <input type="hidden" name="praiseId" value="<c:out value="${praise.praiseId}"/>">
    
    <div>
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" value="<c:out value="${praise.title}"/>" required>
    </div>
    
    <div>
        <label for="content">내용:</label>
        <textarea id="content" name="content" rows="10" required><c:out value="${praise.content}"/></textarea>
    </div>
    
    <div>
        <button type="submit">수정 완료</button>
        <button type="button" onclick="location.href='/praise/detail.do?praiseId=<c:out value="${praise.praiseId}"/>'">취소</button>
    </div>
</form>

</body>
</html>