<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="bg-white rounded-lg shadow border border-gray-200 w-full h-full min-h-[500px] flex flex-col justify-between">

  <!-- 메뉴 리스트 -->
  <nav class="p-4">
    <ul class="divide-y divide-gray-200 text-gray-900 font-bold text-[15px] tracking-tight">
      <li>
        <a href="/02_directions.do" class="block py-2 hover:text-blue-600 transition-colors duration-150">병원 오시는 길</a>
      </li>
      <li>
        <a href="/02_facilities.do" class="block py-2 hover:text-blue-600 transition-colors duration-150">층별 시설 안내</a>
      </li>
      <li>
        <a href="/02_convenience.do" class="block py-2 hover:text-blue-600 transition-colors duration-150">주변 편의 시설</a>
      </li>
      <li>
        <a href="/02_phone.do" class="block py-2 hover:text-blue-600 transition-colors duration-150">전화번호 안내</a>
      </li>
    </ul>
  </nav>

  <!-- 검색 영역 -->
  <div class="p-4 border-t border-gray-200">
    <form action="${pageContext.request.contextPath}/search.do" method="get" class="flex w-full gap-0">
      <input
        type="text"
        name="keyword"
        placeholder="병원 정보 검색"
        required
        class="flex-1 min-w-0 px-3 py-2 border border-gray-300 rounded-l-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
      />
      <button
        type="submit"
        class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium rounded-r-md"
      >
        🔍
      </button>
    </form>
  </div>
</div>
