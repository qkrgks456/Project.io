<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<!-- 부트스트랩 메타태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<link href="/Project/assets/css/bootstrap.css?ver=3" rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
<link rel="stylesheet" href="./10-11.css" />
<script type="text/javascript" src="./10-11.js"></script>
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<link href="/Project/assets/css/main.css?ver=3" rel="stylesheet">
<title>카페</title>
</head>
<body>
	<div class="wrap p-0 m-0">
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
		<!-- 들어갈 내용 -->
		<div class="d-flex" style="height: auto; min-height: 100vh;">
			<jsp:include page="../myShoppingsideBar.jsp"></jsp:include>
			<!-- 내용시작 -->
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">구매내역</h2>
				</div>
				<div class="container">
					<table class="table table-hover mt-2">
						<thead class="table-light">
							<tr>
								<th scope="col">#</th>
								<th scope="col">이미지</th>
								<th scope="col">상품명</th>
								<th scope="col">수량</th>
								<th scope="col">가격</th>
								<th class="text-center" scope="col">상세보기</th>
							</tr>
						</thead>
						<tbody>
							<tr class="">
								<th class="align-middle" scope="row">1</th>
								<td><img src="/Project/assets/img/p3.jpg"
									class="img-thumbnail"
									style="width: 80px; height: 80px; object-fit: cover;" /></td>
								<td class="align-middle">콜롬비아 수프리모</td>
								<td class="align-middle"><div class="qu">3</div></td>
								<td class="price align-middle">24000</td>
						
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm">상세보기</a> <a
											class="btn btn-secondary btn-sm"
											onclick="location.href='/Project/myShopping/sell/productList/productDelResult.jsp'">삭제하기</a>
									</div>
								</td>
							</tr>
							<tr class="">
								<th class="align-middle" scope="row">2</th>
								<td><img src="/Project/assets/img/p11.jpg"
									class="img-thumbnail"
									style="width: 80px; height: 80px; object-fit: cover;" /></td>
								<td class="align-middle">브라질 버본 산토스 No.2</td>
								<td class="align-middle"><div class="qu"> 2</div></td>
								<td class="price align-middle">19000</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm">상세보기</a> <a
											class="btn btn-secondary btn-sm"
											onclick="location.href='/Project/myShopping/sell/productList/productDelResult.jsp'">삭제하기</a>
									</div>
								</td>
							</tr>






						</tbody>
						<tfoot>
							<tr>
								<th>합계</th>
								<th id = 'sumAmount'>수량 : 3</th>
								<th id='sumSumPrice'>가격 : 65000</th>
								<th colspan="3"></th>
							</tr>
						</tfoot>
					</table>
					
				</div>
			</div>
		</div>
	</div>


	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<script type="text/javascript">
	/* 페이지 시작시 총 수량  */
	var sum = 0;
	$('.qu').each(function(i, item) {
		sum += Number($(this).text());
	})
	$('#sumAmount').empty();
	$('#sumAmount').append('수량 : ' + sum+'개');
	/* 페이지 시작시 총 가격  */
	var sumPrice = 0;
	$('.price').each(function(i, item) {
		sumPrice += Number($(this).text());
	})
	$('#sumSumPrice').empty();
	$('#sumSumPrice').append('총 가격 : ' +sumPrice.toLocaleString()+'원');
	/* 수량증가  */
	var sumSum = 0;
	
	$('.up').click(function() {
		var sumPrice = 0;
		var qu = Number($(this).prev('.qu').text());
		qu = qu + 1;
		$(this).prev('.qu').empty();
		$(this).prev('.qu').append(qu);
		var sumSum = 0;
		sumSum = qu * Number($(this).parents('td').next().text());		
		var sum = 0;
		$('.qu').each(function(i, item) {
			sum += Number($(this).text());
		})
		$('#sumAmount').empty();
		$('#sumAmount').append('수량 : ' + sum+'개');
		$(this).parents('td').nextAll('.sumPrice').empty();
		$(this).parents('td').nextAll('.sumPrice').append(sumSum);
		$('.sumPrice').each(function(i, item) {		
			sumPrice += Number($(this).text());
			console.log(sumPrice);			
		})
		$('#sumSumPrice').empty();
		$('#sumSumPrice').append('총 가격 : ' +sumPrice.toLocaleString()+'원');
	})
	
	/* 수량 감소 */
	$('.down').click(function() {
		var sumPrice = 0;
		var qu = Number($(this).prevAll('.qu').text());
		if (qu > 1) {
			qu = qu - 1;
			$(this).prevAll('.qu').empty();
			$(this).prevAll('.qu').append(qu);
			var sumSum = 0;
			sumSum = qu * Number($(this).parents('td').next().text());
			console.log(sumSum);
			var sum = 0;
			$('.qu').each(function(i, item) {
				sum += Number($(this).text());
			})
			$('#sumAmount').empty();
			$('#sumAmount').append('수량 : ' + sum+'개');
			$(this).parents('td').nextAll('.sumPrice').empty();
			$(this).parents('td').nextAll('.sumPrice').append(sumSum);
			$('.sumPrice').each(function(i, item) {		
				sumPrice += Number($(this).text());
				console.log(sumPrice);			
			})
			$('#sumSumPrice').empty();
			$('#sumSumPrice').append('총 가격 : ' +sumPrice.toLocaleString()+'원');
		}
	})
	$('#delProductBtn').click(function(){
		var delCheckArr = [];
		$('input[name="delCheck"]:checked').each(function(){
			delCheckArr.push($(this).val());
		})
		console.log(delCheckArr);
		
	})
	
	
	
	
	
	</script>
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=2"></script>
</body>
</html>