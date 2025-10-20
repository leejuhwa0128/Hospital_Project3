<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>통합 검색 결과</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-50 text-gray-800">

<!-- ✅ 검색창 -->
<div class="max-w-screen-xl mx-auto px-4 sm:px-6 lg:px-8 mt-8">
  <div class="flex justify-end">
    <form action="${pageContext.request.contextPath}/search/result.do" method="get" class="flex items-center">
      <input 
        type="text" 
        name="keyword" 
        value="${searchKeyword}" 
        placeholder="통합 검색..." 
        class="w-full sm:w-96 px-4 py-2 text-sm border border-gray-300 rounded-l-md shadow focus:outline-none focus:ring-2 focus:ring-blue-500"
      />
      <button 
        type="submit" 
        class="px-4 py-2 bg-blue-600 text-white rounded-r-md hover:bg-blue-700 transition">
        🔍
      </button>
    </form>
  </div>
</div>

<!-- ✅ 카운트 계산 -->
<c:set var="doctorDeptCount" value="${doctorCount + departmentCount}" />
<c:set var="hospitalInfoCount" value="${introCount + facilitiesCount + newsCount + csrCount}" />
<c:set var="customerServiceCount" value="${noticeCount + lectureCount + faqCount + feedbackCount + praiseCount}" />
<c:set var="totalCount" value="${doctorDeptCount + hospitalInfoCount + customerServiceCount}" />

<!-- ✅ 총 검색 결과 -->
<div class="max-w-screen-xl mx-auto mt-8 px-4">
  <p class="text-gray-700 font-medium mb-8">
    🔍 "<span class="text-blue-600">${searchKeyword}</span>" 검색 결과 총 
    <span class="font-bold text-red-600">${totalCount}</span> 건이 검색되었습니다.
  </p>
</div>

<!-- 병원정보 총 갯수 계산 -->
<c:set var="hospitalInfoCount" value="${introCount + facilitiesCount + newsCount + csrCount}" />

<!-- ✅ 탭 메뉴 -->
<div class="max-w-screen-xl mx-auto mt-8 px-4">
  <ul class="flex flex-wrap border-b border-gray-200 text-sm font-medium text-center" id="searchTab" data-tabs-toggle="#searchTabContent" role="tablist">
    <li class="mr-2">
      <button id="doctors-tab-btn" data-tabs-target="#doctors-tab" type="button" role="tab" aria-controls="doctors-tab" aria-selected="true"
        class="inline-block p-4 border-b-2 rounded-t-lg hover:text-blue-600 hover:border-blue-600">
        의료진/진료과 (${doctorCount + departmentCount})
      </button>
    </li>
    <li class="mr-2">
      <button id="hospital-info-tab-btn" data-tabs-target="#hospital-info-tab" type="button" role="tab" aria-controls="hospital-info-tab" aria-selected="false"
        class="inline-block p-4 border-b-2 rounded-t-lg hover:text-blue-600 hover:border-blue-600">
       병원정보 (${hospitalInfoCount})
      </button>
    </li>
    <li class="mr-2">
      <button id="customer-service-tab-btn" data-tabs-target="#customer-service-tab" type="button" role="tab" aria-controls="customer-service-tab" aria-selected="false"
        class="inline-block p-4 border-b-2 rounded-t-lg hover:text-blue-600 hover:border-blue-600">
        고객서비스 (${noticeCount + lectureCount + faqCount + feedbackCount + praiseCount})
      </button>
    </li>
  </ul>
</div>

<!-- ✅ 탭 콘텐츠 -->
<div id="searchTabContent" class="max-w-screen-xl mx-auto mt-4 px-4">

  <!-- 의료진/진료과 -->
