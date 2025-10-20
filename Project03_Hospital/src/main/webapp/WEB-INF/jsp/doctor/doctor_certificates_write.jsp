
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진단서 작성</title>
<style>
body {
	font-family: Arial, sans-serif;
	padding: 30px;
	background: #f8f9fa;
}

.form-container {
	width: 700px; /* 👉 전체 폭 늘림 */
	margin: 0 auto;
	border: 1px solid #ddd;
	padding: 30px;
	border-radius: 10px;
	background: #fff;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.form-container h2 {
	text-align: center;
	margin-bottom: 25px;
	font-size: 26px; /* 👉 제목 크게 */
	font-weight: bold;
}

.form-container label {
	display: block;
	margin-top: 20px;
	font-weight: bold;
	font-size: 16px; /* 👉 라벨 크게 */
}

.form-container input, .form-container textarea {
	width: 100%;
	padding: 14px; /* 👉 입력칸 padding 넉넉 */
	margin-top: 8px;
	box-sizing: border-box;
	border: 1px solid #bbb;
	border-radius: 8px;
	font-size: 15px; /* 👉 글자 키움 */
}

/* ✅ 문진표 textarea 전용 스타일 */
.form-container textarea.readonly-text {
	height: 300px; /* 👉 훨씬 크게 */
	resize: vertical;
	background: #f9f9f9;
	font-size: 15px;
	line-height: 1.6;
}

/* 일반 진단/처방/치료 textarea도 조금 더 크게 */
.form-container textarea {
	min-height: 160px;
}

/* 버튼 */
.form-container button {
	margin-top: 25px;
	width: 100%;
	padding: 14px;
	font-size: 18px; /* 👉 버튼 글씨 키움 */
	font-weight: bold;
	background: #2563eb;
	color: #fff;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background 0.2s ease;
}

.form-container button:hover {
	background: #1d4ed8;
}
</style>
</head>
<body>
	<div class="form-container">
		<form action="${pageContext.request.contextPath}/saveCertificate.do"
			method="post">

			<h2 style="text-align: center;">진료기록지 작성</h2>

			<div>
				환자 이름 : ${reservation.patientName}<br /> <input type="hidden"
					name="reservationId"
					value="${empty reservation ? param.reservationId : reservation.reservationId}" />



			</div>

			<div>
				작성일 :
				<fmt:formatDate value="${reservation.reservationDate}"
					pattern="yyyy-MM-dd" />
				<br />
			</div>
			<div>
				문진표
				<textarea class="readonly-text" readonly>${questionnaire.content}</textarea>
			</div>
			<div>
				진단 <br />
				<textarea name="diagnosis" rows="5" cols="50"></textarea>
			</div>

			<div>
				처방 <br />
				<textarea name="prescription" rows="5" cols="50"></textarea>
			</div>
			<div>
				치료 <br />
				<textarea name="treatment" rows="5" cols="50"></textarea>
			</div>

			<div>
				<button type="submit">저장하기</button>
			</div>
		</form>
	</div>


</body>
</html>
