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
							<h6 class="fw-bold ">지역구선택<br/> (해당지역에 맞는 손님에게 카페를 추천해드립니다)</h6>
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
							<label for="ownerNoImg" class="form-label fw-bold">사업자등록증 첨부(필수)
								</label> <input class="form-control" type="file" id="ownerNoImg"
								name="ownerNoImg">
							<div class="invalid-feedback">꼭 첨부해주세요</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="cafeImg" class="form-label fw-bold">카페이미지 첨부(필수)<br/>(9장이하만 등록 가능합니다)</label>
							<input class="form-control" type="file" id="cafeImg"
								name="cafeImg" multiple>
							<div id="oneMust" class="invalid-feedback visually-hidden">1장
								이상 꼭 등록해주세요</div>
							<div id="nineMust" class="invalid-feedback visually-hidden">9장
								이하만 등록 가능합니다</div>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<div class="mb-3">
								<label for="cafeDetail" class="form-label fw-bold">카페설명</label>
								<textarea class="form-control" id="cafeDetail" name="cafeDetail"
									rows="7"></textarea>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="car" class="fw-bold">주차가능여부</label>
							<div class="form-check form-check-inline mx-3">
								<input class="form-check-input" type="radio" name="parkingCheck"
									id="parkingCheck1" value="Y" checked> <label
									class="form-check-label" for="parkingCheck1"> 가능 </label>
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
								<input class="form-check-input" type="radio" name="rooftopCheck"
									id="rooftopCheck1" value="Y" checked> <label
									class="form-check-label" for="rooftopCheck1"> 있음 </label>

							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="rooftopCheck"
									id="rooftopCheck2" value="N"> <label
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
						<c:if test="${suc eq 0}">
						</c:if>
						<hr />
						<div class="col text-center">
							<button id="cafeInputbtn" class="btn btn-dark" type="button">카페등록</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<script type="text/javascript">
		$('#cafeImg').change(function() {
			if ($(this)[0].files.length > 9) {
				$("#nineMust").removeClass("visually-hidden");
				$("#oneMust").addClass("visually-hidden");
				$(this).attr("class", "form-control is-invalid");
			} else if ($(this)[0].files.length == 0) {
				$("#oneMust").removeClass("visually-hidden");
				$("#nineMust").addClass("visually-hidden");
				$(this).attr("class", "form-control is-invalid");
			} else {
				$(this).attr("class", "form-control is-valid");
			}
		})
		$('#ownerNoImg').change(function() {
			if ($(this)[0].files.length == 0) {
				$(this).attr("class", "form-control is-invalid");
			} else {
				$(this).attr("class", "form-control is-valid");
			}
		})
		$("#cafeInputbtn").click(function(){
							$('.nullchecks').each(function() {
								if ($(this).val() == "") {
									$(this).addClass("is-invalid");
								}
							})
							if ($("#cafeName").attr("class") == "form-control is-valid"
									&& $("#cafeAddress").attr("class") == "form-control is-valid"
									&& $("#cafePhone").attr("class") == "form-control is-valid"
									&& $("#cafeTime").attr("class") == "form-control is-valid"
									&& $("#ownerNo").attr("class") == "form-control is-valid"
									&& $("#ownerNoImg").attr("class") == "form-control is-valid"
									&& $("#cafeImg").attr("class") == "form-control is-valid") {
								Swal.fire({
									  title: '정말 이대로 등록하시겠습니까?',
									  text: "검수기간동안 다시 등록할 수 없습니다",
									  icon: 'question',
									  showDenyButton: true,
									  confirmButtonColor: '#000',
									  confirmButtonText: '등록하기',
									  denyButtonText: '취소'
									}).then((result) => {	
										if (result.isConfirmed) {
											var formData = new FormData();
											var ownerNoImg = $("input[name='ownerNoImg']");
											var cafeImg = $("input[name='cafeImg']");
											var filestwo = ownerNoImg[0].files;
											var files = cafeImg[0].files;
											formData.append('cafeName', $("input[name='cafeName']").val());
											formData.append('cafeLocation', $("select[name='cafeLocation']").val());
											formData.append('cafeAddress', $("input[name='cafeAddress']").val());
											formData.append('cafePhone', $("input[name='cafePhone']").val());
											formData.append('cafeTime', $("input[name='cafeTime']").val());
											formData.append('cafeDetail', $("textarea[name='cafeDetail']").val());
											formData.append('parkingCheck', $("input[name='parkingCheck']:checked").val());
											formData.append('petCheck', $("input[name='petCheck']:checked").val());
											formData.append('childCheck', $("input[name='childCheck']:checked").val());
											formData.append('rooftopCheck', $("input[name='rooftopCheck']:checked").val());
											formData.append('groupCheck', $("input[name='groupCheck']:checked").val());
											for (var i = 0; i < files.length; i++) {
												formData.append("cafeImg", files[i]);
											}
											for (var i = 0; i < filestwo.length; i++) {
												formData.append("ownerNoImg", filestwo[i]);
											}
											$.ajax({
												type: "POST",//방식
												url: "/Project/cafewrite",//주소
												data: formData,
												contentType: false,
												processData: false,
												dataType: 'JSON',
												success: function(data) {
													console.log(data);
													if (data.suc > 0) {
														location.href('/Project/myPage/cafeMenu/cafeInput/cafeInputResult.jsp')
													}else{
														console.log("실패지롱");
														Swal.fire(
																{
																	title: '등록실패',
																	icon: 'error',
																	confirmButtonColor: '#000',
																	text: '이미 카페가 등록되어 있습니다',
																	confirmButtonText: '확인',
																}
															).then((result) => {
																
														})
													}
												},
												error: function(e) {//실패시
													console.log(e);
												}
											})
										}
									})
							}
							if ($("#ownerNo").attr("class") == "form-control") {
								$("#ownerNo").addClass("is-invalid");
							}
							if ($('#cafeImg')[0].files.length > 9) {
								$('#cafeImg').addClass("is-invalid");
							} else if ($('#cafeImg')[0].files.length == 0) {
								$("#oneMust").removeClass("visually-hidden");
								$("#nineMust").addClass("visually-hidden");
								$('#cafeImg').addClass("is-invalid");
							}
							if ($('#ownerNoImg')[0].files.length == 0) {
								$('#ownerNoImg').addClass("is-invalid");
							}

						})

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
									$('#ownerNo').attr('class',
											'form-control is-valid');
								} else {
									$('#ownerNo').attr('class',
											'form-control is-invalid');
								}
							},
							error : function(e) { //실패시
								console.log(e);
							}
						});
					}
				})
		if ($('#failmodal').length) {
			var myModal = new bootstrap.Modal(document
					.getElementById('failmodal'), {
				keyboard : true
			})
			myModal.show();
		}
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=45"></script>
</body>
</html>