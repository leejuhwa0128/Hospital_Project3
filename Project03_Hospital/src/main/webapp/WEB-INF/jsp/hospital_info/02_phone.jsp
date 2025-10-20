<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>전화번호 안내</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    .modal-overlay {
      display: none;
    }
    .modal-overlay.show {
      display: flex;
    }
  </style>
</head>
<body class="bg-gray-50 text-gray-800">

  <div class="max-w-7xl mx-auto px-4 py-12">
    <div>
      
      <!-- 제목 -->
      <h2 class="text-xl sm:text-2xl font-semibold text-black mb-6 border-b border-gray-200 pb-2">
         전화번호 안내
      </h2>

      <!-- 전화번호 카드 -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        <!-- 반복되는 카드들 -->
        <%
          String[][] phones = {
            {"대표 번호", "02-1234-5678", "평일 09:00~18:00", "병원 대표창구로 진료과 안내 및 연결"},
            {"진료 예약", "02-1234-1111", "평일 08:30~17:30", "진료 예약, 일정 변경 및 취소"},
            {"건강검진", "02-1234-2222", "평일 08:00~17:00", "검진 예약 및 준비사항 안내"},
            {"고객센터", "02-1234-3333", "평일 09:00~18:00", "민원 접수 및 병원 이용 관련 문의"}
          };

          for (int i = 0; i < phones.length; i++) {
        %>
        <div onclick="openModal('<%= phones[i][0] %>', '<%= phones[i][1] %>', '<%= phones[i][2] %>', '<%= phones[i][3] %>')"
          class="cursor-pointer bg-white border border-gray-200 rounded-lg p-6 shadow hover:shadow-md transition">
          <p class="text-sm text-blue-600 font-medium mb-1"><%= phones[i][0] %></p>
          <p class="text-xl font-semibold text-gray-900"><%= phones[i][1] %></p>
        </div>
        <% } %>
      </div>
    </div>
  </div>

  <!-- 모달 -->
  <div id="phoneModal" class="modal-overlay fixed inset-0 bg-black bg-opacity-50 z-50 items-center justify-center">
    <div class="bg-white rounded-lg shadow-lg w-full max-w-md mx-4">
      <div class="flex justify-between items-center px-6 py-4 border-b border-gray-200">
        <h3 id="modalTitle" class="text-lg font-semibold text-gray-800">제목</h3>
        <button onclick="closeModal()" class="text-gray-400 hover:text-gray-700 text-xl font-bold">&times;</button>
      </div>
      <div class="p-6 text-gray-700 space-y-2 text-sm">
        <p id="modalNumber" class="text-base font-bold text-blue-600">전화번호</p>
        <p id="modalTime">운영시간</p>
        <p id="modalDesc">설명</p>
      </div>
    </div>
  </div>

  <script>
    function openModal(title, number, time, desc) {
      document.getElementById('modalTitle').innerText = title;
      document.getElementById('modalNumber').innerText = number;
      document.getElementById('modalTime').innerText = "운영시간: " + time;
      document.getElementById('modalDesc').innerText = desc;
      document.getElementById('phoneModal').classList.add('show');
    }

    function closeModal() {
      document.getElementById('phoneModal').classList.remove('show');
    }
  </script>

</body>
</html>
