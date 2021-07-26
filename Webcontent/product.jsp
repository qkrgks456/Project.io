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
<link href="/Project/assets/css/main.css?ver=45" rel="stylesheet">
<title>카페</title>
</head>
<body>
	<div class="wrap">
		<!-- 상단 메뉴바 -->
		<!-- 섹션에 아이디가 있다면 -->
		<c:if test="${sessionScope.loginId ne null}">
			<jsp:include page="fixMenu/loginnav.jsp"></jsp:include>
		</c:if>
		<!-- 섹션에 아이디가 없다면 -->
		<c:if test="${sessionScope.loginId eq null}">
			<jsp:include page="fixMenu/navbar.jsp"></jsp:include>
		</c:if>
		<!-- 들어갈 내용 -->
		<section>
		<nav>
			<div>네비게이션</div>
		</nav>
			<h3>폐기 기능</h3>
			<p>폐기기능은 commit 하기전 상태의 파일을 완전히 삭제쓰</p>
			<h3>commit 한 내용을 취소하고 싶다면</h3>
			<p>1. 브런치 초기화 - 특정 지점으로 초기화 하는 기능</p>
			<p>2. reverse commit - 이전 버전으로 되돌린 내용으로 새로 커밋</p>
			<p>불필요한 내용 추가</p>
			<p>git hub 푸시</p>
			<div class="container">
				<div class="container mx-4 mt-5 border border">상품구매 들어갈 예정입니다</div>
			</div>
		</section>
	</div>
	<!-- 하단 고정 퀵메뉴 -->
	<c:if test="${sessionScope.loginId eq 'qkrgks456'}">
		<jsp:include page="fixMenu/quickMenu.html"></jsp:include>
	</c:if>
	<!-- 하단 정보 -->
	<jsp:include page="fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
</html>