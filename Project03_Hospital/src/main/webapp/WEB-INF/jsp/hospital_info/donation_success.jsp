<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>결제 완료</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/donation_success.css"/>
</head>
<body>
    <div class="box">
        <h2>💙 결제가 완료되었습니다</h2>
        <p>소중한 후원에 감사드립니다.</p>

        <table>
            <tr>
                <th>주문번호</th>
                <td>${donation.orderId}</td>
            </tr>
            <tr>
                <th>후원자명</th>
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
            </tr>
            <tr>
                <th>후원 금액</th>
                <td>
                    <fmt:formatNumber value="${donation.amount}" type="currency" currencySymbol="₩"/>
                </td>
            </tr>
            <tr>
                <th>결제일시</th>
                <td>
                    <fmt:formatDate value="${donation.approvedAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
            </tr>
        </table>

        <a href="${pageContext.request.contextPath}/donation/history.do" class="btn">내 후원 내역 보기</a>
    </div>
</body>
</html>