<div id="doctors-tab" role="tabpanel" aria-labelledby="doctors-tab-btn" class="bg-white rounded-xl shadow p-6 space-y-8">

  <!-- 의료진 -->
  <div>
    <h2 class="text-lg font-bold text-blue-600 border-b pb-2 mb-4">👨‍⚕️ 의료진 (${doctorCount})</h2>
    <c:if test="${doctorCount == 0}">
      <p class="text-gray-500">일치하는 의료진이 없습니다.</p>
    </c:if>
    <div class="space-y-4">
      <c:forEach var="doctor" items="${doctorResults}">
        <div class="border-b pb-2">
          <a href="${pageContext.request.contextPath}/doctor/detail.do?id=${doctor.doctorId}" class="hover:text-blue-600">
            <h4 class="font-semibold">${doctor.name} 의사</h4>
            <p class="text-sm text-gray-600">${doctor.deptName} / ${doctor.specialty}</p>
          </a>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 진료과 -->
  <div>
    <h2 class="text-lg font-bold text-green-600 border-b pb-2 mb-4">🏥 진료과 (${departmentCount})</h2>
    <c:if test="${departmentCount == 0}">
      <p class="text-gray-500">일치하는 진료과가 없습니다.</p>
    </c:if>
    <div class="space-y-4">
      <c:forEach var="department" items="${departmentResults}">
        <div class="border-b pb-2">
          <a href="${pageContext.request.contextPath}/department/detail.do?deptId=${department.deptId}" class="hover:text-blue-600">
            <h4 class="font-semibold">${department.name}</h4>
            <p class="text-sm text-gray-600">${department.description}</p>
          </a>
        </div>
      </c:forEach>
    </div>
  </div>
</div>


<!-- 병원정보 -->
<div id="hospital-info-tab" role="tabpanel" aria-labelledby="hospital-info-tab-btn" class="hidden bg-white rounded-xl shadow p-6 space-y-8">

  <!-- 병원 소개 -->
  <div>
    <h2 class="text-lg font-bold text-indigo-600 border-b pb-2 mb-4">🏥 병원 소개 (${introCount})</h2>
    <c:if test="${introCount == 0}">
      <p class="text-gray-500">일치하는 병원 소개가 없습니다.</p>
    </c:if>
    <div class="space-y-4">
      <c:forEach var="item" items="${introResults}">
        <div class="border-b pb-2">
          <a href="${item.url}" class="hover:text-blue-600">
            <h4 class="font-semibold">${item.pageTitle}</h4>
            <p class="text-sm text-gray-600">${item.content}</p>
          </a>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 주요 시설 안내 -->
  <div>
    <h2 class="text-lg font-bold text-green-600 border-b pb-2 mb-4">🏢 주요 시설 안내 (${facilitiesCount})</h2>
    <c:if test="${facilitiesCount == 0}">
      <p class="text-gray-500">일치하는 시설 정보가 없습니다.</p>
    </c:if>
    <div class="space-y-4">
      <c:forEach var="item" items="${facilitiesResults}">
        <div class="border-b pb-2">
          <a href="${item.url}" class="hover:text-blue-600">
            <h4 class="font-semibold">${item.pageTitle}</h4>
            <p class="text-sm text-gray-600">${item.content}</p>
          </a>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 병원 소식 -->
  <div>
    <h2 class="text-lg font-bold text-blue-600 border-b pb-2 mb-4">📣 병원 소식 (${newsCount})</h2>
    <c:if test="${newsCount == 0}">
      <p class="text-gray-500">일치하는 소식이 없습니다.</p>
    </c:if>
    <div class="space-y-4">
      <c:forEach var="item" items="${newsResults}">
        <div class="border-b pb-2">
          <a href="${item.url}" class="hover:text-blue-600">
            <h4 class="font-semibold">${item.pageTitle}</h4>
            <p class="text-sm text-gray-600">${item.content}</p>
          </a>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 사회공헌 -->
  <div>
    <h2 class="text-lg font-bold text-emerald-600 border-b pb-2 mb-4">💚 사회공헌 (${csrCount})</h2>
    <c:if test="${csrCount == 0}">
      <p class="text-gray-500">일치하는 사회공헌 정보가 없습니다.</p>
    </c:if>
    <div class="space-y-4">
      <c:forEach var="item" items="${csrResults}">
        <div class="border-b pb-2">
          <a href="${item.url}" class="hover:text-blue-600">
            <h4 class="font-semibold">${item.pageTitle}</h4>
            <p class="text-sm text-gray-600">${item.content}</p>
          </a>
        </div>
      </c:forEach>
    </div>
  </div>
</div>

 <!-- 고객서비스 -->
