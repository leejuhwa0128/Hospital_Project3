<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>${department.name} - 진료과 소개</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-50 text-gray-800">
<main class="max-w-screen-xl mx-auto px-4 py-12">

  <!-- ✅ 진료과 이름 -->
  <section class="mb-10">
    <h1 class="text-3xl font-extrabold">${department.name}</h1>
  </section>

  <!-- ✅ 탭 -->
  <nav class="flex gap-4 border-b mb-8">
    <button class="tab-button font-semibold py-2 border-b-2 border-blue-600 text-blue-600" data-tab="about">소개</button>
    <button class="tab-button font-semibold py-2 border-b-2 border-transparent hover:border-blue-300" data-tab="doctors">의료진</button>
  </nav>

  <!-- ✅ 탭: 소개 -->
  <section id="tab-about" class="tab-panel">

    <!-- 과 소개 -->
    <div class="bg-white rounded-lg shadow p-6 mb-8">
      <h2 class="text-xl font-bold mb-4">과 소개</h2>
      <c:choose>
        <c:when test="${not empty department.intro}">
          <div class="space-y-2 text-gray-700 leading-relaxed">
            <c:forEach var="sentence" items="${fn:split(department.intro, '.')}">
              <c:if test="${fn:trim(sentence) ne ''}">
                <p>${fn:trim(sentence)}.</p>
              </c:if>
            </c:forEach>
          </div>
        </c:when>
        <c:otherwise>
          <p class="text-gray-400">소개글이 준비중입니다.</p>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- 주요 진료 질환 -->
    <div class="bg-white rounded-lg shadow p-6 mb-8">
      <h3 class="text-xl font-bold mb-4">주요 진료 질환</h3>
      <c:choose>
        <c:when test="${not empty department.mainDiseases}">
          <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-3 text-sm text-gray-700">
            <c:forEach var="dis" items="${fn:split(department.mainDiseases, ',')}">
              <div class="bg-gray-100 px-3 py-2 rounded">${fn:trim(dis)}</div>
            </c:forEach>
          </div>
        </c:when>
        <c:otherwise>
          <p class="text-gray-400">진료 질환 정보가 없습니다.</p>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- 위치 안내 -->
    <div class="bg-white rounded-lg shadow p-6 mb-6">
      <h3 class="text-xl font-bold mb-4">위치 안내</h3>
      <div class="text-gray-700 mb-4">
        <c:choose>
          <c:when test="${not empty department.locationGuide}">
            <p>${department.locationGuide}</p>
          </c:when>
          <c:otherwise>
            <p class="text-gray-400">위치 안내 정보가 없습니다.</p>
          </c:otherwise>
        </c:choose>
      </div>
      <c:if test="${not empty department.mapImagePath}">
        <c:url value="${department.mapImagePath}" var="mapUrl" />
        <img src="${mapUrl}" alt="위치 안내" class="w-full max-w-md rounded-lg shadow" />
      </c:if>
    </div>

    <!-- ✅ 버튼 영역 (하단 우측 정렬) -->
    <div class="flex justify-end gap-4">
      <a href="${pageContext.request.contextPath}/department/main.do"
         class="px-4 py-2 border border-blue-600 text-blue-600 rounded hover:bg-blue-50 text-sm">
        전체 진료과
      </a>
      <a href="${pageContext.request.contextPath}/reservation.do"
         class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 text-sm">
        진료 예약
      </a>
    </div>

  </section>

  <!-- ✅ 탭: 의료진 -->
  <section id="tab-doctors" class="tab-panel hidden">
    <c:if test="${empty doctors}">
      <p class="text-gray-500 text-center py-8">의료진 정보가 없습니다.</p>
    </c:if>

    <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-6">
      <c:forEach var="d" items="${doctors}">
        <c:set var="imgFile" value="${empty d.profileImagePath ? d.doctorId.concat('.png') : d.profileImagePath}" />
        <c:choose>
          <c:when test="${fn:startsWith(imgFile, 'http')}">
            <c:set var="imgUrl" value="${imgFile}" />
          </c:when>
          <c:when test="${fn:startsWith(imgFile, '/')}">
            <c:url var="imgUrl" value="${imgFile}" />
          </c:when>
          <c:otherwise>
            <c:url var="imgUrl" value="/resources/images/doctor/${imgFile}" />
          </c:otherwise>
        </c:choose>

        <a href="${pageContext.request.contextPath}/doctor/detail.do?doctorId=${d.doctorId}"
           class="bg-white p-4 rounded-lg shadow hover:shadow-md transition flex flex-col items-center text-center">
          <img src="${imgUrl}" alt="${d.name}"
               class="w-full h-[280px] object-cover rounded-md mb-3"
               onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/resources/images/default-doctor.png'" />
          <div class="font-bold text-lg">${d.name}</div>
          <div class="text-sm text-gray-500">${empty d.specialty ? department.name : d.specialty}</div>
        </a>
      </c:forEach>
    </div>
  </section>

</main>

<!-- ✅ 탭 스크립트 -->
<script>
  document.querySelectorAll('.tab-button').forEach(btn => {
    btn.addEventListener('click', () => {
      document.querySelectorAll('.tab-button').forEach(b => b.classList.remove('border-blue-600', 'text-blue-600'));
      btn.classList.add('border-blue-600', 'text-blue-600');

      document.querySelectorAll('.tab-panel').forEach(panel => panel.classList.add('hidden'));
      const idx = [...btn.parentNode.children].indexOf(btn);
      document.querySelectorAll('.tab-panel')[idx].classList.remove('hidden');
    });
  });
</script>

<jsp:include page="/WEB-INF/jsp/footer.jsp" />
</body>
</html>
