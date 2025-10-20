<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘 진료 환자 목록</title>

<style>
body {
	font-family: 'Segoe UI', Arial, sans-serif;
	background-color: #f8f9fa;
	margin: 30px;
	color: #333;
}

h2 {
	text-align: center;
	font-size: 26px;
	font-weight: bold;
	margin-bottom: 20px;
	color: #2c3e50;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	background: #fff;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

th, td {
	border-bottom: 1px solid #e0e0e0;
	padding: 12px;
	text-align: center;
	font-size: 14px;
}

th {
	background-color: #2c3e50;
	color: white;
	font-weight: 600;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

tr:hover {
	background-color: #f1f7ff;
}

button, a {
	padding: 6px 12px;
	border: none;
	border-radius: 5px;
	font-size: 13px;
	cursor: pointer;
	transition: background 0.3s;
	text-decoration: none;
	display: inline-block;
}

/* 확인 버튼 */
button.viewRecordBtn {
	background-color: #3498db;
	color: white;
}

button.viewRecordBtn:hover {
	background-color: #2980b9;
}

/* 작성하기 버튼 */
a.write-link {
	background-color: #10b981;
	color: white;
}

a.write-link:hover {
	background-color: #0e9e6e;
}

#recordModal, #savedModal {
	display: none;
	position: fixed;
	top: 20%;
	left: 50%;
	transform: translateX(-50%);
	width: 400px;
	padding: 20px;
	background-color: white;
	border: 2px solid #aaa;
	box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
	z-index: 9999;
	border-radius: 8px;
}

#recordModal button, #savedModal button {
	margin-top: 10px;
	width: 100%;
	background-color: #3498db;
	color: white;
	padding: 10px;
	border: none;
	border-radius: 5px;
	font-size: 14px;
}

a.back-link {
	display: block;
	text-align: center;
	margin-top: 30px;
	color: #3498db;
	font-size: 14px;
}

a.back-link:hover {
	text-decoration: underline;
}
</style>
</head>
<body>

	<h2>오늘 진료 환자 목록</h2>

	<table>
		<thead>
			<tr>
				<th>이름</th>
				<th>예약일자</th>
				<th>예약시간</th>
				<th>진료기록지</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="patient" items="${patientList}">
				<tr>
					<td>${patient.patientName}</td>
					<td><fmt:formatDate value="${patient.reservationDate}"
							pattern="yyyy-MM-dd" /></td>
					<td>${patient.scheduleTime}</td>
					<td><c:choose>
							<c:when test="${patient.hasRecord && patient.reservationId > 0}">
								<button type="button" class="viewRecordBtn"
									data-reservation-id="${patient.reservationId}">확인</button>
							</c:when>
							<c:otherwise>
								<a class="write-link"
									href="writeCertificate.do?reservationId=${patient.reservationId}">
									작성하기 </a>
							</c:otherwise>
						</c:choose></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 진단서 확인 모달 -->
	<div id="recordModal">
		<h3>진단서 내용</h3>
		<div id="recordContent">로딩 중...</div>
		<button
			onclick="document.getElementById('recordModal').style.display='none'">닫기</button>
	</div>

	<!-- 작성 완료 모달 -->
	<div id="savedModal">
		<p style="text-align: center;">기록지가 성공적으로 작성되었습니다.</p>
		<button
			onclick="document.getElementById('savedModal').style.display='none'">확인</button>
	</div>

	<!-- 작성 완료시 모달 자동 실행 -->
	<c:if test="${recordSaved}">
		<script>
		window.onload = function () {
			document.getElementById('savedModal').style.display = 'block';
		}
	</script>
	</c:if>

	<!-- 진단서 조회 JS -->
	<script>
document.addEventListener("DOMContentLoaded", function () {
	var buttons = document.querySelectorAll(".viewRecordBtn");
	for (var i = 0; i < buttons.length; i++) {
		buttons[i].addEventListener("click", function () {
			var rid = this.getAttribute("data-reservation-id");

			if (!rid || isNaN(rid) || parseInt(rid) <= 0) {
				alert("❗ 유효하지 않은 예약 ID: " + rid);
				return;
			}

			var url = "getMedicalRecord.do?reservationId=" + encodeURIComponent(rid);

			fetch(url)
				.then(function (res) {
					if (!res.ok) throw new Error("HTTP 오류: " + res.status);
					return res.json();
				})
				.then(function (data) {
					var html = ""
						+ "<p><strong>작성일:</strong> " + data.recordDate + "</p>"
						+ "<p><strong>진단내용</strong><br>" + (data.diagnosis || "-") + "</p>"
						+ "<p><strong>처방내용</strong><br>" + (data.prescription || "-") + "</p>"
						+ "<p><strong>치료내용</strong><br>" + (data.treatment || "-") + "</p>";
					document.getElementById("recordContent").innerHTML = html;
					document.getElementById("recordModal").style.display = "block";
				})
				.catch(function (err) {
					alert("❌ 진료기록지 정보를 불러오는 중 오류 발생:\n" + err.message);
				});
		});
	}
});
</script>



</body>
</html>
