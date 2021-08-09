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
					<h2 class="fw-bold my-3">판매내역</h2>
				</div>
				<div class="container">
					<thead class="table-light">
						<table class="table table-hover mt-2">

							<tr>
								<th scope="col">#</th>
								<th scope="col">상품명</th>
								<th scope="col">상품코드</th>
								<th scope="col">가격</th>
								<th scope="col">수량</th>
								<th scope="col">합계</th>
								<th class="text-center" scope="col">관리</th>
							</tr>
							</thead>
							<tbody>
								<tr class="">
									<th class="align-middle" scope="row"><div
											class="form-check">
											<input class="form-check-input" type="checkbox" value="s"
												id="flexCheckDefault" name="delCheck">
										</div></th>

									<td class="align-middle">과테말라 안티구아</td>

									<td class="align-middle">31202</td>

									<td class="align-middle">8900</td>

									<td class="align-middle"><div class="qu">502</div></td>
									<td class="price align-middle">4467800</td>
									<td>
										<div class="d-grid gap-2 col-6 mx-auto mt-1">
											<a class="btn btn-secondary btn-sm"
												onclick="location.href='/Project/myShopping/sell/productList/productDelResult.jsp'">삭제하기</a>
										</div>
									</td>
								</tr>
							</tbody>

							<tr class="">
								<th class="align-middle" scope="row"><div
										class="form-check">
										<input class="form-check-input" type="checkbox" value="s"
											id="flexCheckDefault" name="delCheck">
									</div></th>
								</div>
								<td class="align-middle">에티오피아 예가체프 G2</td>

								<td class="align-middle">31234</td>

								<td class="align-middle">8000</td>

								<td class="align-middle"><div class="qu">783</div></td>
								<td class="price align-middle">6264000</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm"
											onclick="location.href='/Project/myShopping/sell/productList/productDelResult.jsp'">삭제하기</a>
									</div>
								</td>
							</tr>
							</tbody>

							<tr class="">
								<th class="align-middle" scope="row"><div
										class="form-check">
										<input class="form-check-input" type="checkbox" value="s"
											id="flexCheckDefault" name="delCheck">
									</div></th>
								<td class="align-middle">에티오피아 시다모 G2</td>

								<td class="align-middle">32111</td>

								<td class="align-middle">8300</td>

								<td class="align-middle"><div class="qu">458</div></td>
								<td class="price align-middle">3801400</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm"
											onclick="location.href='/Project/myShopping/sell/productList/productDelResult.jsp'">삭제하기</a>
									</div>
								</td>
							</tr>
							</tbody>
							<tr class="">
								<th class="align-middle" scope="row"><div
										class="form-check">
										<input class="form-check-input" type="checkbox" value="s"
											id="flexCheckDefault" name="delCheck">
									</div></th>
								<td class="align-middle">써머 주스잔</td>

								<td class="align-middle">21207</td>

								<td class="align-middle">18000</td>

								<td class="align-middle"><div class="qu">213</div></td>
								<td class="price align-middle">3834000</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm"
											onclick="location.href='/Project/myShopping/sell/productList/productDelResult.jsp'">삭제하기</a>
									</div>
								</td>
							</tr>
							</tbody>
							<tr class="">
								<th class="align-middle" scope="row"><div
										class="form-check">
										<input class="form-check-input" type="checkbox" value="s"
											id="flexCheckDefault" name="delCheck">
									</div></th>
								<td class="align-middle">시럽 세트</td>

								<td class="align-middle">21214</td>

								<td class=" align-middle">32000</td>

								<td class="align-middle"><div class="qu">63</div></td>
								<td class="price align-middle">2016000</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm"
											onclick="location.href='/Project/myShopping/sell/productList/productDelResult.jsp'">삭제하기</a>
									</div>
								</td>
							</tr>
							</tbody>
							<tfoot>
								<tr>
									<th>합계</th>
									<th id='sumAmount'>수량 : 3</th>
									<th id='sumSumPrice'>총 매출 : 65000</th>
									<th colspan="3"></th>
								</tr>
							</tfoot>
						</table>
						</table>
						<div class="d-grid gap-2 d-md-block"></div>


						<button class="btn btn-dark" type="button" name="delProductBtn">선택내역
							삭제</button>
				</div>
			</div>

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
		<jsp:include page="/fixMenu/quickMenu.jsp"></jsp:include>
	</c:if>
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
		$('#sumAmount').append('수량 : ' + sum.toLocaleString() + '개');
		
		/* 페이지 시작시 총 가격  */
		var sumPrice = 0;
		$('.price').each(function(i, item) {
			sumPrice += Number($(this).text());
		})
		$('#sumSumPrice').empty();
		$('#sumSumPrice').append('총 매출 : ' + sumPrice.toLocaleString() + '원');

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
					$('#sumAmount').append('수량 : ' +sum.toLocaleString() + '개');
					$(this).parents('td').nextAll('.sumPrice').empty();
					$(this).parents('td').nextAll('.sumPrice').append(sumSum);
					$('.sumPrice').each(function(i, item) {
						sumPrice += Number($(this).text());
						console.log(sumPrice);
					})
					$('#sumSumPrice').empty();
					$('#sumSumPrice').append('총 매출 : ' + sumPrice.toLocaleString() + '원');
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
						$('#sumAmount').append('수량 : ' + sum.toLocaleString() + '개');
						$(this).parents('td').nextAll('.sumPrice').empty();
						$(this).parents('td').nextAll('.sumPrice').append(
								sumSum);
						$('.sumPrice').each(function(i, item) {
							sumPrice += Number($(this).text());
							console.log(sumPrice);
						})
						$('#sumSumPrice').empty();
						$('#sumSumPrice').append('총 매출 : ' + sumPrice.toLocaleString() + '원');
					}
				})
		$('#delProductBtn').click(function() {
			var delCheckArr = [];
			$('input[name="delCheck"]:checked').each(function() {
				delCheckArr.push($(this).val()); //체크된 박스만 뽑아서 배열로 push
				console.log(delCheckArr);		
			})
			
	 $.ajax({
			      type  : "POST",
			      url    : "<c:url value='#컨트롤러값'>",
			      data: {
			    	  delCheckArr : delCheckArr       
			      },
			      success: function(result){
			      	console.log(result);
			      },
			      error: function(xhr, status, error) {
			      	alert(error);
			      }  
			   });
			} 
					})
		 
	</script>
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=2"></script>
</body>
</html></c: