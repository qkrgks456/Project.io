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
<link href="/Project/assets/css/main.css?ver=3" rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
<link rel="stylesheet" href="./10-11.css" />
<script type="text/javascript" src="./10-11.js"></script>
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
		<div class="d-flex" style="height: auto; min-height: 100vh;">
			<jsp:include page="../myShoppingsideBar.jsp"></jsp:include>
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">장바구니</h2>
				</div>
				<div class="container">
					<table class="table table-hover mt-2">
						<thead class="table-light">
						
						
							<tr>
								<th scope="col"><input id="allCheck" type="checkbox"
									class="form-check-input" " /></th>
								<th scope="col">이미지</th>
								<th scope="col">상품명</th>
								<th scope="col">수량</th>
								<th scope="col">가격</th>
								<th class="text-center" scope="col">상세보기</th>
								<div class scope="col"></div>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${cartlist}" var="cartlists">
								<tr class>
									<td class="text_ct align-middle"><input ﻿ name="RowCheck"
										class="productDel form-check-input" type="checkbox"
										value="${cartlists.productId}" /></td>
									</th>
									<td><img src="/photo/${cartlists.newFileName}"
										class="img-thumbnail"
										style="width: 80px; height: 80px; object-fit: cover;" /></td>
									<td class="align-middle">${cartlists.productName}</td>
									<td class="align-middle">
										<div class='d-flex'>
											<div class="qu me-2">1</div>
											<i id="up" class="up bi bi-arrow-up-square-fill"
												style="font-size: 1.2rem;"> </i><i id="down"
												class="down bi bi-arrow-down-square"
												style="font-size: 1.2rem;"></i>
										</div>
									</td>
									<td class="price align-middle">${cartlists.price}</td>
									<td>
										<div class="d-grid gap-2 col-6 mx-auto mt-4">
											<a href="/Project/productdetail?productId=${cartlists.productId}" class="btn btn-secondary btn-sm">상세보기</a>
										</div>
									</td>
									<td class="visually-hidden sumPrice align-middle">${cartlists.price}</td>
								</tr>
							</c:forEach>

						</tbody>
						<tfoot>
							<tr>
								<th>주문</th>
								<th id='sumAmount'>수량 : 3</th>
								<th id='sumSumPrice'>총합계 : 65000</th>

								<th colspan="3"></th>
							</tr>
						</tfoot>
					</table>
					<input type="hidden" class="form-control" id="blackpruductId"
						name="blackproductId" value="">
					<div class="d-grid gap-2 d-md-flex justify-content-md-end">
						<button button id="blackaddsubmit" class="btn btn-dark"
							type="button">선택상품 삭제</button>
						<button type="button"
							onclick="location.href='/Project/cartBuy"
							class="btn btn-dark btn-sm" style="float: right;">선택상품
							주문하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<script type="text/javascript">
		/* 페이지 시작시 총 수량  */
		var sum = 0;
		$('.qu').each(function(i, item) {
			sum += Number($(this).text());
		})
		$('#sumAmount').empty();
		$('#sumAmount').append('수량 : ' + sum + '개');
		/* 페이지 시작시 총 가격  */
		var sumPrice = 0;
		$('.price').each(function(i, item) {
			sumPrice += Number($(this).text());
		})
		$('#sumSumPrice').empty();
		$('#sumSumPrice').append('총 가격 : ' + sumPrice.toLocaleString() + '원');

		/* 수량증가  */
		var sumSum = 0;

		$('.up').click(
				function() {
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
					$('#sumAmount').append('수량 : ' + sum + '개');
					$(this).parents('td').nextAll('.sumPrice').empty();
					$(this).parents('td').nextAll('.sumPrice').append(sumSum);
					$('.sumPrice').each(function(i, item) {
						sumPrice += Number($(this).text());
						console.log(sumPrice);
					})
					$('#sumSumPrice').empty();
					$('#sumSumPrice').append(
							'총 가격 : ' + sumPrice.toLocaleString() + '원');
				})

		/* 수량 감소 */
		$('.down').click(
				function() {
					var sumPrice = 0;
					var qu = Number($(this).prevAll('.qu').text());
					if (qu > 1) {
						qu = qu - 1;
						$(this).prevAll('.qu').empty();
						$(this).prevAll('.qu').append(qu);
						var sumSum = 0;
						sumSum = qu
								* Number($(this).parents('td').next().text());
						console.log(sumSum);
						var sum = 0;
						$('.qu').each(function(i, item) {
							sum += Number($(this).text());
						})
						$('#sumAmount').empty();
						$('#sumAmount').append('수량 : ' + sum + '개');
						$(this).parents('td').nextAll('.sumPrice').empty();
						$(this).parents('td').nextAll('.sumPrice').append(
								sumSum);
						$('.sumPrice').each(function(i, item) {
							sumPrice += Number($(this).text());
							console.log(sumPrice);
						})
						$('#sumSumPrice').empty();
						$('#sumSumPrice').append(
								'총 가격 : ' + sumPrice.toLocaleString() + '원');
					}
				})

		//삭제

		var delproductId = [];
		$('#blackaddsubmit')
				.click(
						function() {
							$('input[name="RowCheck"]:checked').each(
									function() {
										delproductId.push($(this).val());
									})
							$
									.ajax({
										type : "POST",//방식
										url : "/Project/productListDel",//주소
										data : {
											delproductId : delproductId,
										},
										dataType : 'JSON',
										success : function(data) { //성공시
											console.log(data);
											content = "";
											$
													.each(
															data.myProductList,
															function(i, item) {
																content += '<tr>'
																content += '<td class="text_ct align-middle"><input ﻿ name="RowCheck" class="productDel form-check-input"'
							content +=			' type="checkbox" value="'+item.productId+'" /></td>'
																content += '</th>'
																content += '<td class="align-middle">'
																		+ item.productName
																		+ '</td>'
																content += '<td class="align-middle">'
																		+ item.newFileName
																		+ '</td>'
																content += '<td class="align-middle">'
																		+ item.productId
																		+ '</td>'
																content += '<td class="align-middle">'
																		+ item.price
																		+ '</td>'
																content += '<td class="align-middle">'
																		+ item.productQuantity
																		+ '</td>'
																content += '<td>'
																content += '<div class="d-grid gap-2 col-6 mx-auto mt-1">'
																content += '<a class="btn btn-secondary btn-sm" type="button" href="/Project/productdetail?productId='
																		+ item.productId
																		+ '"'
																content += '>상세보기</a>'
																content += '</div>'
																content += '</td>'
																content += '</tr>'
															})
											$('tbody').empty();
											$('tbody').append(content);
										},
										error : function(e) { //실패시
											console.log(e);
										}

									})

						})
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=5"></script>
</body>
</html>