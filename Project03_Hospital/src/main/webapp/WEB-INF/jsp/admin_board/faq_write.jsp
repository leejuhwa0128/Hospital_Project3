<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>➕ FAQ 등록</title>
  <!-- 공통 스타일 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/common.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/manage_detail.css" />

  <!-- 등록 버튼 전용 커스터마이징 -->
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

<h2>➕ FAQ 등록</h2>

<div class="con_wrap bg_13 form-wide">

  <form action="${pageContext.request.contextPath}/admin_board/faq_write.do" method="post">
    <table class="kv-table">
      <tbody>
        <tr>
          <th><label for="category">카테고리</label></th>
          <td>
            <select id="category" name="category" required style="width: 200px;">
              <option value="">선택</option>
              <option value="진료예약">진료예약</option>
              <option value="외래진료">외래진료</option>
              <option value="입퇴원">입퇴원</option>
              <option value="서류발급">서류발급</option>
              <option value="병원안내">병원안내</option>
              <option value="기타">기타</option>
            </select>
          </td>
        </tr>
        <tr>
          <th><label for="question">질문</label></th>
          <td><input type="text" id="question" name="question" required placeholder="질문을 입력하세요" style="width: 100%;" /></td>
        </tr>
        <tr>
          <th><label for="answer">답변</label></th>
          <td>
            <textarea id="answer" name="answer" required
                      style="width: 100%; max-width: 100%; height: 300px; box-sizing: border-box;"
                      placeholder="답변을 입력하세요"></textarea>
          </td>
        </tr>
      </tbody>
    </table>

    <div class="button-group right" style="margin-top: 20px;">
      <button type="submit" class="btn-save">등록</button>
      <a href="${pageContext.request.contextPath}/admin_board/faqManage.do" class="btn-action btn-view">목록</a>
    </div>
  </form>

</div>
</body>
</html>
