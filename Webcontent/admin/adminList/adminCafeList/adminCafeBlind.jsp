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
			<!-- 여기부터 내용 넣으세요 -->
				<div class="cont container-fluid mx-5 py-5">
				<!-- 회원정보 탭(여닫기) -->
					<div class="d-flex align-items-center">
						<button type="button" id="sidebarCollapse"
							class="me-2 btn btn-secondary">
							<i class="bi bi-text-left"></i>
						</button>
						<h2 class="fw-bold my-3">카페 블라인드 추가</h2>
					</div>
					<hr>
					<!-- 블랙 리스트 id, 이름 -->
					<form id="cafeBlindform" action="/Project/cafeBlindAdd" method="post"
						class="needs-validation py-3" novalidate>
					
					<div class = "col-md-9 mb-3"><!-- md 미디엄 -->
					<table class="table table-bordered mt-4">
						<tr>
							<th class="center" width="55%">카페번호</th>
							<th class="center">카페이름</th>
						</tr>
						<tr>
							<td class="align-middle" width="45%">${cafeBlind.cafeKey}</td>
							<td class="align-middle">${cafeBlind.cafeName}</td>
						</tr>
					</table>
					<!-- 블랙 사유 텍스트에리어 -->
					<div class="mb-3">
	  					<label for="cafeBlindreason" class="form-label">사유 작성</label>
	  					<textarea class="form-control" id="cafeBlindRePort" name="cafeBlindRePort" rows="6"></textarea>
					</div>
					<!-- form 버튼  -->
					<div class="form-group md-3">
						<input type="hidden"  class = "form-control" id="cafeBlindId" name="cafeBlindId" value=${cafeBlind.cafeKey}>
						<button id="cafeBlindSubmit" class="btn btn-dark" type="submit">추가</button>
						<button id="adminCafeDetail" class="btn btn-dark" type="button" onclick="location.href='adminCafeDetail?cafeKey=${cafeBlind.cafeKey}'">카페 상세 정보로</button>
						<button id="adminCafeList" class="btn btn-dark" type="button" onclick="location.href='admin/adminList/adminCafeList/adminCafeList.jsp'">리스트로</button>
					</div>
						
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
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
	
	<!-- blackaddsubmit 버튼이 눌릴시 팝업 -->
	 <script type="text/javascript">
	$(document).ready(function() {
		$('#blackaddsubmit').click(function() {
			Swal.fire({
					title: '블랙 리스트 추가완료',
					 icon: 'success',
					 confirmButtonColor: '#000',
					 confirmButtonText: '확인',
			})
		})
		
	})	
	
	-->
</body>
</html>