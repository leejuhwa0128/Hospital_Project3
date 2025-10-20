<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<jsp:include page="/WEB-INF/jsp/header.jsp" />
<script src="https://cdn.tailwindcss.com"></script>
<!-- Flowbite -->
<script src="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.js"></script>

<div class="max-w-7xl mx-auto px-4 py-12 flex flex-col md:flex-row gap-10">

  <!-- 좌측 메뉴 -->
  <aside class="w-full md:w-64 bg-white rounded-lg shadow border border-gray-200">
    <jsp:include page="/WEB-INF/jsp/hospital_info/03_menu.jsp" />
  </aside>

  <!-- 우측 콘텐츠 -->
  <main class="flex-1 bg-white rounded-lg shadow border border-gray-200 p-6">

     <!-- 페이지 타이틀 -->
    <h2 class="text-xl sm:text-2xl font-semibold text-black mb-8 border-b border-gray-200 pb-2">
       건강 정보
    </h2>

    <!-- 카드 그리드 -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
  
  <!-- 카드 1 -->
  <div class="border rounded-lg overflow-hidden shadow hover:shadow-md transition">
    <img src="${pageContext.request.contextPath}/resources/images/news01.png" alt="전립선암" class="w-full h-40 object-cover" />
    <div class="p-4">
      <h3 class="text-lg font-semibold text-gray-800">전립선암</h3>
      <p class="text-sm text-gray-600 mt-1">남성 암 1위 코앞! 전립선암 대처는?</p>
      <div class="mt-3">
        <a href="https://news.kbs.co.kr/news/pc/view/view.do?ncd=8314644&ref=A" target="_blank" rel="noopener"
           class="text-blue-600 hover:underline text-sm font-medium">자세히 보기 →</a>
      </div>
    </div>
  </div>

  <!-- 카드 2 -->
  <div class="border rounded-lg overflow-hidden shadow hover:shadow-md transition">
    <img src="${pageContext.request.contextPath}/resources/images/news02.png" alt="수면 강박" class="w-full h-40 object-cover" />
    <div class="p-4">
      <h3 class="text-lg font-semibold text-gray-800">수면 강박</h3>
      <p class="text-sm text-gray-600 mt-1">무더위 속 우리 아이 위협 ‘소아 장염’</p>
      <div class="mt-3">
        <a href="https://www.kmib.co.kr/article/view.asp?arcid=0028445389&code=61121911&cp=nv" target="_blank" rel="noopener"
           class="text-blue-600 hover:underline text-sm font-medium">자세히 보기 →</a>
      </div>
    </div>
  </div>

  <!-- 카드 3 -->
  <div class="border rounded-lg overflow-hidden shadow hover:shadow-md transition">
    <img src="${pageContext.request.contextPath}/resources/images/news03.png" alt="턱관절" class="w-full h-40 object-cover" />
    <div class="p-4">
      <h3 class="text-lg font-semibold text-gray-800">턱관절</h3>
      <p class="text-sm text-gray-600 mt-1">2030도 예외 없다… 턱관절 장애 조기 진단 중요</p>
      <div class="mt-3">
        <a href="https://www.kukinews.com/article/view/kuk202507280117" target="_blank" rel="noopener"
           class="text-blue-600 hover:underline text-sm font-medium">자세히 보기 →</a>
      </div>
    </div>
  </div>

  <!-- 카드 4 -->
  <div class="border rounded-lg overflow-hidden shadow hover:shadow-md transition">
    <img src="${pageContext.request.contextPath}/resources/images/news04.jpg" alt="여름철 탈수 주의" class="w-full h-40 object-cover" />
    <div class="p-4">
      <h3 class="text-lg font-semibold text-gray-800">여름철 탈수 주의</h3>
      <p class="text-sm text-gray-600 mt-1">고온다습한 날씨, 수분 보충과 전해질 관리가 핵심!</p>
      <div class="mt-3">
        <a href="https://www.thefirstmedia.net/news/articleView.html?idxno=175154" target="_blank" rel="noopener"
           class="text-blue-600 hover:underline text-sm font-medium">자세히 보기 →</a>
      </div>
    </div>
  </div>

  <!-- 카드 5 -->
  <div class="border rounded-lg overflow-hidden shadow hover:shadow-md transition">
    <img src="${pageContext.request.contextPath}/resources/images/news05.jpg" alt="뇌 건강 체크리스트" class="w-full h-40 object-cover" />
    <div class="p-4">
      <h3 class="text-lg font-semibold text-gray-800">뇌 건강 체크리스트</h3>
      <p class="text-sm text-gray-600 mt-1">수면·운동·식습관으로 기억력 지키기.</p>
      <div class="mt-3">
        <a href="https://www.koreahealthlog.com/news/articleView.html?idxno=48597" target="_blank" rel="noopener"
           class="text-blue-600 hover:underline text-sm font-medium">자세히 보기 →</a>
      </div>
    </div>
  </div>

  <!-- 카드 6 -->
  <div class="border rounded-lg overflow-hidden shadow hover:shadow-md transition">
    <img src="${pageContext.request.contextPath}/resources/images/news06.jpg" alt="체중 관리 기본" class="w-full h-40 object-cover" />
    <div class="p-4">
      <h3 class="text-lg font-semibold text-gray-800">체중 관리 기본</h3>
      <p class="text-sm text-gray-600 mt-1">탄수·단백·지방 균형과 근력운동 루틴이 답.</p>
      <div class="mt-3">
        <a href="https://news.hidoc.co.kr/news/articleView.html?idxno=51403" target="_blank" rel="noopener"
           class="text-blue-600 hover:underline text-sm font-medium">자세히 보기 →</a>
      </div>
    </div>
  </div>

  <!-- 카드 7 -->
  <div class="border rounded-lg overflow-hidden shadow hover:shadow-md transition">
    <img src="${pageContext.request.contextPath}/resources/images/news07.jpg" alt="혈압 관리 가이드" class="w-full h-40 object-cover" />
    <div class="p-4">
      <h3 class="text-lg font-semibold text-gray-800">혈압 관리 가이드</h3>
      <p class="text-sm text-gray-600 mt-1">나트륨 줄이고 유산소+근력 병행, 아침·저녁 자가측정 습관화.</p>
      <div class="mt-3">
        <a href="https://www.mkhealth.co.kr/news/articleView.html?idxno=72366" target="_blank" rel="noopener"
           class="text-blue-600 hover:underline text-sm font-medium">자세히 보기 →</a>
      </div>
    </div>
  </div>

  <!-- 카드 8 -->
  <div class="border rounded-lg overflow-hidden shadow hover:shadow-md transition">
    <img src="${pageContext.request.contextPath}/resources/images/news08.jpg" alt="눈 건강 수칙" class="w-full h-40 object-cover" />
    <div class="p-4">
      <h3 class="text-lg font-semibold text-gray-800">눈 건강 수칙</h3>
      <p class="text-sm text-gray-600 mt-1">20-20-20 룰, 인공눈물 사용, 청광 차단으로 눈 피로 줄이기.</p>
      <div class="mt-3">
        <a href="https://news.hidoc.co.kr/news/articleView.html?idxno=51244" target="_blank" rel="noopener"
           class="text-blue-600 hover:underline text-sm font-medium">자세히 보기 →</a>
      </div>
    </div>
  </div>

