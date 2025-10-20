<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>협력의사 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css">
</head>
<body>

<div class="detail-container">
  <h2>협력의사 상세 정보</h2>

  <table class="detail-table">
    <tbody>
      <tr><th>아이디</th><td>${coopUser.userId}</td></tr>
      <tr><th>이름</th><td>${coopUser.name}</td></tr>
      <tr><th>주민번호</th><td>${coopUser.rrn}</td></tr>
      <tr><th>성별</th><td>${coopUser.gender}</td></tr>
      <tr><th>전화번호</th><td>${coopUser.phone}</td></tr>
      <tr><th>이메일</th><td>${coopUser.email}</td></tr>
      <tr><th>소속 병원</th><td>${coopUser.hospitalName}</td></tr>
      <tr>
        <th>가입일</th>
        <td><fmt:formatDate value="${coopUser.regDate}" pattern="yyyy-MM-dd" /></td>
      </tr>
    </tbody>
  </table>

  <div class="button-group left">
    <!-- 협진 요청 내역(해당 협력의의 내역으로 이동) -->
    <a href="<c:url value='/referral/myReferrals.do?userId=${coopUser.userId}&hospitalId=${coopUser.hospitalId}'/>"
       class="btn-action btn-view">협진 요청 내역</a>

    <button type="button" class="btn-action btn-view" onclick="history.back()">뒤로가기</button>

    <!-- 협진 요청 등록: 
         - 관리자는 대상 협력의 파라미터를 포함해서 컨트롤러로 이동
         - 협력의 본인 로그인 시에는 파라미터 없이 이동 -->
    <c:if test="${not empty sessionScope.loginAdmin}">
      <a class="btn-action btn-save"
         href="<c:url value='/referral/referralForm.do'>
                  <c:param name='coopUserId' value='${coopUser.userId}'/>
                  <c:param name='coopHospitalId' value='${coopUser.hospitalId}'/>
               </c:url>">협진 요청 등록</a>
    </c:if>

    <c:if test="${not empty sessionScope.loginUser && sessionScope.loginUser.userId == coopUser.userId}">
      <a class="btn-action btn-save" href="<c:url value='/referral/referralForm.do'/>">협진 요청 등록</a>
    </c:if>
  </div>
</div>

</body>
</html>
