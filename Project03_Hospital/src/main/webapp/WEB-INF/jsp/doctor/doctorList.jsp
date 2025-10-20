<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<html>
<head>
    <title>의료진 소개</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/doctor.css">
   
</head>

<body>
<div class="container">
    
	<br>
    <form action="/doctor/list.do" method="get" class="search-form">
        <input type="text" name="keyword" placeholder="이름 또는 전문분야 검색" value="${keyword}" />
        <button type="submit">검색</button>
    </form>

    <c:if test="${empty doctorList}">
        <div class="no-result">
            찾으시는 의료진 또는 전문분야가 없습니다.
        </div>
    </c:if>

    <div class="doctor-grid">
        <c:forEach var="doc" items="${doctorList}">
            <a href="/doctor/view.do?doctorId=${doc.doctorId}" class="doctor-card">
                <img src="${doc.profileImagePath}" onerror="this.src='/resources/images/default-doctor.png'" />
                <div class="doctor-name"><c:out value="${doc.name}" /></div>
                <div class="doctor-dept badge-dept"><c:out value="${doc.deptName}" /></div>
                <div class="doctor-specialty"><c:out value="${doc.specialty}" /></div>
            </a>
        </c:forEach>
    </div>
</div>
</body>
</html>
