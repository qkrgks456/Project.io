<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<!-- 부트스트랩 메타태그111111111111111111111111111111111111111111111111111 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<link href="/Project/assets/css/bootstrap.css?ver=8" rel="stylesheet">
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<link href="/Project/assets/css/main.css?ver=95" rel="stylesheet">
<title>카페</title>
</head>
<body>
	<!-- 상단 메뉴바 -->
	<!-- 세션에 아이디가 있다면 -->
	<c:if test="${sessionScope.loginId ne null}">
		<jsp:include page="fixMenu/loginnav.jsp"></jsp:include>
	</c:if>
	<!-- 세션에 아이디가 없다면 -->
	<c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="fixMenu/navbar.jsp"></jsp:include>
	</c:if>

	<div class="wrap">
		<!-- 상단 슬라이드 배너 -->
		<div id="carouselExampleCaptions" class="carousel slide"
			data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="assets/img/cafe1.jpg" class="d-block w-100"
						style="height: 350px" alt="...">
				</div>
				<div class="carousel-item">
					<img src="assets/img/cafe2.jpg" class="d-block w-100"
						style="height: 350px" alt="...">
				</div>
				<div class="carousel-item">
					<img src="assets/img/cafe3.jpg" class="d-block w-100"
						style="height: 350px" alt="...">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
		<!-- 들어갈 내용 -->
		<div class="container px-3">
			<div class="container my-3">
				<div class="pt-4">
					<h2 class="fw-bold">About</h2>
					<hr />
				</div>
				<div class="row text-center">
					<div class="col-md-4">
						<span class="fa-stack fa-4x"> <i class="bi bi-check-lg"></i>
						</span>
						<h4 class="my-2 fw-bold">혼잡도를 확인하세요</h4>
						<p class="text-muted mt-2">우리는 당신이 원하는 카페에 도착하여 자리가 없어 시간을
							낭비하지않기를 바랍니다. 실시간혼잡도를 통하여 카페좌석을 확인하세요</p>
					</div>
					<div class="col-md-4">
						<span class="fa-stack fa-4x"> <i
							class="bi bi-chat-square-dots"></i>
						</span>
						<h4 class="my-2 fw-bold">의견을 공유하세요</h4>
						<p class="text-muted">카페와 관련된 내용을 소통하고 나누세요. 다양한 분위기의 카페에 대한
							여러 사람의 생각과 시각적 안목을 기를 수 있을것입니다.</p>
					</div>
					<div class="col-md-4">
						<span class="fa-stack fa-4x"> <i
							class="bi bi-emoji-heart-eyes"></i>
						</span>
						<h4 class="my-2 fw-bold">좋아하는 카페를 확인하세요</h4>
						<p class="text-muted">좋아하는 카페는 좋아요 기능을 통하여 혼잡도를 알림 받을 수 있습니다.
							자주 이용하는 카페는 더 편리하게 이용하세요.</p>
					</div>
				</div>
			</div>
			<!-- 첫번째 행 카페리스트 -->
			<div class="pt-4">
				<h2 class="fw-bold">이런 카페는 어떠세요?</h2>
				<hr />
			</div>
			<div class="row row-cols-1 row-cols-md-4 g-4">
				<c:forEach items="${map.bHitList}" var="bHitlists">
					<div class="col">
						<div class="card showEvent" style="opacity: 0;">
							<a href="/Project/cafeDetail?cafeKey=${bHitlists.cafeKey}&pageCheck=index"> <img
								src="/photo/${bHitlists.newFileName}" class="card-img-top" alt="...">
							</a>
							<div class="card-body">
								<h5 class="card-title fw-bold">${bHitlists.cafeName}
									(${bHitlists.cafeLocation})</h5>
								<p class="text-muted target lh-base">${bHitlists.cafeDetail}</p>

								<div class="text-center">
									<c:if test="${bHitlists.confusion eq '혼잡'}">
										<span data-bs-toggle="tooltip" data-bs-html="true"
											class="qwe fw-bold" id="confusiontooltip"
											style="cursor: default"
											data-bs-template='<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner text-danger fw-bold"></div></div>'
											data-bs-placement="right"
											title="혼잡">
											<i class="bi bi-people-fill" style="font-size: 1.2rem;"></i>
											혼잡도
										</span>
									</c:if>
									<c:if test="${bHitlists.confusion eq '보통'}">
										<span data-bs-toggle="tooltip" data-bs-html="true"
											class="qwe fw-bold" id="confusiontooltip"
											style="cursor: default"
											data-bs-template='<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner text-dark fw-bold"></div></div>'
											data-bs-placement="right"
											title="보통">
											<i class="bi bi-people-fill" style="font-size: 1.2rem;"></i>
											혼잡도
										</span>
									</c:if>
									<c:if test="${bHitlists.confusion eq '쾌적'}">
										<span data-bs-toggle="tooltip" data-bs-html="true"
											class="qwe fw-bold" id="confusiontooltip"
											style="cursor: default"
											data-bs-template='<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner text-success fw-bold"></div></div>'
											data-bs-placement="right"
											title="쾌적">
											<i class="bi bi-people-fill" style="font-size: 1.2rem;"></i>혼잡도
										</span>
									</c:if>
								</div>
								<div class="text-center">
									<span class="fw-bold" style="cursor: default"> <i
										class="bi bi-sunglasses mt-1" style="font-size: 1.3rem;"></i>
										조회수(${bHitlists.bHit})
									</span>
								</div>
								<hr />
								<div class="text-center">
									<a href="/Project/cafeDetail?cafeKey=${bHitlists.cafeKey}&pageCheck=index"
										class="btn btn-outline-dark my-2">자세히 보기</a>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- 두번째 행 카페리스트 -->
			<div class="pt-4">
				<h2 class="fw-bold">사람들이 좋아하는 카페 어떤가요?</h2>
				<hr />
			</div>
			<div class="row row-cols-1 row-cols-md-4 g-4">
				<c:forEach items="${map.goodList}" var="goodlists">
					<div class="col">
						<div class="card showEvent" style="opacity: 0;">
							<a href="/Project/cafeDetail?cafeKey=${goodlists.cafeKey}&pageCheck=index"> <img
								src="/photo/${goodlists.newFileName}" class="card-img-top" alt="...">
							</a>
							<div class="card-body">
								<h5 class="card-title fw-bold">${goodlists.cafeName}
									(${goodlists.cafeLocation})</h5>
								<p class="text-muted target lh-base">${goodlists.cafeDetail}</p>

								<div class="text-center">
									<c:if test="${goodlists.confusion eq '혼잡'}">
										<span data-bs-toggle="tooltip" data-bs-html="true"
											class="qwe fw-bold" id="confusiontooltip"
											style="cursor: default"
											data-bs-template='<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner text-danger fw-bold"></div></div>'
											data-bs-placement="right"
											title="혼잡">
											<i class="bi bi-people-fill" style="font-size: 1.2rem;"></i>
											혼잡도
										</span>
									</c:if>
									<c:if test="${goodlists.confusion eq '보통'}">
										<span data-bs-toggle="tooltip" data-bs-html="true"
											class="qwe fw-bold" id="confusiontooltip"
											style="cursor: default"
											data-bs-template='<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner text-dark fw-bold"></div></div>'
											data-bs-placement="right"
											title="보통">
											<i class="bi bi-people-fill" style="font-size: 1.2rem;"></i>
											혼잡도
										</span>
									</c:if>
									<c:if test="${goodlists.confusion eq '쾌적'}">
										<span data-bs-toggle="tooltip" data-bs-html="true"
											class="qwe fw-bold" id="confusiontooltip"
											style="cursor: default"
											data-bs-template='<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner text-success fw-bold"></div></div>'
											data-bs-placement="right"
											title="쾌적">
											<i class="bi bi-people-fill" style="font-size: 1.2rem;"></i>혼잡도
										</span>
									</c:if>
								</div>
								<div class="text-center">
									<span class="fw-bold" style="cursor: default"> <i
										class="bi bi-hand-thumbs-up-fill" style="font-size: 1.3rem;"></i>
										좋아요(${goodlists.goodCount})
									</span>
								</div>
								<hr />
								<div class="text-center">
									<a href="/Project/cafeDetail?cafeKey=${goodlists.cafeKey}&pageCheck=index"
										class="btn btn-outline-dark my-2">자세히 보기</a>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<!-- 하단 고정 퀵메뉴 -->
	<c:if test="${map.check eq true}">
		<jsp:include page="fixMenu/quickMenu.jsp"></jsp:include>
	</c:if>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 cdn -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<script type="text/javascript">
	$('.showEvent').animate({opacity: "1"}, 500);
	
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=11"></script>
</body>
</html>