<div id="customer-service-tab" role="tabpanel" aria-labelledby="customer-service-tab-btn" class="hidden bg-white rounded-xl shadow p-6 space-y-8">

  <!-- 공지사항 -->
  <div>
    <h2 class="text-lg font-bold text-blue-600 border-b pb-2 mb-4">📢 공지사항 (${noticeCount})</h2>
    <c:if test="${noticeCount == 0}">
      <p class="text-gray-500">일치하는 공지사항이 없습니다.</p>
    </c:if>
    <div class="space-y-4">
      <c:forEach var="notice" items="${noticeResults}">
        <div class="border-b pb-2">
          <a href="${pageContext.request.contextPath}/01_notice/detail.do?noticeId=${notice.noticeId}" class="hover:text-blue-600">
            <h4 class="font-semibold">${notice.title}</h4>
            <p class="text-sm text-gray-600">${notice.content}</p>
          </a>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 강좌 및 행사 -->
  <div>
    <h2 class="text-lg font-bold text-green-600 border-b pb-2 mb-4">🎓 강좌 및 행사 (${lectureCount})</h2>
    <c:if test="${lectureCount == 0}">
      <p class="text-gray-500">일치하는 강좌 및 행사가 없습니다.</p>
    </c:if>
    <div class="space-y-4">
      <c:forEach var="lecture" items="${lectureResults}">
        <div class="border-b pb-2">
          <a href="${pageContext.request.contextPath}/01_lecture/list.do" class="hover:text-blue-600">
            <h4 class="font-semibold">${lecture.title}</h4>
            <p class="text-sm text-gray-600">${lecture.description}</p>
          </a>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 자주 묻는 질문 -->
  <div>
    <h2 class="text-lg font-bold text-amber-600 border-b pb-2 mb-4">❓ 자주 묻는 질문 (${faqCount})</h2>
    <c:if test="${faqCount == 0}">
      <p class="text-gray-500">일치하는 자주 묻는 질문이 없습니다.</p>
    </c:if>
    <div class="space-y-4">
      <c:forEach var="faq" items="${faqResults}">
        <div class="border-b pb-2">
          <a href="${pageContext.request.contextPath}/03_faq/list.do?keyword=${searchKeyword}" class="hover:text-blue-600">
            <h4 class="font-semibold">${faq.question}</h4>
            <p class="text-sm text-gray-600">${faq.answer}</p>
          </a>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 고객의 소리 -->
  <div>
    <h2 class="text-lg font-bold text-rose-600 border-b pb-2 mb-4">💬 고객의 소리 (${feedbackCount})</h2>
    <c:if test="${feedbackCount == 0}">
      <p class="text-gray-500">일치하는 고객의소리가 없습니다.</p>
    </c:if>
    <div class="space-y-4">
      <c:forEach var="feedback" items="${feedbackResults}">
        <div class="border-b pb-2">
          <a href="${pageContext.request.contextPath}/03_feedback/detail.do?id=${feedback.feedbackId}" class="hover:text-blue-600">
            <h4 class="font-semibold">${feedback.title}</h4>
            <p class="text-sm text-gray-600">카테고리: ${feedback.category}</p>
            <p class="text-sm text-gray-600">${feedback.content}</p>
          </a>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 칭찬릴레이 -->
  <div>
    <h2 class="text-lg font-bold text-indigo-600 border-b pb-2 mb-4">🌟 칭찬릴레이 (${praiseCount})</h2>
    <c:if test="${praiseCount == 0}">
      <p class="text-gray-500">일치하는 칭찬릴레이가 없습니다.</p>
    </c:if>
    <div class="space-y-4">
      <c:forEach var="praise" items="${praiseResults}">
        <div class="border-b pb-2">
          <a href="${pageContext.request.contextPath}/03_praise/detail.do?praiseId=${praise.praiseId}" class="hover:text-blue-600">
            <h4 class="font-semibold">${praise.title}</h4>
            <p class="text-sm text-gray-600">${praise.content}</p>
          </a>
        </div>
      </c:forEach>
    </div>
  </div>
</div>


<script src="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.js"></script>

</body>
</html>

<jsp:include page="/WEB-INF/jsp/footer.jsp" />
