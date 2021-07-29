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
					<h2 class="fw-bold my-3">카페정보</h2>
				</div>
				<hr />
				<!-- 내용시작 -->
				<div class="cont container w-50">
					<form class="needs-validation py-3">
						<div class="col-md-9 mb-3">
							<label for="cafeName" class="fw-bold">카페이름</label> <input
								type="text" class="form-control nullcheckgo" id="cafeName"
								value="${dto.cafeName}" name="cafeName">
							<div class="invalid-feedback">필수 정보 입니다</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="cafeAddress" class="fw-bold">카페주소</label> <input
								type="text" class="form-control nullcheckgo" id="cafeAddress"
								name="cafeAddress" value="${dto.cafeAddress}"
								required>
							<div class="invalid-feedback">필수 정보 입니다</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="cafePhone" class="fw-bold">카페연락처</label> <input
								type="text" class="form-control nullcheckgo" id="cafePhone" name="cafePhone"
								value="${dto.cafePhone}" required>
							<div class="invalid-feedback">필수 정보 입니다</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="cafeTime" class="fw-bold">영업시간</label> <input
								type="text" class="form-control nullcheckgo" id="cafeTime" name="cafeTime"
								value="${dto.cafeTime}" required>
							<div class="invalid-feedback">필수 정보 입니다</div>
						</div>
						<div class="col-md-9 mb-3">
							<h6 class="fw-bold ">지역구변경</h6>
							<select class="form-select" name="cafeLocation">
								<option value="도봉구"
									<c:if test="${dto.cafeLocation eq '도봉구'}">selected</c:if>>도봉구</option>
								<option value="강북구"
									<c:if test="${dto.cafeLocation eq '강북구'}">selected</c:if>>강북구</option>
								<option value="노원구"
									<c:if test="${dto.cafeLocation eq '노원구'}">selected</c:if>>노원구</option>
								<option value="중랑구"
									<c:if test="${dto.cafeLocation eq '중랑구'}">selected</c:if>>중랑구</option>
								<option value="성북구"
									<c:if test="${dto.cafeLocation eq '성북구'}">selected</c:if>>성북구</option>
								<option value="종로구"
									<c:if test="${dto.cafeLocation eq '종로구'}">selected</c:if>>종로구</option>
								<option value="중구"
									<c:if test="${dto.cafeLocation eq '중구'}">selected</c:if>>중구</option>
								<option value="용산구"
									<c:if test="${dto.cafeLocation eq '용산구'}">selected</c:if>>용산구</option>
								<option value="서대문구"
									<c:if test="${dto.cafeLocation eq '서대문구'}">selected</c:if>>서대문구</option>
								<option value="마포구"
									<c:if test="${dto.cafeLocation eq '마포구'}">selected</c:if>>마포구</option>
								<option value="영등포구"
									<c:if test="${dto.cafeLocation eq '영등포구'}">selected</c:if>>영등포구</option>
								<option value="강남구"
									<c:if test="${dto.cafeLocation eq '강남구'}">selected</c:if>>강남구</option>
								<option value="강동구"
									<c:if test="${dto.cafeLocation eq '강동구'}">selected</c:if>>강동구</option>
							</select>
						</div>
						<div class="col-md-9 mb-3">
							<div class="mb-3">
								<label for="cafeDetail" class="form-label fw-bold">카페설명</label>
								<textarea class="form-control" id="cafeDetail" name="cafeDetail"
									rows="7">${dto.cafeDetail}</textarea>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="cafeImg" class="form-label fw-bold">카페이미지 추가</label>
							<input class="form-control" type="file" id="cafeImg"
								name="cafeImg" multiple>
							<div id="nineMust" class="invalid-feedback">9장
								이하만 등록 가능합니다</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="car" class="fw-bold">주차가능여부</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="parkingCheck1"> 가능
								</label> <input class="form-check-input" type="radio"
									name="parkingCheck" id="parkingCheck1" value="Y"
									<c:if test="${dto.parkingCheck eq 'Y'}">checked</c:if>>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="parkingCheck"
									id="parkingCheck2" value="N"
									<c:if test="${dto.parkingCheck eq 'N'}">checked</c:if>>
								<label class="form-check-label" for="parkingCheck2"> 불가
								</label>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="petCheck1" class="fw-bold">애완동반가능여부</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="petCheck1">
									가능 </label> <input class="form-check-input" type="radio"
									name="petCheck" id="petCheck1" value="Y"
									<c:if test="${dto.petCheck eq 'Y'}">checked</c:if>>

							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="petCheck"
									id="petCheck2" value="N"
									<c:if test="${dto.petCheck eq 'N'}">checked</c:if>> <label
									class="form-check-label" for="petCheck2"> 불가 </label>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="child" class="fw-bold">유아동반가능여부</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="childCheck1"> 가능 </label> <input
									class="form-check-input" type="radio" name="childCheck"
									id="childCheck1" value="Y"
									<c:if test="${dto.childCheck eq 'Y'}">checked</c:if>>

							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="childCheck"
									id="childCheck2" value="N"
									<c:if test="${dto.childCheck eq 'N'}">checked</c:if>> <label
									class="form-check-label" for="childCheck2"> 불가 </label>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="roof" class="fw-bold">루프탑유무</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="rooftopCheck1"> 있음
								</label> <input class="form-check-input" type="radio"
									name="rooftopCheck" id="rooftopCheck1" value="Y"
									<c:if test="${dto.rooftopCheck eq 'Y'}">checked</c:if>>

							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="rooftopCheck"
									id="rooftopCheck2" value="N"
									<c:if test="${dto.rooftopCheck eq 'N'}">checked</c:if>>
								<label class="form-check-label" for="rooftopCheck2"> 없음
								</label>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="ds" class="fw-bold">단체석유무</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="groupCheck1"> 있음 </label> <input
									class="form-check-input" type="radio" name="groupCheck"
									id="groupCheck1" value="Y" <c:if test="${dto.groupCheck eq 'Y'}">checked</c:if>>

							</div>
							<div class="form-check form-check-inline">
							<label class="form-check-label" for="groupCheck2"> 없음 </label>
								<input class="form-check-input" type="radio" name="groupCheck"
									id="groupCheck2" value="N" <c:if test="${dto.groupCheck eq 'N'}">checked</c:if>> 
							</div>
						</div>
						<hr />
						<h4 class="fw-bold">등록이미지 삭제</h4>
						<div class="col-md-12">
							<div class="row row-col-3 ps-2 d-flex justify-content-center">
								<c:forEach items="${dto.maparr}" var="maps">
									<c:if test="${maps ne null}">
										<div class="col-4 p-1 imagego"
											style="width: 150px; height: 145px">
											<i class="marks bi bi-x-square position-absolute p-0"
												style="margin-left: 95px; font-size: 2.5rem; cursor: pointer;"></i>
											<i title="${maps.fileIdx}"
												class="marks2 visually-hidden bi bi-x-square-fill position-absolute p-0"
												style="margin-left: 95px; font-size: 2.5rem; cursor: pointer;"></i>
											<img title="${maps.fileIdx}" src="/Project/assets/img/12.jpg"
												class="rounded h-100 w-100 imgUpdate"
												style="object-fit: cover;" />
										</div>
									</c:if>
								</c:forEach>
								<div class="col-4 p-1 imagego"
											style="width: 150px; height: 145px">
											<i class="marks bi bi-x-square position-absolute p-0"
												style="margin-left: 95px; font-size: 2.5rem; cursor: pointer;"></i>
											<i 
												class="marks2 visually-hidden bi bi-x-square-fill position-absolute p-0"
												style="margin-left: 95px; font-size: 2.5rem; cursor: pointer;"></i>
											<img src="/Project/assets/img/12.jpg"
												class="rounded h-100 w-100 imgUpdate"
												style="object-fit: cover;" />
										</div>
								
							</div>
						</div>
						<div id="redalert"
					class="alert alert-danger d-flex align-items-center visually-hidden"
					role="alert">
					<svg class="bi flex-shrink-0 me-2 " width="24" height="24"
						role="img" aria-label="Danger:">
						<use xlink:href="#exclamation-triangle-fill" /></svg>
					<div>이미지는 한장 이상 있어야 합니다</div>
				</div>
						<div class="col text-center">
							<button id = "cafeUpdateBtn"class="btn btn-dark mt-2" type="button">카페수정</button>
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
		$('.imgUpdate').mouseover(function() {
		$(this).attr('style','width: 150px; height: 140px; object-fit: cover; cursor: pointer;');
		$(this).prevAll('.marks').addClass("visually-hidden");
		$(this).prevAll('.marks2').removeClass("visually-hidden");
						});
		$('.imgUpdate').mouseleave(function() {
		$(this).attr('style','width: 150px; height: 140px; object-fit: cover;');
		$(this).prevAll('.marks').removeClass("visually-hidden");
		$(this).prevAll('.marks2').addClass("visually-hidden");
				});
		$('.marks').mouseover(function() {
			$(this).addClass("visually-hidden");
			$(this).next().removeClass("visually-hidden");
		});
		$('.marks').mouseleave(function() {
			$(this).removeClass("visually-hidden");
			$(this).next().addClass("visually-hidden");
		});
		var arr = [];
		$('.imgUpdate').click(function() {
			arr.push($(this).attr("title"));
			$(this).parent('div').detach();
		})
		$('.marks2').click(function() {
			arr.push($(this).attr("title"));
			$(this).parent('div').detach();
		})
		$('#cafeImg').change(function() {
			if ($(this)[0].files.length > 9) {
				$(this).attr("class", "form-control is-invalid");
			} else {
				$(this).attr("class", "form-control");
			}
		})
		$("#cafeUpdateBtn").click(function(){
							$('.nullcheckgo').each(function() {
								if ($(this).val() == "") {
									$(this).addClass("is-invalid");
								}
							})
							if($('#cafeImg')[0].files.length==0&&!$('.imagego').length){
								$('#redalert').removeClass("visually-hidden");
								var imagecheck = false;
							}else{
								imagecheck = true;
							}
							if ($("#cafeName").attr("class") == "form-control nullcheckgo"
						&& $("#cafeAddress").attr("class") == "form-control nullcheckgo"
						&& $("#cafePhone").attr("class") == "form-control nullcheckgo"
						&& $("#cafeTime").attr("class") == "form-control nullcheckgo"
						&& imagecheck == true) 
							{ Swal.fire({
									  title: '정말 이대로 수정하시겠습니까?',
									  text: "",
									  icon: 'question',
									  showDenyButton: true,
									  confirmButtonColor: '#000',
									  confirmButtonText: '수정하기',
									  denyButtonText: '취소'
									}).then((result) => {
										var formData = new FormData();
										var cafeImg = $("input[name='cafeImg']");
										var files = cafeImg[0].files;
										formData.append('cafeName', $("input[name='cafeName']").val());
										formData.append('cafeLocation', $("select[name='cafeLocation']").val());
										formData.append('cafeAddress', $("input[name='cafeAddress']").val());
										formData.append('cafePhone', $("input[name='cafePhone']").val());
										formData.append('cafeDetail', $("textarea[name='cafeDetail']").val());
										formData.append('parkingCheck', $("input[name='parkingCheck']:checked").val());
										formData.append('petCheck', $("input[name='petCheck']:checked").val());
										formData.append('childCheck', $("input[name='childCheck']:checked").val());
										formData.append('rooftopCheck', $("input[name='rooftopCheck']:checked").val());
										formData.append('groupCheck', $("input[name='groupCheck']:checked").val());
										for (var i = 0; i < files.length; i++) {
											formData.append("cafeImg", files[i]);
										}
										for (var i = 0; i < arr.length; i++) {
											formData.append("fileIdx", arr[i]);
										}
										$.ajax({
											type : "POST",//방식
											url : "./cafeUpdate",//주소
											data : formData,
											contentType : false,
											processData : false,
											dataType : 'JSON',
											success : function(data) {
												console.log(data);
											},
											error : function(e) {//실패시
												console.log(e);
											}
										})
									})
							}
		})
		$(".nullcheckgo").on("propertychange change keyup paste input", function() {
		if ($(this).val().length >= 1) {
			$(this).attr("class", "form-control");
		}
		else {
			$(this).attr("class", "form-control is-invalid");
		}
	});
	
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=95"></script>
</body>
</html>