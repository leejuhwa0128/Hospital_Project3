<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>사용자 활동 로그</title>
<style>
table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}
</style>
</head>
<body>
	<h2>📝 사용자 활동 로그</h2>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>사용자 ID</th>
				<th>액션</th>
				<th>대상 테이블</th>
				<th>대상 ID</th>
				<th>타임스탬프</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="log" items="${logList}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${log.userId}</td>
					<td>${log.action}</td>
					<td>${log.targetTable}</td>
					<td>${log.targetId}</td>
					<td><fmt:formatDate value="${log.timestamp}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>
