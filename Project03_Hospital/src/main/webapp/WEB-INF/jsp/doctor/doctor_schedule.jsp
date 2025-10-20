<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	com.hospital.vo.UserVO loginUser = (com.hospital.vo.UserVO) session.getAttribute("loginUser");
	String doctorId = loginUser != null ? loginUser.getUserId() : "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doctor_schedule</title>

<!-- jQuery & jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

<script>
	var contextPath = "${pageContext.request.contextPath}";
	var doctorId = "<%=doctorId%>";
</script>

<style>
/* 기존 스타일 그대로 유지 */
body {
	margin: 0;
	font-family: "Malgun Gothic", sans-serif;
	color: #111;
	font-size: 15px;
}

.note-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 8px;
	margin-top: 10px;
	max-width: 280px;
}

.note-btn {
	font-size: 13px;
	font-weight: 700;
	height: 38px;
	text-align: center;
	border: 1px solid #d1d5db;
	background: #f8fafc;
	border-radius: 10px;
	cursor: pointer;
	transition: background-color .12s ease;
}

.note-btn:hover {
	background: #eef2f7;
}

.note-btn.selected {
	background: #2563eb;
	color: #fff;
	border-color: #1d4ed8;
}

#timeContainer {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

#timeContainer h4 {
	font-size: 16px;
	font-weight: 800;
	color: #111;
}

.time-button {
	min-width: 72px;
	height: 36px;
	font-size: 14px;
	font-weight: 700;
	border: 1px solid #d1d5db !important;
	border-radius: 8px;
	background: #fff;
	cursor: pointer;
	transition: background-color .12s ease;
	padding: 2px 8px;
	margin: 3px;
}

.time-button:hover {
	background: #f3f4f6;
}

.time-button.selected {
	background-color: #4caf50 !important;
	color: white !important;
	border: 2px solid #388e3c;
}

.time-button.saved {
	color: #fff !important;
	border: 2px solid #555;
}

