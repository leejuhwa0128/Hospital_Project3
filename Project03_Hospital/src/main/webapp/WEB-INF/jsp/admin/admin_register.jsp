<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 등록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/default.css" />
<script src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath}/js/swiper.min.js"></script>
<script src="${pageContext.request.contextPath}/js/design.js"></script>
</head>
<body>
	<div class="body_wrap"></div>
	<div class="con_wrap bg_13">
		<div class="doctor">
			<div class="doc_left bg_w">
				<form action="${pageContext.request.contextPath}/admin/register.do"
					method="post">
					<div class="doc_con">
						<p class="f_s17 f_w500">아이디</p>
						<input type="text" name="adminId" required />
					</div>
					<div class="doc_con">
						<p class="f_s17 f_w500">비밀번호</p>
						<input type="password" name="password" required />
					</div>
					<div class="doc_con">
						<p class="f_s17 f_w500">이름</p>
						<input type="text" name="name" required />
					</div>
					<div class="doc_con">
						<p class="f_s17 f_w500">이메일</p>
						<input type="email" name="email" />
					</div>
					<div class="doc_con">
						<p class="f_s17 f_w500">전화번호</p>
						<input type="text" name="phone" />
					</div>
					<div class="doc_bottom f_s16 f_w600">
						<button type="submit" class="bg_2">등록하기</button>
						<a href="${pageContext.request.contextPath}/admin/dashboard.do">관리자
							메인으로</a>
					</div>
				</form>
			</div>
		</div>
		<c:if test="${not empty success}">
			<p class="c_g">${success}</p>
		</c:if>
		<c:if test="${not empty error}">
			<p class="c_r">${error}</p>
		</c:if>
	</div>
	<div class="footer bg_13 f_s15">2025 itwill</div>
	</div>
	</div>
</body>
</html>
