<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제증명서류 신청 목록</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-100 text-gray-800">

<section class="max-w-screen-lg mx-auto mt-10 px-4">
    <div class="bg-white rounded-xl shadow-md border border-gray-100 p-8">
        <h2 class="text-2xl font-bold text-gray-800 border-b pb-3 mb-6">📝 제증명서류 신청 목록</h2>

        <c:if test="${not empty message}">
            <div class="mb-4 p-3 bg-green-100 text-green-800 rounded-md">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="mb-4 p-3 bg-red-100 text-red-800 rounded-md">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty certificates}">
                <div class="p-4 text-blue-600 bg-blue-50 border border-blue-100 rounded-md">
                    현재 처리할 제증명 서류가 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm text-left border-collapse">
                        <thead class="bg-gray-100 text-gray-700 border-b">
                            <tr>
                                <th class="px-4 py-2">신청번호</th>
                                <th class="px-4 py-2">환자명</th>
                                <th class="px-4 py-2">신청일</th>
                                <th class="px-4 py-2">종류</th>
                                <th class="px-4 py-2">수령방법</th>
                                <th class="px-4 py-2">상태</th>
                                <th class="px-4 py-2 text-center">처리</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y">
                            <c:forEach var="cert" items="${certificates}">
                                <tr class="${cert.status == '발급완료' ? 'bg-green-50' : ''}">
                                    <td class="px-4 py-2">${cert.certificateId}</td>
                                    <td class="px-4 py-2">${cert.patientVO.patientName}</td>
                                    <td class="px-4 py-2">
                                        <fmt:formatDate value="${cert.issuedAt}" pattern="yyyy-MM-dd" />
                                    </td>
                                    <td class="px-4 py-2">${cert.type}</td>
                                    <td class="px-4 py-2">${cert.requestMethod}</td>
                                    <td class="px-4 py-2">
                                        <span class="
                                            inline-block px-2 py-1 text-xs font-medium rounded-full text-white
                                            <c:choose>
                                                <c:when test='${cert.status == "발급완료"}'>bg-green-600</c:when>
                                                <c:when test='${cert.status == "접수"}'>bg-yellow-500</c:when>
                                                <c:otherwise>bg-blue-500</c:otherwise>
                                            </c:choose>
                                        ">
                                            ${cert.status}
                                        </span>
                                    </td>
                                    <td class="px-4 py-2 text-center">
                                        <c:choose>
                                            <c:when test="${cert.status == '접수'}">
                                                <a href="${pageContext.request.contextPath}/certificates/doctor/writeForm.do?certificateId=${cert.certificateId}"
                                                   class="inline-block px-3 py-1 text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 rounded-md transition">
                                                    작성하기
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/certificates/doctor/editForm.do?certificateId=${cert.certificateId}"
                                                   class="inline-block px-3 py-1 text-sm font-medium text-white bg-gray-600 hover:bg-gray-700 rounded-md transition">
                                                    수정
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div class="flex justify-center mt-6 space-x-1">
                    <c:if test="${currentPage > 1}">
                        <a href="<c:url value='/certificates/doctor/pending.do?page=${currentPage - 1}&pageSize=15'/>"
                           class="px-3 py-1 text-sm border border-gray-300 rounded-md hover:bg-gray-100 text-gray-700">
                            &laquo; 이전
                        </a>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="px-3 py-1 text-sm font-semibold text-white bg-blue-600 rounded-md">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value='/certificates/doctor/pending.do?page=${i}&pageSize=15'/>"
                                   class="px-3 py-1 text-sm border border-gray-300 rounded-md hover:bg-gray-100 text-gray-700">
                                    ${i}
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="<c:url value='/certificates/doctor/pending.do?page=${currentPage + 1}&pageSize=15'/>"
                           class="px-3 py-1 text-sm border border-gray-300 rounded-md hover:bg-gray-100 text-gray-700">
                            다음 &raquo;
                        </a>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<script src="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.js"></script>
</body>
</html>
