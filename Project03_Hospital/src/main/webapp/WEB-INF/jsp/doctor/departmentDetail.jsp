<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
<html>
<head>
    <title>${dept.name} 상세정보</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/department_detail.css">

<script>
function showCategory(name) {
    ['전체', '내과', '외과', '기타'].forEach(function(c) {
        const box = document.getElementById(c);
        if (box) {
            box.style.display = (c === name) ? 'flex' : 'none';
        }
    });

    // 선택된 버튼 배경 스타일 변경 (선택적)
    document.querySelectorAll('.category-tab').forEach(btn => {
        btn.classList.remove('active-tab');
    });
    const btn = document.getElementById('btn-' + name);
    if (btn) btn.classList.add('active-tab');
}

window.onload = function () {
    const selected = '${category}' || '전체';
    showCategory(selected);
};
</script>




</head>
<body>
	<br>
	<br>

	<!-- 상단 버튼 -->
	<div class="top-menu">
		<a href="/departmentList.do" class="category-tab" id="btn-전체">전체</a>
		<button class="category-tab" onclick="showCategory('기타')" id="btn-기타">일반</button>
		<button class="category-tab" onclick="showCategory('내과')" id="btn-내과">내과</button>
		<button class="category-tab" onclick="showCategory('외과')" id="btn-외과">외과</button>
	</div>



	<!-- 전체 목록 -->
	<div class="category-box" id="전체">
		<a href="/departmentDetail.do?deptId=A01&category=내과">감염내과</a> <a
			href="/departmentDetail.do?deptId=A02&category=내과">내분비내과</a> <a
			href="/departmentDetail.do?deptId=A03&category=내과">소화기내과</a> <a
			href="/departmentDetail.do?deptId=A04&category=내과">신장내과</a> <a
			href="/departmentDetail.do?deptId=A05&category=내과">호흡기내과</a> <a
			href="/departmentDetail.do?deptId=B01&category=외과">대장항문외과</a> <a
			href="/departmentDetail.do?deptId=B02&category=외과">유방외과</a> <a
			href="/departmentDetail.do?deptId=B03&category=외과">일반외과</a> <a
			href="/departmentDetail.do?deptId=B04&category=외과">위장관외과</a> <a
			href="/departmentDetail.do?deptId=B05&category=외과">갑상선내분비외과</a> <a
			href="/departmentDetail.do?deptId=C01&category=기타">정형외과</a> <a
			href="/departmentDetail.do?deptId=C02&category=기타">산부인과</a> <a
			href="/departmentDetail.do?deptId=C03&category=기타">신경과</a> <a
			href="/departmentDetail.do?deptId=C04&category=기타">소아청소년과</a> <a
			href="/departmentDetail.do?deptId=C05&category=기타">이비인후과</a>
	</div>

	<!-- 내과 -->
	<div class="category-box" id="내과" style="display: none;">
		<a href="/departmentDetail.do?deptId=A01&category=내과">감염내과</a> <a
			href="/departmentDetail.do?deptId=A02&category=내과">내분비내과</a> <a
			href="/departmentDetail.do?deptId=A03&category=내과">소화기내과</a> <a
			href="/departmentDetail.do?deptId=A04&category=내과">신장내과</a> <a
			href="/departmentDetail.do?deptId=A05&category=내과">호흡기내과</a>
	</div>

	<!-- 외과 -->
	<div class="category-box" id="외과" style="display: none;">
		<a href="/departmentDetail.do?deptId=B01&category=외과">대장항문외과</a> <a
			href="/departmentDetail.do?deptId=B02&category=외과">유방외과</a> <a
			href="/departmentDetail.do?deptId=B03&category=외과">일반외과</a> <a
			href="/departmentDetail.do?deptId=B04&category=외과">위장관외과</a> <a
			href="/departmentDetail.do?deptId=B05&category=외과">갑상선내분비외과</a>
	</div>

	<!-- 기타 -->
	<div class="category-box" id="기타" style="display: none;">
		<a href="/departmentDetail.do?deptId=C01&category=기타">정형외과</a> <a
			href="/departmentDetail.do?deptId=C02&category=기타">산부인과</a> <a
			href="/departmentDetail.do?deptId=C03&category=기타">신경과</a> <a
			href="/departmentDetail.do?deptId=C04&category=기타">소아청소년과</a> <a
			href="/departmentDetail.do?deptId=C05&category=기타">이비인후과</a>
	</div>

	<!-- 상세 정보 -->
	<div class="detail-box">
		<h2>
			<c:out value="${dept.name}" />
		</h2>

		<div class="detail-info">
			<c:choose>
				<c:when test="${dept.name eq '감염내과'}">바이러스, 세균 등 감염성 질환을 전문적으로 진단하고 치료하는 내과입니다.</c:when>
				<c:when test="${dept.name eq '내분비내과'}">당뇨병, 갑상선, 부신 등 호르몬 관련 질환을 진료하는 내과입니다.</c:when>
				<c:when test="${dept.name eq '소화기내과'}">위, 장, 간, 췌장 등 소화기관 관련 질환을 진료하는 내과입니다.</c:when>
				<c:when test="${dept.name eq '신장내과'}">신장 질환 및 투석 치료를 전문으로 하는 내과입니다.</c:when>
				<c:when test="${dept.name eq '호흡기내과'}">폐, 기관지 등 호흡기계 질환을 진료하는 내과입니다.</c:when>

				<c:when test="${dept.name eq '대장항문외과'}">대장 및 항문 부위의 질환을 진단하고 치료하는 외과입니다.</c:when>
				<c:when test="${dept.name eq '유방외과'}">유방 질환의 진단, 치료 및 수술을 전문으로 하는 외과입니다.</c:when>
				<c:when test="${dept.name eq '일반외과'}">복부, 피부, 연부 조직 등 다양한 외과적 질환을 담당합니다.</c:when>
				<c:when test="${dept.name eq '위장관외과'}">위, 소장, 대장 등의 질환에 대한 외과적 치료를 담당합니다.</c:when>
				<c:when test="${dept.name eq '갑상선내분비외과'}">갑상선, 부갑상선 등의 내분비 기관에 대한 수술을 담당합니다.</c:when>

				<c:when test="${dept.name eq '정형외과'}">뼈, 관절, 근육 등의 근골격계 질환을 진단하고 수술합니다.</c:when>
				<c:when test="${dept.name eq '산부인과'}">여성 질환, 임신 및 출산, 생식 건강을 담당하는 진료과입니다.</c:when>
				<c:when test="${dept.name eq '신경과'}">뇌, 척수, 신경계 질환을 약물 등 비수술적으로 치료합니다.</c:when>
				<c:when test="${dept.name eq '소아청소년과'}">영유아부터 청소년까지 성장과 관련된 질환을 진료합니다.</c:when>
				<c:when test="${dept.name eq '이비인후과'}">귀, 코, 목 및 인접 부위의 질환을 진료하고 수술합니다.</c:when>
				<c:when test="${dept.name eq '응급의학과'}">응급상황에서 신속한 진단과 치료를 제공하는 과입니다.</c:when>
				<c:when test="${dept.name eq '피부과'}">피부, 손발톱, 모발 등의 질환을 진단하고 치료합니다.</c:when>
				<c:when test="${dept.name eq '흉부외과'}">심장, 폐, 식도 등 흉부 장기의 외과적 치료를 담당합니다.</c:when>

				<c:otherwise>해당 진료과의 설명은 준비 중입니다.</c:otherwise>
			</c:choose>
		</div>

		<div class="detail-info">
			<strong>진료과 번호:</strong>
			<c:out value="${dept.phone}" />
		</div>
	</div>

	<!-- 아래에 의사 목록 출력할 공간 -->
	<div class="doctor-list-box">
		<h3>의료진 소개</h3>

		<c:forEach var="doc" items="${doctorList}">
			<a href="/doctor/view.do?doctorId=${doc.doctorId}"
				style="text-decoration: none;">
				<div class="doctor-card">
					<div class="profile-img">
						<img src="${doc.profileImagePath}" alt="의사 사진"
							onerror="this.src='/resources/images/default-doctor.png'" />
					</div>
					<div class="doctor-info">
						<strong><c:out value="${doc.name}" /></strong><br> <span
							style="color: #555;">전문분야:</span>
						<c:out value="${doc.specialty}" />
					</div>
				</div>
			</a>
		</c:forEach>
	</div>







</body>
</html>
