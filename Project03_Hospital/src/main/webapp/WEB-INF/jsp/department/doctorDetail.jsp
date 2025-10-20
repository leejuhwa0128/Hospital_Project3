<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="ko_KR" />
<fmt:setTimeZone value="Asia/Seoul" />

<%
   java.time.LocalDate base;
String dParam = request.getParameter("d");
base = (dParam != null && !dParam.isEmpty()) ? java.time.LocalDate.parse(dParam) : java.time.LocalDate.now();

int startDow = java.time.DayOfWeek.WEDNESDAY.getValue();
int diff = (7 + base.getDayOfWeek().getValue() - startDow) % 7;
java.time.LocalDate weekStart = base.minusDays(diff);

java.util.List<String> weekDateStrs = new java.util.ArrayList<>();
for (int i = 0; i < 7; i++)
   weekDateStrs.add(weekStart.plusDays(i).toString());

request.setAttribute("weekDates", weekDateStrs);
request.setAttribute("prevDate", weekStart.minusDays(7).toString());
request.setAttribute("nextDate", weekStart.plusDays(7).toString());
%>

<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${doctor.name}교수·${doctor.deptName}|진료일정</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

   <div class="max-w-screen-xl mx-auto px-4 py-10">

      <!-- 상단 프로필 -->
      <div class="grid grid-cols-1 md:grid-cols-[220px_1fr] gap-8 items-stretch">
    <!-- 프로필 사진 -->
    <c:set var="imgFile"
        value="${empty doctor.profileImagePath ? doctor.doctorId.concat('.png') : doctor.profileImagePath}" />
    <c:choose>
        <c:when test="${fn:startsWith(imgFile, 'http')}">
            <c:set var="imgSrc" value="${imgFile}" />
        </c:when>
        <c:when test="${fn:startsWith(imgFile, '/')}">
            <c:url value="${imgFile}" var="imgSrc" />
        </c:when>
        <c:otherwise>
            <c:url value="/resources/images/doctor/${imgFile}" var="imgSrc" />
        </c:otherwise>
    </c:choose>

    <div class="w-full h-full">
        <img src="${imgSrc}" alt="${doctor.name}"
             class="w-full h-full object-cover rounded-xl shadow"
             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/resources/images/default-doctor.png';" />
    </div>
         <!-- 텍스트 정보 -->
         <div>
            <h1 class="text-3xl font-extrabold mb-1">${doctor.name}</h1>
            <p class="text-blue-600 font-semibold mb-4">${doctor.deptName}</p>

            <!-- 전문 분야 -->
            <c:if test="${not empty doctor.specialty}">
               <div class="flex flex-wrap gap-2 mb-6">
                  <c:forEach var="sp" items="${fn:split(doctor.specialty, ',')}">
                     <span
                        class="bg-blue-100 text-blue-800 text-xs px-3 py-1 rounded-full">${fn:trim(sp)}</span>
                  </c:forEach>
               </div>
            </c:if>
            <c:choose>
           <c:when test="${not empty sessionScope.loginUser}">
             <c:url var="reserveUrl" value="/reservation.do"/>
           </c:when>
           <c:otherwise>
             <!-- 로그인 안 된 경우: 게스트 시작으로 보냄 -->
             <c:url var="reserveUrl" value="/reservation/guest-start.do">
               <!-- 선택: 돌아올 때 필요하면 파라미터 전달 -->
               <c:param name="from" value="doctorDetail"/>
               <c:param name="doctorId" value="${doctor.doctorId}"/>
             </c:url>
           </c:otherwise>
         </c:choose>

            <!-- 버튼들 -->
            <div class="flex flex-wrap gap-3 mb-6">
               <a href="${reserveUrl}"
               class="bg-blue-600 text-white text-sm font-medium px-4 py-2 rounded hover:bg-blue-700 transition">
              예약하기
            </a> <a
                  href="${pageContext.request.contextPath}/doctor/list.do?deptId=${doctor.deptId}"
                  class="bg-white border text-sm px-4 py-2 rounded hover:bg-gray-50">
                  ${doctor.deptName} 의료진 찾기 </a> <a
                  href="${pageContext.request.contextPath}/department/detail.do?deptId=${doctor.deptId}"
                  class="bg-white border text-sm px-4 py-2 rounded hover:bg-gray-50">
                  ${doctor.deptName} 정보 </a>
            </div>

            <!-- 학력/경력 -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
               <!-- 학력 -->
               <div class="bg-white p-5 shadow rounded">
                  <h3 class="text-lg font-semibold mb-2">🎓 학력</h3>
                  <ul class="text-sm list-disc pl-5 space-y-1">
                     <li>한국대학교 의과대학 졸업</li>
                     <li>한국대학교 의과대학 의학과 대학원 석사</li>
                     <li>한국대학교 의과대학 의학과 대학원 박사</li>
                  </ul>
               </div>

               <!-- 경력 -->
               <div class="bg-white p-5 shadow rounded">
                  <h3 class="text-lg font-semibold mb-2">💼 경력</h3>
                  <ul class="text-sm list-disc pl-5 space-y-1">
                     <li>한국대학교 의과대학 전임의</li>
                     <li>코리아병원 임상시험센터 임상전임강사</li>
                     <li>코리아병원 의학교실 전임강사</li>
                     <li>Welcome to KOREA 교환교수</li>
                  </ul>
               </div>
            </div>
         </div>
      </div>

      <!-- 스케줄 -->
      <div class="mt-12">
         <h2 class="text-xl font-bold mb-4">🗓 진료 스케줄</h2>

         <%-- 타이틀 날짜 주차 계산 --%>
         <%
            java.util.List<?> _wds = (java.util.List<?>) request.getAttribute("weekDates");
         java.time.LocalDate _ws = java.time.LocalDate.parse((String) _wds.get(0));
         int _weekNo = (_ws.getDayOfMonth() - 1) / 7 + 1;
         String _titleTxt = String.format("%d월 %d주", _ws.getMonthValue(), _weekNo);
         %>

         <!-- 주간 네비게이션 -->
         <div class="flex justify-between items-center mb-4">
            <a href="?doctorId=${doctor.doctorId}&d=${prevDate}"
               class="text-sm text-blue-600 hover:underline">◀ 지난주</a>
            <div class="text-base font-semibold"><%=_titleTxt%></div>
            <a href="?doctorId=${doctor.doctorId}&d=${nextDate}"
               class="text-sm text-blue-600 hover:underline">다음주 ▶</a>
         </div>

         <!-- 범례 -->
         <div class="text-xs text-right text-gray-500 mb-2 space-x-2">
            <span class="font-bold text-blue-500">◆</span> 학회 <span
               class="font-bold text-red-500">●</span> 강의 <span
               class="font-bold text-gray-400">✖</span> 휴가 <span
               class="font-bold text-green-500">■</span> 기타
         </div>

         <!-- 스케줄 테이블 -->
         <div class="overflow-x-auto bg-white rounded shadow">
            <table class="min-w-full text-sm text-center">
               <thead>
                  <tr class="bg-gray-100">
                     <th class="py-2 px-2">구분</th>
                     <c:forEach var="dStr" items="${weekDates}">
                        <fmt:parseDate value="${dStr}" pattern="yyyy-MM-dd"
                           var="dParsed" />
                        <th class="py-2 px-2"><fmt:formatDate value="${dParsed}"
                              pattern="E" /></th>
                     </c:forEach>
                  </tr>
                  <tr class="bg-gray-50">
                     <th class="py-1 px-2"></th>
                     <c:forEach var="dStr" items="${weekDates}">
                        <fmt:parseDate value="${dStr}" pattern="yyyy-MM-dd"
                           var="dParsed" />
                        <th class="py-1 px-2"><fmt:formatDate value="${dParsed}"
                              pattern="dd" />일</th>
                     </c:forEach>
                  </tr>
               </thead>
               <tbody>
                  <!-- ✅ 문자열을 리스트로 변환 -->
                  <c:set var="slots" value="${fn:split('오전,오후', ',')}" />

                  <c:forEach var="slot" items="${slots}">
                     <tr class="border-t">
                        <th class="py-2 px-2 bg-gray-50">${slot}</th>

                        <c:forEach var="dStr" items="${weekDates}">
                           <td class="py-2 px-2"><c:set var="cell" value="" /> <c:forEach
                                 var="sc" items="${scheduleList}">
                                 <fmt:formatDate value="${sc.scheduleDate}"
                                    pattern="yyyy-MM-dd" var="scDate" />
                                 <c:if
                                    test="${scDate eq dStr && fn:trim(sc.timeSlot) eq slot}">
                                    <c:set var="stype"
                                       value="${empty sc.scheduleType ? sc.note : sc.scheduleType}" />
                                    <c:choose>
                                       <c:when test="${stype eq '외래진료'}">
                                          <c:set var="cell" value="" />
                                       </c:when>
                                       <c:when test="${stype eq '강의'}">
                                          <c:set var="cell"
                                             value="<span class='text-red-500 font-bold'>●</span>" />
                                       </c:when>
                                       <c:when test="${stype eq '학회'}">
                                          <c:set var="cell"
                                             value="<span class='text-blue-500 font-bold'>◆</span>" />
                                       </c:when>
                                       <c:when test="${stype eq '휴가'}">
                                          <c:set var="cell"
                                             value="<span class='text-gray-400 font-bold'>✖</span>" />
                                       </c:when>
                                       <c:otherwise>
                                          <c:set var="cell"
                                             value="<span class='text-green-600 font-bold'>■</span>" />
                                       </c:otherwise>
                                    </c:choose>


                                 </c:if>
                              </c:forEach> <c:out value="${cell}" escapeXml="false" /></td>
                        </c:forEach>
                     </tr>
                  </c:forEach>
               </tbody>
            </table>
         </div>
      </div>

   </div>

   <jsp:include page="/WEB-INF/jsp/footer.jsp" />
</body>
</html>
