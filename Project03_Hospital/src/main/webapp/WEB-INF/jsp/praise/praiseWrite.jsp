<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>칭찬글 작성</title>
</head>
<body>

<h1>칭찬글 작성</h1>

<form action="/praise/write.do" method="post">
    <div>
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" required>
    </div>
    <div>
        <label for="content">내용:</label>
        <textarea id="content" name="content" rows="10" cols="50" required></textarea>
    </div>
    <button type="submit">등록</button>
    <button type="button" onclick="history.back()">취소</button>
</form>

</body>
</html>