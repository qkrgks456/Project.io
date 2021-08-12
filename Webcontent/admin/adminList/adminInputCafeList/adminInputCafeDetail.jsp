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
				<!-- 여기부터 내용 넣으세요 -->
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">등록카페상세</h2>
				</div>
				<hr />
				<div class="container px-5 w-75">
					<table class="table table-bordered mt-4">
						<tr>
							<th class="center" width="30%">아이디</th>
							<td class="align-middle">${map.cafeKey}</td>
						</tr>
						<tr>
							<th class="center">카페이름</th>
							<td class="align-middle">${map.cafeName}</td>
						</tr>
						<tr>
							<th class="center">카페연락처</th>
							<td class="align-middle">${map.cafePhone}</td>
						</tr>
						<tr>
							<th class="center">카페설명</th>
							<td class="align-middle"><textarea class="form-control"
									cols="50" rows="8" style="resize:none;" readonly>${map.cafeDetail}</textarea></td>
						</tr>
						<tr>
							<th class="center">영업시간</th>
							<td class="align-middle">${map.cafeTime}</td>
						</tr>
						<tr>
							<th class="center">주소</th>
							<td class="align-middle">${map.cafeAddress}</td>
						</tr>
						<tr>
							<th class="center">카페지역구</th>
							<td class="align-middle">${map.cafeLocation}</td>
						</tr>
						<tr>
							<th class="center">사업자등록번호</th>
							<td class="align-middle">${map.ownerNo}</td>
						</tr>
					</table>
					<div class="row">
						<div class="col-md-6">
							<h2 class="fw-bold">사업자 등록증</h2>
							<img src="/photo/${map.ownerNoImage}" class="rounded"
								style="width: 220px; height: 300px" style="object-fit: cover;" />
						</div>
						<div class="col-md-6">
							<h2 class="fw-bold">카페이미지</h2>
							<div class="row row-col-3 d-float">
								<c:forEach items="${map.imageList}" var="imageLists">
									<div class="col-4 p-1" style="width: 150px; height: 145px">
										<img src="/photo/${imageLists}" class="rounded h-100 w-100"
											style="object-fit: cover;" />
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="mt-4 text-center">
						<a href="/Project/inputCafeInfo" class="btn btn-dark">리스트로</a>
						<button title="/Project/inputCafeOpen?cafeKey=${map.cafeKey}"
							id="authorityBtn" class="btn btn-dark">권한등록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>

	<script type="text/javascript">
	$('#authorityBtn').click(function() {
		var href = $(this).attr('title');
		Swal.fire({
			title: '수정완료',
			icon: 'success',
			confirmButtonColor: '#000',
			confirmButtonText: '확인',
		}).then((result) => {							
			if (result.isConfirmed) {
				location.href= href;
			}
		})
	})	
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
</html>