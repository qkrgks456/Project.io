<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link href="/Project/assets/css/main.css?ver=10" rel="stylesheet">
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

		<div class="container px-4 my-4">
			<h2 class="fw-bold">원두 > 에티오피아 예가체프 G2</h2>
			<hr />
			<div class="card mb-3" style="max-width: 1250px;">
				<div class="row g-0">
					<div class="col-md-4">
						<img src="/Project/assets/img/p1.jpg"
							class="img-fluid rounded-start" alt="...">
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<br>
							<h3 class="bold">에티오피아 예가체프 G2</h3>
							<h3>${vo.productName}</h3>
							<br>
							<p class="text-muted mt-2">
								부드러우면서 짙은 꽃향기, 목넘김 이후에 남는 아련한 향, 부드러운 바디, 달콤한 신맛 등<br>
								예가체프를 최고의 커피라 부르는 이유는 많습니다</p>
							<p class="text-muted bold">(200g 기준 판매)</p>
							

							<!-- 수량선택 셀렉트바  -->
							<br>
							<h5 class="text-muted mt-2 fw-bold" style="text-align: left;">수량</h5>
							<form name="form1" method="post"
								action="/Project/myShopping/buy/cart.jsp">
								<input type="hidden" name="productId" value="${vo.productId}">
								<select name="quantity">
									<c:forEach begin="1" end="10" var="i">
										<option value="${i }">${i}</option>
									</c:forEach>
								</select>&nbsp;개 <br>

								<!-- 가격  -->
								<br>
								<h5 class="text-muted mt-2 fw-bold" style="text-align: left;">가격</h5>
								<h3>8,000원</h3>
								<h3>
									<fmt:formatNumber value="${vo.Price}" pattern="###,###" />
								</h3>


								<!-- 구매/장바구니 버튼 -->
								<br><br><br><br>
								
								<div class="d-grid gap-2 d-md-flex justify-content-md-end">
									<button type="submit"
										onclick="location.href='/Project/myShopping/buy/cart.jsp'"
										class="btn btn-success btn-lg " value="장바구니에 담기">장바구니</button>
							</form>
							</div>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button"
								onclick="location.href='/Project/MainProduct/productResult.jsp'"
								class="btn btn-secondary btn-lg" style="float: right;">구매하기</button>
						</div></div>
					</div>
					<!-- 좋아요 댓글 -->
					<div class="d-grid gap-1 d-md-block">
						<div id="good" class="d-inline-flex align-items-center">
							<i id="goodicon" class="bi bi-hand-thumbs-up-fill"
								style="font-size: 2.0rem;"></i>
							<p class="ms-2 mt-3 fw-bold">좋아요(10)</p>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<div id="commenticon" class="d-inline-flex align-items-center">
								<i id="commenticons" class="bi bi-chat-square-text-fill mt-1"
									style="font-size: 2.0rem;"></i>
								<p class="ms-2 mt-3 fw-bold">댓글(11)</p>
							</div>
						</div>
					</div>
				</div>

			</div>

			<!-- 상세 페이지 -->
			<hr />
			<br> <br> <img src="/Project/assets/img/p3.jpg" width="350"
				height="250"
				style="margin-left: auto; margin-right: auto; display: block;" />

			<p class="ms-1 mt-1 bold" style="text-align: center;">
				향 ●●●●○<br> 산도●●●●●<br> 단맛●●●○○<br> 쓴맛●●●○○<br>
				바디감●●●●○<br>
			</p>

			<br>
			<p class="text-muted mt-2" style="text-align: center">
				에티오피아 남부 시다모 현안의 예가체프 지역 고지대에서 재배하는 커피입니다.<br> 에티오피아 커피 중 가장
				세련된 커피라 평가받고있으며,<br> 예가체프의 향기는 제대로 맡아본 사람이 아니면 도저히 상상만으로 떠올릴 수
				없을 정도라고 합니다.<br> 향 때문에 유명해진 것이라고도 말할 수 있죠.<br> 부드러우면서 짙은
				꽃향기, 목넘김 이후에 남는 아련한 향, 부드러운 바디감, 달콤한 신맛 등 예가체프를 최고의 커피라 부르는 이유는
				많습니다.<br> <br> 일반적으로 과실의 상쾌한 신맛과 초콜릿의 달콤함,<br> 그리고
				와인에 비유되는 향미와 깊은 맛을 가졌습니다.<br> '카페 로스터리' 에서 최고의 예가체프를 즐겨 보세요<br>
			</p>
		</div>
	</div>

	<!-- 댓글(카페상세 댓글 복붙) -->
	<div class="container px-4 my-4">
		<h3 id="comments" class="fw-bold mt-3">댓글</h3>
		<hr />
		<div class="d-flex align-items-center">
			<div class="form-floating flex-grow-1 px-2">
				<textarea class="form-control" placeholder="Leave a comment here"
					id="floatingTextarea2" style="height: 100px"></textarea>
				<label for="floatingTextarea2">qkrgks456님, 이곳에 댓글을 작성하세요</label>
			</div>
			<a class="btn btn-secondary btn-sm">등록</a>
		</div>
		<div class="container px-5 py-4 my-4">
			<p class="fw-bold">qkrgks789</p>
			<p class="lh-sm">
				이쪽에 댓글 내용이 들어갈겁니다 <a class="float-end btn btn-secondary btn-sm"
					onclick="location.href='/Project/report/report.jsp'">신고</a> <a
					class="mx-2 float-end btn btn-secondary btn-sm">삭제</a> <a
					class="float-end btn btn-secondary btn-sm">수정</a>
			</p>
			<hr />
			<p class="fw-bold">qkrgks456</p>
			<p class="lh-sm">
				이쪽에 댓글 내용이 들어갈겁니다<a class="float-end btn btn-secondary btn-sm"
					onclick="location.href='/Project/report/report.jsp'">신고</a>
			</p>
			<hr />
			<p class="fw-bold">qkrgks123</p>
			<p class="lh-sm">
				이쪽에 댓글 내용이 들어갈겁니다<a class="float-end btn btn-secondary btn-sm"
					onclick="location.href='/Project/report/report.jsp'">신고</a>
			</p>
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
	<script src="/Project/assets/js/main.js?var=6">
		
	</script>
</body>
</html>