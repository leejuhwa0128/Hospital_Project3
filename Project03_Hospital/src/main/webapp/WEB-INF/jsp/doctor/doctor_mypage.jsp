
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료진 마이페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.modal {
    display: none;
    position: fixed;
    top: 30%;
    left: 50%;
    transform: translate(-50%, -30%);
    padding: 20px;
    background-color: #fff;
    border: 1px solid #333;
    box-shadow: 0 0 10px rgba(0,0,0,0.5);
}
</style>
<script>
$(function () {
    $("#cancelBtn").on("click", function () {
        history.back();
    });

    const msg = "${msg}";
    if (msg) {
        $("#modalMessage").text(msg);
        $("#messageModal").fadeIn();
    }

    $("#closeModal").on("click", function () {
        // 메시지가 성공 메시지일 경우 doctor_main.do로 이동
        const messageText = $("#modalMessage").text();
        if (messageText.includes("성공")) {
            location.href = "doctor_main.do";
        } else {
            $("#messageModal").fadeOut();
        }
    });
});
</script>
</head>
<body>

<h2>의료진 마이페이지</h2>

<form action="update_doctor_info.do" method="post">
    <table cellpadding="5">
        <tr>
            <th>ID</th>
            <td>${user.userId}<input type="hidden" name="userId" value="${user.userId}"></td>
        </tr>
        <tr>
            <th>이름</th>
            <td>${user.name}</td>
        </tr>
        <tr>
            <th>기존 비밀번호</th>
            <td>
                <input type="password" name="currentPassword"><br>
                <small>비밀번호 변경 시 기존 비밀번호를 입력해주세요.</small>
            </td>
        </tr>
        <tr>
            <th>새 비밀번호</th>
            <td>
                <input type="password" name="newPassword"><br>
                <small>변경하지 않으려면 비워두세요.</small>
            </td>
        </tr>
        <tr>
            <th>핸드폰</th>
            <td><input type="text" name="phone" value="${user.phone}"></td>
        </tr>
        <tr>
            <th>이메일</th>
            <td><input type="email" name="email" value="${user.email}"></td>
        </tr>
        <tr>
            <th>프로필 소개</th>
            <td><textarea name="bio" rows="4" cols="40">${doctorInfo.bio}</textarea></td>
        </tr>
    </table>
    <br>
    <button type="submit">수정하기</button>
    <button type="button" id="cancelBtn">취소</button>
</form>

<!-- 모달 -->
<div class="modal" id="messageModal">
    <p id="modalMessage"></p>
    <button id="closeModal">확인</button>
</div>

</body>
</html>
