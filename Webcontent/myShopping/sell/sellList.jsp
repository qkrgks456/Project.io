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
			<jsp:include page="../myShoppingsideBar.jsp"></jsp:include>
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
								<th scope="col">#</th>
								<th scope="col">이미지</th>
								<th scope="col">상품명</th>
								<th scope="col">가격</th>
								<th scope="col">수량</th>
								<th scope="col">합계</th>
								<th class="text-center" scope="col">상세보기</th>
							</tr>
						</thead>
						<tbody>
							<tr class="">
								<th class="align-middle" scope="row">


									<div class="check">
										<input type="checkbox" name="buy" value="260" checked="">
									</div>
								<td><div class="img">
										<img src="/Project/assets/img/p11.jpg" class="img-thumbnail"
											style="width: 80px; height: 80px; object-fit: cover;" />
									</div></td>

								<td class="align-middle">브라질 버본 산토스 No.2</td>

								<td class="align-middle">
									<div class="subdiv">
										<div class="basketprice">
											<input type="hidden" name="p_price" id="p_price1"
												class="p_price" value="9500">9,500원
										</div>
									</div>
								</td>

								<td class="align-middle">
											<div class="num">
											<div class="updown">
												<input type="text" name="p_num1" id="p_num1" size="2"
													maxlength="4" class="p_num" value="2"
													onkeyup="javascript:basket.changePNum(1);"> <span
													onclick="javascript:basket.changePNum(1);"><i
													class="fas fa-arrow-alt-circle-up up"></i></span> <span
													onclick="javascript:basket.changePNum(1);"><i
													class="fas fa-arrow-alt-circle-down down"></i></span>
											</div>
										</div>
															
								</td>
								<td class="align-middle">
									<div class="sum">40,000원</div>
								</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm">상세보기</a> <a
											class="btn btn-secondary btn-sm" onclick="javascript:basket.delItem();">삭제하기</a>
									</div>
								</td>
							</tr>
						</tbody>

						<tr class="">
							<th class="align-middle" scope="row">
								<div class="check">
									<input type="checkbox" name="buy" value="260" checked="">
								</div>
							<td><div class="img">
									<img src="/Project/assets/img/m4.jpg" class="img-thumbnail"
										style="width: 80px; height: 80px; object-fit: cover;" />
								</div></td>
							<td class="align-middle">텀블러</td>
							<td class="align-middle">35,000원</td>
							<td class="align-middle">
								<div class="updown">
									<input type="text" name="p_num1" id="p_num1" size="2"
										maxlength="4" class="p_num" value="2"> <span><i
										class="fas fa-arrow-alt-circle-up up"></i></span> <span><i
										class="fas fa-arrow-alt-circle-down down"></i></span>
								</div>
								</div>
							</td>
							<td class="align-middle">
								<div class="sum">40,000원</div>
							</td>
							<td>
								<div class="d-grid gap-2 col-6 mx-auto mt-1">
									<a class="btn btn-secondary btn-sm">상세보기</a> <a
										class="btn btn-secondary btn-sm">삭제하기</a>
								</div>
							</td>
						</tr>
						</tbody>

						<tr class="">
							<th class="align-middle" scope="row">
								<div class="check">
									<input type="checkbox" name="buy" value="260" checked="">
								</div>
							<td><div class="img">
									<img src="/Project/assets/img/m6.jpg" class="img-thumbnail"
										style="width: 80px; height: 80px; object-fit: cover;" />
								</div></td>
							<td class="align-middle">시럽 세트</td>
							<td class="align-middle">32,000원</td>
							<td class="align-middle">
								<div class="updown">
									<input type="text" name="p_num1" id="p_num1" size="2"
										maxlength="4" class="p_num" value="2"> <span><i
										class="fas fa-arrow-alt-circle-up up"></i></span> <span><i
										class="fas fa-arrow-alt-circle-down down"></i></span>
								</div>
								</div>
							</td>
							<td class="align-middle">
								<div class="sum">40,000원</div>
							</td>
							<td>
								<div class="d-grid gap-2 col-6 mx-auto mt-1">
									<a class="btn btn-secondary btn-sm">상세보기</a> <a
										class="btn btn-secondary btn-sm">삭제하기</a>
								</div>
							</td>
						</tr>
						</tbody>

						<tr class="">
							<th class="align-middle" scope="row">
								<div class="check">
									<input type="checkbox" name="buy" value="260" checked="">
								</div>
							<td><div class="img">
									<img src="/Project/assets/img/p7.jpg" class="img-thumbnail"
										style="width: 80px; height: 80px; object-fit: cover;" />
								</div></td>
							<td class="align-middle">과테말라 안티구아</td>
							<td class="align-middle">8,900원</td>
							<td class="align-middle">
								<div class="updown">
									<input type="text" name="p_num1" id="p_num1" size="2"
										maxlength="4" class="p_num" value="2"> <span><i
										class="fas fa-arrow-alt-circle-up up"></i></span> <span><i
										class="fas fa-arrow-alt-circle-down down"></i></span>
								</div>
								</div>
							</td>
							<td class="align-middle">
								<div class="sum">40,000원</div>
							</td>
							<td>
								<div class="d-grid gap-2 col-6 mx-auto mt-1">
									<a class="btn btn-secondary btn-sm">상세보기</a> <a
										class="btn btn-secondary btn-sm">삭제하기</a>
								</div>
							</td>
						</tr>
						</tbody>

						<tr class="">
							<th class="align-middle" scope="row">
								<div class="check">
									<input type="checkbox" name="buy" value="260" checked="">
								</div>
							<td><div class="img">
									<img src="/Project/assets/img/m7.jpg" class="img-thumbnail"
										style="width: 80px; height: 80px; object-fit: cover;" />
								</div></td>
							<td class="align-middle">써머 주스잔</td>
							<td class="align-middle">16,000원</td>
							<td class="align-middle">
								<div class="updown">
									<input type="text" name="p_num1" id="p_num1" size="2"
										maxlength="4" class="p_num" value="2"> <span><i
										class="fas fa-arrow-alt-circle-up up"></i></span> <span><i
										class="fas fa-arrow-alt-circle-down down"></i></span>
								</script>
								</div>
								</div>
							</td>
							<td class="align-middle">
								<div class="sum">40,000원</div>
							</td>
							<td>
								<div class="d-grid gap-2 col-6 mx-auto mt-1">
									<a class="btn btn-secondary btn-sm">상세보기</a> <a
										class="btn btn-secondary btn-sm">삭제하기</a>
								</div>
							</td>
						</tr>
						</tbody>



				</div>
			</div>
			</div>
		</div>
	</div>
</body>
</html>

<!-- 하단 고정 퀵메뉴 -->
	
	</c:if>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
<script src="/Project/assets/js/main.js?var=2"></script><c:if test="${sessionScope.loginId eq 'qkrgks456'}">
		<jsp:include page="/fixMenu/quickMenu.html"></jsp:include>