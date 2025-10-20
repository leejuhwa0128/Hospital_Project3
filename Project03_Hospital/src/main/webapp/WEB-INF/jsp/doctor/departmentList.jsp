<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<html>
<head>
    <title>진료과 소개</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/department.css">
</head>

<body>
    <div class="dept-wrapper">
        
		<Br>
        <form action="/doctor/list.do" method="get" class="search-form">
            <input type="text" name="keyword" placeholder="이름 또는 전문분야 검색" value="${keyword}" />
            <button type="submit">검색</button>
        </form>

        <div class="category-title">● 일반 진료과</div>
        <div class="dept-container">
            <c:forEach var="dept" items="${departments}">
                <c:if test="${dept.description ne '내과' and dept.description ne '외과' and not fn:contains('000,001,002,999, D1', dept.deptId)}">
                    <div class="dept-card">
                        <a href="/departmentDetail.do?deptId=${dept.deptId}">
                            <h3><c:out value="${dept.name}" /></h3>
                        </a>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <div class="category-title">● 내과</div>
        <div class="dept-container">
            <c:forEach var="dept" items="${departments}">
                <c:if test="${dept.description eq '내과' and not fn:contains('000,001,002,999, D1', dept.deptId)}">
                    <div class="dept-card">
                        <a href="/departmentDetail.do?deptId=${dept.deptId}">
                            <h3><c:out value="${dept.name}" /></h3>
                        </a>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <div class="category-title">● 외과</div>
        <div class="dept-container">
            <c:forEach var="dept" items="${departments}">
                <c:if test="${dept.description eq '외과' and not fn:contains('000,001,002,999, D1', dept.deptId)}">
                    <div class="dept-card">
                        <a href="/departmentDetail.do?deptId=${dept.deptId}">
                            <h3><c:out value="${dept.name}" /></h3>
                        </a>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</body>
</html>
