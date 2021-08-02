<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<style>
table {
	width: 500px;
	table-layout: fixed;
}
</style>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="wrap">
		<!-- 상단 메뉴바 -->
		<!-- 섹션에 아이디가 있다면 -->
		<c:if test="${sessionScope.loginId ne null}">
			<jsp:include page="fixMenu/loginnav.jsp"></jsp:include>
		</c:if>
		<!-- 섹션에 아이디가 없다면 -->
		<c:if test="${sessionScope.loginId eq null}">
			<jsp:include page="fixMenu/navbar.jsp"></jsp:include>
		</c:if>
		<!-- 들어갈 내용 -->
		<section>
			<!-- 상단 슬라이드 배너 시작 -->
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
			<!-- 상단 슬라이드바 끝 -->

			<!-- 게시판 틀 시작 -->
			<div class="container mt-4">
				<!-- 검색창 -->
				<div class="row">
					<div class="d-flex">
						<p class="fw-bold mt-4 h1">통합 검색 시스템</p>
						<div class="col d-flex justify-content-end mt-4">
							<form class="d-inline-flex justify-content-end"
								style="height: 42px;" action="serachCafeName" method="post" id="sresult">

								<select name="searchtype"
									class="d-inline-flex justify-content-end me-2"
									style="height: 42px;">
									<option value="searchcafename" name="searchcafename">카페이름</option>
									<option value="searchcafeproduct" name="searchcafeproduct">카페상품</option>
								</select> <input class="form-control me-1" type="search" aria-label="Search"
								placeholder="검색어를 입력해주세요."	name="searchresult" id="searchresult">
								<button class="btn btn-outline-secondary" type="submit" id="sbtn">search</button>
							</form>
						</div>
					</div>
					<hr />
				</div>
				<!-- 검색창 끝 -->

				<table class="table table-hover">
					<thead>
						<p class="fw-bold mt-4 h3">카페검색</p>
						<tr>
							<th scope="col">이미지</th>
							<th scope="col">카페 이름</th>
							<th scope="col">지역구</th>
							<th scope="col">상세보기</th>
							<th scope="col">혼잡도</th>
						</tr>

					</thead>
					<tbody>
					
						<c:forEach items="${list}" var="bbs">
							<tr>
								<td>
								
							<c:forEach items="${nameimage }" var="bbs2">
										<img src="/photo/${bbs2.newFileName}" width="75px"	height="75px" />
							</c:forEach>
									
								</td>
								<td class="align-middle">${bbs.cafeName}</td>
								<td class="align-middle">${bbs.cafeLocation}</td>

								<td class="align-middle"><a href="cafeDetail?cafeKey=${bbs.cafeKey }">상세보기</a></td>

								<!-- 혼잡도 출력에 따른 색상처리 -->
								<c:if test="${bbs.confusion eq '혼잡' }">
									<td style="color: red; font-weight: bold" class="align-middle">${bbs.confusion}</td>
								</c:if>
								<c:if test="${bbs.confusion eq '보통' }">
									<td style="color: #ffcc00; font-weight: bold;" class="align-middle">${bbs.confusion}</td>
								</c:if>
								<c:if test="${bbs.confusion eq '여유' }">
									<td style="color: green; font-weight: bold" class="align-middle">${bbs.confusion}</td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>



				<table class="table table-hover " >

						<p class="fw-bold mt-4 h3">상품검색</p>
					<thead>
						<tr>
							<th scope="col">이미지</th>
							<th scope="col">상품 이름</th>
							<th scope="col">가격</th>
							<th scope="col">카페 이름</th>
							<th scope="col">카페 지역</th>
						</tr>

					</thead>
					<tbody>
						<c:forEach items="${list2}" var="bbs2">
							<tr>
								<td class="align-middle"></td>
								<td class="align-middle">${bbs2.productName}</td>
								<td class="align-middle">${bbs2.price}</td>

								<td class="align-middle"><a href="MainCafe/cafe.jsp">${bbs2.cafeName}</a></td>
								<td class="align-middle">${bbs2.cafeLocation}</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>



			</div>
			<script src="https://code.jquery.com/jquery-3.6.0.js"
				integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
				crossorigin="anonymous">
				
			</script>
			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
				integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
				crossorigin="anonymous">
				
			</script>
			<!-- 게시판 끝  -->


		</section>
	</div>
	<!-- 하단 고정 퀵메뉴 -->
	<c:if test="${sessionScope.loginId eq 'qkrgks456'}">
		<jsp:include page="fixMenu/quickMenu.html"></jsp:include>
	</c:if>
	<!-- 하단 정보 -->
	<jsp:include page="fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
<script>
$(document).ready(function() {
$("#sbtn").click(function(){
	if($("#searchresult").val().length==0){alert("검색어를 입력해 주세요."); $("#searchresult").focus(); return false;}
})
});
</script>

</html>