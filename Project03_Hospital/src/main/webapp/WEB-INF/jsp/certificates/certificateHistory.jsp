<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <style>
        body { font-family: 'Malgun Gothic', 'Apple SD Gothic Neo', Arial, sans-serif; margin: 20px; color: #333; }
        h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; margin-bottom: 20px; }
        
        .message-success { color: #28a745; background-color: #d4edda; border: 1px solid #c3e6cb; padding: 10px; border-radius: 5px; margin-bottom: 15px; }
        .message-error { color: #dc3545; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 10px; border-radius: 5px; margin-bottom: 15px; }
        
        .form-section { background-color: #f9f9f9; padding: 20px; border-radius: 8px; border: 1px solid #eee; margin-bottom: 30px; }
        .form-section label { font-weight: bold; margin-right: 10px; }
        .form-section input[type="number"] { padding: 8px; border: 1px solid #ccc; border-radius: 4px; width: 150px; }
        .form-section button {
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .form-section button:hover {
            background-color: #0056b3;
        }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        th, td { border: 1px solid #e0e0e0; padding: 12px 15px; text-align: left; }
        th { background-color: #f2f2f2; font-weight: bold; color: #555; }
        tr:nth-child(even) { background-color: #f8f8f8; }
        tr:hover { background-color: #f1f1f1; }

        .status {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 5px;
            font-size: 0.9em;
            font-weight: bold;
            color: white;
            min-width: 60px;
            text-align: center;
        }
        .status-completed { background-color: #28a745; }
        .status-processing { background-color: #ffc107; }
        .status-pending { background-color: #007bff; }
        .status-canceled { background-color: #dc3545; }

        .btn {
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 0.9em;
            display: inline-block;
            margin-right: 5px;
        }
        .btn-info { background-color: #17a2b8; color: white; border: 1px solid #17a2b8; }
        .btn-info:hover { background-color: #117a8b; }
        .btn-success { background-color: #28a745; color: white; border: 1px solid #28a745; }
        .btn-success:hover { background-color: #1e7e34; }
        .btn-disabled { background-color: #6c757d; color: #dee2e6; border: 1px solid #6c757d; cursor: not-allowed; opacity: 0.7; }

        /* 페이징 스타일 추가 */
        .pagination { text-align: center; margin-top: 20px; }
        .pagination a, .pagination .disabled, .pagination .active {
            display: inline-block;
            padding: 8px 16px;
            text-decoration: none;
            color: #007bff;
            border: 1px solid #dee2e6;
            margin: 0 4px;
            border-radius: 4px;
        }
        .pagination a:hover { background-color: #f8f9fa; }
        .pagination .active {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
        }
        .pagination .disabled { color: #6c757d; cursor: not-allowed; }
    </style>
</head>
<body>
    <h1>${pageTitle}</h1>

    <c:if test="${not empty message}"><p class="message-success"><c:out value="${message}"/></p></c:if>
    <c:if test="${not empty error}"><p class="message-error"><c:out value="${error}"/></p></c:if>

    <div class="form-section" style="display: none;">
        <form action="<c:url value="/certificates/history.do"/>" method="get">
            <label for="searchPatientNo">조회할 환자 번호:</label>
            <input type="number" id="searchPatientNo" name="patientNo" value="${searchPatientNo}"><br><br>
            <button type="submit">조회</button>
        </form>
    </div>

    <div class="history-section">
        <c:choose>
            <c:when test="${not empty certificates}">
            <h2>${certificates[0].patientVO.patientName} 환자 신청 이력</h2>
                <table>
                    <thead>
                        <tr>
                            <th>신청번호</th>
                            <th>환자 이름</th>
                            <th>종류</th>
                            <th>신청일</th>
                            <th>상태</th>
                            <th>수령방법</th>
                            <th>열람일</th>
                            <th>처리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cert" items="${certificates}">
                            <tr>
                                <td><c:out value="${cert.certificateId}"/></td>
                                <td><c:out value="${cert.patientVO.patientName}"/></td>
                                <td><c:out value="${cert.type}"/></td>
                                <td><fmt:formatDate value="${cert.issuedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td>
                                    <span class="status<c:choose>
                                            <c:when test="${cert.status == '발급완료'}"> status-completed</c:when>
                                            <c:when test="${cert.status == '처리중'}"> status-processing</c:when>
                                            <c:when test="${cert.status == '접수'}"> status-pending</c:when>
                                            <c:when test="${cert.status == '취소'}"> status-canceled</c:when>
                                            <c:otherwise></c:otherwise>
                                        </c:choose>">
                                        <c:out value="${cert.status}"/>
                                    </span>
                                </td>
                                <td><c:out value="${cert.requestMethod}"/></td>
                                <td>
                                    <c:if test="${not empty cert.viewedAt}">
                                        <fmt:formatDate value="${cert.viewedAt}" pattern="yyyy-MM-dd HH:mm"/>
                                    </c:if>
                                    <c:if test="${empty cert.viewedAt}">-</c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${cert.status == '발급완료'}">
                                            <a href="${pageContext.request.contextPath}/certificates/detail/${cert.certificateId}.do" class="btn btn-info">상세보기</a>
                                            <c:if test="${cert.requestMethod != '방문'}">
                                                <a href="${pageContext.request.contextPath}/certificates/download.do?certificateId=${cert.certificateId}" class="btn btn-success">다운로드</a>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-disabled" disabled>처리 대기</button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <%-- Paging --%>
                <div class="pagination">
                    <%-- 이전 페이지 링크 --%>
                    <c:choose>
                        <c:when test="${page.hasPrevious}">
                            <a href="<c:url value='/certificates/history.do?page=${page.previousPage}&pageSize=${page.pageSize}'/>">&laquo; 이전</a>
                        </c:when>
                        <c:otherwise>
                            <span class="disabled">&laquo; 이전</span>
                        </c:otherwise>
                    </c:choose>
                    
                    <%-- 페이지 번호 링크 --%>
                    <c:forEach var="pageNum" begin="${page.startPage}" end="${page.endPage}">
                        <c:choose>
                            <c:when test="${pageNum == page.currentPage}">
                                <span class="active"><c:out value="${pageNum}"/></span>
                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value='/certificates/history.do?page=${pageNum}&pageSize=${page.pageSize}'/>"><c:out value="${pageNum}"/></a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <%-- 다음 페이지 링크 --%>
                    <c:choose>
                        <c:when test="${page.hasNext}">
                            <a href="<c:url value='/certificates/history.do?page=${page.nextPage}&pageSize=${page.pageSize}'/>">다음 &raquo;</a>
                        </c:when>
                        <c:otherwise>
                            <span class="disabled">다음 &raquo;</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                <p>조회된 증명서 신청 이력이 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>