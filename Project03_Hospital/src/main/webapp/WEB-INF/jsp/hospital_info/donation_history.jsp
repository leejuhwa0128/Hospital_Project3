<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>기부 내역</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/donation_history.css"/>
</head>
<body>
    <div class="donation-history">
        <h1>💙 기부 내역</h1>
        <table>
            <thead>
                <tr>
                    <th>주문번호</th>
                    <th>후원자명</th>
                    <th>금액</th>
                    <th>결제일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="donation" items="${donations}">
                    <tr>
                        <td>${donation.orderId}</td>
                        <td>
                            <c:choose>
                                <c:when test="${empty donation.donorName}">
                                    익명
                                </c:when>
                                <c:otherwise>
                                    ${donation.donorName}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <fmt:formatNumber value="${donation.amount}" type="currency" currencySymbol="₩"/>
                        </td>
                        <td>
                            <fmt:formatDate value="${donation.approvedAt}" pattern="yyyy-MM-dd HH:mm"/>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="${pageContext.request.contextPath}/04_donation.do" class="btn-primary">메인화면으로</a>
    </div>
</body>
</html>
