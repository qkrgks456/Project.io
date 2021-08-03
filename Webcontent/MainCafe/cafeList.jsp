<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<!-- 부트스트랩 메타태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<link href="/Project/assets/css/bootstrap.css?ver=15" rel="stylesheet">
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<link href="/Project/assets/css/main.css?ver=16" rel="stylesheet">
<title>카페</title>
</head>
<body>
	<div class="wrap">
		<!-- 상단 메뉴바 -->
		<!-- 섹션에 아이디가 있다면 -->
		<c:if test="${sessionScope.loginId ne null}">
			<jsp:include page="/fixMenu/loginnav.jsp"></jsp:include>
		</c:if>
		<!-- 섹션에 아이디가 없다면 -->
		<c:if test="${sessionScope.loginId eq null}">
			<jsp:include page="/fixMenu/navbar.jsp"></jsp:include>
		</c:if>
		<!-- 들어갈 내용 -->
		<div class="container">
			<!-- 검색창 -->
			<div class="row">
				<div class="d-flex">
					<p class="fw-bold mt-4 h1">카페정보</p>
					<div class="col d-flex justify-content-end mt-4">
						<form class="d-inline-flex justify-content-end"
							style="height: 42px;">
							<input class="form-control me-1" type="search"
								placeholder="카페명을 입력해주세요" aria-label="Search">
							<button class="btn btn-outline-secondary" type="submit">search</button>
						</form>
					</div>
				</div>
				<hr />
			</div>
			<div class="row row-cols-1 row-cols-md-4 g-4">
				<c:forEach items="${map.list}" var="map" varStatus="status">
					<div class="col">
						<div class="card showEvent" style="opacity:0;">
							<a href="/Project/cafeDetail?cafeKey=${map.cafeKey}"> <img
								src="/photo/${map.newFileName}" class="card-img-top" alt="...">
							</a>
							<div class="card-body">
								<h5 class="card-title fw-bold">${map.cafeName} (${map.cafeLocation})</h5>
								<p class="text-muted target lh-base">${map.cafeDetail}</p>

								<div class="text-center">
									<c:if test="${map.confusion eq '혼잡'}">
										<span data-bs-toggle="tooltip" data-bs-html="true"
											class="qwe fw-bold" id="confusiontooltip" style="cursor:default" 
											data-bs-template='<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner text-danger fw-bold"></div></div>'
											data-bs-placement="right" title="혼잡<c:if test="${map.cafeTotalTable-map.cafeCurrentTable ne 0}">(${map.cafeTotalTable}/${map.cafeCurrentTable}석)</c:if>"> <i
											class="bi bi-people-fill" style="font-size: 1.2rem;"></i> 혼잡도
										</span>
									</c:if>
									<c:if test="${map.confusion eq '보통'}">
										<span data-bs-toggle="tooltip" data-bs-html="true"
											class="qwe fw-bold" id="confusiontooltip" style="cursor:default" 
											data-bs-template='<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner text-dark fw-bold"></div></div>'
											data-bs-placement="right" title="보통<c:if test="${map.cafeTotalTable-map.cafeCurrentTable ne 0}">(${map.cafeTotalTable}/${map.cafeCurrentTable}석)</c:if>"> <i
											class="bi bi-people-fill" style="font-size: 1.2rem;"></i> 혼잡도
										</span>
									</c:if>
									<c:if test="${map.confusion eq '쾌적'}">
										<span data-bs-toggle="tooltip" data-bs-html="true"
											class="qwe fw-bold" id="confusiontooltip" style="cursor:default" 
											data-bs-template='<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner text-success fw-bold"></div></div>'
											data-bs-placement="right" title="쾌적<c:if test="${map.cafeTotalTable-map.cafeCurrentTable ne 0}">(${map.cafeTotalTable}/${map.cafeCurrentTable}석)</c:if>"> <i
											class="bi bi-people-fill" style="font-size: 1.2rem;"></i>혼잡도
										</span>
									</c:if>
								</div>
								<div class="text-center">
									<span class="fw-bold" style="cursor:default" > <i class="bi bi-sunglasses"
										style="font-size: 1.3rem;"></i> 조회수(${map.bHit})
									</span>
								</div>
								<hr/>
								<div class="text-center">
									<a href="/Project/cafeDetail?cafeKey=${map.cafeKey}"
										class="btn btn-outline-dark my-2">자세히 보기</a>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="mt-4">
				<hr />
				<!-- 페이지네이션 -->
				<ul class="pagination justify-content-center">
					<c:if test="${map.startPage ne 1}">
						<li class="page-item"><a class="page-link"
							href="/Project/cafeList?page=${map.startPage-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
						<c:if test="${i ne map.currPage}">
							<li class="page-item"><a class="page-link"
								href="/Project/cafeList?page=${i}">${i}</a></li>
						</c:if>
						<c:if test="${i eq map.currPage}">
							<li class="page-item active" style="cursor:default"><a class="page-link pageNum"
							 title="${i}">${i}</a></li>
						</c:if>
					</c:forEach>
					<c:if test="${map.totalPage ne map.endPage}">
						<li class="page-item"><a class="page-link"
							href="/Project/cafeList?page=${map.endPage+1}" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<!-- 하단 고정 퀵메뉴 -->
	<c:if test="${sessionScope.loginId eq 'qkrgks456'}">
		<jsp:include page="/fixMenu/quickMenu.html"></jsp:include>
	</c:if>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<script type="text/javascript">
	$('.showEvent').animate({opacity: "1"}, 500);
	
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
</html>