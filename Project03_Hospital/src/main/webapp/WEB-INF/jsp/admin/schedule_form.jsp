<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doctor_schedule</title>

<!-- jQuery & jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

<%
	com.hospital.vo.UserVO loginUser = (com.hospital.vo.UserVO) session.getAttribute("loginUser");
String _doctorId = (loginUser != null)
		? loginUser.getUserId()
		: (request.getParameter("doctorId") != null ? request.getParameter("doctorId") : "");
%>
<script>
  var contextPath = "${pageContext.request.contextPath}";
  var doctorId    = "<%=_doctorId%>";

  const qs = new URLSearchParams(location.search);
  var contextPath = "${pageContext.request.contextPath}";
  var doctorId = qs.get("doctorId") || ""; // ← 강제 세팅
  var sPage  = qs.get("sPage") || 1;
  var rPage  = qs.get("rPage") || 1;
  var vPage  = qs.get("vPage") || 1;

  var DETAIL_URL  = contextPath + "/admin/doctorDetail.do"
                  + "?doctorId=" + encodeURIComponent(doctorId)
                  + "&sPage=" + sPage + "&rPage=" + rPage + "&vPage=" + vPage
                  + "#schedule";

  var LIST_URL    = contextPath + "/admin/schedule/list.do";
  var SAVE_URL    = contextPath + "/admin/insertSchedule.do";
  var DELETE_URL  = contextPath + "/admin/deleteSchedule.do";
  var UPDATE_FORM = contextPath + "/admin/updateScheduleForm.do";
</script>

<style>
.time-button.selected {
	background-color: #4caf50 !important;
	color: #fff !important;
	border: 2px solid #388e3c;
}

.time-button.saved {
	color: #fff !important;
	border: 2px solid #555;
}

.saved-out {
	background: #f44336 !important;
	border-color: #d32f2f !important;
}

.saved-conf {
	background: #2196f3 !important;
	border-color: #1976d2 !important;
}

.saved-lecture {
	background: #9c27b0 !important;
	border-color: #7b1fa2 !important;
}

.saved-vacation {
	background: #9e9e9e !important;
	border-color: #616161 !important;
}

.saved-etc {
	background: #ff9800 !important;
	border-color: #f57c00 !important;
}

#saveBtn, #cancelBtn {
	display: none;
}

.note-btn {
	margin-right: 5px;
	padding: 4px 10px;
	border: 1px solid #999;
	background: #f0f0f0;
	cursor: pointer;
}

.note-btn.selected {
	background: #0066cc;
	color: #fff;
}

.period-head {
	display: flex;
	align-items: center;
	gap: 8px;
	margin: 4px 0;
}

.select-all-btn {
	padding: 2px 8px;
	border: 1px solid #bbb;
	background: #fff;
	cursor: pointer;
}
</style>

<script>
$(function(){
  $("#datepicker").datepicker({
    minDate:0, dateFormat:"yy-mm-dd",
    onSelect: function(dateText){
      $("#selectedDateText").text("시간 선택");
      $("#selectedDate").val(dateText);
      generateTimeButtons();
      $("#saveBtn,#cancelBtn").show();
    }
  });

  $("#saveBtn").off("click").on("click", function(){
    const date = $("#selectedDate").val();
    const selectedButtons = $(".time-button.selected");
    const note = $("#selectedNote").val();

    if (!doctorId){ alert("의사 ID가 없습니다."); history.back(); return; }
    if (!date || selectedButtons.length===0 || !note){ alert("날짜/시간/내용을 모두 선택하세요."); return; }

    $(this).prop("disabled", true);
    let ok = true, cnt = 0;

    selectedButtons.each(function(){
      const time = $(this).text();
      const hour = parseInt(time.split(":")[0], 10);
      const timeSlot = (hour < 12) ? "오전" : "오후";

      $.ajax({
        type:"POST", url:SAVE_URL, async:false,
        data:{ doctorId:doctorId, scheduleDate:date, timeSlot:timeSlot, scheduleTime:time, note:note },
        success:function(){ cnt++; }, error:function(){ ok=false; }
      });
    });

    if (ok && cnt>0){ alert("저장 완료!"); location.href = DETAIL_URL; }
    else { alert("일부 저장 실패 또는 에러 발생"); $("#saveBtn").prop("disabled", false); }
  });

  $("#cancelBtn").on("click", function(){
    if (!doctorId){ history.back(); return; }
    location.href = DETAIL_URL;
  });

  $(".note-btn").click(function(){
    $(".note-btn").removeClass("selected");
    $(this).addClass("selected");
    $("#selectedNote").val($(this).data("note"));
  });
});

