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
				<div class="cont container-fluid mx-5 py-5">
					<!-- 회원정보 탭(여닫기) -->
					<div class="d-flex align-items-center">
						<button type="button" id="sidebarCollapse"
							class="me-2 btn btn-secondary">
							<i class="bi bi-text-left"></i>
						</button>
						<h2 class="fw-bold my-3">카페 상세정보</h2>
					</div>
					<hr />
					<div class="cont container">
					
					
					<div class = "col-md-9 mb-3"><!-- md 미디엄 -->
					
					<table class="table table-bordered mt-4">
						<tr>
								<th class="center" width="30%">카페이름</th>
								<td class="align-middle" width="70%">${adminCafeDetail.cafeName}</td>
							</tr>
							<tr>
								<th class="center">판매자</th>
								<td class="align-middle">${adminCafeDetail.name}</td>
							</tr>
							<tr>
								<th class="center">이메일</th>
								<td class="align-middle">${adminCafeDetail.email}</td>
							</tr>
							<tr>
								<th class="center">사업자 번호</th>
								<td class="align-middle">${adminCafeDetail.ownerNo}</td>
							</tr>
							<tr>
								<th class="center">주소</th>
								<td class="align-middle">${adminCafeDetail.cafeLocation}</td>
							</tr>
							<tr>
								<th class="center">매장좌석</th>
								<td class="align-middle">${adminCafeDetail.cafeTotalTable}</td>
							</tr>
							<tr>
								<th class="center">블라인드 여부</th>
								<td class="align-middle">${adminCafeDetail.cafeDel}</td>
							</tr>
							<tr>
								<th class="center">블라인드 사유</th>
								<c:if test="${empty adminCafeDetail.blindReason}"><td class="align-middle">N</td></c:if>
								<c:if test="${!empty adminCafeDetail.blindReason}"><td class="align-middle">${adminCafeDetail.blindReason}</td></c:if>
							</tr>
					</table>
					<div>
						<Button class="btn btn-dark" onclick="location.href='cafeBlind?ownerNo=${adminCafeDetail.ownerNo}'">블라인드</Button>
						<Button class="btn btn-dark" onclick="location.href='cafeBlindMinus'">블라인드 해제</Button>
						<Button class="btn btn-dark" onclick="location.href='admin/adminList/adminCafeList/adminCafeList.jsp'">리스트로</Button>
					</div>
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