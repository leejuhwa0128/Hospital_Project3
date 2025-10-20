<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/referral/referral_header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>진료의뢰 안내</title>
    <style>
        /* ===== 레이아웃 ===== */
        body{
            font-family:'맑은 고딕','Malgun Gothic',sans-serif;
            margin:0; padding:0; background:#fff;
        }
        .main-container{
            display:flex; gap:24px;
            max-width:1200px; margin:0 auto; padding:40px 20px;
        }

        /* 좌측 사이드바는 referral_sidebar.css의 .ref-sidebar, .ref-side-menu 사용 */

        /* ===== 본문 영역 ===== */
        .content{ flex:1; }

        .title{
            font-size:26px; font-weight:800; color:#000;
            border-bottom:2px solid #000;
            padding-bottom:12px; margin:6px 0 24px;
        }

        /* 상단 배너 */
        .banner{
            background-image:url('${pageContext.request.contextPath}/resources/images/referral_banner.jpg');
            background-size:cover; background-position:center;
            border-radius:12px;
            padding:60px 28px;
            color:#000; font-size:22px; font-weight:800;
            position:relative; overflow:hidden;
            box-shadow:0 6px 22px rgba(0,0,0,.08);
        }
        .banner::after{
            content:""; position:absolute; inset:0;
            background:linear-gradient(180deg, rgba(255,255,255,.12), rgba(255,255,255,.55));
        }
        .banner > span{ position:relative; z-index:1; }

        /* 안내 박스 */
        .info-box{
            background:#fff; border-radius:14px;
            border:1px solid var(--line, #e6ebf1);
            box-shadow:0 8px 24px rgba(0,0,0,.06);
            padding:20px 22px; margin-top:-28px; position:relative; z-index:2;
        }
        .info-box p{ margin:0 0 8px; font-size:15px; color:#333; line-height:1.8; }
        .note{
            display:flex; align-items:center; gap:6px;
            font-size:13px; color:#666;
        }
        .note::before{ content:"ⓘ"; color:#316BFF; font-weight:700; }

        .referral-btn{
            display:inline-flex; align-items:center; gap:8px;
            background:#316BFF; color:#fff; padding:12px 18px;
            border-radius:28px; font-weight:800; font-size:14px;
            text-decoration:none;
            transition:transform .15s ease, box-shadow .15s ease, background .15s ease;
            box-shadow:0 6px 18px rgba(49,107,255,.28);
        }
        .referral-btn:hover{ background:#1f50d4; transform:translateY(-1px); }

        /* ===== 절차(스텝) ===== */
        .section-title{
            margin:40px 0 14px; font-size:20px; font-weight:800; color:#000;
        }
        .steps{
            display:grid; grid-template-columns:repeat(auto-fit, minmax(220px,1fr));
            gap:14px;
        }
        .step-card{
            background:#fff; border:1px solid var(--line, #e6ebf1);
            border-radius:12px; padding:16px;
            box-shadow:0 4px 12px rgba(0,0,0,.04);
        }
        .step-head{
            display:flex; align-items:center; gap:10px; margin-bottom:8px;
        }
        .step-num{
            width:28px; height:28px; border-radius:50%;
            display:inline-flex; align-items:center; justify-content:center;
            background:#eef3ff; color:#003366; font-weight:800; font-size:13px;
            border:1px solid #dfe8ff;
        }
        .step-title{ font-size:15px; font-weight:800; color:#111; }
        .step-desc{ margin:0; font-size:14px; color:#444; line-height:1.75; }

        /* ===== 카드 2열(운영시간/의뢰 연락처) ===== */
        .info-grid{
            display:grid; grid-template-columns:repeat(auto-fit, minmax(280px,1fr));
            gap:16px; margin-top:16px;
        }
        .ibox{
            background:#f9f9f9; border:1px solid #eee; border-radius:12px;
            padding:18px; font-size:14px; color:#000; line-height:2;
        }
        .ibox h4{ margin:0 0 10px; font-size:16px; font-weight:800; }
        .label{ display:inline-block; width:64px; color:#555; }

        /* ===== 필요서류/유의사항 ===== */
        .doc-need, .caution{
            background:#fff; border:1px solid var(--line, #e6ebf1);
            border-radius:12px; padding:16px;
        }
        .doc-need ul, .caution ul{ margin:8px 0 0 16px; padding:0; }
        .doc-need li, .caution li{ font-size:14px; color:#333; line-height:1.9; }

        /* 반응형 */
        @media (max-width:900px){
            .main-container{ flex-direction:column; }
            .cta-row{ justify-content:stretch; }
            .referral-btn{ justify-content:center; width:100%; }
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/referral_sidebar.css?v=20250811">
</head>
<body>

<div class="main-container">
    <!-- ✅ 좌측 사이드바 (요청하신 고정 코드 그대로) -->
    <aside class="ref-sidebar">
        <h3>진료의뢰&조회</h3>
        <ul class="ref-side-menu">
            <li><a class="is-active" href="/referral/referral.do">진료의뢰 안내</a></li>
            <li><a href="/referral/status.do">진료의뢰 신청현황</a></li>
            <li><a href="/referral/statusAll.do">의뢰/회송 환자 결과 조회</a></li>
            <li><a href="/referral/doctor.do">의료진 검색</a></li>
        </ul>
    </aside>

    <!-- ✅ 본문 콘텐츠 -->
    <div class="content">
        <div class="title">진료의뢰 안내</div>

        <!-- 상단 배너 -->
        <div class="banner">
            <span>진료를 의뢰해 주셔서 감사합니다.</span>
        </div>

        <!-- 안내 박스 + CTA -->
        <div class="info-box">
            <p>진료 및 검사를 위해 환자 의뢰가 필요하다고 판단되는 경우 MEDIPRIME 협진병원을 이용하시면 빠른 진료예약 및 접수가 가능합니다.</p>
            <p class="note">전자의뢰는 각 병원 홈페이지에서 신청 바랍니다.</p>

        </div>

        <!-- 의뢰 절차 -->
        <h3 class="section-title">진료의뢰 절차</h3>
        <div class="steps">
            <div class="step-card">
                <div class="step-head">
                    <div class="step-num">1</div>
                    <div class="step-title">의뢰서 준비</div>
                </div>
                <p class="step-desc">환자 기본정보, 임상소견, 검사·치료 이력, 의뢰 사유를 포함해 의뢰서를 작성합니다.</p>
            </div>
            <div class="step-card">
                <div class="step-head">
                    <div class="step-num">2</div>
                    <div class="step-title">의뢰 접수</div>
                </div>
                <p class="step-desc">협진센터로 팩스 또는 온라인으로 접수합니다. 접수 후 확인 연락을 드립니다.</p>
            </div>
            <div class="step-card">
                <div class="step-head">
                    <div class="step-num">3</div>
                    <div class="step-title">예약/안내</div>
                </div>
                <p class="step-desc">환자분께 예약 시간과 방문 절차를 안내하고 필요한 준비물을 안내합니다.</p>
            </div>
            <div class="step-card">
                <div class="step-head">
                    <div class="step-num">4</div>
                    <div class="step-title">진료 및 결과 회신</div>
                </div>
                <p class="step-desc">진료 후 결과를 의뢰기관에 신속히 회신하여 연속성 있는 치료가 가능하도록 지원합니다.</p>
            </div>
        </div>

        <!-- 2열 정보 카드 -->
        <h3 class="section-title">진료협력센터 문의</h3>
        <div class="info-grid">
            <div class="ibox">
                <h4 style="color:#0074d9;">운영시간</h4>
                <div><span class="label">평&nbsp;&nbsp;일</span>오전 9:00 ~ 오후 6:00</div>
                <div><span class="label">토요일</span>오전 9:00 ~ 오후 6:00</div>
            </div>
            <div class="ibox">
                <h4 style="color:#2e8b57;">의사 전용 진료의뢰</h4>
                <div><span class="label">전화</span>02-1234-5678</div>
                <div><span class="label">팩스</span>02-1234-5678</div>
                <div><span class="label">응급실</span>02-5678-5678</div>
            </div>
        </div>

        <!-- 필요서류 & 유의사항 -->
        <div class="info-grid" style="margin-top:18px;">
            <div class="doc-need">
                <h4 class="section-title" style="margin-top:0;">필요 서류</h4>
                <ul>
                    <li>진료의뢰서 (의사 소견 포함)</li>
                    <li>최근 검사결과 및 영상자료(필요 시 CD)</li>
                    <li>투약/치료 이력 요약</li>
                </ul>
            </div>
            <div class="caution">
                <h4 class="section-title" style="margin-top:0;">유의사항</h4>
                <ul>
                    <li>개인정보(주민번호 등) 노출 최소화 및 식별정보 정확성 확인</li>
                    <li>긴급 환자는 협진센터 및 응급실로 즉시 전화 문의</li>
                    <li>예약 시간 10분 전 도착 권장</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jsp/referral/referral_footer.jsp" %>
</body>
</html>
