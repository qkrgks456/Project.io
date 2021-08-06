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
<link href="/Project/assets/css/main.css?ver=4" rel="stylesheet">
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
		<!-- 사이드바 배치 -->
		<div class="d-flex" style="height: auto; min-height: 100vh;">
			<!-- 사이드바 불러오기 -->
			<jsp:include page="/admin/adminSideBar.jsp"></jsp:include>
			<div class="cont container-fluid mx-5 py-5">
				<!--오른쪽 내용넣기 -->
				<div class="cont container-fluid mx-5 py-5">
					<!-- 회원정보 탭(여닫기) -->
					<div class="d-flex align-items-center">
						<button type="button" id="sidebarCollapse"
							class="me-2 btn btn-secondary">
							<i class="bi bi-text-left"></i>
						</button>
						<h2 class="fw-bold my-3">상품정보 조회</h2>
					</div>
					<hr />
					<div class="cont container">
						<form id="ProductListform" action="/Project/adminProductList"
							method="post">
							<!-- 셀렉/text/검색 3개 -->
							<div class="row mb-1">
								<!-- 셀렉트 -->
								<div class="form-group col-2 m-0 p-0">
									<select class="form-select" name="ProductSearchSelect">
										<option value="memberKey" selected>아이디</option>
										<option value="email">이메일</option>
										<option value="ProductName">상품이름</option>
									</select>
								</div>
								<!-- 검색/버튼 -->
								<div class="col-10 m-0 p-0">
									<!-- 왼쪽으로 당기기 -->
									<div class="row">
										<!-- 검색 공간 -->
										<div class="form-group col-10 mp-0 me-0">
											<input type="text" class="form-control" id="productSearch"
												name="productSearch" />
										</div>
										<!-- 검색 버튼 공간 -->
										<div class="form-group col-2 p-0 m-0">
											<button class="btn btn-dark" type="submit">검색</button>
										</div>
									</div>
								</div>
							</div>
						</form>
						
						<div class="row mb-1">
						<table class="table table-bordered mt-4">
							<tr>
								<th class="center">유저 아이디</th>
								<th class="center">카페명</th>
								<th>상품명</th>
								<th>등록날짜</th>
								<th>블라인드 여부</th>
								<th>상세보기</th>
							</tr>
							
							<c:if test="${empty list}">
							<tr><td colspan="6">해당 데이터가 존재하지 않습니다.</td></tr>
							</c:if>
							<!-- 검색 리스트 출력 -->
							<c:forEach items="${list}" var="productSearch">
							<tr>
								<td class="align-middle">${productSearch.cafeKey}</td>
								<td class="align-middle">${productSearch.cafeName}</td>
								<td class="align-middle">${productSearch.productName}</td>
								<td class="align-middle">${productSearch.reg_date}</td>
								<td class="align-middle">${productSearch.productDel}</td>
								<td><button id="productDetail" class="btn btn-dark"
										type="button" onclick="location.href='/Project/adminProductDetail?productId=${productSearch.productId}'">상세보기</button></td>
							</tr>
							</c:forEach>
							
						</table>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
</html>