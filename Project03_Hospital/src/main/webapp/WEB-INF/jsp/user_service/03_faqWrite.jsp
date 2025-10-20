<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 작성</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_service/03/faqform.css">
</head>
<body>
	<div class="main-container">
		<jsp:include page="/WEB-INF/jsp/user_service/03_menu.jsp" />
		<div class="content-area">
			<h2>FAQ 작성</h2>
			<form action="${pageContext.request.contextPath}/03_faq/write.do"
				method="post">
				<table>
					<tr>
						<th>카테고리</th>
						<td><select name="category" required>
								<option value="">선택</option>
								<option value="진료예약">진료예약</option>
								<option value="외래진료">외래진료</option>
								<option value="입퇴원">입퇴원</option>
								<option value="서류발급">서류발급</option>
								<option value="병원안내">병원안내</option>
								<option value="기타">기타</option>
						</select></td>
					</tr>
					<tr>
						<th>질문</th>
						<td><input type="text" name="question" required></td>
					</tr>
					<tr>
						<th>답변</th>
						<td><textarea name="answer" rows="8" required></textarea></td>
					</tr>
				</table>
				<br>
				<button type="submit">등록</button>
				<button type="button" onclick="history.back()">취소</button>
			</form>
		</div>
	</div>
</body>
</html>
