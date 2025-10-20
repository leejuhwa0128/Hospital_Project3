<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="loginUser" value="${sessionScope.loginUser}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제증명 수정</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-100 text-gray-800">

<section class="max-w-screen-lg mx-auto mt-10 px-4">
    <div class="bg-white rounded-xl shadow-md border border-gray-100 p-8">
        <h2 class="text-2xl font-bold text-gray-800 border-b pb-3 mb-6">📄 제증명 수정</h2>

        <c:if test="${not empty error}">
            <div class="mb-4 p-3 bg-red-100 text-red-800 rounded-md">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/certificates/updateCertificate.do" method="post" class="space-y-6">
            <input type="hidden" name="certificateId" value="${certificate.certificateId}" />
            <input type="hidden" name="issuedBy" value="${loginUser.userId}" />

            <!-- 기본 정보 -->
            <div class="space-y-1">
                <p><strong>환자명:</strong>
                    <c:choose>
                        <c:when test="${not empty certificate.patientVO}">
                            ${certificate.patientVO.patientName}
                        </c:when>
                        <c:otherwise>(정보 없음)</c:otherwise>
                    </c:choose>
                </p>
                <p><strong>진료일:</strong>
                    <c:if test="${not empty certificate.medicalRecordVO}">
                        <fmt:formatDate value="${certificate.medicalRecordVO.recordDate}" pattern="yyyy-MM-dd" />
                    </c:if>
                    <c:if test="${empty certificate.medicalRecordVO}">(정보 없음)</c:if>
                </p>
                <p><strong>신청일:</strong>
                    <fmt:formatDate value="${certificate.issuedAt}" pattern="yyyy-MM-dd" />
                </p>
                <p><strong>종류:</strong> ${certificate.type}</p>
                <p><strong>수령방법:</strong> ${certificate.requestMethod}</p>
            </div>

            <!-- 진료 기록 (읽기 전용) -->
            <div>
                <h3 class="text-lg font-semibold text-gray-700 border-t pt-6 mb-4">■ 진료 기록 (참고용)</h3>

                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">진단명</label>
                    <textarea class="w-full p-3 border rounded-md bg-gray-100 text-sm" rows="4" readonly>
${certificate.medicalRecordVO != null ? certificate.medicalRecordVO.diagnosis : '정보 없음'}
                    </textarea>
                </div>

                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">치료 내용</label>
                    <textarea class="w-full p-3 border rounded-md bg-gray-100 text-sm" rows="4" readonly>
${certificate.medicalRecordVO != null ? certificate.medicalRecordVO.treatment : '정보 없음'}
                    </textarea>
                </div>

                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">처방 내용</label>
                    <textarea class="w-full p-3 border rounded-md bg-gray-100 text-sm" rows="4" readonly>
${certificate.medicalRecordVO != null ? certificate.medicalRecordVO.prescription : '정보 없음'}
                    </textarea>
                </div>
            </div>

            <!-- 진단 내용 (수정 가능) -->
            <div>
                <label for="content" class="block text-sm font-medium text-gray-700 mb-1">진단 내용</label>
                <textarea id="content" name="content" class="w-full p-3 border border-gray-300 rounded-md text-sm focus:ring-2 focus:ring-blue-500 focus:outline-none" rows="10" required>${certificate.content}</textarea>
            </div>

            <!-- 버튼 -->
            <div class="text-center pt-6 border-t">
                <button type="submit" class="px-5 py-2 rounded-md bg-blue-600 text-white hover:bg-blue-700 transition">수정 완료</button>
            </div>
        </form>
    </div>
</section>

<script src="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.js"></script>
</body>
</html>
