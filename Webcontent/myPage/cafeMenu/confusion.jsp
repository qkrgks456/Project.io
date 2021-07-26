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
<link href="/Project/assets/css/bootstrap.css?ver=15" rel="stylesheet">
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<link href="/Project/assets/css/main.css?ver=19" rel="stylesheet">
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
		<div class="d-flex" style="height: auto; min-height: 100vh;">
			<jsp:include page="../myPagesideBar.jsp"></jsp:include>
			<!-- 오른쪽 시작 -->
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">혼잡도설정</h2>
				</div>
				<hr />
				<div class="cont container d-flex justify-content-evenly mt-4">
					<!-- 내 정보 수정 폼 -->
					<form id="myinfoform" action="#" method="post"
						class="needs-validation py-3 col-md-6 border-end" novalidate>
						<div class="text-center">
							<h3 class="fw-bold">테이블설정</h3>
						</div>
						<div class="col-md-9 mb-3 mt-4">
							<label for="validationTooltip02" class="fw-bold">총좌석</label> <input
								type="text" class="form-control" id="UserPw"
								placeholder="숫자를 입력해주세요" value="" required>
							<div class="invalid-feedback">숫자를 입력해주세요</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="validationTooltip02" class="fw-bold">현재좌석</label> <input
								type="password" class="form-control" id="UserPw"
								placeholder="숫자를 입력해주세요" value="" required>
							<div class="invalid-feedback">숫자를 입력해주세요</div>
						</div>
						<div class="text-center">
							<button class="btn btn-dark" type="button">확인</button>
						</div>
					</form>


					<form id="myinfoform" action="#" method="post"
						class="needs-validation py-3 col-md-6" novalidate>
						<div class="text-center">
							<h3 class="fw-bold">혼잡도 기준 설정</h3>
						</div>
						<div class="col-md-9 mb-3 mt-4">
							<label for="validationTooltip02" class="fw-bold">여유</label> <input
								type="text" class="form-control" id="UserPw"
								placeholder="숫자를 입력해주세요" value="" required>
							<div class="invalid-feedback">숫자를 입력해주세요</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="validationTooltip02" class="fw-bold">보통</label> <input
								type="password" class="form-control" id="UserPw"
								placeholder="숫자를 입력해주세요" value="" required>
							<div class="invalid-feedback">숫자를 입력해주세요</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="validationTooltip02" class="fw-bold">혼잡</label> <input
								type="password" class="form-control" id="UserPw"
								placeholder="숫자를 입력해주세요" value="" required>
							<div class="invalid-feedback">숫자를 입력해주세요</div>
						</div>
						<div class="text-center">
							<button class="btn btn-dark" type="button">확인</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=8"></script>
</body>
</html>