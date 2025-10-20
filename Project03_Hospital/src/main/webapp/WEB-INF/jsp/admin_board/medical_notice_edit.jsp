<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>의료진 공지사항 수정</title>

  <!-- 공통 스타일 포함 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css" />

  <!-- 등록/수정 버튼 전용 커스터마이징 -->
  <style>
    button.btn-save {
      background-color: #16a34a !important;
      color: #fff !important;
      font-size: 13px !important;
      font-weight: 500 !important;
      padding: 6px 12px !important;
      border: none !important;
      border-radius: 4px !important;
      cursor: pointer;
    }

    button.btn-save:hover {
      background-color: #15803d !important;
    }
  </style>
</head>
<body>

  <div class="con_wrap bg_13 form-wide">
    <h2 class="total_tit f_s20 f_w700">의료진 공지사항 수정</h2>

    <form action="<c:url value='/admin_board/medicalNoticeEdit.do'/>" method="post">
      <input type="hidden" name="noticeId" value="${notice.noticeId}" />
      <input type="hidden" name="targetRole" value="all" />

      <table class="kv-table">
        <tbody>
          <tr>
            <th><label for="title">제목</label></th>
            <td>
              <input type="text" id="title" name="title"
                     value="${notice.title}" required placeholder="제목을 입력하세요"
                     style="width: 100%;">
            </td>
          </tr>
          <tr>
            <th><label for="content">내용</label></th>
            <td>
              <textarea id="content" name="content"
                        style="width: 100%; max-width: 100%; height: 300px; box-sizing: border-box;"
                        placeholder="공지 내용을 입력하세요" required><c:out value="${notice.content}" /></textarea>
            </td>
          </tr>
        </tbody>
      </table>

      <div class="button-group right" style="margin-top: 20px;">
        <button type="submit" class="btn-save">수정 완료</button>
        <a href="${pageContext.request.contextPath}/admin_board/medicalNoticeManage.do" class="btn-action btn-view">목록</a>
      </div>
    </form>
  </div>

</body>
</html>
