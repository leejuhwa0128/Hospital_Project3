<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>공지사항 등록</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css" />
  
  <style>
    button.btn-save {
      background-color: #16a34a !important;
      color: #fff !important;
      font-size: 13px !important;
      font-weight: 500 !important;
      padding: 6px 12px !important;
      border: none !important;
      border-radius: 4px !important;
    }
    button.btn-save:hover {
      background-color: #15803d !important;
    }
  </style>
</head>
<body>

<h2>📢 공지사항 등록</h2>

<div class="con_wrap bg_13 form-wide">
  <form action="${pageContext.request.contextPath}/admin_board/notice_write.do" method="post">

    <table class="kv-table">
      <tbody>
        <tr>
          <th><label for="title">제목</label></th>
          <td><input type="text" id="title" name="title" required placeholder="제목을 입력하세요" style="width: 100%;"></td>
        </tr>
        <tr>
          <th><label for="content">내용</label></th>
          <td>
            <textarea id="content" name="content"
                      style="width: 100%; max-width: 100%; height: 300px; box-sizing: border-box;"
                      placeholder="내용을 입력하세요" required></textarea>
          </td>
        </tr>
      </tbody>
    </table>

    <div class="button-group right" style="margin-top: 20px;">
      <button type="submit" class="btn-save">등록</button>
      <a href="${pageContext.request.contextPath}/admin_board/noticeManage.do" class="btn-action btn-view">목록</a>
    </div>
  </form>
</div>

</body>
</html>
