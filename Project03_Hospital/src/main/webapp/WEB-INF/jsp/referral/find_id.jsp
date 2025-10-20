<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>

<style>
  /* 페이지 본문만 최소 스타일 */
  .page-wrap{max-width:1200px;margin:40px auto;padding:0 16px}
  .find-box{max-width:420px;margin:0 auto;border:1px solid #eee;border-radius:10px;padding:24px}
  .find-box h2{margin:0 0 16px;font-size:20px}
  .row{margin:12px 0}
  .row label{display:block;margin-bottom:6px;font-weight:bold}
  .row input{width:100%;height:38px;padding:0 10px;box-sizing:border-box}
  .help{font-size:12px;color:#666}
  .btns{display:flex;gap:10px;margin-top:16px}
  .btn{flex:1;height:40px;border:1px solid #333;background:#000;color:#fff;cursor:pointer}
  .result{margin-top:16px;padding:12px;background:#f7f7f7;border-radius:8px}
  .error{color:#c00;margin-top:8px}
  .links{margin-top:14px;text-align:center;display:flex;gap:12px;justify-content:center}
  .links a{color:#06c;text-decoration:none}
</style>
</head>
<body>

  <div class="page-wrap">
    <div class="find-box">
      <h2>아이디 찾기</h2>

      <form action="${pageContext.request.contextPath}/referral/findId.do" method="post" autocomplete="off">
        <div class="row">
          <label for="name">이름 <span style="color:#c00">*</span></label>
          <input type="text" id="name" name="name" value="<c:out value='${param.name}'/>" required />
        </div>

        <div class="row">
          <label for="phone">휴대폰번호 (선택)</label>
          <input type="text" id="phone" name="phone" placeholder="010-1234-5678"
                 value="<c:out value='${param.phone}'/>" />
          <div class="help">하이픈(-) 있어도 됩니다.</div>
        </div>

        <div class="row">
          <label for="email">이메일 (선택)</label>
          <input type="email" id="email" name="email" placeholder="example@domain.com"
                 value="<c:out value='${param.email}'/>" />
        </div>

        <div class="error">
          <c:if test="${not empty error}">
            <c:out value="${error}"/>
          </c:if>
        </div>

        <div class="btns">
          <button type="submit" class="btn">아이디 찾기</button>
        </div>
      </form>

      <c:if test="${not empty foundId}">
        <div class="result">
          확인된 아이디: <strong><c:out value="${foundId}"/></strong>
        </div>
      </c:if>

      <c:if test="${not empty notFound}">
        <div class="result">
          입력하신 정보로 가입된 아이디를 찾을 수 없습니다.
        </div>
      </c:if>

      <div class="links">
        <a href="<c:url value='/referral/auth.do'/>">로그인</a>
        <span>|</span>
        <a href="<c:url value='/referral/findPw.do'/>">비밀번호 찾기</a>
      </div>
    </div>
  </div>
</body>
</html>
