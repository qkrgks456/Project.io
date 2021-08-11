<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<link href="/Project/assets/css/bootstrap.css?ver=8" rel="stylesheet">
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<link href="/Project/assets/css/main.css?ver=3" rel="stylesheet">
<title>카페</title>
</head>
<body>
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
	<div class="wrap">
			<div class="container px-4 py-4 my-4 border shadow-lg" id="cont">
				<h4 class="mb-3 fw-bold">회원가입</h4>
				<hr />
				<form action="/Project/signup" method="post"
					class="needs-validation" novalidate>
					<div class="form-floating col-md-9 mb-3">
						<input type="text" class="form-control" name="UserId"
							id="UserId" placeholder="아이디" value="" required> <label
							for="validationTooltip01" class="fw-bold">아이디</label>
							<div id="check1" class="invalid-feedback">중복확인을 다시 해주세요</div>
							<div id="check2" class="invalid-feedback visually-hidden">필수 정보입니다(100자 이하만 가능)</div>
						<input type="button" class="btn btn-dark btn-sm mt-2" id="ckBtn"
							value="중복확인">
						<!-- 중복확인 끝 -->
						<p class="visually-hidden text-success mt-1" id="pass">"사용가능합니다"</p>
						<p class="visually-hidden text-danger mt-1" id="fail">"사용불가"</p>
					</div>
					<div class="form-floating col-md-9 mb-3">
						<input type="password" class="nullchecks form-control"
							name="UserPw" id="UserPw" placeholder="비밀번호" value="" required>
						<label for="validationTooltip02" class="fw-bold">비밀번호</label>
						<div class="invalid-feedback">10자 이상 입력해주세요</div>
					</div>
					<div class="form-floating col-md-9 mb-3">
						<input type="password" class="form-control" id="UserPwch"
							name="UserPwch" placeholder="비밀번호확인" value="" required> <label
							for="validationTooltip02" class="fw-bold">비밀번호확인</label>
						<div class="invalid-feedback">동일한지 확인해주세요</div>
					</div>
					<div class="form-floating col-md-9 mb-3">
						<input type="text" class="nullchecks nullcheck form-control"
							id="UserName" name="UserName" placeholder="이름" required>
						<label for="validationTooltip04" class="fw-bold">이름</label>
						<div class="invalid-feedback">필수 정보입니다</div>
					</div>
					<div class="form-floating col-md-9 mb-3">
						<input type="text" class="nullchecks nullcheck form-control"
							id="UserEmail" name="UserEmail" placeholder="이름" required>
						<label for="validationTooltip04" class="fw-bold">이메일</label>
						<div class="invalid-feedback">필수 정보입니다</div>
					</div>

					<div class="form-floating col-md-9 mb-3">
						<input type="text" class="nullchecks nullcheck form-control"
							id="UserAddress" name="UserAddress" placeholder="주소" required>
						<label for="validationTooltip03" class="fw-bold">주소</label>
						<div class="invalid-feedback">필수 정보입니다</div>
					</div>
					<div class="col-md-9 mb-3">
						<h6 class="fw-bold ">지역구선택 (해당지역 카페를 추천해드립니다)</h6>
						<select class="form-select" name="userLocation">
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
						<label for="validationTooltip05" class="fw-bold">성별</label>
						<div class="form-check form-check-inline mx-3">
							<label class="form-check-label" for="flexRadioDefault1">
								남 </label> <input class="form-check-input" type="radio" value="남"
								name="genderradio" id="genderradio1" checked>

						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="genderradio"
								value="여" id="genderradio2"> <label
								class="form-check-label" for="flexRadioDefault2"> 여 </label>
						</div>
					</div>
					<div class="col-md-9 mb-3">
						<label for="validationTooltip05" class="fw-bold">이메일 수신</label>
						<div class="form-check form-check-inline mx-3">
							<label class="form-check-label" for="flexRadioDefault1">
								동의 </label> <input class="form-check-input" type="radio" value="Y"
								name="emailradio" id="emailradio1" checked>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="emailradio"
								value="N" id="emailradio2"> <label
								class="form-check-label" for="flexRadioDefault2"> 거부 </label>
						</div>
					</div>
					<div class="col-md-9 mb-3">
						<label for="validationTooltip05" class="fw-bold">혼잡도 알림 여부</label>
						<div class="form-check form-check-inline mx-3">
							<label class="form-check-label" for="alertradio"> 동의 </label> <input
								class="form-check-input" type="radio" name="alertradio"
								id="alertradio1" value="Y" checked>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="alertradio"
								id="alertradio2" value="N"> <label
								class="form-check-label" for="alertradio2"> 거부 </label>
						</div>
					</div>

					<hr />
					<div class="col text-center">
						<input class="btn btn-dark" type="button" id="signupbtn"
							value="가입하기">
					</div>
				</form>
			</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 cdn  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<script>
	
	$('#ckBtn').click(function(){
	var userId=$('#UserId').val().trim();
		console.log(userId);
		if(userId != ""&&userId.length<=100){
			$('#check2').addClass('visually-hidden');
			$('#check1').removeClass('visually-hidden');
			$.ajax({
	            type : "POST",//방식
	            url : "/Project/signupcheck",//주소
	            data : {
	            	userId : userId
	            },
	            dataType : 'JSON',
	            success : function(data) { //성공시
	               console.log(data);   
	            	if(data.suc){
	            		$('#pass').addClass("visually-hidden");
	            	   $('#fail').removeClass("visually-hidden");
	            	   $('#UserId').removeClass("is-valid");
	            	   $('#UserId').addClass("is-invalid");      	  
	            	}else{
	            		$('#pass').removeClass("visually-hidden");
	             	   $('#fail').addClass("visually-hidden");
	             	  $('#UserId').removeClass("is-invalid");
	             	  $('#UserId').addClass("is-valid");   
	             	 $('#UserId').attr('readonly',true)
	            	}
	            },
	            error : function(e) { //실패시
	               console.log(e);
	            }
	         });
		}else{
			$('#check2').removeClass('visually-hidden');
			$('#check1').addClass('visually-hidden');
			 $('#UserId').addClass("is-invalid"); 
		}
	})	
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=56"></script>
</body>

</html>