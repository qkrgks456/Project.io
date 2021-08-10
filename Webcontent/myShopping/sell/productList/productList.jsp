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
								<th scope="col"><input id="allCheck" type="checkbox"
									class="form-check-input" " /></th>
								<th scope="col">상품명</th>
								<th scope="col">상품코드</th>
								<th scope="col">가격</th>
								<th scope="col">수량</th>
								<th class="text-center" scope="col">관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${map.myProductList}">
								<tr>
									<td class="text_ct align-middle"><input ﻿ name="RowCheck"
										class="productDel form-check-input" type="checkbox"
										value="${result.productId}" /></td>
									</th>
									<td class="align-middle">${result.productName}</td>
									<td class="align-middle">${result.productId}</td>
									<td class="align-middle">${result.price}</td>
									<td class="align-middle">${result.productQuantity}</td>
									<td>
										<div class="d-grid gap-2 col-6 mx-auto mt-1">
											<a
												href="/Project/productdetail?productId=${result.productId}"
												class="btn btn-secondary btn-sm" type="button">상세보기</a>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<!-- 상품삭제(상품블라인드처리 부분) -->
					<input type="hidden" class="form-control" id="blackpruductId"
						name="blackproductId" value="">
					<button id="blackaddsubmit" class="btn btn-dark" type="button">선택
						상품 삭제</button>

				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 추가라인  -->


	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<script type="text/javascript">
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
	<script src="/Project/assets/js/main.js?var=4"></script>
</body>

</html>