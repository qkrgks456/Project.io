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
			<c:redirect url="index.jsp"></c:redirect>
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
					<c:if test="${check eq false}">
						<div class="py-3">
							<div class="form-floating col-md-9 mb-3">
								<input type="text" class="form-control nullchecks" id="cafeName"
									name="cafeName" placeholder="카페이름"> <label
									for="cafeName" class="fw-bold">카페이름(필수)</label>
								<div class="invalid-feedback">필수 정보 입니다</div>
							</div>
							<div class="form-floating col-md-9 mb-3">
								<input type="text" class="form-control nullchecks"
									id="cafeAddress" name="cafeAddress" placeholder="주소" required>
								<label for="cafeAddress" class="fw-bold">카페주소(필수)</label>
								<div class="invalid-feedback">필수 정보 입니다</div>
							</div>

							<div class="form-floating col-md-9 mb-3">
								<input type="text" class="form-control nullchecks"
									name="cafePhone" id="cafePhone" placeholder="몰라" required>
								<label for="cafeAddress" class="fw-bold">카페연락처(필수)</label>
								<div class="invalid-feedback">필수 정보 입니다</div>
							</div>
							<div class="form-floating col-md-9 mb-3">
								<input type="text" class="form-control nullchecks" id="cafeTime"
									name="cafeTime" placeholder="주소" required> <label
									for="validationTooltip03" class="fw-bold">영업시간(필수)</label>
								<div class="invalid-feedback">필수 정보 입니다</div>
							</div>
							<div class="form-floating col-md-9 mb-3">
								<input type="text" class="form-control" id="ownerNo"
									name="ownerNo" placeholder="주소" required> <label
									for="ownerNo" class="fw-bold">사업자등록번호(필수)</label>
								<div class="invalid-feedback">사용 불가,중복확인을 다시 해주세요</div>
								<div class="valid-feedback">사용 가능</div>
								<input id="ownerNobtn" type="button"
									class="btn btn-dark btn-sm mt-2" value="중복확인">
							</div>

							<div class="col-md-9 mb-3">
								<h6 class="fw-bold ">
									지역구선택<br /> (해당지역에 맞는 손님에게 카페를 추천해드립니다)
								</h6>
								<select class="form-select" name="cafeLocation">
									<option value="도봉구" selected>도봉구</option>
									<option value="강북구">강북구</option>
									<option value="노원구">노원구</option>
									<option value="중랑구">중랑구</option>
									<option value="성북구">성북구</option>
									<option value="종로구">종로구</option>
									<option value="중구">중구</option>
									<option value="용산구">용산구</option>
									<option value="서대문구">서대문구</option>
									<option value="마포구">마포구</option>
									<option value="영등포구">영등포구</option>
									<option value="강남구">강남구</option>
									<option value="강동구">강동구</option>
								</select>
							</div>
							<div class="col-md-9 mb-3">
								<label for="ownerNoImg" class="form-label fw-bold">사업자등록증
									첨부(필수) </label> <input class="form-control" type="file" id="ownerNoImg"
									name="ownerNoImg">
								<div class="invalid-feedback">꼭 첨부해주세요</div>
							</div>
							<div class="col-md-9 mb-3">
								<label for="cafeImg" class="form-label fw-bold">카페이미지
									첨부(필수)<br />(9장이하만 등록 가능합니다)
								</label> <input class="form-control" type="file" id="cafeImg"
									name="cafeImg" multiple>
								<div id="oneMust" class="invalid-feedback visually-hidden">1장
									이상 꼭 등록해주세요</div>
								<div id="nineMust" class="invalid-feedback visually-hidden">9장
									이하만 등록 가능합니다</div>
							</div>
							<div class="form-floating col-md-9 mb-3">
								<div class="mb-3">
									<label for="cafeDetail" class="form-label fw-bold">카페설명</label>
									<textarea class="form-control" id="cafeDetail"
										name="cafeDetail" rows="7"></textarea>
								</div>
							</div>
							<div class="col-md-9 mb-3">
								<label for="car" class="fw-bold">주차가능여부</label>
								<div class="form-check form-check-inline mx-3">
									<input class="form-check-input" type="radio"
										name="parkingCheck" id="parkingCheck1" value="Y" checked>
									<label class="form-check-label" for="parkingCheck1"> 가능
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" value="N"
										name="parkingCheck" id="parkingCheck2"> <label
										class="form-check-label" for="parkingCheck2"> 불가 </label>
								</div>
							</div>
							<div class="col-md-9 mb-3">
								<label for="dogcat" class="fw-bold">애완동반가능여부</label>
								<div class="form-check form-check-inline mx-3">
									<input class="form-check-input" type="radio" name="petCheck"
										id="petCheck1" value="Y" checked> <label
										class="form-check-label" for="petCheck1"> 가능 </label>

								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="petCheck"
										value="N" id="petCheck2"> <label
										class="form-check-label" for="petCheck2"> 불가 </label>
								</div>
							</div>
							<div class="col-md-9 mb-3">
								<label for="child" class="fw-bold">유아동반가능여부</label>
								<div class="form-check form-check-inline mx-3">
									<input class="form-check-input" type="radio" name="childCheck"
										id="childCheck1" value="Y" checked> <label
										class="form-check-label" for="childCheck1"> 가능 </label>

								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="childCheck"
										id="childCheck2" value="N"> <label
										class="form-check-label" for="childCheck2"> 불가 </label>
								</div>
							</div>
							<div class="col-md-9 mb-3">
								<label for="roof" class="fw-bold">루프탑유무</label>
								<div class="form-check form-check-inline mx-3">
									<input class="form-check-input" type="radio"
										name="rooftopCheck" id="rooftopCheck1" value="Y" checked>
									<label class="form-check-label" for="rooftopCheck1"> 있음
									</label>

								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="rooftopCheck" id="rooftopCheck2" value="N"> <label
										class="form-check-label" for="rooftopCheck2"> 없음 </label>
								</div>
							</div>
							<div class="col-md-9 mb-3">
								<label for="ds" class="fw-bold">단체석유무</label>
								<div class="form-check form-check-inline mx-3">
									<input class="form-check-input" type="radio" name="groupCheck"
										id="groupCheck1" value="Y" checked> <label
										class="form-check-label" for="groupCheck1"> 있음 </label>

								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="groupCheck"
										id="groupCheck2" value="N"> <label
										class="form-check-label" for="groupCheck2"> 없음 </label>
								</div>
							</div>
							<hr />
							<div class="col text-center">
								<button id="cafeInputbtn" class="btn btn-dark" type="button">카페등록</button>
							</div>
						</div>
					</c:if>
					<c:if test="${check eq true}">
						<div class="text-center">
							<p class="text-muted">카페를 삭제하였거나 이미 카페를 등록하였습니다</p>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- cafeInput js 추가 -->
	<script src="/Project/assets/js/cafeInput.js?var=29"></script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=12"></script>
</body>
</html>