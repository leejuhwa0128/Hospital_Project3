<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>주변 편의시설</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-7xl mx-auto px-4 py-12">
    <div>

      <!-- 타이틀 -->
      <h2 class="text-xl sm:text-2xl font-semibold text-black mb-6 border-b border-gray-200 pb-2">
         주변 편의시설
      </h2>

      <!-- 카드 그리드 -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <!-- 카드 반복 -->
        <%
          String[][] facilities = {
            {"facility_food.jpg", "식당", "맛있어 식당", "장소: B관 B2층 로비<br>이용시간: 평일 07:30~20:00<br>토요일 08:00~19:00<br>일요일·공휴일 10:00~18:00<br>*15:00~16:30 브레이크 타임<br>전화: 070-4060-6820"},
            {"facility_conv.jpg", "편의점", "다있어 편의점", "장소: B관 B2층 로비<br>이용시간: 24시간<br>전화: 원내 1439"},
            {"facility_cafe.jpg", "커피전문점", "건강해 카페", "장소: A관 1층 로비<br>평일 06:30~20:00<br>토요일 06:30~19:00<br>일요일·공휴일 06:30~18:00<br>전화: 070-8633-8234"},
            {"facility_cafe2.jpg", "커피전문점", "행복해 카페", "장소: C관 5층<br>평일 07:00~18:00<br>토요일 07:00~15:00<br>일요일·공휴일 미운영"},
            {"facility_rest.jpg", "휴게실", "쉬어가 휴게실", "장소: B관 B2층 로비<br>평일 07:00~21:00<br>토요일 07:00~20:00<br>일요일·공휴일 09:00~19:00<br>전화: 원내 1431"},
            {"facility_bank.jpg", "은행", "다줄게 은행", "장소: B관 B2층 로비<br>평일 09:00~16:00<br>토요일·일요일·공휴일 미운영"},
            {"facility_pharmacy.jpg", "약국", "아프지마 약국", "장소: A관 1층<br>이용시간: 평일 08:00~20:00<br>토요일 09:00~14:00<br>일요일·공휴일 미운영"},
            {"facility_atm.jpg", "ATM", "돈많아 ATM", "장소: A관 1층 로비<br>이용시간: 24시간 운영"},
            {"facility_flower.jpg", "플라워샵", "향긋해 꽃집", "장소: A관 1층<br>평일 09:00~18:00<br>토요일 09:00~15:00<br>전화: 02-1234-5678"}
          };

          for (String[] f : facilities) {
        %>
        <div class="bg-white rounded-lg shadow border border-gray-200 overflow-hidden hover:shadow-md transition">
          <img src="${pageContext.request.contextPath}/resources/images/<%= f[0] %>" alt="<%= f[2] %>" class="w-full h-48 object-cover">
          <div class="p-4">
            <p class="text-sm text-blue-600 font-medium mb-1"><%= f[1] %></p>
            <h4 class="text-lg font-semibold text-gray-900 mb-2"><%= f[2] %></h4>
            <p class="text-sm text-gray-700 leading-relaxed">
              <%= f[3] %>
            </p>
          </div>
        </div>
        <% } %>
      </div>

    </div>
  </div>

</body>
</html>
