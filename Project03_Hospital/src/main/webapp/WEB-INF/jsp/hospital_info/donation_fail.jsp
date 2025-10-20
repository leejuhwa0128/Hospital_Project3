<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>기부 실패</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/donation_fail.css"/>
</head>
<body>
    <div class="donation-result fail">
        <h1>❌ 결제 실패</h1>
        <p>결제가 취소되었거나 오류가 발생했습니다.</p>

        <!-- 서버에서 전달된 에러 메시지 표시 -->
        <p><strong>주문번호:</strong> ${orderId}</p>
        <p><strong>오류 코드:</strong> ${code}</p>
        <p><strong>메시지:</strong> ${message}</p>

        <!-- 다시 기부 페이지로 이동 -->
        <a href="${pageContext.request.contextPath}/04_donation.do" class="btn-primary">다시 시도하기</a>
    </div>
</body>
</html>