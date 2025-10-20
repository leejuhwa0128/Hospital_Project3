<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>의사 관리</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
</head>
<body>

	<h2>의사 목록</h2>

	<div class="search-box">
		<form
			action="${pageContext.request.contextPath}/admin/doctorSearch.do"
			method="get">
			<input type="text" name="keyword" placeholder="이름 또는 전문분야"
				value="${param.keyword}" />
			<button type="submit" class="btn">검색</button>
		</form>
	</div>

	<table class="data-table">
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>진료과</th>
				<th>전문분야</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="doc" items="${doctorList}">
				<tr>
					<td>${doc.doctorId}</td>
					<td>${doc.name}</td>

					<!-- 진료과: select는 아래 저장폼(id=f_의사ID)로 연결 -->
					<td><select name="deptId" form="f_${doc.doctorId}">
							<c:forEach var="dept" items="${deptList}">
								<option value="${dept.deptId}"
									${dept.deptId == doc.deptId ? 'selected' : ''}>${dept.name}</option>
							</c:forEach>
					</select></td>

					<!-- 전문분야: input도 동일 폼으로 연결 -->
					<td><input type="text" name="specialty"
						value="${doc.specialty}" form="f_${doc.doctorId}" /></td>

					<td>
						<!-- 저장 폼(행 단위) -->
						<form id="f_${doc.doctorId}" class="inline-form" method="post"
							action="${pageContext.request.contextPath}/admin/updateDoctor.do">
							<input type="hidden" name="doctorId" value="${doc.doctorId}">
							<button type="submit" class="btn-action btn-save">저장</button>
						</form> <!-- 상세 보기 -->
						<form class="inline-form" method="get"
							action="${pageContext.request.contextPath}/admin/doctorDetail.do">
							<input type="hidden" name="doctorId" value="${doc.doctorId}">
							<button type="submit" class="btn-action btn-view">상세</button>
						</form> <!-- 삭제 -->
						<form class="inline-form" method="post"
							action="${pageContext.request.contextPath}/admin/deleteDoctor.do">
							<input type="hidden" name="doctorId" value="${doc.doctorId}">
							<button type="submit" class="btn-action btn-delete"
								onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
						</form>
					</td>
				</tr>
			</c:forEach>

			<c:if test="${empty doctorList}">
				<tr>
					<td colspan="5" style="text-align: center;">등록된 의사가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

</body>
</html>
