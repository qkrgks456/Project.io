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
<link href="/Project/assets/css/main.css?ver=8" rel="stylesheet">
<title>카페</title>
</head>
<style>
* {
	box-sizing: border-box;
}

.slider {
	width: 200px;
	border-radius: 10px;
	overflow: hidden;
}

.slides {
	display: flex;
	overflow-x: auto;
	/* overflow: hidden; */
	scroll-snap-type: x mandatory;
	scroll-behavior: smooth;
	-webkit-overflow-scrolling: touch;
}

.slides::-webkit-scrollbar {
	width: 10px;
	height: 10px;
}

.slides::-webkit-scrollbar-thumb {
	background: #343a40;
	border-radius: 10px;
}

.slides::-webkit-scrollbar-track {
	background: transparent;
}

.slides>div {
	scroll-snap-align: start;
	flex-shrink: 0;
	width: 200px;
	height: 200px;
	margin-right: 50px;
	border-radius: 10px;
	overflow: hidden;
	background: #eee;
	transform-origin: center center;
	transform: scale(1);
	transition: transform 0.5s;
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 100px;
}

.author-info {
	background: rgba(0, 0, 0, 0.75);
	color: white;
	padding: 0.75rem;
	position: absolute;
	bottom: 0;
	left: 0;
	width: 100%;
	margin: 0;
}

.author-info a {
	color: white;
}

