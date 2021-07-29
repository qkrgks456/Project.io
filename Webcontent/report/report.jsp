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
<link href="/Project/assets/css/main.css?ver=6" rel="stylesheet">
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
		<div class="container px-5 mt-5 ">
			<h2 class="fw-bold my-3">신고하기</h2>
			<hr />
			<div id = "sform">
			<form action="#" method="post"
				class="needs-validation" novalidate>
				<div class="form-floating col-md-3 mb-3">
					<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">아이디</h6>
					<input class="form-control" type="text" value="qkrgks456****"
						aria-label="Disabled input example" disabled readonly
						name="UserId" id="UserId">
				</div>
				<div class="form-floating col-md-3 mb-3">
					<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">신고
						사유</h6>
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value=""
							id="flexCheckDefault"> <label class="form-check-label"
							for="flexCheckDefault"> 광고 / 음란성 </label>
					</div>

					<div class="form-check">
						<input class="form-check-input" type="checkbox" value=""
							id="flexCheckDefault"> <label class="form-check-label"
							for="flexCheckDefault"> 욕설 / 부적합한 말</label>
					</div>

					<div class="form-check">
						<input class="form-check-input" type="checkbox" value=""
							id="flexCheckDefault"> <label class="form-check-label"
							for="flexCheckDefault"> 회원 분란 유도 </label>
					</div>

					<div class="form-check">
						<input class="form-check-input" type="checkbox" value=""
							id="flexCheckDefault"> <label class="form-check-label"
							for="flexCheckDefault"> 회원 비방 </label>
					</div>

					<div class="form-check">
						<input class="form-check-input" type="checkbox" value=""
							id="flexCheckDefault"> <label class="form-check-label"
							for="flexCheckDefault"> 도배성 </label>
					</div>

					<div class="mb-3">
						<input type="email" class="form-control col-md-3 mb-3"
							id="exampleFormControlInput1" placeholder="기타사유">
					</div>
					</div>
				
				<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">신고 날짜</h6>
				<div class="col-md-3 mb-3">
						<input type="email" class="form-control"
							id="exampleFormControlInput1" placeholder="2021. 07. 28" disabled readonly>
					</div>
					
					<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">신고 댓글</h6>
					<div class="col-md-3 mb-3">
						<input type="email" class="target form-control "
							id="exampleFormControlInput1" placeholder="신고 댓글 내용 불러오기 신고 댓글 내용 불러오기신고 댓글 내용 불러오기신고 댓글 내용 불러오기신고 댓글 내용 불러오기신고 댓글 내용 불러오기신고 댓글 내용 불러오기" disabled readonly>
					
					</div></div>
					</div>
				
					
					
				
				
				<hr />
				<div class="col text-center">
					<button class="btn btn-dark" type="button" id="signupbtn">신고하기</button>
				</div>
			</form>



		</div>
	</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
</html>