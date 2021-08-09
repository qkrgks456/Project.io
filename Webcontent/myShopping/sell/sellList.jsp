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
					<table class="table table-hover mt-2">
						<thead class="table-light">
							<tr>
								<th scope="col"><input id="allCheck" type="checkbox"
									class="form-check-input"" /></th>
								<th scope="col">상품명</th>
								<th scope="col">상품코드</th>
								<th scope="col">가격</th>

								<th class="text-center" scope="col">관리</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${sellList}" var="sellList">
								<tr class="">
									<th class="align-middle" scope="row"><div
											class="form-check">
											<input class="form-check-input" type="checkbox" value="s"
												id="flexCheckDefault" name="delCheck">
										</div></th>
									<td class="align-middle">${sellList.productName}</td>
									<td class="align-middle">${sellList.productId}</td>
									<td class="align-middle">${sellList.price}</td>
									<td>
										<div class="d-grid gap-2 col-6 mx-auto mt-1">
											<a class="btn btn-secondary btn-sm"
												onclick="location.href='/Project/myShopping/sell/productList/productDelResult.jsp'">삭제하기</a>
										</div>
									</td>
								</tr>
								</c:forEach>
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

	</c:if>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<script type="text/javascript">
	

		/* 페이지 시작시 총 가격  */
		var sumPrice = 0;
		$('.price').each(function(i, item) {
			sumPrice += Number($(this).text());
		})
		$('#sumSumPrice').empty();
		$('#sumSumPrice').append('총 매출 : ' + sumPrice.toLocaleString() + '원');

	
		
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
</html>