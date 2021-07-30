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
		<c:if test="${businessCheck ne true}">
			<c:redirect url="businessChangeCheck.jsp"></c:redirect>
		</c:if>
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
			<jsp:include page="/myPage/myPagesideBar.jsp"></jsp:include>
			<!-- 오른쪽 시작 -->
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">사업자번호변경</h2>
				</div>
				<hr />
				<div class="cont container w-50">
					<!-- 변경 폼 -->
					<form class="py-3" action="/Project/businessChange" method="post">
						<div class="col-md-9 mb-3">
							<label for="ownerNo" class="fw-bold">바꿀사업자번호</label> <input
								id="ownerNo" type="text" class="form-control" name="ownerNo"
								required>
							<div class="invalid-feedback">사용 불가,번호확인을 다시 해주세요</div>
							<div class="valid-feedback">사용 가능</div>
							<input id="ownerNobtn" type="button"
								class="btn btn-dark btn-sm mt-2" value="사업자번호확인">
						</div>
						<div class="col text-center">
							<input id="businessChangeBtn" type="button" class="btn btn-dark"
								value="정보수정">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<script type="text/javascript">
		$("#ownerNobtn").click(function() {
			if ($('#ownerNo').val() == "") {
				$('#ownerNo').addClass("is-invalid");
			} else {
				var ownerNum = $('#ownerNo').val()
				$.ajax({
					type : "POST",//방식
					url : "/Project/ownerCheck",//주소
					data : {
						ownerNo : ownerNum
					},
					dataType : 'JSON',
					success : function(data) { //성공시
						console.log(data.ownerCheck);
						if (data.ownerCheck == false) {
							$('#ownerNo').removeClass("is-invalid");
							$('#ownerNo').addClass("is-valid");
						} else {
							$('#ownerNo').addClass("is-invalid");
							$('#ownerNo').removeClass("is-valid");
						}
					},
					error : function(e) { //실패시
						console.log(e);
					}
				});
			}
		})

		$('#businessChangeBtn').click(function() {
			if ($('#ownerNo').attr('class') == 'form-control is-valid') {
				$(this).attr('type', 'submit');
			}
		})
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=8"></script>
</body>
</html>