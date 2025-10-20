<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>증명서 발급 신청</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Tailwind & Flowbite -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-100 text-gray-800">

<section class="max-w-screen-lg mx-auto mt-10 px-4">
    <div class="bg-white rounded-xl shadow-md border border-gray-100 p-8">
        <h1 class="text-2xl font-bold text-center text-gray-800 mb-6">📋 증명서 발급 신청</h1>

        <c:if test="${not empty message}">
            <p class="text-green-600 mb-4 text-center font-medium"><c:out value="${message}" /></p>
        </c:if>
        <c:if test="${not empty error}">
            <p class="text-red-600 mb-4 text-center font-medium"><c:out value="${error}" /></p>
        </c:if>

        <form action="<c:url value='/certificates/request.do' />" method="post" class="space-y-6">

            <c:if test="${not empty loggedInPatientName}">
                <p class="font-medium">신청자: <span class="text-blue-600">${loggedInPatientName}</span> 님</p>
            </c:if>

            <!-- 환자 번호 -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">환자 번호</label>
                <input type="number" value="${loggedInPatientNo}" readonly class="w-full px-3 py-2 border rounded-md bg-gray-100" />
                <input type="hidden" name="patientNo" value="${loggedInPatientNo}" />
            </div>

            <!-- 증명서 종류 -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">증명서 종류</label>
                <select id="type" name="type" required class="w-full px-3 py-2 border rounded-md">
                    <option value="">선택하세요</option>
                    <option value="진단서" <c:if test="${certificateVO.type == '진단서'}">selected</c:if>>진단서</option>
                    <option value="소견서" <c:if test="${certificateVO.type == '소견서'}">selected</c:if>>소견서</option>
                </select>
            </div>

            <!-- 진료 기록 -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">진료 기록 선택</label>
                <c:choose>
                    <c:when test="${not empty medicalRecords}">
                        <select id="recordId" name="recordId" required class="w-full px-3 py-2 border rounded-md">
                            <option value="">선택하세요</option>
                            <c:forEach var="record" items="${medicalRecords}">
                                <option value="${record.recordId}">
                                    <fmt:formatDate value="${record.recordDate}" pattern="yyyy년 MM월 dd일" /> - ${record.diagnosis} (${record.doctorName})
                                </option>
                            </c:forEach>
                        </select>
                    </c:when>
                    <c:otherwise>
                        <select disabled class="w-full px-3 py-2 border rounded-md bg-gray-100">
                            <option>선택 가능한 진료 기록이 없습니다.</option>
                        </select>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 수령 방법 -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">수령 방법</label>
                <select id="requestMethod" name="requestMethod" required class="w-full px-3 py-2 border rounded-md">
                    <option value="">선택하세요</option>
                    <option value="방문" <c:if test="${certificateVO.requestMethod == '방문'}">selected</c:if>>방문</option>
                    <option value="온라인" <c:if test="${certificateVO.requestMethod == '온라인'}">selected</c:if>>온라인</option>
                </select>
            </div>

            <input type="hidden" name="method" value="온라인" />

            <!-- 방문 수령 안내 -->
            <div id="visitReceptionInfo" class="hidden bg-green-50 border border-green-200 rounded-md p-4 mt-6 text-sm text-green-800">
                <h4 class="text-lg font-semibold text-green-700 border-b border-green-300 pb-2 mb-3">🏥 방문 수령 안내</h4>
                <p>증명서 수령을 위해 본인 확인이 필요합니다.</p>
                <ul class="list-disc pl-5 mt-2">
                    <li><strong>수령 가능 시간:</strong> 평일 09:00 ~ 17:00 (점심시간 12:30 ~ 13:30 제외)</li>
                    <li><strong>수령 장소:</strong> 본관 1층 원무과 증명서 발급 창구</li>
                </ul>

                <!-- 구비 서류 안내 테이블 -->
                <div class="overflow-x-auto mt-6">
                    <table class="w-full text-sm text-left border border-gray-300 rounded-md">
                        <thead class="bg-gray-100 text-gray-700">
                            <tr>
                                <th class="p-2">신청자</th>
                                <th class="p-2">환자의 나이</th>
                                <th class="p-2">구비서류</th>
                                <th class="p-2">권리주체</th>
                            </tr>
                        </thead>
                        <tbody class="text-gray-700 bg-white">
                            <tr>
                                <td rowspan="3" class="p-2 align-top">환자(본인)</td>
                                <td class="p-2">만 17세 이상</td>
                                <td class="p-2">환자 본인의 신분증 또는 사본</td>
                                <td class="p-2">환자 본인</td>
                            </tr>
                            <tr>
                                <td class="p-2">만 14세 이상 ~ 17세 미만</td>
                                <td class="p-2">학생증 (권장)</td>
                                <td class="p-2">환자 본인</td>
                            </tr>
                            <tr>
                                <td class="p-2">만 14세 미만</td>
                                <td class="p-2">법정대리인 확인 서류 및 신분증 또는 사본</td>
                                <td class="p-2">법정대리인</td>
                            </tr>
                            <tr>
                                <td rowspan="3" class="p-2 align-top">환자 친족</td>
                                <td class="p-2">만 17세 이상</td>
                                <td class="p-2">
                                    환자 및 신청자 신분증 또는 사본<br/>
                                    <a href="/resources/forms/consent_form.pdf" class="text-blue-600 underline" target="_blank">환자 자필 서명 동의서[다운로드] </a><br/>
                                    친족관계 증명서
                                </td>
                                <td class="p-2">환자 본인</td>
                            </tr>
                            <tr>
                                <td class="p-2">만 14세 이상 ~ 17세 미만</td>
                                <td class="p-2">
                                    학생증 (권장)<br/>
                                    신청자 신분증 또는 사본<br/>
                                    <a href="/resources/forms/consent_form.pdf" class="text-blue-600 underline" target="_blank">환자 자필 서명 동의서[다운로드] </a><br/>
                                    친족관계 증명서
                                </td>
                                <td class="p-2">환자 본인</td>
                            </tr>
                            <tr>
                                <td class="p-2">만 14세 미만</td>
                                <td class="p-2">법정대리인 관련 서류 동일 적용</td>
                                <td class="p-2">법정대리인</td>
                            </tr>
                            <tr>
                                <td rowspan="3" class="p-2 align-top">대리인</td>
                                <td class="p-2">만 17세 이상</td>
                                <td class="p-2">
                                    환자 및 신청자 신분증 또는 사본<br/>
                                    <a href="/resources/forms/consent_form.pdf" class="text-blue-600 underline" target="_blank">환자 자필 서명 동의서[다운로드] </a><br/>
                                    <a href="/resources/forms/power_of_attorney.pdf" class="text-blue-600 underline" target="_blank">환자 자필 서명한 위임장[다운로드]</a>
                                </td>
                                <td class="p-2">환자 본인</td>
                            </tr>
                            <tr>
                                <td class="p-2">만 14세 이상 ~ 17세 미만</td>
                                <td class="p-2">
                                    학생증<br/>
                                    신청자 신분증 또는 사본<br/>
                                    <a href="/resources/forms/consent_form.pdf" class="text-blue-600 underline" target="_blank">환자 자필 서명 동의서[다운로드] </a><br/>
                                    <a href="/resources/forms/power_of_attorney.pdf" class="text-blue-600 underline" target="_blank">환자 자필 서명한 위임장[다운로드]</a>
                                </td>
                                <td class="p-2">환자 본인</td>
                            </tr>
                            <tr>
                                <td class="p-2">만 14세 미만</td>
                                <td class="p-2">
                                    법정대리인 확인 서류<br/>
                                    신청자 신분증 또는 사본<br/>
                                    <a href="/resources/forms/consent_form.pdf" class="text-blue-600 underline" target="_blank">환자 자필 서명 동의서[다운로드] </a><br/>
                                    <a href="/resources/forms/power_of_attorney.pdf" class="text-blue-600 underline" target="_blank">환자 자필 서명한 위임장[다운로드]</a>
                                </td>
                                <td class="p-2">법정대리인</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 온라인 수령 안내 -->
            <div id="onlineReceptionInfo" class="hidden bg-green-50 border border-green-200 rounded-md p-4 mt-6 text-sm text-green-800">
                <h4 class="text-lg font-semibold text-green-700 border-b border-green-300 pb-2 mb-3">🌐 온라인 수령 안내</h4>
                <ul class="list-disc pl-6 space-y-1">
                    <li><strong>다운로드 가능 기간:</strong> 발급 완료일로부터 30일 이내</li>
                    <li><strong>참고:</strong> 일부 증명서는 온라인 수령이 제한될 수 있습니다.</li>
                </ul>
            </div>

            <!-- 유의사항 -->
            <div class="bg-yellow-50 border border-yellow-300 text-yellow-800 text-sm rounded-md p-4 mt-6">
                <p><strong>※ 신청 전 유의사항</strong></p>
                <ul class="list-disc pl-5 mt-1 space-y-1">
                    <li>신청 완료 후에는 증명서 종류, 진료 기록, 수령 방법 등의 변경이 어려울 수 있습니다.</li>
                    <li>입력하신 정보가 부정확하여 발생하는 문제의 책임은 신청자 본인에게 있습니다.</li>
                </ul>
            </div>

            <!-- 신청 버튼 -->
            <div class="pt-6">
                <button type="submit" class="w-full bg-blue-600 text-white text-lg py-3 rounded-md hover:bg-blue-700 transition"
                    <c:if test="${empty medicalRecords}">disabled</c:if>>신청하기</button>
            </div>
        </form>
    </div>
</section>

<!-- JS: 수령 방법 안내 표시 -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const methodSelect = document.getElementById('requestMethod');
        const visitInfo = document.getElementById('visitReceptionInfo');
        const onlineInfo = document.getElementById('onlineReceptionInfo');

        function toggleInfo() {
            visitInfo.classList.add('hidden');
            onlineInfo.classList.add('hidden');

            if (methodSelect.value === '방문') {
                visitInfo.classList.remove('hidden');
            } else if (methodSelect.value === '온라인') {
                onlineInfo.classList.remove('hidden');
            }
        }

        methodSelect.addEventListener('change', toggleInfo);
        toggleInfo(); // 초기 실행
    });
</script>

<script src="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.js"></script>
</body>
</html>
