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
<link href="/Project/assets/css/bootstrap.css?ver=3" rel="stylesheet">
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<link href="/Project/assets/css/main.css?ver=25" rel="stylesheet">
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


		<!-- 원두 상품 코너 -->
		<div class="container">
			<br>
			<h1 class="fw-bold">원두</h1>
			<!-- 검색창 -->
			<nav class="navbar navbar-light ">
				<div class="container-fluid mb-3">
					<form
						class="d-flex position-absolute top-50 end-0 translate-middle-y">
						<input class="form-control me-1" type="search"
							placeholder="상품명을 입력해주세요" aria-label="Search">
						<button class="btn btn-outline-secondary" type="submit">search</button>
					</form>
				</div>
			</nav>
			<hr />

			<!-- 판매창 -->
			<div class="container mx-4 mt-5">
				<div class="row row-cols-1 row-cols-md-4 g-4">
					<div class="col">
						<div class="card h-100">
							<img src="assets/img/p1.jpg" class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="fw-bold">에티오피아 예가체프 G2</h5>
								<p class="target text-muted mt-2">꽃 향기 가득 화사한 산미와 부드러운 단맛의
									달콤함이 매력적인 에티오피아 100% 스페셜티 원두 입니다</p>
								<div class="d-grid gap-2 col-6 mx-auto">
									<button type="button" onclick="location.href='/Project/MainProduct/product.jsp'"
										class="btn btn-outline-secondary">자세히보기</button>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card h-100">
							<img src="assets/img/p5.jpg" class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="fw-bold">콜롬비아 수프리모</h5>
								<p class="text-muted mt-2">부드럽고 향이 풍부한, 아침을 깨우기에 적합한 원두로
									부드러운 맛으로 유명합니다</p>
								<div class="d-grid gap-2 col-6 mx-auto">
									<button type="button" onclick="location.href='item/item.jsp'"
										class="btn btn-outline-secondary">자세히보기</button>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card h-100">
							<img src="assets/img/p6.jpg" class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="fw-bold">케냐 AA</h5>
								<p class="text-muted mt-2">아프리카 고지대에서 생산된 원두로, 덜 익은 과일의 새콤한
									맛이 오래도록 여운으로 남는 매력이 있습니다.</p>
								<div class="d-grid gap-2 col-6 mx-auto">
									<button type="button" onclick="location.href='item/item.jsp'"
										class="btn btn-outline-secondary">자세히보기</button>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card h-100">
							<img src="assets/img/p7.jpg" class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="fw-bold">과테말라 안티구아</h5>
								<p class="text-muted mt-2">커피나무가 화산 폭발에서 나온 질소를 흡수하여 연기가 타는
									듯한 향을 가진 스모크 커피의 대명사입니다</p>
								<div class="d-grid gap-2 col-6 mx-auto">
									<button type="button" onclick="location.href='item/item.jsp'"
										class="btn btn-outline-secondary">자세히보기</button>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card h-100">
							<img src="assets/img/p8.jpg" class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="fw-bold">코스타리카 따라주</h5>
								<p class="text-muted mt-2">고산지대의 일교차가 큰 지대에서 자란 원두로 훌륭한 바디감과
									톡 쏘는듯한 산미와 깔끔한 뒷맛이 특징인 원두입니다</p>
								<div class="d-grid gap-2 col-6 mx-auto">
									<button type="button" onclick="location.href='item/item.jsp'"
										class="btn btn-outline-secondary">자세히보기</button>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card h-100">
							<img src="assets/img/p9.jpg" class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="fw-bold">인도네시아 만델링</h5>
								<p class="text-muted mt-2">초콜릿 맛과 고소하고 달콤한 향이 나며, 묵직하고 강렬한
									바디를 가지며 풍부한 향이 납니다</p>
								<div class="d-grid gap-2 col-6 mx-auto">
									<button type="button" onclick="location.href='item/item.jsp'"
										class="btn btn-outline-secondary">자세히보기</button>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card h-100">
							<img src="assets/img/p10.jpg" class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="fw-bold">에티오피아 시다모 G2</h5>
								<p class="text-muted mt-2">와인 같은 농밀한 산미와 향이 인상적이다. 풍부한 과일의
									묵직한 향과 산미를 맛볼 수도 있습니다</p>
								<div class="d-grid gap-2 col-6 mx-auto">
									<button type="button" onclick="location.href='item/item.jsp'"
										class="btn btn-outline-secondary">자세히보기</button>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card h-100">
							<img src="assets/img/p11.jpg" class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="fw-bold">브라질 버본 산토스 No.2</h5>
								<p class="text-muted mt-2">향이 뛰어나고 단맛과 신맛, 쓴맛이 골고루 조화를 이루며
									식었을 때 신맛이 더욱 강해지는 원두입니다</p>
								<div class="d-grid gap-2 col-6 mx-auto">
									<button type="button" onclick="location.href='item/item.jsp'"
										class="btn btn-outline-secondary">자세히보기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	

	<!-- MD 상품 코너 -->
	<div class="container">

		<h1 class="fw-bold">MD</h1>
		<hr />
		<div class="container mx-4 mt-5">
			<div class="row row-cols-1 row-cols-md-4 g-4">
				<div class="col">
					<div class="card h-100">
						<img src="assets/img/m0.jpg" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="fw-bold">빈티지 머그</h5>
							<p class="text-muted mt-2">기본의 우아한 멋이 있는 심플한 라인입니다. 빈티지한 색감에서
								고급스러움이 묻어나오는 딥한 컬러의 머그잔입니다</p>
							<div class="d-grid gap-2 col-6 mx-auto">
								<button type="button" class="btn btn-outline-secondary">자세히보기</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-100">
						<img src="assets/img/m1.jpg" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="fw-bold">써머 유리컵</h5>
							<p class="text-muted mt-2">여름에 빠질 수 없는 투명한 기본 유리컵입니다. 시원한 에이드
								한잔을 담아 기분전환 해보세요</p>
							<div class="d-grid gap-2 col-6 mx-auto">
								<button type="button" class="btn btn-outline-secondary">자세히보기</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-100">
						<img src="assets/img/m2.jpg" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="fw-bold">에스프레소잔</h5>
							<p class="text-muted mt-2">60ml정도의 크기로 기본적인 에스프레소를 여유있게 즐기실 수
								있는 디자인입니다.</p>
							<div class="d-grid gap-2 col-6 mx-auto">
								<button type="button" class="btn btn-outline-secondary">자세히보기</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-100">
						<img src="assets/img/m3.jpg" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="fw-bold">머그&소서 세트</h5>
							<p class="text-muted mt-2">빗방울에서 영감을 받은 머그와 소서 세트입니다. 빵과 커피와
								함께 즐겨보세요.</p>
							<div class="d-grid gap-2 col-6 mx-auto">
								<button type="button" class="btn btn-outline-secondary">자세히보기</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-100">
						<img src="assets/img/m4.jpg" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="fw-bold">텀블러</h5>
							<p class="text-muted mt-2">스테인리스 스틸 텀블러입니다. 보온/보냉 효과가 우수한 이중벽
								구조 슬라이드형 제품입니다</p>
							<div class="d-grid gap-2 col-6 mx-auto">
								<button type="button" class="btn btn-outline-secondary">자세히보기</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-100">
						<img src="assets/img/m5.jpg" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="fw-bold">커트러리 세트</h5>
							<p class="text-muted mt-2">매일 홈카페를 즐길수 있는 브런치 커트러리 세트입니다.
								집에서도 카페를 즐겨보세요</p>
							<div class="d-grid gap-2 col-6 mx-auto">
								<button type="button" class="btn btn-outline-secondary">자세히보기</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-100">
						<img src="assets/img/m6.jpg" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="fw-bold">시럽 세트</h5>
							<p class="text-muted mt-2">집에서도 카페를 즐기세요! 다양하게 즐길 수 있는 시럽을 종합
								선물세트로 판매합니다</p>
							<div class="d-grid gap-2 col-6 mx-auto">
								<button type="button" class="btn btn-outline-secondary">자세히보기</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-100">
						<img src="assets/img/m7.jpg" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="fw-bold">써머 주스잔</h5>
							<p class="text-muted mt-2">더블월 구조의 글라스입니다. 찬음료전용잔으로, 깔끔하고 시원한
								분위기를 연출하는 상품입니다.</p>
							<div class="d-grid gap-2 col-6 mx-auto">
								<button type="button" class="btn btn-outline-secondary">자세히보기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
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
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
</html>