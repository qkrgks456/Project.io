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
			<jsp:include page="../myPagesideBar.jsp"></jsp:include>
			<!-- 오른쪽 시작 -->
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">비밀번호변경</h2>
				</div>
				<hr />
				<div class="cont container w-50">
					<!-- 내 정보 수정 폼 -->
					<!--  구상.. 내정보수정을 입력하면->비밀번호 변경하라는 페이지로 이동해서 수정을 ? -->
					<form id="myinfoformqs" action="/Project/passwordChange"
						method="post" class="needs-validation py-3" novalidate>
						<div class="text-center">
							<h3 class="fw-bold">비밀번호변경</h3>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<input type="password" class="form-control"
								id="UserPw" name="UserPw" placeholder="비밀번호" value="" required>
							<label for="validationTooltip02" class="fw-bold">비밀번호</label>
							<div class="invalid-feedback">10자 이상 입력해주세요</div>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<input type="password" class="form-control"
								id="UserPwchs" name="UserPwchs" placeholder="비밀번호확인" value=""
								required> <label for="validationTooltip02"
								class="fw-bold">비밀번호확인</label>
							<div class="invalid-feedback">동일한지 확인해주세요</div>
						</div>
						<div class="text-center">
							<input id="infopwchange" class="btn btn-dark" type="button"
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
		$('#infopwchange').click(function() {
							if ($('#UserPw').val().trim() == "") {
								$('#UserPw').attr('class','nullchecks form-control is-invalid');
							}
							
							if ($('#UserPw').attr('class') == 'form-control is-valid'
									&& $('#UserPwchs').attr('class') == 'form-control is-valid') {
								//UserName 요소의 class 속성의 값을 가져온다.
								console.log("안녕");
								$(this).attr('type', 'submit');
								//inforchange 요소에 type 속성을 추가하고 속성의 값은 submit으로 적용합니다.		
							}
						})
						$("#UserPwchs").on("propertychange change keyup paste input",function() {
												if ($("#UserPw").val() == $(this).val()) {
													$(this).attr("class","form-control is-valid");
												} else {
													$(this).attr("class","form-control is-invalid");
												}
											});

	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=8"></script>
</body>
</html>