</div>


    <!-- 페이지네이션 -->
    <c:url var="firstUrl" value="/03_healthinfo.do"><c:param name="page" value="1"/></c:url>
    <c:url var="prevUrl"  value="/03_healthinfo.do"><c:param name="page" value="${hiPage-1}"/></c:url>
    <c:url var="nextUrl"  value="/03_healthinfo.do"><c:param name="page" value="${hiPage+1}"/></c:url>
    <c:url var="lastUrl"  value="/03_healthinfo.do"><c:param name="page" value="${hiTotal}"/></c:url>

    <div class="mt-10 flex justify-center space-x-1 text-sm font-medium">
      <c:if test="${hiPage > 1}">
        <a href="${firstUrl}" class="px-3 py-1 border rounded hover:bg-gray-100">&laquo;</a>
        <a href="${prevUrl}" class="px-3 py-1 border rounded hover:bg-gray-100">&lsaquo;</a>
      </c:if>

      <c:forEach begin="1" end="${hiTotal}" var="i">
        <c:url var="pageUrl" value="/03_healthinfo.do"><c:param name="page" value="${i}"/></c:url>
        <c:choose>
          <c:when test="${i == hiPage}">
            <span class="px-3 py-1 bg-blue-600 text-white rounded">${i}</span>
          </c:when>
          <c:otherwise>
            <a href="${pageUrl}" class="px-3 py-1 border rounded hover:bg-gray-100">${i}</a>
          </c:otherwise>
        </c:choose>
      </c:forEach>

      <c:if test="${hiPage < hiTotal}">
        <a href="${nextUrl}" class="px-3 py-1 border rounded hover:bg-gray-100">&rsaquo;</a>
        <a href="${lastUrl}" class="px-3 py-1 border rounded hover:bg-gray-100">&raquo;</a>
      </c:if>
    </div>

  </main>
</div>
