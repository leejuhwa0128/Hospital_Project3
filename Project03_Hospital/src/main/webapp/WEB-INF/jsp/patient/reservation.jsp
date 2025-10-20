<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
  <c:when test="${not empty sessionScope.loginUser and not empty sessionScope.loginUser.patientNo}"><%-- 회원 통과 --%></c:when>
  <c:when test="${not empty sessionScope.guestPatientNo}"><%-- 비회원(게스트) 통과 --%></c:when>
  <c:otherwise><c:redirect url="/reservation/guest-start.do"/></c:otherwise>
</c:choose>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>진료 예약</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reservationstyle.css" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
/* ========== 진료과 리스트 ========== */
#deptList{display:grid;grid-template-columns:1fr;gap:8px}
.dept-item{display:flex;align-items:center;gap:10px;padding:10px 12px;border:1px solid #e5e7eb;border-radius:10px;background:#fff;cursor:pointer;transition:background .15s,border-color .15s}
.dept-item:hover{background:#f0f7ff;border-color:#93c5fd}
.dept-item.active{border-color:#2563eb;box-shadow:0 0 0 2px rgba(37,99,235,.15) inset}
.dept-icon{width:24px;height:24px;object-fit:contain;flex:0 0 24px}
.dept-text{font-weight:600;color:#1f2937;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}

/* ========== 의료진 카드(사진 위, 텍스트 아래 / 2열) ========== */
#doctorList{padding-top:4px}
.doctor-grid{
  display:grid;
  grid-template-columns:repeat(2, minmax(0,1fr)); /* 한 줄에 2개 */
  gap:12px;
}
.doctor-card{
  display:flex;
  flex-direction:column;        /* ⬅ 사진 위 / 텍스트 아래 */
  border:1px solid #e5e7eb;
  border-radius:12px;
  background:#fff;
  overflow:hidden;
  cursor:pointer;
  transition:transform .08s ease, box-shadow .08s ease, border-color .15s;
}
.doctor-card:hover{transform:translateY(-1px);box-shadow:0 6px 16px rgba(0,0,0,.06)}
.doctor-card.active{border-color:#2563eb;box-shadow:0 0 0 2px rgba(37,99,235,.15) inset}

/* 사진: 5:7 비율 유지 + 잘림 방지 */
.doc-photo{
  width:100%;
  aspect-ratio:5/7;             /* 세로형 비율 고정 */
  background:#f3f4f6;
  display:flex;
  align-items:center;
  justify-content:center;
}
.doc-photo img{
  max-width:100%;
  max-height:100%;
  object-fit:contain;            /* 잘리지 않게 */
  display:block;
}

/* 텍스트 */
.doc-meta{
  padding:10px 12px;
  text-align:center;
}
.doc-name{font-weight:700;color:#111827;margin-bottom:4px;line-height:1.2;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.doc-dept{font-size:12px;color:#1d4ed8;margin-bottom:2px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.doc-spec{font-size:12px;color:#6b7280;line-height:1.4;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden}
</style>
</head>
<body>
<c:if test="${(empty sessionScope.loginUser or empty sessionScope.loginUser.patientNo) and not empty sessionScope.guestPatientNo}">
  <div class="alert alert-info">비회원 예약 모드입니다. 완료 후 ‘비회원 예약 조회’에서 확인하세요.</div>
  <input type="hidden" name="patientNo" value="${sessionScope.guestPatientNo}" />
</c:if>

<div class="wrap">
  <!-- 1. 진료과 -->
  <section class="card">
    <h2>진료과/센터 선택</h2>
    <div class="search"><input id="deptSearch" type="text" placeholder="검색어를 입력하세요" /></div>
    <div id="deptList" aria-live="polite"></div>
  </section>

  <!-- 2. 의료진 -->
  <section class="card">
    <h2>의료진 선택</h2>
    <div id="doctorList" aria-live="polite"><p class="muted">좌측에서 진료과를 먼저 선택해주세요.</p></div>
  </section>

  <!-- 3. 날짜/시간 -->
  <section class="card">
    <h2>예약 가능한 날짜/시간</h2>
    <div class="cal-head">
      <button type="button" id="prevMonth" aria-label="이전 달">&lt;</button>
      <div id="calTitle" style="font-weight:600">-</div>
      <button type="button" id="nextMonth" aria-label="다음 달">&gt;</button>
    </div>
    <div id="calendar"></div>
    <div class="legend"><span>파란색 선택됨 · 회색 비활성</span></div>
    <h3 style="margin:8px 0 8px; font-size:16px;">예약 가능 시간 선택</h3>
    <div id="timeList"></div>
  </section>

  <!-- 4. 요약/제출 -->
  <section class="card">
    <h2>예약정보 확인</h2>
    <div id="summary" class="summary-box">
      <p class="muted">진료과, 의사, 날짜와 시간을 선택하면 요약이 표시됩니다.</p>
    </div>
    <form id="reserveForm" method="post" action="${cPath}/questionnaire/start.do">
      <input type="hidden" name="deptId" id="f_deptId">
      <input type="hidden" name="doctorId" id="f_doctorId">
      <input type="hidden" name="scheduleId" id="f_scheduleId">
      <input type="hidden" name="reservationDate" id="f_date">
      <input type="hidden" name="reservationTime" id="f_time">
      <input type="hidden" name="status" value="대기">
      <button class="submit" type="submit" id="submitBtn" disabled>예약하기</button>
    </form>
  </section>
</div>

<script>
(function(){
  var selected = { deptId:null, deptName:'', doctorId:null, doctorName:'', date:null, time:null, scheduleId:null };

  /* JSP 경로 변수 */
  var CTX = '${pageContext.request.contextPath}';
  var DEFAULT_DOCTOR_IMG = CTX + '/resources/images/default-doctor.png';

  /* ========= 안전 파서 ========= */
  function pick(){ for(var i=0;i<arguments.length;i++){ var v=arguments[i]; if(v!==undefined && v!==null && v!=='') return v; } return ''; }
  function toStr(v, fallback){ if(v===undefined||v===null) return fallback||''; return (typeof v==='string')? v : String(v); }
  function getDeptName(d){ return toStr(pick(d.deptName, d.name, d.DEPT_NAME, d.dept_name, d.title, d.id),'진료과'); }
  function getDeptId(d){ return toStr(pick(d.deptId, d.dept_id, d.DEPT_ID, d.id),''); }

  /* ========= 숨길 진료과(정확히 일치하는 이름만 제외) ========= */
  var HIDDEN_SET = new Set(["관리부","내과","진료과 없음"]);

  /* ========= 아이콘 매핑 ========= */
  var ICON_MAP = {
    "감염내과":"virus.png","내과":"medical.png","내분비내과":"pancreas.png","소화기내과":"stomach.png","호흡기내과":"lungs.png",
    "신장내과":"kidneys.png","신경과":"nervous-system.png","피부과":"skin.png",
    "갑상선내분비외과":"thyroid.png","대장항문외과":"intestine.png","위장관외과":"digestive-system.png","일반외과":"scalpel.png",
    "정형외과":"fracture.png","흉부외과":"heart.png","유방외과":"ribbon.png","이비인후과":"otorhinolaryngology.png",
    "소아청소년과":"baby-teeth.png","산부인과":"pregnancy.png","응급의학과":"ambulance.png"
  };
  function iconFor(name){ return ICON_MAP[name] || "medical.png"; }

  /* ========= 요약 ========= */
  function ymd(d){ var y=d.getFullYear(); var m=d.getMonth()+1; if(m<10)m='0'+m; var day=d.getDate(); if(day<10)day='0'+day; return y+'-'+m+'-'+day; }
  function fmtYM(d){ return d.getFullYear()+'년 '+(d.getMonth()+1)+'월'; }
  function setSummary(){
    if(selected.deptId && selected.doctorId && selected.date && selected.time){
      $("#summary").html(
        '<p>진료과: '+selected.deptName+'</p>'+
        '<p>의사: '+selected.doctorName+'</p>'+
        '<p>예약날짜: '+selected.date+'</p>'+
        '<p>예약시간: '+selected.time+'</p>'
      );
      $("#submitBtn").prop("disabled", false);
      $("#f_deptId").val(selected.deptId);
      $("#f_doctorId").val(selected.doctorId);
      $("#f_scheduleId").val(selected.scheduleId);
      $("#f_date").val(selected.date);
      $("#f_time").val(selected.time);
    }else{
      $("#summary").html('<p class="muted">진료과, 의사, 날짜와 시간을 선택하면 요약이 표시됩니다.</p>');
      $("#submitBtn").prop("disabled", true);
    }
  }

  /* ========= 1) 진료과 ========= */
  var allDepts = [];
  function renderDepts(list){
    var $box = $("#deptList").empty();
    if(!list || !list.length){ $box.html('<p class="muted">결과가 없습니다.</p>'); return; }
    list.forEach(function(d){
      var name = getDeptName(d).trim();
      var id   = getDeptId(d);
      if (HIDDEN_SET.has(name)) return; // ⬅ 숨김 처리

      var icon = iconFor(name);
      var $li = $(
        '<div class="dept-item" role="button" tabindex="0" data-id="'+id+'">'+
          '<img class="dept-icon" alt="'+name+'" '+
               'src="'+CTX+'/resources/images/icon/department/'+icon+'" '+
               'onerror="this.onerror=null;this.src=\''+(CTX+'/resources/images/icon/department/medical.png')+'\';" />'+
          '<span class="dept-text">'+name+'</span>'+
        '</div>'
      );
      if(String(selected.deptId)===String(id)) $li.addClass('active');
      $li.on('click', function(){
        $(".dept-item").removeClass("active");
        $(this).addClass("active");
        selected.deptId   = String($(this).data("id"));
        selected.deptName = name;
        selected.doctorId = selected.doctorName = null;
        selected.date = selected.time = selected.scheduleId = null;
        $("#doctorList").html('<p class="muted">의사 목록을 불러오는 중...</p>');
        $("#calendar").empty(); $("#timeList").empty(); setSummary();
        loadDoctors(selected.deptId);
      });
      $box.append($li);
    });
  }
  function loadDepts(){
    $.getJSON(CTX+'/doctors/api/departments.do', function(data){
      var raw = Array.isArray(data)? data : (data && data.list) ? data.list : [];
      // 로드 시점부터 숨길 항목 제거
      allDepts = raw.filter(function(d){
        var nm = getDeptName(d).trim();
        return !HIDDEN_SET.has(nm);
      });
      renderDepts(allDepts);
    }).fail(function(){
      $("#deptList").html('<p class="muted">진료과 목록을 불러오지 못했습니다.</p>');
    });
  }
  $("#deptSearch").on("input", function(){
    var k = $(this).val().trim().toLowerCase();
    if(!k) return renderDepts(allDepts);
    var f = allDepts.filter(function(d){
      var name = getDeptName(d).toLowerCase();
      return name.indexOf(k) >= 0;
    });
    renderDepts(f);
  });

  /* ========= 2) 의사(카드 2열 + 사진 위/텍스트 아래) ========= */
  function renderDoctors(list){
    var $wrap = $('<div class="doctor-grid"></div>');
    var $box = $("#doctorList").empty().append($wrap);

    if(!list || !list.length){
      $box.html('<p class="muted">해당 진료과의 의료진이 없습니다.</p>');
      return;
    }

    list.forEach(function(v){
      var nameTxt = toStr(pick(v.name, v.doctorName, v.doctor_name, v.korName, v.nameKor, v.fullName, v.doctorNm, v.doctor_nm, '의사'));
      var specs   = toStr(pick(v.specialty, v.specialties, v.major, v.field, v.note, '' ));
      var deptNm  = toStr(pick(v.deptName, v.departmentName, v.dept_nm, '' ));
      var idVal   = toStr(pick(v.doctorId, v.id, v.doctor_id, '' ));
      var imgFile = toStr(pick(v.profileImagePath, idVal ? (idVal+'.png') : '' , ''));
      var imgSrc  = imgFile ? (CTX + '/resources/images/doctor/' + imgFile) : DEFAULT_DOCTOR_IMG;

      var $card   = $('<div class="doctor-card" role="button" tabindex="0"></div>').attr('data-id', idVal);

      var $photo  = $('<div class="doc-photo"></div>').append(
        $('<img/>')
          .attr('alt', nameTxt)
          .attr('src', imgSrc)
          .on('error', function(){ this.onerror=null; this.src = DEFAULT_DOCTOR_IMG; })
      );

      var $meta = $('<div class="doc-meta"></div>');
      $meta.append('<div class="doc-name">'+nameTxt+'</div>');
      if(deptNm) $meta.append('<div class="doc-dept">'+deptNm+'</div>');
      $meta.append('<div class="doc-spec">'+(specs || '')+'</div>');

      if(String(selected.doctorId)===String(idVal)) $card.addClass('active');

      $card.append($photo).append($meta);

      $card.on('click', function(){
        $(".doctor-card").removeClass("active");
        $(this).addClass("active");
        selected.doctorId = String($(this).data("id"));
        selected.doctorName = nameTxt;
        selected.date = selected.time = selected.scheduleId = null;
        $("#calendar").html(''); $("#timeList").html(''); setSummary();
        loadSchedules(selected.doctorId);
      });

      $wrap.append($card);
    });
  }
  function loadDoctors(deptId){
    $.getJSON(CTX+'/doctors/api/doctors.do', { deptId: deptId }, function(data){
      var list = Array.isArray(data)? data : (data && data.list) ? data.list : [];
      renderDoctors(list);
    }).fail(function(){
      $("#doctorList").html('<p class="muted">의사 목록을 불러오지 못했습니다.</p>');
    });
  }

  /* ========= 3) 스케줄 ========= */
  var curMonth = new Date();
  var latestSchedules = { scheduleMap:{}, reservedIds:[] };

  function buildCalendar(daysMap){
    $("#calTitle").text(fmtYM(curMonth));
    var headers = ['일','월','화','수','목','금','토'];
    var $cal = $("#calendar").empty();
    headers.forEach(function(h){ $cal.append('<div class="dow">'+h+'</div>'); });

    var first = new Date(curMonth.getFullYear(), curMonth.getMonth(), 1);
    var last  = new Date(curMonth.getFullYear(), curMonth.getMonth()+1, 0);
    for(var i=0;i<first.getDay();i++) $cal.append('<div></div>');

    for(var d=1; d<=last.getDate(); d++){
      (function(dv){
        var date = new Date(curMonth.getFullYear(), curMonth.getMonth(), dv);
        var key = ymd(date);
        var has = !!daysMap[key];
        var cls = 'day' + (has ? '' : ' disabled') + (selected.date===key ? ' active':'');
        var $cell = $('<div class="'+cls+'"></div>').text(dv);
        if(has){
          $cell.on('click', function(){
            $(".day").removeClass("active");
            $(this).addClass("active");
            selected.date = key; selected.time = null; selected.scheduleId=null;
            renderTimes(key, daysMap[key]); setSummary();
          });
        }
        $cal.append($cell);
      })(d);
    }
  }
  function renderTimes(dayKey, slots){
    var reserved = (latestSchedules.reservedIds || []);
    var $box = $("#timeList").empty();
    if(!slots || !slots.length){ $box.html('<span class="muted">이 날짜는 예약 가능한 시간이 없습니다.</span>'); return; }

    slots.forEach(function(s){
      var taken = reserved.indexOf(s.id) >= 0;
      var cls = 'time-btn' + (taken ? ' disabled':'') + (selected.scheduleId===s.id ? ' active':'');
      var $btn = $('<button type="button" class="'+cls+'"></button>').text(s.time);
      if(!taken){
        $btn.on('click', function(){
          $(".time-btn").removeClass("active");
          $(this).addClass("active");
          selected.time = s.time;
          selected.scheduleId = s.id;
          setSummary();
        });
      }
      $box.append($btn);
    });
  }
  function loadSchedules(doctorId){
    $.getJSON(CTX+'/doctors/api/doctor-schedules.do', { doctorId: doctorId }, function(resp){
      latestSchedules = resp || {scheduleMap:{}, reservedIds:[]};
      buildCalendar(latestSchedules.scheduleMap);
    }).fail(function(){
      $("#calendar").html('<p class="muted">스케줄을 불러오지 못했습니다.</p>');
    });
  }

  $("#prevMonth").on("click", function(){
    curMonth = new Date(curMonth.getFullYear(), curMonth.getMonth()-1, 1);
    buildCalendar(latestSchedules.scheduleMap);
  });
  $("#nextMonth").on("click", function(){
    curMonth = new Date(curMonth.getFullYear(), curMonth.getMonth()+1, 1);
    buildCalendar(latestSchedules.scheduleMap);
  });

  /* 제출 가드 */
  $("#reserveForm").on("submit", function(e){
    if(!(selected.deptId && selected.doctorId && selected.scheduleId)){
      e.preventDefault();
      alert("진료과, 의사, 날짜/시간을 모두 선택해주세요.");
    }
  });

  /* 초기 로드 */
  loadDepts();
})();
</script>

</body>
</html>
<jsp:include page="/WEB-INF/jsp/footer.jsp" />
 