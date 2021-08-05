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
<link href="/Project/assets/css/main.css?ver=56" rel="stylesheet">
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
		<!-- 들어갈 내용 -->
		<div class="d-flex" style="height: auto; min-height: 100vh;">
			<jsp:include page="../myPagesideBar.jsp"></jsp:include>
			<!-- 오른쪽 시작 -->
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">혼잡도설정</h2>
				</div>
				<hr />
				<c:if test="${map.check eq true}">
					<div class="cont container d-flex justify-content-evenly py-3">
						<!-- 좌석수정 -->
						<div id="myinfoform"
							class="needs-validation py-3 col-md-6 border-end">
							<div class="text-center">
								<h3 class="fw-bold">테이블설정</h3>
							</div>
							<div id="totalTable" class="col-md-9 mb-3 mt-4">
								<label for="cafeTotalTable" class="fw-bold">총좌석</label> <input
									type="text" class="numCheck form-control" id="cafeTotalTable"
									name="cafeTotalTable" placeholder="숫자를 입력해주세요"
									value="${map.cafeTotalTable}" required>
								<div class="invalid-feedback">숫자를 입력해주세요</div>
							</div>
							<div id="curTable" class="col-md-9 mb-3">
								<label for="cafeCurrentTable" class="fw-bold">현재좌석</label> <input
									type="text" class="numCheck form-control" id="cafeCurrentTable"
									name="cafeCurrentTable" placeholder="숫자를 입력해주세요"
									value="${map.cafeCurrentTable}" required>
								<div class="invalid-feedback">숫자를 입력해주세요</div>
							</div>
							<div class="text-center">
								<input id="tableChange" class="btn btn-dark" type="button"
									value="수정">
							</div>
							<div class="text-center mt-2">
								<p>* 잘못된 수치를 넣으실 혼잡도가 수정되지 않습니다</p>
							</div>
						</div>
						<!-- 기준수정 -->
						<div id="myinfoformss" class="needs-validation py-3 col-md-6">
							<div class="text-center">
								<h3 class="fw-bold">혼잡도 기준 설정</h3>
							</div>
							<div id="leisurelyBox" class="col-md-9 mb-3 mt-4">
								<label for="leisurely" class="fw-bold">쾌적</label> <input
									type="text" class="numCheck form-control" id="leisurely"
									name="leisurely" placeholder="숫자를 입력해주세요"
									value="${map.leisurely}" required>
								<div class="invalid-feedback">숫자를 입력해주세요</div>
							</div>
							<div id="normalBox" class="col-md-9 mb-3">
								<label for="normal" class="fw-bold">보통</label> <input
									type="text" class="numCheck form-control" id="normal"
									name="normal" placeholder="숫자를 입력해주세요" value="${map.normal}"
									required>
								<div class="invalid-feedback">숫자를 입력해주세요</div>
							</div>
							<div id="congestBox" class="col-md-9 mb-3">
								<label for="congest" class="fw-bold">혼잡</label> <input
									type="text" class="numCheck form-control" id="congest"
									name="congest" placeholder="숫자를 입력해주세요" value="${map.congest}"
									required>
								<div class="invalid-feedback">숫자를 입력해주세요</div>
							</div>
							<div class="text-center">
								<input id="standardChange" class="btn btn-dark" type="button"
									value="수정">
							</div>
							<div id="explanationBox" class="text-center mt-2">
								<p>* 잘못된 수치를 넣으실 혼잡도가 수정되지 않습니다</p>
								<p>0 < (쾌적) < ${map.leisurely} < (보통) < ${map.normal} < (혼잡)
									< ${map.congest}</p>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${map.check eq false}">
					<div class="text-center">
						<p class="text-muted">등록된 카페정보가 없습니다</p>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- confusion.js 추가 -->
	<script src="/Project/assets/js/confusion.js?var=95"></script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=8"></script>
</body>
</html>