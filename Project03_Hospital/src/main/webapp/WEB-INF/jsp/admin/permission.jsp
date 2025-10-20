<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>권한 수정</title>
<style>
table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	border: 1px solid #ccc;
	padding: 10px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}

form {
	margin: 0;
}
</style>
</head>
<body>

	<h2>사용자 권한 수정</h2>
	<table>
		<thead>
			<tr>
				<th>사용자 ID</th>
				<th>이름</th>
				<th>현재 권한</th>
				<th>권한 변경</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="user" items="${userList}">
				<tr>
					<td>${user.userId}</td>
					<td>${user.name}</td>
					<td>${user.role}</td>
					<td>
						<form
							action="${pageContext.request.contextPath}/admin/updateUserRole.do"
							method="post">
							<input type="hidden" name="userId" value="${user.userId}" /> <select
								name="role">
								<option value="admin" ${user.role == 'admin' ? 'selected' : ''}>관리자</option>
								<option value="doctor"
									${user.role == 'doctor' ? 'selected' : ''}>의사</option>
								<option value="nurse" ${user.role == 'nurse' ? 'selected' : ''}>간호사</option>
								<option value="coop" ${user.role == 'coop' ? 'selected' : ''}>협력기관</option>
							</select> <input type="submit" value="수정" />
						</form>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</body>
</html>