.saved-out { background: #ef4444 !important; border-color: #b91c1c !important; }
.saved-conf { background: #3b82f6 !important; border-color: #1d4ed8 !important; }
.saved-lecture { background: #a855f7 !important; border-color: #7e22ce !important; }
.saved-vacation { background: #9ca3af !important; border-color: #4b5563 !important; }
.saved-etc { background: #f59e0b !important; border-color: #d97706 !important; }

.cal-actions {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 14px;
	margin-top: 20px;
	padding-bottom: 30px;
}

.mp-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	min-width: 110px;
	height: 42px;
	padding: 0 18px;
	font-size: 15px;
	font-weight: 800;
	border-radius: 12px;
	border: 1px solid transparent;
	cursor: pointer;
	box-shadow: 0 1px 0 rgba(0,0,0,.07), 0 2px 8px rgba(0,0,0,.06);
}

.mp-btn--save {
	background: #16a34a;
	color: #fff;
	border-color: #15803d;
}

.mp-btn--save:hover {
	background: #15803d;
}

#saveBtn, #cancelBtn, #mainBtn {
	display: none;
}
</style>

<script>
$(function () {
	// ✅ 페이지 로드시 빈 시간표 출력
	generateEmptyTimeButtons();

	$("#datepicker").datepicker({
		minDate: 0,
		onSelect: function (dateText) {
			$("#selectedDateText").text("시간 선택");
			$("#selectedDate").val(dateText);
			generateTimeButtons();
			$("#saveBtn, #cancelBtn, #mainBtn").show();
		}
	});

	$("#saveBtn").on("click", function () {
		const date = $("#selectedDate").val();
		const selectedButtons = $(".time-button.selected");
		const note = $("#selectedNote").val();

		if (!date || selectedButtons.length === 0) {
			alert("날짜와 시간을 모두 선택하세요.");
			return;
		}

		$(this).prop("disabled", true);
		let allSaved = true;

		selectedButtons.each(function () {
			const time = $(this).text();
			const hour = parseInt(time.split(":")[0]);
			const timeSlot = hour < 12 ? "오전" : "오후";

			$.ajax({
				type: "POST",
				url: contextPath + "/doctor/schedule/save.do",
				data: { date: date, timeSlot: timeSlot, scheduleTime: time, note: note },
				async: false,
				success: function () {},
				error: function () { allSaved = false; }
			});
		});

		if (allSaved) {
			alert("저장 완료!");
			location.reload();
		} else {
			alert("저장 중 오류 발생");
			$("#saveBtn").prop("disabled", false);
		}
	});

	$(".note-btn").click(function () {
		$(".note-btn").removeClass("selected");
		$(this).addClass("selected");
		$("#selectedNote").val($(this).data("note"));
	});
});

// ✅ 날짜 선택 전: 비어있는 시간표만 출력
function generateEmptyTimeButtons() {
	const container = $("#timeContainer");
	container.empty();

	const amDiv = $("<div>").append("<h4>오전</h4>");
	const pmDiv = $("<div>").append("<h4>오후</h4>");

	for (let h = 9; h <= 18; h++) {
		for (let m = 0; m <= 30; m += 30) {
			if (h === 18 && m === 30) continue;
			const time = String(h).padStart(2, '0') + ":" + String(m).padStart(2, '0');
			const btn = $("<button>")
				.text(time)
				.addClass("time-button")
				.attr("disabled", true)
				.css({ cursor: "not-allowed", opacity: 0.4 });
			(h < 12 ? amDiv : pmDiv).append(btn);
		}
	}
	container.append(amDiv).append("<br>").append(pmDiv);
}

// ✅ 날짜 선택 후: 실제 스케줄 AJAX로 불러오기
function generateTimeButtons() {
	const container = $("#timeContainer");
	container.empty();
	const date = $("#selectedDate").val();

	$.ajax({
		type: "GET",
		url: contextPath + "/doctor/schedule/list.do",
		data: { date: date },
		dataType: "json",
		success: function (scheduleList) {
			const amDiv = $("<div>").append("<h4>오전</h4>");
			const pmDiv = $("<div>").append("<h4>오후</h4>");

			for (let h = 9; h <= 18; h++) {
				for (let m = 0; m <= 30; m += 30) {
					if (h === 18 && m === 30) continue;
					const time = String(h).padStart(2, '0') + ":" + String(m).padStart(2, '0');

					const btn = $("<button>")
						.text(time)
						.addClass("time-button");

					const matched = scheduleList.find(s => s.scheduleTime && s.scheduleTime.substring(0, 5) === time);

					if (matched) {
						btn.addClass("saved");
						switch (matched.note) {
							case "외래진료": btn.addClass("saved-out"); break;
							case "학회": btn.addClass("saved-conf"); break;
							case "강의": btn.addClass("saved-lecture"); break;
							case "휴가": btn.addClass("saved-vacation"); break;
							case "기타": btn.addClass("saved-etc"); break;
						}

						btn.on("click", function () {
							if (confirm(time + " 시간을 삭제하시겠습니까?")) {
								$.ajax({
									type: "POST",
									url: contextPath + "/deleteSchedule.do",
									data: { date: date, scheduleType: time },
									success: function () {
										alert("삭제 완료");
										generateTimeButtons();
									},
									error: function () {
										alert("삭제 실패");
									}
								});
							}
						});
					} else {
						btn.on("click", function () {
							$(this).toggleClass("selected");
						});
					}

					(h < 12 ? amDiv : pmDiv).append(btn);
				}
			}
			container.append(amDiv).append("<br>").append(pmDiv);
		},
		error: function () {
			alert("스케줄 불러오기 실패");
		}
	});
}
</script>
</head>

<body>
	<input type="hidden" id="selectedDate" />
	<input type="hidden" id="selectedNote" name="note" />

	<div style="display: flex; justify-content: center; padding: 40px;">
		<table>
			<tr>
				<td>
					<h3>날짜 선택</h3>
					<div id="datepicker"></div>

					<div id="noteButtons" class="note-grid">
						<button class="note-btn" data-note="외래진료">외래진료</button>
						<button class="note-btn" data-note="학회">학회</button>
						<button class="note-btn" data-note="강의">강의</button>
						<button class="note-btn" data-note="휴가">휴가</button>
						<button class="note-btn" data-note="기타">기타</button>
					</div>
				</td>
				<td style="vertical-align: top; padding-left: 30px;">
					<div id="selectedDateText" style="margin-bottom: 10px; font-weight: bold;">시간 선택</div>
					<div id="timeContainer" style="margin-bottom: 20px;"></div>
					<div class="cal-actions">
						<button type="button" id="saveBtn" class="mp-btn mp-btn--save">저장</button>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
