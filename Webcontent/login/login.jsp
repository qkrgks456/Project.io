<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<link href="/Project/assets/css/bootstrap.css?ver=8" rel="stylesheet">
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<link href="/Project/assets/css/main.css?ver=8" rel="stylesheet">
<title>카페</title>
</head>
<body>
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
	<div class="wrap d-flex align-items-center">
		<div class="container px-4 py-4 my-4 border shadow-lg" id="cont">
			<h4 class="mb-3 fw-bold">로그인</h4>
			<hr />
			<div class="container w-75">
				<form id="loginform" action="/Project/login" method="post">
					<div class="form-group">
						<label for="InputId" class="fw-bold">아이디</label> <input
							type="text" class="form-control" name="InputId" id="InputId"
							<c:if test="${cookie.memberKey ne null}"> value="${cookie.memberKey.value}" </c:if>
							placeholder="아이디를 입력해주세요">
						<div class="invalid-feedback">아이디를 입력해주세요</div>
					</div>
					<div class="form-group my-2">
						<label for="InputPassword" class="fw-bold">비밀번호</label> <input
							type="password" class="form-control" name="InputPassword"
							id="InputPassword" placeholder="비밀번호를 입력해주세요">
						<div class="invalid-feedback">비밀번호를 입력해주세요</div>
					</div>
					<div class="form-check mt-2">
						<input type="checkbox" class="form-check-input" id="idCheck" name="idCheck" >
						<label class="form-check-label" for="idCheck">아이디 저장</label>
					</div>
				</form>
				<c:if test="${success eq 'fail'}">
				<div id="redalert"
					class=" alert alert-danger d-flex align-items-center"
					role="alert">
					<svg class="bi flex-shrink-0 me-2" width="24" height="24"
						role="img" aria-label="Danger:">
						<use xlink:href="#exclamation-triangle-fill" /></svg>
					<div>없는 아이디거나 비밀번호가 틀립니다</div>
				</div>
				</c:if>
				<hr />
				<div>
					<div class="float-start">
						<div class="d-grid float-start">
							<a href="/Project/login/idFind/idFind.jsp">아이디를 잊으셨나요?</a> <a
								href="/Project/login/passwordFind/passwordFind.jsp">비밀번호를 잊으셨나요?</a>
						</div>
					</div>
					<div class="float-end">
					
						<input type="button" class="btn btn-dark" form="loginform" id="login" value="로그인">
						<a href="/Project/index.jsp"class="btn btn-secondary">메인</a>
					</div>
				</div>
				</div>
			</div>
		</div>
		<!-- 하단 정보 -->
		<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
		<!-- 스크립트 cdn  -->
		<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
		<!-- main js 추가 -->
		<script src="/Project/assets/js/main.js?var=3"></script>
	
</body>
</html>