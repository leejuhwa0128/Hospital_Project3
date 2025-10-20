<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style>
  .page-wrap{max-width:1200px;margin:40px auto;padding:0 16px}
  .find-box{max-width:420px;margin:0 auto;border:1px solid #eee;border-radius:10px;padding:24px}
  .find-box h2{margin:0 0 16px;font-size:20px}
  .row{margin:12px 0}
  .row label{display:block;margin-bottom:6px;font-weight:bold}
  .row input{width:100%;height:38px;padding:0 10px;box-sizing:border-box}
  .btns{display:flex;gap:10px;margin-top:16px}
  .btn{flex:1;height:40px;border:1px solid #333;background:#000;color:#fff;cursor:pointer}
  .msg{margin-top:14px;padding:12px;border-radius:8px}
  .ok{background:#f1f8f1;color:#065}
  .err{background:#fff1f1;color:#a00}
  .links{margin-top:14px;text-align:center;display:flex;gap:12px;justify-content:center}
  .links a{color:#06c;text-decoration:none}
</style>
</head>
<body>
<div class="page-wrap">
  <div class="find-box">
    <h2>비밀번호 찾기</h2>

    <form action="<c:url value='/referral/findPw.do'/>" method="post" autocomplete="off">
      <div class="row">
        <label for="userId">아이디</label>
        <input type="text" id="userId" name="userId" value="<c:out value='${param.userId}'/>" required />
      </div>
      <div class="row">
        <label for="name">이름</label>
        <input type="text" id="name" name="name" value="<c:out value='${param.name}'/>" required />
      </div>
      <div class="row">
        <label for="email">이메일</label>
        <input type="email" id="email" name="email" value="<c:out value='${param.email}'/>" required />
      </div>

      <c:if test="${not empty error}">
        <div class="msg err"><c:out value="${error}"/></div>
      </c:if>
      <c:if test="${not empty notFound}">
        <div class="msg err">입력하신 정보와 일치하는 계정을 찾을 수 없습니다.</div>
      </c:if>
      <c:if test="${sent}">
        <div class="msg ok">임시 비밀번호를 이메일로 발송했습니다. 로그인 후 반드시 변경하세요.</div>
      </c:if>

      <div class="btns">
        <button type="submit" class="btn">임시 비밀번호 받기</button>
      </div>
    </form>

    <div class="links">
      <a href="<c:url value='/referral/auth.do'/>">로그인</a>
      <span>|</span>
      <a href="<c:url value='/referral/findId.do'/>">아이디 찾기</a>
    </div>
  </div>
</div>
</body>
</html>