function generateTimeButtons(){
  const container = $("#timeContainer").empty();
  const date = $("#selectedDate").val();

  $.ajax({
    type:"GET", url:LIST_URL, data:{doctorId:doctorId, date:date}, dataType:"json",
    success:function(scheduleList){
      // 오전/오후 컨테이너 + 전체선택 버튼
      const amDiv = $("<div class='period am'>");
      amDiv.append('<div class="period-head"><h4 style="margin:0;">오전</h4><button type="button" class="select-all-btn" data-period="am">전체선택</button></div>');
      const pmDiv = $("<div class='period pm'>");
      pmDiv.append('<div class="period-head"><h4 style="margin:0;">오후</h4><button type="button" class="select-all-btn" data-period="pm">전체선택</button></div>');

      for (let h=9; h<=18; h++){
        for (let m=0; m<=30; m+=30){
          if (h===18 && m===30) continue;
          const time = String(h).padStart(2,'0') + ":" + String(m).padStart(2,'0');
          const btn = $("<button>").text(time).addClass("time-button")
            .attr("data-period", (h < 12 ? "am" : "pm"))
            .css({margin:"3px",padding:"5px 10px",border:"1px solid #ccc",cursor:"pointer"});

          const matched = scheduleList.find(s => s.scheduleTime && s.scheduleTime.substring(0,5)===time);

          if (matched){
            btn.addClass("saved").data("sid", matched.scheduleId);
            switch(matched.note){
              case "외래진료": btn.addClass("saved-out"); break;
              case "학회":     btn.addClass("saved-conf"); break;
              case "강의":     btn.addClass("saved-lecture"); break;
              case "휴가":     btn.addClass("saved-vacation"); break;
              default:         btn.addClass("saved-etc");
            }
            btn.on("click", function(){
              const sid = $(this).data("sid"); if (!sid) return;
              if (confirm("예약이 연결된 경우 삭제되지 않습니다.\n그래도 " + time + " 시간을 삭제하시겠습니까?")){
            	  $.post(DELETE_URL, { scheduleId:sid, doctorId:doctorId })
            	   .done(function(){ alert("삭제 완료"); generateTimeButtons(); })
            	   .fail(function(){ alert("삭제 실패"); });
            	}
            });
            btn.on("dblclick", function(){
              const sid = $(this).data("sid"); if (!sid) return;
              location.href = UPDATE_FORM + "?scheduleId=" + sid;
            });
          } else {
            btn.on("click", function(){ $(this).toggleClass("selected"); });
          }

          (h<12 ? amDiv : pmDiv).append(btn);
        }
      }

      container.append(amDiv).append("<br>").append(pmDiv);

      // ★ 전체선택: 이미 저장된(.saved) 버튼은 제외하고 해당 구간 모두 선택
      container.off("click", ".select-all-btn").on("click", ".select-all-btn", function(){
        const period = $(this).data("period"); // 'am' or 'pm'
        container.find('.time-button[data-period="'+period+'"]').not('.saved').addClass('selected');
      });
    },
    error:function(xhr){ alert("스케줄 불러오기 실패: " + xhr.status); }
  });
}
</script>
</head>

<body>
	<input type="hidden" id="selectedDate">
	<input type="hidden" id="selectedNote" name="note">

	<table>
		<tr>
			<td>
				<h3>날짜 선택</h3>
				<div id="datepicker"></div>
				<div id="noteButtons" style="margin-top: 10px;">
					<button class="note-btn" data-note="외래진료">외래진료</button>
					<button class="note-btn" data-note="학회">학회</button>
					<button class="note-btn" data-note="강의">강의</button>
					<br>
					<br>
					<button class="note-btn" data-note="휴가">휴가</button>
					<button class="note-btn" data-note="기타">기타</button>
				</div>
			</td>
			<td style="vertical-align: top; padding-left: 30px;">
				<div id="selectedDateText"
					style="margin-bottom: 10px; font-weight: bold;"></div>
				<div id="timeContainer" style="margin-bottom: 20px;"></div>
				<div>
					<button id="saveBtn">저장</button>
					<button id="cancelBtn">취소</button>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>
