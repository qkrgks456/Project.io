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
					<h2 class="fw-bold my-3">카페등록</h2>
				</div>
				<hr />
				<!-- 내용시작 -->
				<div class="cont container w-50">
					<form action="/Project/data/signupProc.jsp" method="post"
						class="needs-validation py-3" novalidate>
						<div class="form-floating col-md-9 mb-3">
							<input type="text" class="form-control" id="cafeName" name="cafeName"
								placeholder="카페이름"> <label
								for="validationTooltipUsername" class="fw-bold">카페이름</label>
							<div class="invalid-tooltip">Please choose a unique and
								valid username.</div>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<input type="text" class="form-control" id="cafeAddress" name="cafeAddress"
								placeholder="주소" required> <label
								for="validationTooltip03" class="fw-bold">카페주소</label>
							<div class="invalid-tooltip">Please provide a valid city.</div>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<input type="text" class="form-control" name="cafeAddress"
								placeholder="몰라" required> <label
								for="validationTooltip05" class="fw-bold">카페연락처</label>
							<div class="invalid-tooltip">Please provide a valid zip.</div>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<input type="text" class="form-control" id="validationTooltip03"
								placeholder="주소" required> <label
								for="validationTooltip03" class="fw-bold">영업시간</label>
							<div class="invalid-tooltip">Please provide a valid city.</div>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<input type="text" class="form-control" id="validationTooltip03"
								placeholder="주소" required> <label
								for="validationTooltip03" class="fw-bold">사업자등록번호</label>
							<div class="invalid-tooltip">Please provide a valid city.</div>
						</div>
						<div class="col-md-9 mb-3">
							<h6 class="fw-bold ">지역구선택 (해당지역에 맞는 손님에게 카페를 추천해드립니다)</h6>
							<select class="form-select">
								<option value="스타벅스" selected>도봉구</option>
								<option value="이디아">강북구</option>
								<option value="할리스">노원구</option>
								<option value="투썸플레이스">중랑구</option>
								<option value="메가커피">성북구</option>
								<option value="스타벅스">종로구</option>
								<option value="이디아">중구</option>
								<option value="할리스">용산구</option>
								<option value="투썸플레이스">서대문구</option>
								<option value="메가커피">마포구</option>
								<option value="스타벅스">영등포구</option>
								<option value="이디아">강남구</option>
								<option value="할리스">강동구</option>
							</select>
						</div>
						<div class="col-md-9 mb-3">
							<label for="formFileMultiple" class="form-label fw-bold">카페이미지
								첨부</label> <input class="form-control" type="file"
								id="formFileMultiple" multiple>
						</div>
						<div class="col-md-9 mb-3">
							<label for="FileMultiple" class="form-label fw-bold">사업자등록증 첨부</label> <input class="form-control" type="file"
								id="FileMultiple" multiple>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<div class="mb-3">
								<label for="exampleFormControlTextarea1"
									class="form-label fw-bold">카페설명</label>
								<textarea class="form-control" id="exampleFormControlTextarea1"
									rows="7"></textarea>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="car" class="fw-bold">주차가능여부</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="flexRadioDefault1">
									가능 </label> <input class="form-check-input" type="radio"
									name="flexRadioDefault" id="flexRadioDefault3" checked>

							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="flexRadioDefault" id="flexRadioDefault4"> <label
									class="form-check-label" for="flexRadioDefault2"> 불가 </label>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="dogcat" class="fw-bold">애완동반가능여부</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="flexRadioDefault1">
									가능 </label> <input class="form-check-input" type="radio"
									name="alertradio" id="flexRadioDefault3" checked>

							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="alertradio"
									id="flexRadioDefault4"> <label class="form-check-label"
									for="flexRadioDefault2"> 불가 </label>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="child" class="fw-bold">유아동반가능여부</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="flexRadioDefault1">
									가능 </label> <input class="form-check-input" type="radio" name="c"
									id="flexRadioDefault3" checked>

							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="c"
									id="flexRadioDefault4"> <label class="form-check-label"
									for="flexRadioDefault2"> 불가 </label>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="roof" class="fw-bold">루프탑유무</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="flexRadioDefault1">
									있음 </label> <input class="form-check-input" type="radio" name="s"
									id="flexRadioDefault3" checked>

							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="s"
									id="flexRadioDefault4"> <label class="form-check-label"
									for="flexRadioDefault2"> 없음 </label>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="ds" class="fw-bold">단체석유무</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="flexRadioDefault1">
									있음 </label> <input class="form-check-input" type="radio" name="b"
									id="flexRadioDefault3" checked>

							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="b"
									id="flexRadioDefault4"> <label class="form-check-label"
									for="flexRadioDefault2"> 없음 </label>
							</div>
						</div>
						<hr />
						<div class="col text-center">
							<button class="btn btn-dark" type="button">카페등록</button>
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
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=85"></script>
</body>
</html>