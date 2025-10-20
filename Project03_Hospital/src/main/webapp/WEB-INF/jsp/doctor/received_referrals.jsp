<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>협진 요청 수신 목록</title>

    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: #f9fafb;
            margin: 20px;
            color: #1f2937;
        }

        .content {
            max-width: 100%;
            margin: auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }

        .title {
            font-size: 26px;
            font-weight: bold;
            border-bottom: 2px solid #2c3e50;
            padding-bottom: 10px;
            color: #2c3e50;
            text-align: center;
            margin-bottom: 20px;
        }

        .debug {
            font-size: 14px;
            color: #d35400;
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            background-color: #ffffff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
        }

        thead th {
            background-color: #1f2937;
            color: white;
            font-weight: 600;
            font-size: 14px;
            padding: 14px 20px;
            text-align: left;
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

        /* 버튼 스타일 */
        button {
            padding: 6px 12px;
            font-size: 13px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
            background-color: #3498db;
            color: white;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 36px;
        }

        button:hover {
            background-color: #2980b9;
        }

        button[disabled] {
            background-color: #ddd;
            color: #777;
            cursor: not-allowed;
        }

        span {
            color: #e74c3c;
            font-weight: 500;
        }

        form {
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            height: 100%;
        }
    </style>
</head>
<body>

<div class="content">
    <div class="title">협진 요청 수신 목록</div>

    <div class="debug">
        요청 수: ${fn:length(requests)}
        <c:if test="${empty requests}">
            (데이터가 없습니다)
        </c:if>
    </div>

    <table id="requestsTable">
        <thead>
            <tr>
                <th style="width: 7%;">번호</th>
                <th style="width: 15%;">진료과</th>
                <th style="width: 15%;">담당의</th>
                <th style="width: 15%;">요청자</th>
                <th style="width: 18%;">요청병원</th>
                <th style="width: 15%;">요청일</th>
                <th style="width: 15%;">확인</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="request" items="${requests}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${request.departmentName}</td>
                    <td>${request.doctorName}</td>
                    <td>${request.userName}</td>
                    <td>${request.hospitalName}</td>
                    <td>
                        <fmt:formatDate value="${request.createdAt}" pattern="yyyy-MM-dd" />
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${request.replyExists}">
                                <form action="${pageContext.request.contextPath}/referral2/detail.do" method="get">
                                    <input type="hidden" name="requestId" value="${request.requestId}" />
                                    <button type="submit">확인</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <span>미작성</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty requests}">
                <tr>
                    <td colspan="7">표시할 협진 요청이 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<!-- ✅ DataTables 초기화 -->
<script>
    $(document).ready(function () {
        $('#requestsTable').DataTable({
            "pageLength": 20,
            "lengthChange": false,
            "ordering": false,
            "searching": false,
            "language": {
                "paginate": {
                    "previous": "이전",
                    "next": "다음"
                },
                "info": "_TOTAL_건 중 _START_ ~ _END_ 표시",
                "emptyTable": "표시할 협진 요청이 없습니다."
            }
        });
    });
</script>

</body>
</html>
