<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/jsp/header.jsp" />
<style>
.result-list {
	display: flex;
	flex-direction: column;
	gap: 15px;
	margin-top: 20px;
}

.result-item {
	padding: 15px 20px;
	border: 1px solid #e1e1e1;
	border-radius: 8px;
	background: #fdfdfd;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
	transition: transform 0.2s ease;
}

.result-item:hover {
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.result-title {
	font-size: 16px;
	color: #000;
	text-decoration: none;
}

.result-title:hover {
	text-decoration: underline;
}

.page-label {
	font-size: 13px;
	color: #666;
	margin-bottom: 6px;
}

.result-snippet {
	font-size: 13px;
	color: #888;
	margin-top: 6px;
}

.category-title {
	margin-top: 30px;
	margin-bottom: 10px;
	font-size: 17px;
	font-weight: bold;
	color: #222;
	border-bottom: 2px solid #ddd;
	padding-bottom: 5px;
}
</style>

<h2>"${keyword}" 검색 결과</h2>

<c:choose>
	<c:when test="${empty groupedResults}">
		<p>검색 결과가 없습니다.</p>

		<!-- 🔥 인기 키워드 추천 -->
		<div class="result-list">
			<div class="category-title">많이 검색하는 키워드</div>

			<div class="result-item">
				<a class="result-title"
					href="${pageContext.request.contextPath}/02_directions.do">오시는
					길</a>
				<div class="result-snippet">병원 위치 및 교통편을 안내합니다.</div>
			</div>

			<div class="result-item">
				<a class="result-title"
					href="${pageContext.request.contextPath}/03_notice.do">공지사항</a>
				<div class="result-snippet">병원 공지 및 최신 소식을 확인하세요.</div>
			</div>

			<div class="result-item">
				<a class="result-title"
					href="${pageContext.request.contextPath}/03_healthinfo.do">건강
					정보</a>
				<div class="result-snippet">생활 속 건강 지식을 제공합니다.</div>
			</div>
		</div>
	</c:when>


	<c:otherwise>
		<div class="result-list">
			<c:forEach var="entry" items="${groupedResults}">
				<div class="category-title">${entry.key}</div>
				<c:forEach var="item" items="${entry.value}">
					<div class="result-item">
						<a class="result-title" href="${item.url}">${item.title}</a>
						
						<c:if test="${item.category ne '언론' and item.category ne '공지' and item.category ne '소식' and item.category ne '채용' and item.category ne '병원 소식'}">

							<div class="result-snippet">
								<c:out value="${item.summary}" escapeXml="true" />
							</div>
						</c:if>
					</div>
				</c:forEach>
			</c:forEach>





		</div>
	</c:otherwise>
</c:choose>
