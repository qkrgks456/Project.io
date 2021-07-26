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
					<h2 class="fw-bold my-3">장바구니</h2>
				</div>
				<div class="container">
					<table class="table table-hover mt-2">
						<thead class="table-light">
							<tr>
								<th scope="col">#</th>
								<th scope="col">이미지</th>
								<th scope="col">상품명</th>
								<th scope="col">상품설명</th>
								<th scope="col">가격</th>
								<th class="text-center" scope="col">상세보기</th>
							</tr>
						</thead>
						<tbody>
							<tr class="visually-hidden">
								<th class="align-middle" scope="row">1</th>
								<td><img src="/Project/assets/img/12.jpg"
									class="img-thumbnail"
									style="width: 80px; height: 80px; object-fit: cover;" /></td>
								<td class="align-middle">상품명</td>
								<td class="align-middle">상품코드</td>
								<td class="align-middle">가격</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm">상세보기</a> <a
											class="btn btn-secondary btn-sm">좋아요취소</a>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="text-center text-muted">장바구니에 상품정보가 없습니다</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=5"></script>
</body>
</html>