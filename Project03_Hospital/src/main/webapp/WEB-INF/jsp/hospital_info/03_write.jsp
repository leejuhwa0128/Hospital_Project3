<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hospital.vo.UserVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String category = request.getParameter("category");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${not empty event ? event.category : category} 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/event_form.css"/>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<div class="main-container">
	<jsp:include page="/WEB-INF/jsp/hospital_info/03_menu.jsp" />

	<div class="content-area">
		<c:set var="isEdit" value="${not empty event}" />
		<h2>${isEdit ? event.category : category} ${isEdit ? '수정' : '글쓰기'}</h2>

		<form action="${pageContext.request.contextPath}${isEdit ? '/info/03_update.do' : '/info/03_write.do'}" method="post">
			<c:if test="${isEdit}">
				<input type="hidden" name="eventId" value="${event.eventId}" />
			</c:if>
			<input type="hidden" name="category" value="${isEdit ? event.category : category}" />

			제목: <input type="text" name="title" value="${isEdit ? event.title : ''}" required /><br/>
			내용: <textarea name="description" rows="10" required>${isEdit ? event.description : ''}</textarea><br/>
			<button type="submit">${isEdit ? '수정' : '등록'}</button>
		</form>
	</div>
</div>

</body>
</html>