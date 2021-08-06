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
						<h2 class="fw-bold my-3">상품정보 상세</h2>
					</div>
					<hr />
					<div class="row mb-1">
						<table class="table table-bordered mt-4">
							<tr>
								<th class="center">카페명</th>
								<td class="align-middle">${adminProductDetail.cafeName}</td>
							</tr>
							<tr>
								<th class="center">상품이름</th>
								<td class="align-middle">${adminProductDetail.productName}</td>
							</tr>
							<tr>
								<th class="center">이름</th>
								<td class="align-middle">${adminProductDetail.name}</td>
							</tr>
							<tr>
								<th class="center">가격</th>
								<td class="align-middle">${adminProductDetail.productPrice}</td>
							</tr>
							<tr>
								<th class="center">상품설명</th>
								<td class="align-middle">${adminProductDetail.explanation}</td>
							</tr>
							<tr>
								<th class="center">블라인드 여부</th>
								<td class="align-middle">${adminProductDetail.productDel}</td>
							</tr>
							<tr>
								<th class="center">블라인드 사유</th>

								<c:if test="${empty adminProductDetail.pBlindReason}">
									<td class="align-middle">N</td>
								</c:if>
								<!-- 아래 조건이 적용안됨 -->
								<c:if test="${!empty adminProductDetail.pBlindReason}">
									<td class="align-middle">${adminProductDetail.pBlindReason}</td>
								</c:if>
							</tr>
							
							<!-- 검색 리스트 출력 -->
						</table>
						<div>
							<button class="btn btn-dark" onclick="location.href='adminProductBlind?productId=${adminProductDetail.productId}&cafeName=${adminProductDetail.cafeName}&productName=${adminProductDetail.productName}'">블라인드</button>
							<button class="btn btn-dark" onclick="location.href='productBlindMinus?productId=${adminProductDetail.productId}'">블라인드 해제</button>
							<button class="btn btn-dark" onclick="location.href='admin/adminList/adminProductList/adminProductList.jsp'">리스트로</button>
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