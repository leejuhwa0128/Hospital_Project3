<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정/탈퇴</title>
    <script>
        function confirmDelete() {
            return confirm("정말 탈퇴하시겠습니까?");
        }
    </script>
    <style>
        body {
            font-family: '맑은 고딕', sans-serif;
            padding: 40px;
        }
        h2 {
            margin-bottom: 20px;
        }
        form {
            margin-bottom: 20px;
        }
        input[type="text"], input[type="email"] {
            width: 300px;
            padding: 5px;
        }
        input[type="submit"], button {
            padding: 8px 15px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h2>회원정보 수정 / 탈퇴</h2>

    <!-- ✅ 회원 정보 수정 폼 -->
    <form action="mypage.do" method="post">
        <!-- patientNo는 hidden으로 전달 -->
        <input type="hidden" name="patientNo" value="${loginUser.patientNo}">

        <p>
            아이디: <input type="text" name="patientUserId"
                value="${loginUser.patientUserId}" readonly>
        </p>
        <p>
            이름: <input type="text" name="patientName"
                value="${loginUser.patientName}" required>
        </p>
        <p>
            성별: <input type="text" name="patientGender"
                value="${loginUser.patientGender}" required>
        </p>
        <p>
            이메일: <input type="email" name="patientEmail"
                value="${loginUser.patientEmail}" required>
        </p>
        <p>
            전화번호: <input type="text" name="patientPhone"
                value="${loginUser.patientPhone}" required>
        </p>

	<c:if test="${not empty updated}">
    <script>alert('정보가 성공적으로 수정되었습니다.');</script>
	</c:if>
        
    </form>
    <form action="/patient/editPatientForm.do" method="get">
    <button type="submit">정보 수정</button>
	</form>
	

    <!-- ✅ 회원 탈퇴 버튼 -->
    <form action="/patient/delete.do" method="post" onsubmit="return confirmDelete();">
        <button type="submit">회원 탈퇴</button>
    </form>

    <!-- ✅ 로그아웃 버튼 -->
    <button onclick="location.href='logout.do'">로그아웃</button>

    <!-- ✅ 탈퇴 후 알림 -->
    <c:if test="${param.deleted == '1'}">
        <script>
            alert('회원 탈퇴가 완료되었습니다.');
        </script>
    </c:if>

    <hr>
</body>
</html>

<jsp:include page="/WEB-INF/jsp/footer.jsp" />
