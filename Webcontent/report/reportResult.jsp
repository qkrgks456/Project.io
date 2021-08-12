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
			<h2 class="fw-bold my-3">신고 완료</h2>
			<hr />

			<img src="/Project/assets/img/n1.jpg" width="350" height="350"
				style="margin-left: auto; margin-right: auto; display: block;" />
			<h3 style="text-align: center">
				신고가 완료됐습니다.<br>
				신고된 댓글은 관리자가 확인해 기준에 맞게 조치하고 있습니다.<br>
				<h3 style="text-align: center; color: red;">
					단, 신고가 되었다고 해서 모두 조치되는 것은 아니며,<br> 이용약관 및 운영원칙에 따라 조치되지 않는
					게시물이 있을 수 있습니다. <br>
					<br> <a class="btn btn-secondary btn-lg"
						href="/Project/" role="button">메인으로</a>
				</h3>
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