<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   boolean isLoggedIn = (session.getAttribute("loginUser") != null);
Object loginUser = session.getAttribute("loginUser");
String userName = "";
String role = "";
if (loginUser != null) {
   if (loginUser.getClass().getSimpleName().equals("PatientVO")) {
      userName = ((com.hospital.vo.PatientVO) loginUser).getPatientName();
   } else if (loginUser.getClass().getSimpleName().equals("UserVO")) {
      userName = ((com.hospital.vo.UserVO) loginUser).getName();
      role = ((com.hospital.vo.UserVO) loginUser).getRole();
   }
}

// 현재 URL 기준 활성화 메뉴 설정
String uri = request.getRequestURI();
boolean isDeptOrDoctor = uri.contains("/doctor/") || uri.contains("/department/");
boolean isReservation = uri.contains("/reservation/");
boolean isInfoActive = uri.contains("/hospital_info/");
boolean isCustomerActive = uri.contains("/user_service/");
%>

<!-- Tailwind & Flowbite -->
<link href="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.css"
   rel="stylesheet" />

<nav
   class="bg-white border-b border-gray-200 dark:bg-gray-800 relative z-50">
   <div class="max-w-screen-xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex justify-between items-center h-20">

         <!-- 로고 -->
         <a href="${pageContext.request.contextPath}/main.do"
            class="flex-shrink-0"> <img
            src="${pageContext.request.contextPath}/resources/images/mainlogo.png"
            class="h-12" alt="병원 로고">
         </a>

         <!-- 메뉴 -->
         <div class="hidden md:flex space-x-10 items-center">

            <!-- 의료진/진료과 -->
            <div class="relative z-50">
               <button id="dropdownButton1" data-dropdown-toggle="dropdownMenu1"
                  class="text-sm px-4 py-2 rounded hover:bg-gray-100 dark:hover:bg-gray-700 
            <%=isDeptOrDoctor ? "text-blue-700 font-bold" : "text-gray-800 dark:text-white font-semibold"%>">
                  의료진/진료과</button>
               <div id="dropdownMenu1"
                  class="z-50 hidden absolute mt-2 bg-white divide-y divide-gray-100 rounded-lg shadow w-48 dark:bg-gray-700">
                  <ul class="py-2 text-sm text-gray-700 dark:text-gray-200">
                     <li><a
                        href="${pageContext.request.contextPath}/doctor/main.do"
                        class="flex justify-between items-center w-full px-4 py-2 font-bold text-left text-gray-900 border border-gray-200 dark:border-gray-600 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-600">의료진
                     </a></li>
                     <li><a
                        href="${pageContext.request.contextPath}/department/main.do"
                        class="flex justify-between items-center w-full px-4 py-2 font-bold text-left text-gray-900 border border-gray-200 dark:border-gray-600 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-600">진료과
                     </a></li>
                  </ul>
               </div>
            </div>

            <!-- 예약/진료 안내 -->
            <!-- 예약/진료 안내 -->
            <div class="relative z-50">
               <button id="dropdownButton2" data-dropdown-toggle="dropdownMenu2"
                  class="text-sm px-4 py-2 rounded hover:bg-gray-100 dark:hover:bg-gray-700 
    <%=isReservation ? "text-blue-700 font-bold" : "text-gray-800 dark:text-white font-semibold"%>">
                  예약/진료 안내</button>

               <div id="dropdownMenu2"
                  class="z-50 hidden absolute mt-2 bg-white divide-y divide-gray-100 rounded-lg shadow w-64 dark:bg-gray-700">

                  <div id="accordion-reservation" data-accordion="collapse"
                     class="p-2 text-sm text-gray-700 dark:text-gray-200">

                     <!-- 예약 -->
                     <h2>
                        <button type="button"
                           class="flex justify-between items-center w-full px-4 py-2 font-bold text-left text-gray-900 border border-gray-200 dark:border-gray-600 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-600"
                           data-accordion-target="#resv" aria-expanded="false"
                           aria-controls="resv">
                           예약
                           <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd"
                                 d="M5.23 7.21a.75.75 0 011.06-.02L10 10.67l3.71-3.48a.75.75 0 111.04 1.08l-4.25 4a.75.75 0 01-1.04 0l-4.25-4a.75.75 0 01-.02-1.06z"
                                 clip-rule="evenodd" />
          </svg>
                        </button>
                     </h2>
                     <div id="resv" class="hidden">
                        <ul class="py-2">
                           <c:choose>
                              <c:when test="${not empty sessionScope.loginUser}">
                                 <li><a href="${cPath}/reservation.do"
                                    class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">회원
                                       예약 </a></li>
                                 <li><a href="${cPath}/reservation/my.do"
                                    class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">예약내역
                                       조회 </a></li>
                              </c:when>
                              <c:otherwise>
                                 <li><a href="${cPath}/reservation/guest-start.do"
                                    class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">비회원
                                       예약 </a></li>
                                 <li><a
                                    href="${cPath}/reservation/guest-start.do?mode=list"
                                    class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">비회원
                                       예약 조회</a></li>
                              </c:otherwise>
                           </c:choose>
                        </ul>
                     </div>

                     <!-- 진료안내 -->
                     <h2>
                        <button type="button"
                           class="flex justify-between items-center w-full px-4 py-2 font-bold text-left text-gray-900 border border-gray-200 dark:border-gray-600 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-600"
                           data-accordion-target="#guide" aria-expanded="false"
                           aria-controls="guide">
                           진료안내
                           <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd"
                                 d="M5.23 7.21a.75.75 0 011.06-.02L10 10.67l3.71-3.48a.75.75 0 111.04 1.08l-4.25 4a.75.75 0 01-1.04 0l-4.25-4a.75.75 0 01-.02-1.06z"
                                 clip-rule="evenodd" />
          </svg>
                        </button>
                     </h2>
                     <div id="guide" class="hidden">
                        <ul class="py-2">
                           <li><a
                              href="${pageContext.request.contextPath}/reservation/guide.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">진료
                                 안내</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/reservation/counsel.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">진료
                                 상담</a></li>
                        </ul>
                     </div>

                  </div>
               </div>
            </div>


            <!-- 협력기관 -->
            <ul class="your-menu-class">
               <li class="dropdown"><a
                  href="${pageContext.request.contextPath}/referral/logout.do?returnUrl=/referral/main.do"
                  class="text-sm px-4 py-2 rounded hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-800 dark:text-white font-semibold"
                  target="_blank" rel="noopener noreferrer"> 협력기관 </a></li>
            </ul>
            <!-- 병원 정보 -->
            <div class="relative z-50">
               <button id="dropdownButton3" data-dropdown-toggle="dropdownMenu3"
                  class="text-sm px-4 py-2 rounded hover:bg-gray-100 dark:hover:bg-gray-700
    <%=isInfoActive ? "text-blue-700 font-bold" : "text-gray-800 dark:text-white font-semibold"%>">
                  병원 정보</button>

               <div id="dropdownMenu3"
                  class="z-50 hidden absolute mt-2 bg-white divide-y divide-gray-100 rounded-lg shadow w-72 dark:bg-gray-700">

                  <div id="accordion-collapse" data-accordion="collapse"
                     class="p-2 text-sm text-gray-700 dark:text-gray-200">

                     <!-- 병원 소개 -->
                     <h2>
                        <button type="button"
                           class="flex justify-between items-center w-full px-4 py-2 font-bold text-left text-gray-900 border border-gray-200 dark:border-gray-600 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-600"
                           data-accordion-target="#intro" aria-expanded="false"
                           aria-controls="intro">
                           병원 소개
                           <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                              <path fill-rule="evenodd"
                                 d="M5.23 7.21a.75.75 0 011.06-.02L10 10.67l3.71-3.48a.75.75 0 111.04 1.08l-4.25 4a.75.75 0 01-1.04 0l-4.25-4a.75.75 0 01-.02-1.06z"
                                 clip-rule="evenodd" /></svg>
                        </button>
                     </h2>
                     <div id="intro" class="hidden">
                        <ul class="py-2">
                           <li><a
                              href="${pageContext.request.contextPath}/01_overview.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">병원
                                 개요</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/01_mission.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">미션/비전</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/01_greeting.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">인사말</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/01_history.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">연혁</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/01_orgchart.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">조직도</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/01_philosophy.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">운영
                                 철학</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/01_tour.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">병원
                                 둘러보기</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/01_statistics.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">현황
                                 및 통계</a></li>
                        </ul>
                     </div>

                     <!-- 주요 시설 안내 -->
                     <h2>
                        <button type="button"
                           class="flex justify-between items-center w-full px-4 py-2 font-bold text-left text-gray-900 border border-gray-200 dark:border-gray-600 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-600"
                           data-accordion-target="#facility" aria-expanded="false"
                           aria-controls="facility">
                           주요 시설 안내
                           <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                              <path fill-rule="evenodd"
                                 d="M5.23 7.21a.75.75 0 011.06-.02L10 10.67l3.71-3.48a.75.75 0 111.04 1.08l-4.25 4a.75.75 0 01-1.04 0l-4.25-4a.75.75 0 01-.02-1.06z"
                                 clip-rule="evenodd" /></svg>
                        </button>
                     </h2>
                     <div id="facility" class="hidden">
                        <ul class="py-2">
                           <li><a
                              href="${pageContext.request.contextPath}/02_directions.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">병원
                                 오시는 길</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/02_facilities.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">층별
                                 시설 안내</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/02_convenience.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">주변
                                 편의 시설</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/02_phone.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">전화번호
                                 안내</a></li>
                        </ul>
                     </div>

                     <!-- 병원 소식 -->
                     <h2>
                        <button type="button"
                           class="flex justify-between items-center w-full px-4 py-2 font-bold text-left text-gray-900 border border-gray-200 dark:border-gray-600 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-600"
                           data-accordion-target="#news" aria-expanded="false"
                           aria-controls="news">
                           병원 소식
                           <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                              <path fill-rule="evenodd"
                                 d="M5.23 7.21a.75.75 0 011.06-.02L10 10.67l3.71-3.48a.75.75 0 111.04 1.08l-4.25 4a.75.75 0 01-1.04 0l-4.25-4a.75.75 0 01-.02-1.06z"
                                 clip-rule="evenodd" /></svg>
                        </button>
                     </h2>
                     <div id="news" class="hidden">
                        <ul class="py-2">
                           <li><a
                              href="${pageContext.request.contextPath}/03_press.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">언론
                                 보도</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/03_recruit.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">채용
                                 공고</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/03_news.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">병원
                                 소식</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/03_healthinfo.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">건강
                                 정보</a></li>
                        </ul>
                     </div>

                     <!-- 사회공헌 -->
                     <h2>
                        <button type="button"
                           class="flex justify-between items-center w-full px-4 py-2 font-bold text-left text-gray-900 border border-gray-200 dark:border-gray-600 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-600"
                           data-accordion-target="#social" aria-expanded="false"
                           aria-controls="social">
                           사회공헌
                           <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                              <path fill-rule="evenodd"
                                 d="M5.23 7.21a.75.75 0 011.06-.02L10 10.67l3.71-3.48a.75.75 0 111.04 1.08l-4.25 4a.75.75 0 01-1.04 0l-4.25-4a.75.75 0 01-.02-1.06z"
                                 clip-rule="evenodd" /></svg>
                        </button>
                     </h2>
                     <div id="social" class="hidden">
                        <ul class="py-2">
                           <li><a
                              href="${pageContext.request.contextPath}/04_donation.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">기부
                                 소개</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/04_volunteer.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">의료
                                 봉사 활동</a></li>
                           <li><a href="${pageContext.request.contextPath}/04_esg.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">ESG
                                 활동</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/04_community.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">지역
                                 사회 협력</a></li>
                        </ul>
                     </div>

                  </div>
               </div>
            </div>

            <!-- 고객서비스 -->
            <div class="relative z-50">
               <button id="dropdownButton4" data-dropdown-toggle="dropdownMenu4"
                  class="text-sm px-4 py-2 rounded hover:bg-gray-100 dark:hover:bg-gray-700
    <%=isCustomerActive ? "text-blue-700 font-bold" : "text-gray-800 dark:text-white font-semibold"%>">
                  고객서비스</button>

               <div id="dropdownMenu4"
                  class="z-50 hidden absolute mt-2 bg-white divide-y divide-gray-100 rounded-lg shadow w-72 dark:bg-gray-700">

                  <div id="accordion-customer" data-accordion="collapse"
                     class="p-2 text-sm text-gray-700 dark:text-gray-200">

                     <!-- 이용 안내 -->
                     <h2>
                        <button type="button"
                           class="flex justify-between items-center w-full px-4 py-2 font-bold text-left text-gray-900 border border-gray-200 dark:border-gray-600 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-600"
                           data-accordion-target="#cs-use" aria-expanded="false"
                           aria-controls="cs-use">
                           이용 안내
                           <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                              <path fill-rule="evenodd"
                                 d="M5.23 7.21a.75.75 0 011.06-.02L10 10.67l3.71-3.48a.75.75 0 111.04 1.08l-4.25 4a.75.75 0 01-1.04 0l-4.25-4a.75.75 0 01-.02-1.06z"
                                 clip-rule="evenodd" /></svg>
                        </button>
                     </h2>
                     <div id="cs-use" class="hidden">
                        <ul class="py-2">
                           <li><a
                              href="${pageContext.request.contextPath}/01_notice/list.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">공지사항</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/01_lecture/list.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">강좌
                                 및 행사</a></li>
                        </ul>
                     </div>
                     <!-- 서류 발급 -->
                     <h2>
                        <button type="button"
                           class="flex justify-between items-center w-full px-4 py-2 font-bold text-left 
           text-gray-900 border border-gray-200 dark:border-gray-600 
           dark:text-white hover:bg-gray-100 dark:hover:bg-gray-600"
                           data-accordion-target="#cs-docs" aria-expanded="false"
                           aria-controls="cs-docs">
                           서류 발급
                           <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
      <path fill-rule="evenodd"
                                 d="M5.23 7.21a.75.75 0 011.06-.02L10 10.67l3.71-3.48a.75.75 
           0 111.04 1.08l-4.25 4a.75.75 0 01-1.04 0l-4.25-4a.75.75 
           0 01-.02-1.06z"
                                 clip-rule="evenodd" />
    </svg>
                        </button>
                     </h2>
                     <div id="cs-docs" class="hidden">
                        <ul class="py-2">
                           <li><a
                              href="${pageContext.request.contextPath}/certificates/request.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">
                                 제증명 발급</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/certificates/history.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">
                                 서류 발급 이력 조회</a></li>
                        </ul>
                     </div>

                     <!-- 고객 소통 -->
                     <h2>
                        <button type="button"
                           class="flex justify-between items-center w-full px-4 py-2 font-bold text-left text-gray-900 border border-gray-200 dark:border-gray-600 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-600"
                           data-accordion-target="#cs-comm" aria-expanded="false"
                           aria-controls="cs-comm">
                           고객 소통
                           <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                              <path fill-rule="evenodd"
                                 d="M5.23 7.21a.75.75 0 011.06-.02L10 10.67l3.71-3.48a.75.75 0 111.04 1.08l-4.25 4a.75.75 0 01-1.04 0l-4.25-4a.75.75 0 01-.02-1.06z"
                                 clip-rule="evenodd" /></svg>
                        </button>
                     </h2>
                     <div id="cs-comm" class="hidden">
                        <ul class="py-2">
                           <li><a
                              href="${pageContext.request.contextPath}/03_faq/list.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">FAQ</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/03_feedback/list.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">고객의
                                 소리</a></li>
                           <li><a
                              href="${pageContext.request.contextPath}/03_praise/list.do"
                              class="block px-6 py-2 hover:bg-gray-100 dark:hover:bg-gray-700">칭찬
                                 릴레이</a></li>
                        </ul>
                     </div>

                  </div>
               </div>
            </div>

         </div>

         <!-- 로그인 영역 -->

         <button onclick="handleUserIconClick()"
            class="text-gray-700 hover:text-blue-600">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none"
               viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
               class="w-6 h-6">
    <path stroke-linecap="round" stroke-linejoin="round"
                  d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.5 20.25a8.25 8.25 0 1115 0v.75H4.5v-.75z" />
  </svg>
         </button>




      </div>
   </div>
