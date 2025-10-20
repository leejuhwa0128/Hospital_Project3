<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>과거 진단서 목록</title>

    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: #f9fafb;
            margin: 40px;
            color: #1f2937;
        }

        h2 {
            text-align: center;
            font-size: 28px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            margin-top: 20px;
        }

        thead th {
            background-color: #1f2937;
            color: white;
            font-weight: 600;
            font-size: 14px;
            padding: 14px 20px;
            text-align: left;
            vertical-align: middle;
        }

        tbody td {
            padding: 14px 20px;
            font-size: 14px;
            text-align: left;
            vertical-align: middle;
            border-bottom: 1px solid #e5e7eb;
            line-height: 1.5;
            word-break: break-word;
        }

        tbody tr:nth-child(even) {
            background-color: #f9fafb;
        }

        tbody tr:hover {
            background-color: #eff6ff;
        }

        /* Column widths */
        th.col-name,      td.col-name      { width: 15%; }
        th.col-date,      td.col-date      { width: 14%; }
        th.col-diagnosis, td.col-diagnosis { width: 18%; }
        th.col-prescribe, td.col-prescribe { width: 18%; }
        th.col-treatment, td.col-treatment { width: 18%; }
        th.col-request,   td.col-request   { width: 17%; }

        /* Buttons */
        button, .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 6px 12px;
            font-size: 13px;
            font-weight: 500;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
            height: 36px;
            box-sizing: border-box;
        }

        .btn-primary {
            background-color: #3b82f6;
            color: white;
        }

        .btn-primary:hover {
            background-color: #2563eb;
        }

        .btn-disabled {
            background-color: #d1d5db;
            color: #6b7280;
            cursor: not-allowed;
        }

        form {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            height: 100%;
            margin: 0;
        }
    </style>
</head>
<body>

    <c:if test="${not empty duplicate}">
        <script>
            alert("이미 협진 요청이 등록된 진료기록입니다.");
        </script>
    </c:if>

    <h2>과거 진료기록</h2>

    <table id="recordsTable">
        <thead>
            <tr>
                <th class="col-name">환자 이름</th>
                <th class="col-date">작성일</th>
                <th class="col-diagnosis">진단</th>
                <th class="col-prescribe">처방</th>
                <th class="col-treatment">치료</th>
                <th class="col-request">협진 신청</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="record" items="${recordList}">
                <tr>
                    <td class="col-name">${record.patientName}</td>
                    <td class="col-date">
                        <fmt:formatDate value="${record.recordDate}" pattern="yyyy-MM-dd" />
                    </td>
                    <td class="col-diagnosis">${record.diagnosis}</td>
                    <td class="col-prescribe">${record.prescription}</td>
                    <td class="col-treatment">${record.treatment}</td>
                    <td class="col-request">
                        <c:choose>
                            <c:when test="${record.requested}">
                                <button type="button" class="btn btn-disabled" disabled>신청완료</button>
                            </c:when>
                            <c:otherwise>
                                <form method="get" action="${pageContext.request.contextPath}/referral2/requestForm.do">
                                    <input type="hidden" name="recordId" value="${record.recordId}" />
                                    <button type="submit" class="btn btn-primary">협진 신청</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <script>
        $(document).ready(function () {
            $('#recordsTable').DataTable({
                "pageLength": 20,
                "lengthChange": false,
                "ordering": false,
                "searching": false,
                "language": {
                    "paginate": {
                        "previous": "이전",
                        "next": "다음"
                    },
                    "info": "_TOTAL_건 중 _START_ ~ _END_ 표시"
                }
            });
        });
    </script>

</body>
</html>