.slider>img {
	object-fit: cover;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

.slider>a {
	display: inline-flex;
	width: 1.5rem;
	height: 1.5rem;
	background: #eee;
	text-decoration: none;
	align-items: center;
	justify-content: center;
	border-radius: 50%;
	margin: 0 0 0.5rem 0;
	position: relative;
}

.slider>a:active {
	top: 1px;
}

.slider>a:focus {
	background: #000;
}
</style>
<body>
	<div class="wrap">
		<!-- 상단 메뉴바 -->
		<c:set var="loginId">${sessionScope.loginId}</c:set>
		<!-- 섹션에 아이디가 있다면 -->
		<c:if test="${loginId!=''}">
			<jsp:include page="/fixMenu/loginnav.jsp"></jsp:include>
		</c:if>
		<!-- 섹션에 아이디가 없다면 -->
		<c:if test="${loginId==''}">
			<jsp:include page="/fixMenu/navbar.jsp"></jsp:include>
		</c:if>
		<!-- 들어갈 내용 -->
		<div class="container px-5 mt-5 my-2">
			<h1 class="fw-bold" id="cafename">껠끄쇼즈</h1>
			<hr />
			<div class="container px-5 mt-3">
				<div class="row">
					<div class="col-md-6">
						<img src="/Project/assets/img/12.jpg"
							class="rounded img-fluid float-end"
							style="width: 450px; height: 435px; object-fit: cover;"
							id="mainimg" />
					</div>
					<div class="col-md-6">
						<div class="row row-col-3 d-float">
							<div class="col-4 p-1" style="width: 150px; height: 145px">
								<img src="/Project/assets/img/12.jpg"
									class="visually-hidden rounded imgs h-100 w-100"
									style="object-fit: cover;" />
							</div>
							<div class="col-4 p-1" style="width: 150px; height: 145px">
								<img src="/Project/assets/img/a2.jpg"
									class="visually-hidden rounded imgs h-100 w-100"
									style="object-fit: cover;" />
							</div>
							<div class="col-4 p-1" style="width: 150px; height: 145px">
								<img src="/Project/assets/img/a3.jpg"
									class="visually-hidden rounded imgs h-100 w-100"
									style="object-fit: cover;" />
							</div>
							<div class="col-4 p-1" style="width: 150px; height: 145px">
								<img src="/Project/assets/img/a4.jpg"
									class="visually-hidden rounded imgs h-100 w-100"
									style="object-fit: cover;" />
							</div>
							<div class="col-4 p-1" style="width: 150px; height: 145px">
								<img src="/Project/assets/img/a5.jpg"
									class="visually-hidden rounded imgs h-100 w-100"
									style="object-fit: cover;" />
							</div>
							<div class="col-4 p-1" style="width: 150px; height: 145px">
								<img src="/Project/assets/img/a6.jpg"
									class="visually-hidden rounded imgs h-100 w-100"
									style="object-fit: cover;" />
							</div>
							<div class="col-4 p-1" style="width: 150px; height: 145px">
								<img src="/Project/assets/img/a7.jpg"
									class="visually-hidden rounded imgs h-100 w-100"
									style="object-fit: cover;" />
							</div>
							<div class="col-4 p-1" style="width: 150px; height: 145px">
								<img src="/Project/assets/img/a8.jpg"
									class="visually-hidden rounded imgs h-100 w-100"
									style="object-fit: cover;" />
							</div>
							<div class="col-4 p-1" style="width: 150px; height: 145px">
								<img src="/Project/assets/img/a9.jpg"
									class="visually-hidden rounded imgs h-100 w-100"
									style="object-fit: cover;" />
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--카페 상세정보 테이블-->
			<div class="container px-5 mt-4">
				<h3 class="fw-bold">정보</h3>
				<hr />
				<div class="container px-5 mt-4">
					<div class="row">
						<div class="col-md-2">
							<div id="good" class="d-inline-flex align-items-center">
								<i id="goodicon" class="bi bi-hand-thumbs-up-fill"
									style="font-size: 2.0rem;"></i>
								<p class="ms-2 mt-3 fw-bold">좋아요(1)</p>
							</div>
						</div>
						<div class="col-md-2">
							<div id="commenticon" class="d-inline-flex align-items-center">
								<i id="commenticons" class="bi bi-chat-square-text-fill mt-1"
									style="font-size: 2.0rem;"></i>
								<p class="ms-2 mt-3 fw-bold">댓글(1)</p>
							</div>
						</div>
						<div class="col-md-2 p-0">
							<div id="commenticon" class="d-inline-flex align-items-center">
								<i id="commenticons" class="bi bi-sunglasses mt-1"
									style="font-size: 2.2rem;"></i>
								<p class="ms-2 mt-3 fw-bold">조회수(1)</p>
							</div>
						</div>
						<div class="col-md-2">
							<div id="commenticon" class="d-inline-flex align-items-center"
								data-bs-toggle="tooltip" data-bs-html="true"
								data-bs-placement="right" title="쾌적">
								<i id="commenticons" class="bi bi-people-fill mt-1"
									style="font-size: 2.0rem;"></i>
								<p class="ms-2 mt-3 fw-bold">혼잡도</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-7 my-2">
							<table class="table table-borderless my-2">
								<tbody>
									<tr class="row">
										<th class="col-sm-3">카페설명</th>
										<td class="col"><p>텍스트 기준은 4줄로 더 늘어나게 되면 (...)으로 표시되게
												됩니다 이런 효과주는게 간지가 나잖아요 그래서 만약에 더 쓰게 되면 ...으로 표시되고 남은내용은
												자세히보기에서 상세히 볼 수 있습니다!</p></td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">주소</th>
										<td class="col"><p id="add">서울특별시 강남구 도곡로70길 5</p></td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">영업시간</th>
										<td class="col">12:30 - 19:30</td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">연락처</th>
										<td class="col">02-123-1234</td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">주차</th>
										<td class="col">불가</td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">단체석</th>
										<td class="col">유</td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">루프탑</th>
										<td class="col">무</td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">유아동반</th>
										<td class="col">가능</td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">반려동물동반</th>
										<td class="col">불가</td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">웹사이트</th>
										<td class="col"><a
											href="http://www.instagram.com/quelquechose_seoul/"
											class="under_line" target="_blank" style="color: brown;">
												카페 홈페이지로 이동</a></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="col-sm-5 my-2 pt-3">
							<!-- 지도 -->
							<div id="map" class="border shadow"
								style="width: 100%; height: 350px;"></div>
						</div>
					</div>
				</div>
				<h3 class="fw-bold">메뉴</h3>
				<hr />
				<!-- 이미지 슬라이드 -->
				<div class="container px-5 mt-4">
					<div class="slider">
						<div class="slides">
							<div id="slide-1">
								<img class="w-100 h-100" src="/Project/assets/img/macaron.jpg"
									alt="macaron" style="object-fit: cover;">
							</div>
							<div id="slide-2">
								<img class="w-100 h-100" src="/Project/assets/img/macaron2.jpg"
									alt="macaron" style="object-fit: cover;">
							</div>
							<div id="slide-3">
								<img class="w-100 h-100" src="/Project/assets/img/tart.jpg"
									alt="tart" style="object-fit: cover;">
							</div>
						</div>
					</div>
				</div>
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
						이쪽에 댓글 내용이 들어갈겁니다
						<a class="float-end btn btn-secondary btn-sm">신고</a>
						<a class="mx-2 float-end btn btn-secondary btn-sm">삭제</a>
						<a class="float-end btn btn-secondary btn-sm">수정</a>
					</p>
					<hr />
					<p class="fw-bold">qkrgks456</p>
					<p class="lh-sm">
						이쪽에 댓글 내용이 들어갈겁니다<a class="float-end btn btn-secondary btn-sm">신고</a>
					</p>
					<hr />
					<p class="fw-bold">qkrgks123</p>
					<p class="lh-sm">
						이쪽에 댓글 내용이 들어갈겁니다<a class="float-end btn btn-secondary btn-sm">신고</a>
					</p>
					<hr />
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
	<script src="/Project/assets/js/main.js?var=156"></script>
	<!-- 카카오맵 api 추가 -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=96f67dd6c088728e30743d7db32a6789&libraries=services"></script>
	<script src="/Project/assets/js/map.js?var=6"></script>
</body>
</html>