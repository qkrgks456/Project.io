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
<link href="/Project/assets/css/bootstrap.css?ver=4" rel="stylesheet">
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<link href="/Project/assets/css/main.css?ver=5" rel="stylesheet">
<style type="text/css">
.list-group-item {
	border: 1px solid rgba(0, 0, 0, 0.125);
}
</style>
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
		<!-- 들어갈 내용 -->
		<section>
			<div class="container px-5 mt-5 ">
				<!-- 사이드 바 메뉴-->

				<jsp:include page="/login/idPasswordMenu.jsp"></jsp:include>
				<h2 class="fw-bold my-3">아이디찾기</h2>
				<hr />
				<div class="container px-3 w-50 border my-4">
					<form action="/Project/findIdByEmail  " method="post" class="my-4">
						<h2 class="fw-bold">본인확인 이메일로 인증</h2>
						<p>
							* 본인확인 이메일 주소와 입력한 이메일 주소가 같아야,<br /> 이메일을 통하여 아이디를 확인 받을 수
							있습니다.
						</p>
						<hr />
						<div class="form col-md-9 mb-3 mt-3">
							<label for="validationTooltip04" class="fw-bold my-1">이름</label>
							<input type="text" class="form-control" id="UserName" name="UserName"
								placeholder="정확하게 입력해주세요" required>
							<div class="invalid-feedback">필수 정보입니다</div>
						</div>
						<div class="form col-md-9 mb-3">
							<label for="validationTooltipUsername" class="fw-bold my-1">이메일</label>
							<input type="text" class="form-control" id="UserEmail" name="UserEmail"
								placeholder="정확하게 입력해주세요" required>
								<!--  아이디 찾기 버튼 --> 
								<div class="text-center mt-2">
								<input class="btn btn-secondary" type="submit" value="아이디 찾기">
								</div>
							<div class="invalid-feedback">필수 정보입니다</div>						
						</div>
					</form>
				</div>
			</div>
		</section>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=2"></script>
</body>
</html>