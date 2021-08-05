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
<link href="/Project/assets/css/main.css?ver=10" rel="stylesheet">
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
			<jsp:include page="/myPage/myPagesideBar.jsp"></jsp:include>
			<!-- 오른쪽 시작 -->
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">사업자번호변경</h2>
				</div>
				<hr />
				<div class="cont container w-50">
					<!-- 본인확인 폼 -->
					<form action="/Project/businessCheck" method="post"
						class="needs-validation py-3">
						<div class="text-center">
							<h3 class="fw-bold">본인확인</h3>
						</div>
						<div class="col-md-9 mb-3">
							<label for="businessUserId" class="fw-bold">아이디</label> <input
								type="text" class="form-control nullcheckgo" id="businessUserId"
								name="businessUserId">
							<div class="invalid-feedback">필수정보 입니다</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="businessUserPw" class="fw-bold">비밀번호</label> <input
								type="password" class="form-control nullcheckgo"
								id="businessUserPw" name="businessUserPw">
							<div class="invalid-feedback">필수정보 입니다</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="businessUserPwCheck" class="fw-bold">비밀번호확인</label> <input
								type="password" class="form-control" id="businessUserPwCheck">
							<div class="invalid-feedback">동일한지 확인해주세요</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="businessNumber" class="fw-bold">현재사업자번호</label> <input
								type="text" class="form-control nullcheckgo" id="businessNumber" name="businessNumber">
							<div class="invalid-feedback">필수정보 입니다</div>
						</div>
						<c:if test="${businessCheck eq false}">
						<div id="redalert"
							class="alert alert-danger d-flex align-items-center"
							role="alert">
							<svg class="bi flex-shrink-0 me-2 " width="24" height="24"
								role="img" aria-label="Danger:">
						<use xlink:href="#exclamation-triangle-fill" /></svg>
							<div>정보를 확인해 주세요</div>
						</div>
						</c:if>
						<div class="text-center">
							<input id="businessChkBtn" class="btn btn-dark" type="button"
								value="확인">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<script type="text/javascript">
		$(".nullcheckgo").on(
				"propertychange change keyup paste input",
				function() {
					if ($(this).val().length >= 1) {
						$(this).attr("class",
								"form-control nullcheckgo is-valid");
					} else {
						$(this).attr("class",
								"form-control nullcheckgo is-invalid");
					}
				});
		$("#businessUserPwCheck").on("propertychange change keyup paste input",
				function() {
					if ($("#businessUserPw").val() == $(this).val()) {
						$(this).attr("class", "form-control is-valid");
					} else {
						$(this).attr("class", "form-control is-invalid");
					}
				});
		$("#businessChkBtn")
				.click(
						function() {
							if ($('#businessUserId').attr("class") == 'form-control nullcheckgo is-valid'
									&& $('#businessUserPw').attr("class") == 'form-control nullcheckgo is-valid'
									&& $('#businessNumber').attr("class") == 'form-control nullcheckgo is-valid'
									&& $('#businessUserPwCheck').attr("class") == 'form-control is-valid') {
								$('#businessChkBtn').attr("type", "submit");
							}
						})
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=8"></script>
</body>
</html>