<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>예약 현황 (캘린더)</title>

<!-- 공통 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/manage_all.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/calendar.css">

<!-- FullCalendar -->
<link
	href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<style>
.calendar-header {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 10px;
	margin-bottom: 12px;
	font-size: 18px;
	font-weight: 600;
}

.calendar-header button {
	font-size: 15px;
	padding: 4px 10px;
	background-color: #4a2d2d;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.calendar-header button:hover {
	background-color: #3b1f1f;
}

.modal {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.4);
	display: none;
	align-items: center;
	justify-content: center;
	z-index: 1000;
}

.modal-content {
	background: #fff;
	padding: 20px 30px;
	border-radius: 8px;
	min-width: 260px;
}

.modal-content select {
	width: 100%;
	padding: 6px;
	margin: 8px 0;
}

.btn-calendar {
	background-color: #4a2d2d;
	color: white;
	border: none;
	padding: 6px 12px;
	border-radius: 4px;
	font-size: 14px;
	cursor: pointer;
	font-weight: 500;
	transition: background-color 0.2s ease;
}

.btn-calendar:hover {
	background-color: #3b1f1f;
}
</style>
</head>

<body>
	<div class="detail-container">
		<div class="calendar-header">
			<span id="calendar-title">2025년 8월</span>
			<button class="btn-calendar" onclick="openDateModal()">📅</button>
		</div>
		<div id="calendar"></div>
	</div>

	<!-- 연/월 선택 모달 -->
	<div id="dateModal" class="modal">
		<div class="modal-content">
			<h3>연도 / 월 선택</h3>
			<select id="yearSelect"></select> <select id="monthSelect">
				<c:forEach var="i" begin="1" end="12">
					<option value="${i - 1}">${i}월</option>
				</c:forEach>
			</select>
			<div style="text-align: right; margin-top: 10px;">
				<button onclick="goToSelectedDate()" class="btn-action btn-save">이동</button>
				<button onclick="closeDateModal()" class="btn-action btn-view">취소</button>
			</div>
		</div>
	</div>

	<script>
    const summaryData = [
      <c:forEach var="s" items="${summaryList}" varStatus="st">
        { date: '${s.resvDate}', count: ${empty s.resvCount ? 0 : s.resvCount} }<c:if test="${!st.last}">,</c:if>
      </c:forEach>
    ];

    let calendar;

    document.addEventListener('DOMContentLoaded', function () {
      const calendarEl = document.getElementById('calendar');
      const ctx = '${pageContext.request.contextPath}';

      calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        headerToolbar: {
          left: 'prev,next today',
          center: '',
          right: ''
        },
        locale: 'ko',
        timeZone: 'Asia/Seoul',
        height: 'auto',
        expandRows: true,
        dayMaxEventRows: 2,
        views: {
          dayGridMonth: {
            titleFormat: { year: 'numeric', month: 'long' }
          }
        },
        events: summaryData.map(it => ({
          start: it.date,
          allDay: true,
          extendedProps: { count: it.count, date: it.date }
        })),
        dateClick: function (info) {
          window.open(ctx + '/admin/reservations/viewByDate.do?date=' + info.dateStr,
            '_blank', 'width=1280,height=900,left=80,top=60,resizable=yes,scrollbars=yes');
        },
        eventClick: function (info) {
          const date = info.event.extendedProps?.date || info.event.startStr;
          window.open(ctx + '/admin/reservations/viewByDate.do?date=' + date,
            '_blank', 'width=1280,height=900,left=80,top=60,resizable=yes,scrollbars=yes');
        },
        eventContent(info) {
          const n = document.createElement('span');
          n.textContent = (info.event.extendedProps?.count ?? 0) + '건';
          return { domNodes: [n] };
        },
        eventDidMount(info) {
          const c = info.event.extendedProps?.count ?? 0;
          info.el.title = `${info.event.startStr} • ${c}건 예약`;
        }
      });

      calendar.render();
      updateTitle();

      fitHeight();
      let raf;
      window.addEventListener('resize', () => {
        cancelAnimationFrame(raf);
        raf = requestAnimationFrame(fitHeight);
      });

      // 연도 초기화
      const yearSelect = document.getElementById('yearSelect');
      const now = new Date();
      for (let y = now.getFullYear() - 3; y <= now.getFullYear() + 2; y++) {
        const opt = document.createElement('option');
        opt.value = y;
        opt.textContent = y + '년';
        if (y === now.getFullYear()) opt.selected = true;
        yearSelect.appendChild(opt);
      }
      document.getElementById('monthSelect').value = now.getMonth();
    });

    function fitHeight() {
      const BOTTOM_GAP = 0.08;
      const rect = document.getElementById('calendar').getBoundingClientRect();
      const available = window.innerHeight - rect.top;
      const target = Math.max(650, Math.floor(available * (1 - BOTTOM_GAP)));
      calendar.setOption('height', target);
      calendar.updateSize();
    }

    function updateTitle() {
      const current = calendar.getDate();
      document.getElementById('calendar-title').textContent =
        current.getFullYear() + '년 ' + (current.getMonth() + 1) + '월';
    }

    function openDateModal() {
      document.getElementById('dateModal').style.display = 'flex';
    }

    function closeDateModal() {
      document.getElementById('dateModal').style.display = 'none';
    }

    function goToSelectedDate() {
      const y = document.getElementById('yearSelect').value;
      const m = document.getElementById('monthSelect').value;
      const newDate = new Date(y, m, 1);
      calendar.gotoDate(newDate);
      updateTitle();
      closeDateModal();
    }
  </script>
</body>
</html>
