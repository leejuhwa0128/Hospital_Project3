<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<html>
<head>
    <title>${doctor.name} 상세정보</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/doctor_detail.css">
</head>

<body>
<div class="container">
  


    <!-- 프로필 -->
    <div class="profile-section">
        <img src="${doctor.profileImagePath}" alt="의사 사진"
             onerror="this.src='/resources/images/default-doctor.png'"
             class="profile-img" />
        <div class="profile-info">
            <h2><c:out value="${doctor.name}" /></h2>
            <p><span class="label">전문분야: </span>
                <span class="doctor-specialty"><c:out value="${doctor.specialty}" /></span></p>
        </div>
    </div>

    <!-- 자기소개 -->
    <div class="title">자기소개</div>
    <div class="bio"><c:out value="${doctor.bio}" /></div>

    <!-- 시간표 -->
    <div class="title">진료시간표</div>
    <table class="schedule-table">
        <thead>
        <tr>
            <th>진료시간</th>
            <th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>오전</td>
            <c:forEach var="day" items="${days}">
                <c:set var="key" value="${day}_오전" />
                <td>
                    <c:choose>
                        <c:when test="${not empty scheduleMap[key]}">
                            <span class="note-${scheduleMap[key]}"><c:out value="${scheduleMap[key]}" /></span>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
            </c:forEach>
        </tr>
        <tr>
            <td>오후</td>
            <c:forEach var="day" items="${days}">
                <c:set var="key" value="${day}_오후" />
                <td>
                    <c:choose>
                        <c:when test="${not empty scheduleMap[key]}">
                            <span class="note-${scheduleMap[key]}"><c:out value="${scheduleMap[key]}" /></span>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
            </c:forEach>
        </tr>
        </tbody>
    </table>

    <!-- 예약 버튼 -->
    <div class="btn-center">
        <a href="#" class="btn-reserve">예약하기</a>
    </div>

    <!-- 뒤로가기 -->
    <div class="btn-center">
        <a href="javascript:history.back()" class="btn-back">← 뒤로가기</a>
    </div>

</div>
</body>
</html>
