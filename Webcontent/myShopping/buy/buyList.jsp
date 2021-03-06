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
				<hr />
				<div class="container">
					<c:if test="${purchaseList[0] ne null}">
						<table class="table table-hover mt-2">
							<thead class="table-light">
								<tr>
									<th scope="col"><input id="allCheck" type="checkbox"
										class="form-check-input" /></th>
									<th scope="col">이미지</th>
									<th scope="col">상품명</th>
									<th scope="col">수량</th>
									<th scope="col">가격</th>
									<th class="text-center" scope="col">상세보기</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${purchaseList}" var="buylists">
									<tr>
										<td class="text_ct align-middle"><input name="RowCheck"
											class="productDel form-check-input" type="checkbox"
											value="${buylists.orderNo}" /></td>
										<td><img src="/photo/${buylists.newFileName}"
											class="img-thumbnail"
											style="width: 80px; height: 80px; object-fit: cover;" /></td>
										<td class="align-middle">${buylists.productName}</td>
										<td class="align-middle"><div class="qu">${buylists.productQuantity}</div></td>
										<td class="price align-middle">${buylists.price}</td>

										<td>
										
											<div class="d-grid gap-2 col-6 mx-auto mt-4">
												<a
													href="/Project/productdetail?productId=${buylists.productId}"
													class="btn btn-secondary btn-sm">상세보기</a>
											</div>
										</td>
										<td class="visually-hidden sumPrice align-middle">${buylists.price * buylists.productQuantity}</td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<th>합계</th>
									<th id='sumAmount'>수량 : 3</th>
									<th id='sumSumPrice'>가격 : 65000</th>
									<th colspan="3"></th>
								</tr>
							</tfoot>
						</table>

						<input type="hidden" class="form-control" id="blackpruductId"
							name="blackproductId" value="">
						<div class="d-grid gap-2 d-md-flex justify-content-md-end">
							<button id="blackaddsubmit" class="btn btn-dark" type="button">선택상품
								삭제</button>

						</div>
					</c:if>
					<c:if test="${purchaseList[0] eq null}">
						<div class="text-center">
							<p class="text-muted">구매한 상품이 없습니다</p>
						</div>
					</c:if>
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
		$('#sumAmount').append('수량 : ' + sum + '개');
		/* 페이지 시작시 총 가격  */
		var sumPrice = 0;
		$('.sumPrice').each(function(i, item) {
			sumPrice += Number($(this).text());
		})
		$('#sumSumPrice').empty();
		$('#sumSumPrice').append('총 가격 : ' + sumPrice.toLocaleString() + '원');
		
		//삭제
		var qus = [];
		var delproductId = [];
		var prices = [];
		$('#blackaddsubmit').click(function() {
			$('input[name="RowCheck"]:checked').each(
					function() {
						delproductId.push($(this).val());
					})
							if (delproductId.length != 0) {
										$.ajax({
											type : "POST",//방식
											url : "/Project/buyListDel",//주소
											data : {
												delproductId : delproductId,
											},
											dataType : 'JSON',
											success : function(data) { //성공시
												console.log(data);
												content = "";
												$
														.each(
																data.purchaseList,
																function(i,
																		item) {
																	content += '<tr>'
																	content += '<td class="text_ct align-middle"><input name="RowCheck"'
									content +=			' class="productDel form-check-input" type="checkbox"'
										content +=			' value="'+item.orderNo+'" /></td>'
																	content += '<td><img src="/photo/'+item.newFileName+'"'
											content +=			'class="img-thumbnail"'
												content +=			' style="width: 80px; height: 80px; object-fit: cover;" /></td>'
																	content += '<td class="align-middle">'
																			+ item.productName
																			+ '</td>'
																	content += '<td class="align-middle"><div class="qu">'
																			+ item.productQuantity
																			+ '</div></td>'
																	content += '<td class="price align-middle">'
																			+ item.price
																			+ '</td>'
																	content += '<td>'
																	content += '<div class="d-grid gap-2 col-6 mx-auto mt-4">'
																	content += '<a href="/Project/productdetail?productId='
																			+ item.productId
																			+ '"'
																	content += 'class="btn btn-secondary btn-sm">상세보기</a>'
																	content += '</div>'
																	content += '</td>'
																		content +=	'<td class="visually-hidden sumPrice align-middle">'+item.price * item.productQuantity+'</td>'
																	content += '</tr>'
																})
												$('tbody').empty();
												$('tbody').append(content);
												/* 페이지 시작시 총 수량  */
												var sum = 0;
												$('.qu').each(function(i, item) {
													sum += Number($(this).text());
												})
												$('#sumAmount').empty();
												$('#sumAmount').append('수량 : ' + sum + '개');
												/* 페이지 시작시 총 가격  */
												var sumPrice = 0;
												$('.sumPrice').each(function(i, item) {
													sumPrice += Number($(this).text());
												})
												$('#sumSumPrice').empty();
												$('#sumSumPrice').append('총 가격 : ' + sumPrice.toLocaleString() + '원');
											},
											error : function(e) { //실패시
												console.log(e);
											}

										})
							}

						})
		$('#blackBuy')
				.click(
						function() {
							$('input[name="RowCheck"]:checked').each(
									function() {
										delproductId.push($(this).val());
										qus.push($(this).parent().nextAll(
												'.abc').find('div.qu').text());
										prices.push($(this).parent().nextAll(
												'.price').text());
									})
							$
									.ajax({
										type : "POST",//방식
										url : "/Project/cartBuy",//주소
										data : {
											delproductId : delproductId,
											qus : qus,
											prices : prices,
										},
										dataType : 'JSON',
										success : function(data) { //성공시
											if (data.suc > 0) {
												location.href = '/Project/myshopping/buy/buyList.jsp';
											}
										},
										error : function(e) { //실패시
											console.log(e);
										}
									})

						})
	</script>
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=2"></script>
</body>
</html>