</nav>

<!-- 역할 기반 이동 -->
<!-- 역할 기반 이동: 기존 <script> 전체 교체 -->
<script>
  function handleUserIconClick() {
    const ctx = "${pageContext.request.contextPath}";
    const isLoggedIn = <%= (loginUser != null) %>;
    if (!isLoggedIn) {
      location.href = ctx + "/loginSelector.do";
      return;
    }

    // 세션 타입/역할 안전하게 읽기
    const userType = "<%= (loginUser != null ? loginUser.getClass().getSimpleName() : "") %>";
    const roleVal = ("${sessionScope.loginUser.role}" || "").toString().trim().toLowerCase();

    // 환자 세션이면 환자 마이페이지
    if (userType === "PatientVO") {
      location.href = ctx + "/user/patientPage.do";
      return;
    }

    // 역할 기반 라우팅 (의사/협진)
    if (roleVal === "doctor") {
      location.href = ctx + "/user/doctorPage.do";
      return;
    }
    if (roleVal === "coop") {
      location.href = ctx + "/user/coopPage.do";
      return;
    }

    // 그 외 기본 이동
    location.href = ctx + "/loginSelector.do";
  }
</script>


<!-- Flowbite JS -->
<script src="https://unpkg.com/flowbite@2.3.0/dist/flowbite.min.js"></script>
