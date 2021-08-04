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
		<div class="d-flex" style="height: auto; min-height: 100vh;">
			<jsp:include page="/myShopping/myShoppingsideBar.jsp"></jsp:include>
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">상품정보</h2>
				</div>
				<div class="container">
					<table class="table table-hover mt-2">
						<thead class="table-light">
							<tr>
								<th scope="col">#</th>
								<th scope="col">상품명</th>
								<th scope="col">상품코드</th>
								<th scope="col">가격</th>
								<th scope="col">수량</th>
								<th class="text-center" scope="col">관리</th>
							</tr>
						</thead>
						<tbody>

							<tr>
								<th class="align-middle" scope="row">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value=""
											id="flexCheckDefault">

									</div>
								</th>
								<td class="align-middle">과테말라 안티구아</td>
								<td class="align-middle">30133</td>
								<td class="align-middle">8,900원</td>
								<td class="align-middle">53개</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<button class="btn btn-secondary btn-sm" type="button"
											onclick="location.href='/Project/myShopping/sell/productInput/productInput.jsp'">상세보기</button>
											<a class="btn btn-secondary btn-sm"
										onclick="location.href='/Project/myShopping/sell/productList/productDelResult.jsp'">삭제하기</a>
										</div>
									</div>
									</div>
								</td>
							</tr>

							<tr>
								<th class="align-middle" scope="row">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value=""
											id="flexCheckDefault">

									</div>
								</th>
								<td class="align-middle">과테말라 안티구아</td>
								<td class="align-middle">30133</td>
								<td class="align-middle">8,900원</td>
								<td class="align-middle">53개</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<button class="btn btn-secondary btn-sm" type="button"
											onclick="location.href='/Project/myShopping/sell/productInput/productInput.jsp'">상세보기</button>
									<a class="btn btn-secondary btn-sm"
										onclick="location.href='/Project/myShopping/sell/productList/productDelResult.jsp'">삭제하기</a>
								
									</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<a href="javascript:void(0)" class="btn btn-dark" type="button"
						onclick="javascript:basket.delCheckedItem();">선택상품삭제</a>

				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<script>
	<script>
	//이벤트 리스너 등록

	document.addEventListener('DOMContentLoaded', function() {
		
		let basket = {
			    totalCount: 0, 
			    totalPrice: 0,
			    //체크한 장바구니 상품 비우기
			    delCheckedItem: function(){
			        document.querySelectorAll("input[name=buy]:checked").forEach(function (item) {
			            item.parentElement.parentElement.parentElement.remove();
			        });
			        //AJAX 서버 업데이트 전송
			        
		// "선택 상품 삭제" 버튼 클릭

		document.querySelector('.basketrowcmd a:first-child')
				.addEventListener('click', function() {

					basket.delCheckedItem();

				});

		document.querySelectorAll('.basketcmd a').forEach(

		function(item) {

			item.addEventListener('click', function() {

				basket.delItem();

			});

		}

		);
		

		// 장바구니 행 "삭제" 버튼 클릭

		document.querySelectorAll('.basketcmd a').forEach(

		function(item) {

			item.addEventListener('click', function() {

				basket.delItem();

			});

		}

		);

		delItem : function() {

			event.target.parentElement.parentElement.parentElement.remove();

		}

	}
	</script>

	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=4"></script>
</body>

</html>