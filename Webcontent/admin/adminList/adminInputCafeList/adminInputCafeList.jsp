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
			<c:redirect url="/Project/"/>
		</c:if>
		<!-- 사이드바 배치 -->
		<div class="d-flex" style="height: auto; min-height: 100vh;">
			<!-- 사이드바 불러오기 -->
			<jsp:include page="/admin/adminSideBar.jsp"></jsp:include>
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">등록카페정보</h2>
				</div>
				<hr />
				<!-- 여기부터 내용 넣으세요 -->
				<table class="table table-hover mt-2">
					<thead class="table-light">
						<tr>
							<th scope="col">아이디</th>
							<th scope="col">카페명</th>
							<th scope="col">카페번호</th>
							<th class="text-center" scope="col">상세보기</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${inputCafeList}" var="inputCafeLists">
							<tr class="">
								<td class="align-middle">${inputCafeLists.cafeKey}</td>
								<td class="align-middle">${inputCafeLists.cafeName}</td>
								<td class="align-middle">${inputCafeLists.cafePhone}</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto">
										<a class="btn btn-secondary btn-sm"
											href="/Project/inputcafeDetail?cafeKey=${inputCafeLists.cafeKey}">상세보기</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<script type="text/javascript">
	$('#sasd').click(function() {
	})
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
</html>