<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doctor_main.jsp</title>

<!-- ✅ jQuery 필수 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
/* ✅ 모달 스타일 */
#logoutModal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0; top: 0; width: 100%; height: 100%;
    background-color: rgba(0,0,0,0.4);
}
#logoutModalContent {
    background-color: white;
    width: 300px;
    margin: 15% auto;
    padding: 20px;
    text-align: center;
    border-radius: 8px;
    box-shadow: 0 0 10px gray;
}
</style>

<script>
$(function () {
    // 로그아웃 클릭 시 모달 열기
    $("#logoutLink").click(function (e) {
        e.preventDefault();
        $("#logoutModal").fadeIn();
    });

    // 확인 버튼 → 로그아웃 처리
    $("#confirmLogout").click(function () {
        window.location.href = "<%= request.getContextPath() %>/user/logout.do";
    });

    // 취소 버튼 → 모달 닫기
    $("#cancelLogout").click(function () {
        $("#logoutModal").fadeOut();
    });
});
</script>
</head>
<body>

<!-- 세로 메뉴 영역 -->
<div>
    <ul>
        <li><a href="/doctor_schedule.do">진료 일정 관리</a></li>
        <li><a href="/certificates.do">진료 환자 목록 및 진료기록지 작성</a></li>
        <li><a href="/past_certificates.do">과거 진료기록 </a></li>
        <li><a href="/doctor_notice.do">의료진 공지사항(의료진 + 협진)</a></li>
        <li><a href="/referral2/received.do">협진 게시판</a></li>
        <li><a href="/doctor_mypage.do">정보수정</a></li>
        <li><a href="/certificates/doctor/pending.do">제증명 발급 서류 목록</a></li>
        <li><a href="${pageContext.request.contextPath}/user/logout.do" id="logoutLink">로그아웃</a></li> 
         
        
    </ul>
</div>

<!-- ✅ 로그아웃 모달 -->
<div id="logoutModal">
    <div id="logoutModalContent">
        <p>로그아웃하시겠습니까?</p>
        <button id="confirmLogout">확인</button>
        <button id="cancelLogout">취소</button>
    </div>
</div>

</body>
</html>
