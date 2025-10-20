<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${pageTitle}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Tailwind + Flowbite -->
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.css"
   rel="stylesheet" />
</head>
<body class="bg-gray-100 text-gray-800">

   <section class="max-w-screen-lg mx-auto mt-10 px-4">
      <div class="bg-white rounded-xl shadow-md border border-gray-100 p-8">
         <h1 class="text-2xl font-bold text-gray-800 border-b pb-4 mb-6">${pageTitle}</h1>

         <!-- 증명서 정보 없음 -->
         <c:if test="${certificate == null}">
            <div class="text-red-600 font-medium mb-6">⚠️ 증명서 정보를 찾을 수
               없습니다.</div>
            <div class="text-center">
               <a href="<c:url value='/certificates/history.do'/>"
                  class="inline-block px-5 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition">
                  🔙 이력 목록으로 돌아가기 </a>
            </div>
         </c:if>

         <!-- 증명서 정보 있음 -->
         <c:if test="${certificate != null}">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-x-6 gap-y-4 text-sm">
               <div>
                  <p class="text-gray-500 mb-1">신청번호</p>
                  <p class="font-medium">${certificate.certificateId}</p>
               </div>

               <div>
                  <p class="text-gray-500 mb-1">환자 번호</p>
                  <p class="font-medium">${certificate.patientNo}</p>
               </div>

               <div>
                  <p class="text-gray-500 mb-1">환자 이름</p>
                  <p class="font-medium">${certificate.patientVO.patientName}</p>
               </div>

               <div>
                  <p class="text-gray-500 mb-1">증명서 종류</p>
                  <p class="font-medium">${certificate.type}</p>
               </div>

               <div class="md:col-span-2">
                  <p class="text-gray-500 mb-1">진단 내용</p>
                  <div
                     class="whitespace-pre-line bg-gray-50 border border-gray-200 rounded-md p-3 text-sm">
                     <c:out value="${certificate.content}" />
                  </div>
               </div>

               <c:if test="${certificate.medicalRecordVO != null}">
                  <div>
                     <p class="text-gray-500 mb-1">진료일</p>
                     <p class="font-medium">
                        <fmt:formatDate
                           value="${certificate.medicalRecordVO.recordDate}"
                           pattern="yyyy-MM-dd" />
                     </p>
                  </div>
               </c:if>

               <div>
                  <p class="text-gray-500 mb-1">발급일</p>
                  <p class="font-medium">
                     <fmt:formatDate value="${certificate.issuedAt}"
                        pattern="yyyy-MM-dd HH:mm:ss" />
                  </p>
               </div>

               <div>
                  <p class="text-gray-500 mb-1">발급자</p>
                  <p class="font-medium">${certificate.issuedByName}</p>
               </div>

               <div>
                  <p class="text-gray-500 mb-1">신청 방법</p>
                  <p class="font-medium">${certificate.method}</p>
               </div>

               <div>
                  <p class="text-gray-500 mb-1">수령 방법</p>
                  <p class="font-medium">${certificate.requestMethod}</p>
               </div>

               <div>
                  <p class="text-gray-500 mb-1">상태</p>
                  <span
                     class="inline-block px-3 py-1 rounded-full text-white text-xs font-medium
                        <c:choose>
                            <c:when test="${certificate.status eq '발급완료'}">bg-green-600</c:when>
                            <c:when test="${certificate.status eq '대기중'}">bg-yellow-500</c:when>
                            <c:otherwise>bg-gray-500</c:otherwise>
                        </c:choose>">
                     ${certificate.status} </span>
               </div>

               <div>
                  <p class="text-gray-500 mb-1">열람일</p>
                  <p class="font-medium">
                     <c:choose>
                        <c:when test="${certificate.viewedAt != null}">
                           <fmt:formatDate value="${certificate.viewedAt}"
                              pattern="yyyy-MM-dd HH:mm:ss" />
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                     </c:choose>
                  </p>
               </div>
            </div>

            <!-- 뒤로가기 버튼 -->
            <div class="mt-8 text-center">
               <a
                  href="<c:url value='/certificates/history.do?patientNo=${certificate.patientNo}'/>"
                  class="inline-block px-6 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition">
                  🔙 이력 목록으로 돌아가기 </a>
            </div>
         </c:if>
      </div>
   </section>

   <script src="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.js"></script>
</body>
</html>
