<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>


<c:set var="cPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>예약내역 조회</title>
<style>
  body{font-family:system-ui,Arial,sans-serif;background:#fff}
  /* ===== 페이지 타이틀(좌측 상단) ===== */
  .page-header{margin:20px 0 14px}
  .page-title{
    font-size:28px; line-height:1.25; font-weight:800; letter-spacing:-0.3px;
    background:linear-gradient(120deg,#111827,#2563eb 70%);
    -webkit-background-clip:text; background-clip:text; color:transparent;
  }
  .page-sub{color:#6b7280;font-size:13px;margin-top:4px}

  /* ===== 표 ===== */
  table{width:100%;border-collapse:collapse;background:#fff}
  th,td{border:1px solid #e5e7eb;padding:10px;text-align:center;font-size:14px}
  thead th{background:#f8fafc;font-weight:700}
  .actions form{display:inline-block;margin:0 3px}
  .btn{padding:6px 10px;border:1px solid #cbd5e1;background:#f8fafc;border-radius:6px;cursor:pointer}
  .btn:hover{background:#eef2ff}
  .btn[disabled]{opacity:.5;cursor:not-allowed}

  /* ===== 우측 드로어 ===== */
  .drawer{position:fixed;top:0;right:-420px;width:420px;height:100vh;background:#fff;
          box-shadow:-8px 0 24px rgba(0,0,0,.08);transition:right .25s ease;z-index:1000;display:flex;flex-direction:column}
  .drawer.open{right:0}
  .drawer-header{display:flex;justify-content:space-between;align-items:center;padding:14px 16px;border-bottom:1px solid #eee}
  .drawer-body{padding:14px 16px;overflow:auto;gap:12px;display:flex;flex-direction:column}
  .field{position:relative;display:flex;flex-direction:column;gap:6px}
  .input{padding:10px 12px;border:1px solid #d1d5db;border-radius:8px}
  .help{color:#6b7280;font-size:12px}
  .suggest{
    position:absolute;left:0;top:calc(100% + 6px);width:100%;
    border:1px solid #e5e7eb;border-radius:8px;background:#fff;
    display:none;max-height:240px;overflow:auto;z-index:3000;
  }
  .suggest-item{padding:10px 12px;cursor:pointer}
  .suggest-item:hover{background:#f3f4f6}
  .chip-group{display:flex;flex-wrap:wrap;gap:8px}
  .chip{padding:8px 12px;border:1px solid #cbd5e1;border-radius:999px;cursor:pointer;background:#fff}
  .chip.active{background:#111827;color:#fff;border-color:#111827}
  .chip[disabled]{opacity:.45;cursor:not-allowed}
  .drawer-footer{margin-top:auto;padding:12px 16px;border-top:1px solid #eee;display:flex;gap:8px}

  .list{margin-top:8px}
  .doctor-item{
    display:block;padding:8px 10px;border:1px solid #e5e7eb;border-radius:8px;
    margin-bottom:6px;cursor:pointer;background:#fff
  }
  .doctor-item:hover{background:#f8fafc}
  .doctor-item.active{outline:2px solid #111827}

  /* ===== 플래시 모달 ===== */
  .flash-backdrop{position:fixed;inset:0;background:rgba(0,0,0,.45);display:none;align-items:center;justify-content:center;z-index:3000}
  .flash-backdrop.open{display:flex}
  .flash-card{width:min(420px,92vw);background:#fff;border-radius:14px;box-shadow:0 20px 40px rgba(0,0,0,.25);padding:18px 16px}
  .flash-title{font-weight:800;font-size:18px;margin-bottom:6px}
  .flash-msg{color:#111827;margin:8px 0 14px;line-height:1.5}
  .flash-actions{display:flex;justify-content:flex-end;gap:8px}
  .flash-btn{padding:8px 14px;border:1px solid #cbd5e1;background:#111827;color:#fff;border-radius:8px;cursor:pointer}
  .flash-btn:hover{opacity:.9}
  .flash-error .flash-title{color:#b91c1c}
  html, body { height: 100%; }
   body {
     min-height: 100vh;
     display: flex;
     flex-direction: column; /* 세로 플렉스 */
   }
.page-main { flex: 1; display: flex; flex-direction: column; } /* 본문이 남은 공간 채움 */
.flash-actions .flash-btn{
  all: unset;                 /* 외부 버튼 규칙(아이콘 버튼 등) 초기화 */
  display: inline-block;
  padding: 8px 14px;
  border-radius: 8px;
  border: 1px solid #111827;
  background: #111827;
  color: #fff;
  font-weight: 700;
  line-height: 1.1;
  cursor: pointer;
}
.flash-actions .flash-btn:hover{ opacity: .9; }
.flash-actions .flash-btn:focus{ outline: 2px solid #111827; outline-offset: 2px; }

/* (옵션) 표의 취소 버튼이 disabled일 때도 글자가 보이도록 */
.btn{ color:#111827; }
.btn[disabled]{ opacity:.55; color:#6b7280; background:#f3f4f6; }
</style>


<script>
  'use strict';

  var BASE = '<c:out value="${cPath}"/>';
  var currentReservationId=null, selectedDept=null, selectedDoctor=null, selectedDate=null, selectedTime=null;

  /* ===================== 유틸 ===================== */
  function consoleError(e){ console.error(e); }
  function escapeHtml(s){
    return (s||'').replace(/[&<>"']/g, function(m){
      return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[m];
    });
  }
  function pick(row, names){
    for (const n of names) if (row && row[n] != null && row[n] !== '') return row[n];
    if (!row) return undefined;
    const lower = {}; for (const k in row) lower[k.toLowerCase()] = k;
    for (const n of names){ const k = lower[String(n).toLowerCase()]; if (k && row[k] != null && row[k] !== '') return row[k]; }
    return undefined;
  }
  function pickByRegex(row, regex){ for (const k in row){ if (regex.test(k)) return row[k]; } return undefined; }

  /* 응답을 배열로 정규화 */
  function toArray(data){
    if (Array.isArray(data)) return data;
    if (data && typeof data === 'object'){
      const cand = data.list || data.items || data.rows || data.results || data.data;
      if (Array.isArray(cand)) return cand;
      if ('doctorId' in data || 'doctor_id' in data || 'id' in data) return [data];
    }
    return [];
  }

  function getDoctorId(row){
    if(!row) return '';
    return (pick(row, ['doctorId','doctor_id','id']) || pickByRegex(row, /(doctor.*id)/i) || '').toString();
  }
  function getDoctorName(row){
    if(!row) return '';
    return (pick(row, ['name','doctorName']) || pickByRegex(row, /(name)$/i) || '').toString();
  }

  /* ===================== 날짜/시간 비교 유틸 ===================== */
  const NOW_BUFFER_MIN = 0; // 지금으로부터 몇 분 이후까지를 '과거'로 볼지 버퍼
  function pad2(n){ return ('0'+n).slice(-2); }
  function toYMDfromDate(d){ return d.getFullYear() + '-' + pad2(d.getMonth()+1) + '-' + pad2(d.getDate()); }
  function ymdToNum(s){ const m = String(s||'').trim().match(/^(\d{4})[-/.]?(\d{1,2})[-/.]?(\d{1,2})$/); if(!m) return null; return (+m[1])*10000 + (+m[2])*100 + (+m[3]); }
  function todayYmdNum(){ const d = new Date(); return d.getFullYear()*10000 + (d.getMonth()+1)*100 + d.getDate(); }
  function toHHMM(raw){
    if (raw==null) return '';
    const s = String(raw).trim();
    if (/^\d{4}$/.test(s)) return s.slice(0,2)+':'+s.slice(2);
    let m = /^(\d{1,2}):(\d{1,2})$/.exec(s); if (m) return ('0'+m[1]).slice(-2)+':'+('0'+m[2]).slice(-2);
    if (/^\d{2}:\d{2}$/.test(s)) return s;
    m = s.match(/\b(\d{1,2}):(\d{2})\b/); if (m) return ('0'+m[1]).slice(-2)+':'+m[2];
    m = s.match(/\b(\d{2})(\d{2})\b/); if (m) return m[1]+':'+m[2];
    return '';
  }
  function hhmmToMinutes(s){ const t = toHHMM(s); if(!t) return null; const h=+t.slice(0,2), m=+t.slice(3); return h*60 + m; }
  function isPastDateYmd(s){ const n = ymdToNum(s); if(n==null) return false; return n < todayYmdNum(); }
  function isPastTimeOn(dateStr, timeStr){
    const d = ymdToNum(dateStr); if(d==null) return false;
    const today = todayYmdNum();
    if(d > today) return false;
    if(d < today) return true;
    const now = new Date();
    const nowMin = now.getHours()*60 + now.getMinutes() + NOW_BUFFER_MIN;
    const slotMin = hhmmToMinutes(timeStr);
    if(slotMin==null) return false;
    return slotMin <= nowMin;
  }

  /* ===================== JSON 우선, XML 폴백 ===================== */
  async function fetchJson(url){
    const res = await fetch(url, { credentials:'same-origin', headers:{'Accept':'application/json'} });
    const ct = (res.headers.get('content-type') || '').toLowerCase();
    if (ct.indexOf('application/json') !== -1) return res.json();
    const text = await res.text();
    if (!text.trim().startsWith('<')) throw new Error('Not JSON');
    const xml = new DOMParser().parseFromString(text, 'application/xml');
    if (xml.querySelector('parsererror')) throw new Error('XML parse error');

    const list = xml.getElementsByTagName('List')[0];
    if (list){
      const arr = [];
      Array.from(list.children).forEach(function(item){
        const obj = {}; Array.from(item.children).forEach(function(el){ obj[el.tagName.toLowerCase()] = el.textContent; });
        if (obj.doctorid && !obj.doctorId) obj.doctorId = obj.doctorid;
        if (obj.doctorname && !obj.name)   obj.name    = obj.doctorname;
        arr.push(obj);
      });
      return arr;
    }
    const map = xml.getElementsByTagName('Map')[0];
    if (map){
      const obj = {}; Array.from(map.children).forEach(function(el){ obj[el.tagName.toLowerCase()] = el.textContent; });
      if (obj.doctorid && !obj.doctorId) obj.doctorId = obj.doctorid;
      if (obj.doctorname && !obj.name)   obj.name    = obj.doctorname;
      return obj;
    }
    throw new Error('Unknown XML');
  }

  /* ===================== 날짜 정규화 & 가용 시간 추출 (신규) ===================== */
  function normalizeYMD(d){
    if (!d) return '';
    if (d instanceof Date) return toYMDfromDate(d);
    const s = String(d).trim();
    let m = s.match(/(\d{4})[-/.](\d{1,2})[-/.](\d{1,2})/); // yyyy-mm-dd | yyyy.mm.dd | yyyy/mm/dd
    if (m) return m[1] + '-' + pad2(+m[2]) + '-' + pad2(+m[3]);
    m = s.match(/(\d{4})(\d{2})(\d{2})/); // yyyyMMdd
    if (m) return m[1] + '-' + m[2] + '-' + m[3];
    return '';
  }
  function getTimeValue(row){
    if(typeof row==='string') return toHHMM(row);
    if(!row) return '';
    const cands = ['time','scheduleTime','startTime','start','slotTime','apptTime','reservationTime','TIME','SLOTTIME'];
    for (const k of cands){ const t = toHHMM(row[k]); if (t) return t; }
    for (const k in row){ if (/time$/i.test(k) || /^time$/i.test(k)){ const t = toHHMM(row[k]); if (t) return t; } }
    const H = pick(row, ['hour','hh','Hr','HOUR','HH']), M = pick(row, ['minute','mm','MINUTE','MM']);
    if (H!=null && M!=null) return toHHMM(`${H}:${M}`);
    return '';
  }
  function extractAvailableTimes(rows, dateStr){
    rows = toArray(rows);
    const yes = v => v === true || v === 'Y' || v === 'y' || v === 1 || v === '1';
    const no  = v => v === false || v === 'N' || v === 'n' || v === 0 || v === '0';
    const seen = new Set();
    const list = [];
    for (const r of rows){
      if (r && typeof r === 'object'){
        if ('reserved'  in r && yes(r.reserved)) continue;
        if ('booked'    in r && yes(r.booked))   continue;
        if ('available' in r && no(r.available)) continue;
        if (typeof r.status === 'string' && /full|closed|unavailable/i.test(r.status)) continue;
      }
      const t = getTimeValue(r);
      const tt = toHHMM(t);
      if (!tt) continue;
      if (isPastTimeOn(dateStr, tt)) continue; // 오늘 날짜의 과거 시간 제외
      if (seen.has(tt)) continue;
      seen.add(tt);
      list.push(tt);
    }
    return list.sort();
  }
  async function fetchAvailableTimesForDate(doctorId, dateStr){
    try{
      const url = BASE + '/api/schedules/times.do?doctorId='
                + encodeURIComponent(doctorId) + '&date=' + encodeURIComponent(dateStr);
      const rows = await fetchJson(url);
      return extractAvailableTimes(rows, dateStr);
    }catch(e){ return []; }
  }

  /* ===================== 모달 ===================== */
  function openEdit(reservationId, deptName, doctorName, doctorId, dateStr, timeStr){
    currentReservationId = reservationId;
    document.getElementById('drawer').classList.add('open');

    document.getElementById('deptInput').value   = deptName || '';
    document.getElementById('doctorInput').value = doctorName || '';
    document.getElementById('deptSuggest').innerHTML = '';
    document.getElementById('deptSuggest').style.display='none';
    document.getElementById('doctorList').innerHTML = '';
    document.getElementById('dateChips').innerHTML = '';
    document.getElementById('timeChips').innerHTML = '';

    selectedDept=null; selectedDoctor=null; selectedDate=null; selectedTime=null;

    if (doctorId){
      selectedDoctor = doctorId;
      fetchJson(BASE + '/api/doctors/byId.do?doctorId=' + encodeURIComponent(doctorId))
        .then(function(d){ if(d && d.name) document.getElementById('doctorInput').value = d.name; })
        .catch(consoleError);
      loadScheduleDates(doctorId, dateStr, timeStr);
    }
  }
  function closeEdit(){ document.getElementById('drawer').classList.remove('open'); }

  /* ===================== 진료과 자동완성 ===================== */
  let _deptAll = null, _deptLoadInFlight = null, _deptToken = 0;
  const DEPT_MAX = 15;

  async function loadAllDepartments(){
    if (_deptAll) return _deptAll;
    if (_deptLoadInFlight) return _deptLoadInFlight;

    const urls = [
      BASE + '/api/departments/list.do',
      BASE + '/api/departments/all.do',
      BASE + '/doctors/api/departments.do',
      BASE + '/api/departments/search.do?q='
    ];

    _deptLoadInFlight = (async function(){
      for (const url of urls){
        try{
          const rows = toArray(await fetchJson(url));
          if (rows.length){
            const seen = new Set();
            const list = rows.map(function(r){
              const id   = (r.deptId || r.deptid || r.id || r.DEPTID || r.ID || '').toString();
              const name = (r.name  || r.deptName || r.department || r.DEPTNAME || r.DEPARTMENT || '').toString();
              return { id, name };
            }).filter(d => d.id || d.name).filter(d=>{
              const k = d.id + '|' + d.name;
              if (seen.has(k)) return false; seen.add(k); return true;
            });
            _deptAll = list;
            _deptLoadInFlight = null;
            return _deptAll;
          }
        }catch(e){ /* 다음 url 시도 */ }
      }
      _deptLoadInFlight = null;
      _deptAll = [];
      return _deptAll;
    })();

    return _deptLoadInFlight;
  }

  function renderDeptSuggest(items, q){
    const box = document.getElementById('deptSuggest');
    if (!box) return;
    if (!items || !items.length){ box.innerHTML = ''; box.style.display = 'none'; return; }

    const query = String(q||'').toLowerCase();
    const html = items.slice(0, DEPT_MAX).map(function(d){
      const label = d.name || '';
      const i = label.toLowerCase().indexOf(query);
      const pretty = (i>=0)
        ? escapeHtml(label.slice(0,i)) + '<mark>' + escapeHtml(label.slice(i,i+query.length)) + '</mark>' + escapeHtml(label.slice(i+query.length))
        : escapeHtml(label);
      return '<div class="suggest-item" role="button" tabindex="-1" data-id="'+ escapeHtml(d.id) +'" data-name="'+ escapeHtml(d.name) +'">'+ pretty + '</div>';
    }).join('');
    box.innerHTML = html;
    box.style.display = 'block';
  }

  document.addEventListener('pointerdown', function(e){
    const suggestItem = e.target.closest('#deptSuggest .suggest-item');
    const inSuggest   = !!e.target.closest('#deptSuggest');
    const inInput     = !!e.target.closest('#deptInput');

    if (suggestItem){
      e.preventDefault();
      e.stopPropagation();
      e.stopImmediatePropagation && e.stopImmediatePropagation();
      selectDeptItem(suggestItem);
      return;
    }
    if (!inSuggest && !inInput){
      const box = document.getElementById('deptSuggest');
      if (box){ box.innerHTML=''; box.style.display='none'; }
    }
  }, true);

  function selectDeptItem(item){
    const id   = item.getAttribute('data-id');
    const name = item.getAttribute('data-name') || item.textContent.trim();
    if(!id) return;

    const input = document.getElementById('deptInput');
    if (input) input.value = name;

    const box = document.getElementById('deptSuggest');
    if (box){ box.innerHTML = ''; box.style.display = 'none'; }

    selectedDept = id;
    selectedDoctor = null; selectedDate = null; selectedTime = null;

    document.getElementById('doctorInput').value = '';
    document.getElementById('doctorList').innerHTML = '';
    document.getElementById('dateChips').innerHTML = '';
    document.getElementById('timeChips').innerHTML = '';

    loadDoctorsListByDept(id);
  }

  let deptTypingTimer = null;
  function handleDeptInput(raw){
    const q = (raw || '').trim();
    clearTimeout(deptTypingTimer);
    deptTypingTimer = setTimeout(async function(){
      if (!q){ renderDeptSuggest([], ''); return; }
      const token = ++_deptToken;
      const all = await loadAllDepartments();
      if (token !== _deptToken) return;
      const nq = q.toLowerCase();
      const filtered = all.filter(d => (d.name||'').toLowerCase().indexOf(nq) !== -1);
      renderDeptSuggest(filtered, q);
    }, 60);
  }

  window.addEventListener('DOMContentLoaded', function(){
    var el = document.getElementById('deptInput');
    if (!el) return;
    el.setAttribute('autocomplete','off');
    el.setAttribute('autocorrect','off');
    el.setAttribute('autocapitalize','off');
    el.setAttribute('spellcheck','false');
    el.addEventListener('input', function(e){ handleDeptInput(e.target.value); });
    el.addEventListener('compositionend', function(e){ handleDeptInput(e.target.value); });
  });

  /* ===================== 과 선택 → 의사 목록 ===================== */
  let doctorsReqToken = 0;

  async function loadDoctorsListByDept(deptId){
    if(!deptId) return;
    const myToken = ++doctorsReqToken;

    const box = document.getElementById('doctorList');
    box.innerHTML = '<div class="help">의사 목록을 불러오는 중...</div>';

    let rows = [];
    try{
      const r1 = await fetchJson(BASE + '/api/doctors/listByDept.do?deptId=' + encodeURIComponent(deptId));
      rows = toArray(r1);
    }catch(e){ }

    if (!rows.length){
      try{
        const r2 = await fetchJson(BASE + '/api/doctors/byDept.do?deptId=' + encodeURIComponent(deptId));
        rows = toArray(r2);
      }catch(e){ }
    }

    if (myToken !== doctorsReqToken) return;

    if(!rows.length){ box.innerHTML = '<div class="help">이 과의 의사 정보가 없습니다.</div>'; return; }

    const seen = new Set();
    const ids = [];
    for (const row of rows){
      const id = getDoctorId(row);
      if (!id) continue;
      if (seen.has(id)) continue;
      seen.add(id);
      ids.push(id);
    }
    if (!ids.length){ box.innerHTML = '<div class="help">이 과의 의사 정보가 없습니다.</div>'; return; }

    const details = await Promise.all(ids.map(async (id) => {
      try {
        const info = await fetchJson(BASE + '/api/doctors/byId.do?doctorId=' + encodeURIComponent(id));
        const name = (info && (info.name || info.doctorName)) ? String(info.name || info.doctorName) : ('['+id+']');
        return { id, name };
      } catch(e){
        return { id, name:'['+id+']' };
      }
    }));
    if (myToken !== doctorsReqToken) return;

    details.sort((a,b)=> a.name.localeCompare(b.name,'ko'));
    box.innerHTML = details.map(d =>
      '<button type="button" class="doctor-item" data-id="'+ escapeHtml(d.id) +'" data-name="'+ escapeHtml(d.name) +'">'
      +  escapeHtml(d.name)
      + '</button>'
    ).join('');
  }

  /* ===================== 스케줄 날짜/시간 ===================== */
  let datesReqToken = 0;
  let timesReqToken = 0;

  function loadScheduleDates(doctorId, preDate, preTime){
    const myToken = ++datesReqToken;

    var dateBox = document.getElementById('dateChips');
    var timeBox = document.getElementById('timeChips');
    dateBox.innerHTML=''; timeBox.innerHTML='';

    if(!doctorId){ dateBox.innerHTML='<div class="help">의사를 먼저 선택하세요.</div>'; return; }

    (async function(){
      try{
        let rows = await fetchJson(BASE + '/api/schedules/dates.do?doctorId=' + encodeURIComponent(doctorId));
        if (myToken !== datesReqToken) return;
        rows = toArray(rows);

        // 응답 → yyyy-MM-dd 로 정규화
        const rawDates = rows.map(function(v){
          let d = (typeof v === 'string')
            ? v
            : (v.date || v.day || v.RESERVATIONDATE || v.reservationDate || '');
          return normalizeYMD(d);
        }).filter(Boolean);

        // 과거 날짜 제거
        let dates = Array.from(new Set(rawDates))
          .filter(d => !isPastDateYmd(d))
          .sort();

        // 전달받은 preDate 정규화
        preDate = normalizeYMD(preDate);

        // ★ 각 날짜에 '미래 가용 시간'이 1개 이상 있는 경우만 남김
        const withTimes = await Promise.all(
          dates.map(async d => ({ d, times: await fetchAvailableTimesForDate(doctorId, d) }))
        );
        dates = withTimes.filter(x => x.times && x.times.length > 0).map(x => x.d);

        if(!dates.length){
          dateBox.innerHTML = '<div class="help">변경 가능한 날짜가 없습니다.</div>';
          return;
        }
        if (preDate && !dates.includes(preDate)) preDate = '';

        dates.forEach(function(d){
          var btn = document.createElement('button');
          btn.type='button';
          btn.className='chip' + (preDate===d ? ' active' : '');
          btn.setAttribute('data-date', d);
          btn.textContent=d;
          btn.addEventListener('click', function(){
            Array.prototype.forEach.call(dateBox.querySelectorAll('.chip'), function(c){ c.classList.remove('active'); });
            btn.classList.add('active');
            selectedDate=d; selectedTime=null;
            loadScheduleTimes(doctorId, d, null);
          });
          dateBox.appendChild(btn);
        });

        if(preDate){
          selectedDate=preDate;
          loadScheduleTimes(doctorId, preDate, preTime || null);
        }else{
          const first = dateBox.querySelector('.chip');
          if (first) first.click();
        }
      }catch(e){
        console.error(e);
        dateBox.innerHTML = '<div class="help">스케줄이 없습니다.</div>';
      }
    })();
  }

  async function loadScheduleTimes(doctorId, dateStr, preTime){
    const myToken = ++timesReqToken;

    const timeBox = document.getElementById('timeChips');
    if(!doctorId || !dateStr){ timeBox.innerHTML=''; return; }

    timeBox.innerHTML = '<div class="help">시간을 불러오는 중...</div>';

    try{
      const url = BASE + '/api/schedules/times.do?doctorId='
                + encodeURIComponent(doctorId) + '&date=' + encodeURIComponent(dateStr);
      let rows = await fetchJson(url);
      if (myToken !== timesReqToken) return;

      const list = extractAvailableTimes(rows, dateStr);

      if (!list.length){
        timeBox.innerHTML = '<div class="help">해당 날짜에 가능한 시간이 없습니다.</div>';
        return;
      }

      if (preTime && !list.includes(toHHMM(preTime))) preTime = null;

      timeBox.innerHTML = '';
      list.forEach(function(t){
        var btn = document.createElement('button');
        btn.type = 'button';
        btn.className = 'chip' + (preTime === t ? ' active' : '');
        btn.setAttribute('data-time', t);
        btn.textContent = t;
        btn.addEventListener('click', function(){
          Array.prototype.forEach.call(timeBox.querySelectorAll('.chip'), c => c.classList.remove('active'));
          btn.classList.add('active');
          selectedTime = t;
        });
        timeBox.appendChild(btn);
      });

      if (preTime){
        selectedTime = preTime;
      }else{
        const first = timeBox.querySelector('.chip');
        if (first) first.click();
      }
    }catch(e){
      console.error(e);
      timeBox.innerHTML = '<div class="help">시간 정보를 불러오지 못했습니다.</div>';
    }
  }

  /* ===================== 저장 ===================== */
  function saveChange(){
    if(!selectedDoctor){ alert('의사를 선택해주세요.'); return; }
    if(!selectedDate){ alert('예약일을 선택해주세요.'); return; }
    if(!selectedTime){ alert('시간을 선택해주세요.'); return; }
    var form = document.createElement('form');
    form.method='post';
    form.action = BASE + '/reservation/' + currentReservationId + '/update.do';
    form.innerHTML =
        '<input type="hidden" name="department" value="' + escapeHtml(document.getElementById('deptInput').value) + '">'
      + '<input type="hidden" name="doctorId" value="' + escapeHtml(selectedDoctor) + '">'
      + '<input type="hidden" name="reservationDate" value="' + escapeHtml(selectedDate) + '">'
      + '<input type="hidden" name="scheduleTime" value="' + escapeHtml(selectedTime) + '">';
    document.body.appendChild(form); form.submit();
  }

  /* ===================== 이벤트 바인딩 ===================== */
  document.addEventListener('click', function(e){
    var btn = e.target.closest('.btn-edit');
    if(!btn) return;
    openEdit(
      btn.getAttribute('data-res-id'),
      btn.getAttribute('data-dept') || '',
      btn.getAttribute('data-doc-name') || '',
      btn.getAttribute('data-doc-id') || '',
      btn.getAttribute('data-date') || '',
      btn.getAttribute('data-time') || ''
    );
  });

  document.addEventListener('click', function(e){
    var item = e.target.closest('.doctor-item');
    if(!item) return;
    document.querySelectorAll('.doctor-item.active').forEach(function(n){ n.classList.remove('active'); });
    item.classList.add('active');
    selectedDoctor = item.getAttribute('data-id');
    document.getElementById('doctorInput').value = item.getAttribute('data-name') || '';
    document.getElementById('dateChips').innerHTML = '';
    document.getElementById('timeChips').innerHTML = '';
    ++datesReqToken; ++timesReqToken;
    loadScheduleDates(selectedDoctor, null, null);
  });

  /* ===== Flash 모달 ===== */
  function openFlash(message, isError){
    var m = document.getElementById('flashModal');
    var c = document.getElementById('flashCard');
    document.getElementById('flashMsg').textContent = message || '';
    document.getElementById('flashTitle').textContent = isError ? '실패' : '완료';
    c.classList.toggle('flash-error', !!isError);
    m.classList.add('open');
    document.addEventListener('keydown', escCloseOnce, { once:true });
  }
  function escCloseOnce(e){ if(e.key === 'Escape') closeFlash(); }
  function closeFlash(){ document.getElementById('flashModal').classList.remove('open'); }

  window.addEventListener('DOMContentLoaded', function(){
    var ok = '<c:out value="${msg}"/>';
    var err = '<c:out value="${error}"/>';
    if (err && err.trim().length)      openFlash(err, true);
    else if (ok && ok.trim().length)   openFlash(ok, false);
  });
  window.addEventListener('DOMContentLoaded', function(){
    var fm = document.getElementById('flashModal');
    if (fm){
      fm.addEventListener('click', function(e){
        if (e.target === e.currentTarget) closeFlash();
      });
    }
  });
</script>

</head>

<body>
<main class="page-main">
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<!-- 좌측 상단 타이틀 영역 -->
<div class="page-header">
  <div class="page-title">예약내역 조회</div>
  <!-- 필요시 부제목: <div class="page-sub">내 예약을 한눈에 관리하세요</div> -->
</div>

<table>
  <thead>
    <tr>
      <th>No</th>
      <th>진료과</th>
      <th>의사</th>
      <th>예약일</th>
      <th>시간</th>
      <th>관리</th> <!-- 변경/취소 버튼 열 -->
    </tr>
  </thead>
  <tbody>
  <c:forEach var="r" items="${list}" varStatus="vs">
    <tr>
      <td>${vs.index + 1}</td>
      <td>${fn:escapeXml(r.department)}</td>
      <td>${fn:escapeXml(r.doctorName)}</td>
      <td><fmt:formatDate value="${r.reservationDate}" pattern="yyyy-MM-dd"/></td>
      <td>${fn:escapeXml(r.scheduleTime)}</td>

      <!-- 관리(변경/취소) -->
      <td class="actions">
        <button type="button" class="btn btn-edit"
                data-res-id="${r.reservationId}"
                data-dept="${fn:escapeXml(r.department)}"
                data-doc-name="${fn:escapeXml(r.doctorName)}"
                data-doc-id="${fn:escapeXml(r.doctorId)}"
                data-date="<fmt:formatDate value='${r.reservationDate}' pattern='yyyy-MM-dd'/>"
                data-time="${fn:escapeXml(r.scheduleTime)}">변경</button>

        <form method="post"
              action="${pageContext.request.contextPath}/reservation/${r.reservationId}/cancel.do"
              onsubmit="return confirm('해당 예약을 취소하시겠어요?');">
          <!-- 이미 취소된 건 비활성화하고 싶으면 아래 조건 유지 -->
          <button type="submit" class="btn" <c:if test="${r.status=='취소'}">disabled</c:if>>취소</button>
        </form>
      </td>
    </tr>
  </c:forEach>

  <c:if test="${empty list}">
    <tr><td colspan="6">예약 내역이 없습니다.</td></tr>
  </c:if>
  </tbody>
</table>

<!-- 우측 모달 -->
<div id="drawer" class="drawer" aria-hidden="true">
  <div class="drawer-header">
    <strong>예약 변경</strong>
    <button type="button" class="btn" onclick="closeEdit()">닫기</button>
  </div>
  <div class="drawer-body">
    <div class="field">
      <label>진료과</label>
      <input id="deptInput" class="input" type="text" placeholder="진료과 검색" autocomplete="off" />
      <div id="deptSuggest" class="suggest"></div>
      <div class="help">부서를 입력하면 자동완성이 나타납니다.</div>
    </div>

    <div class="field">
      <label>의사</label>
      <input id="doctorInput" class="input" type="text" placeholder="의사 목록에서 선택하세요." readonly />
      <div id="doctorList" class="list"></div>
      <div id="doctorSuggest" class="suggest" style="display:none"></div>
      <div class="help">부서 선택 시 이 과의 모든 의사가 아래 목록에 표시됩니다. 목록에서 클릭하세요.</div>
    </div>

    <div class="field">
      <label>예약일</label>
      <div id="dateChips" class="chip-group"></div>
      <div class="help">선택한 의사의 실제 스케줄 날짜만 보여줍니다.</div>
    </div>

    <div class="field">
      <label>시간</label>
      <div id="timeChips" class="chip-group"></div>
      <div class="help">해당 날짜의 예약 가능 시간만 선택할 수 있습니다.</div>
    </div>
  </div>

  <div class="drawer-footer">
    <button type="button" class="btn" onclick="saveChange()">저장</button>
    <button type="button" class="btn" onclick="closeEdit()">닫기</button>
  </div>
</div>

<!-- Flash Modal -->
<div id="flashModal" class="flash-backdrop" role="dialog" aria-modal="true" aria-labelledby="flashTitle">
  <div class="flash-card" id="flashCard">
    <div class="flash-title" id="flashTitle">알림</div>
    <div class="flash-msg" id="flashMsg"></div>
    <div class="flash-actions">
  <button type="button" class="flash-btn" onclick="closeFlash()"><span>확인</span></button>
</div>
  </div>
</div>
</main>
<jsp:include page="/WEB-INF/jsp/footer.jsp" />
</body>
</html>


 