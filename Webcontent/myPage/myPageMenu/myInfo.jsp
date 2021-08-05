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
<link href="/Project/assets/css/main.css?ver=9" rel="stylesheet">
<title>카페</title>
<style type="text/css">

footer {
	margin-top : 80px;
	height: 80px;
	position: relative;
	transform: translateY(-100%);
	background-color: black;
}
</style>
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
					<h2 class="fw-bold my-3">내정보</h2>
				</div>
				<hr />
				<div class="cont container w-50">
					<!-- 내 정보 수정 폼 -->			
					<form id="myinfoform" action="/Project/memberupdate" method="post" 
						class="needs-validation py-3" novalidate>					
						<div class="form-floating col-md-9 mb-3">
						<input type="text" class="nullchecks form-control" value="${dto.name}"
							title="${updateSuc}" id="UserName" name="UserName" placeholder="이름" required> <label
							for="validationTooltip04" class="fw-bold">이름</label>
						<div class="invalid-feedback">필수 정보입니다</div>
					</div>
						
						<div class="form-floating col-md-9 mb-3">
							<input type="text" class="nullchecks form-control" id="UserEmail" name="UserEmail"
								placeholder="이메일" value="${dto.email}"
								aria-describedby="validationTooltipUsernamePrepend" required>
							<label for="validationTooltipUsername" class="fw-bold">이메일</label>
							<div class="invalid-feedback">필수 정보입니다</div>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<input type="text" class="nullchecks form-control" id="UserAddress" name="UserAddress" value="${dto.address}"
								placeholder="주소" required> <label
								for="validationTooltip03" class="fw-bold">주소</label>
							<div class="invalid-feedback">필수 정보입니다</div>
						</div>
						
						<div class="col-md-9 mb-3">
						<h6 class="fw-bold " >지역구선택 (해당지역 카페를 추천해드립니다)</h6>
						<select class="form-select" name="select" >
							<option value="도봉구" <c:if test="${dto.location eq '도봉구'}">selected</c:if>>도봉구</option>
							<option value="강북구" <c:if test="${dto.location eq '강북구'}">selected</c:if>>강북구</option>
							<option value="노원구" <c:if test="${dto.location eq '노원구'}">selected</c:if>>노원구</option>
							<option value="중랑구" <c:if test="${dto.location eq '중랑구'}">selected</c:if>>중랑구</option>
							<option value="성북구" <c:if test="${dto.location eq '성북구'}">selected</c:if>>성북구</option>
							<option value="종로구" <c:if test="${dto.location eq '종로구'}">selected</c:if>>종로구</option>
							<option value="중구" <c:if test="${dto.location eq '중구'}">selected</c:if>>중구</option>
							<option value="용산구" <c:if test="${dto.location eq '용산구'}">selected</c:if>>용산구</option>
							<option value="서대문구" <c:if test="${dto.location eq '서대문구'}">selected</c:if>>서대문구</option>
							<option value="마포구" <c:if test="${dto.location eq '마포구'}">selected</c:if>>마포구</option>
							<option value="영등포구" <c:if test="${dto.location eq '영등포구'}">selected</c:if>>영등포구</option>
							<option value="강남구" <c:if test="${dto.location eq '강남구'}">selected</c:if>>강남구</option>
							<option value="강동구" <c:if test="${dto.location eq '강동구'}">selected</c:if>>강동구</option>
						</select>
					</div>
						<div class="col-md-9 mb-3">
							<label for="checks" class="fw-bold" id="emailsusin" name="emailsusin" >이메일 수신</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="emailcheckchange1">
									동의 </label> <input class="form-check-input" type="radio" value="Y"
									name="emailcheckchange" id="emailcheckchange1"<c:if test="${dto.emailCheck eq 'Y'}">checked</c:if>>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"  
									name="emailcheckchange" id="emailcheckchange2" value="N" <c:if test="${dto.emailCheck eq 'N'}">checked</c:if>> <label
									class="form-check-label" for="emailcheckchange2"> 거부 </label>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<label for="checks" class="fw-bold" id ="congestionCheck" name="congestionCheck" >혼잡도 알림 여부</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="alertradiochange1">
									동의 </label> <input class="form-check-input" type="radio"
									name="alertradiochange" id="alertradiochange1" value="Y" <c:if test="${dto.congestionCheck eq 'Y'}">checked</c:if>>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="alertradiochange" id="alertradiochange2" value="N" <c:if test="${dto.congestionCheck eq 'N'}">checked</c:if>> <label
									class="form-check-label" for="alertradiochange2" > 거부 </label>
							</div>
						</div>
						<hr />
						<div class="col text-center">
							<button id="infochange" class="btn btn-dark" type="submit"  >정보수정</button>
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
	<script src="/Project/assets/js/main.js?var=8"></script>
	<script type="text/javascript">
	console.log($('#UserName').attr('title'));
			
	if($('#UserName').attr('title')!=""){
		Swal.fire({
			title: '정보수정완료',
			 icon: 'success',
			 confirmButtonColor: '#000',
			 confirmButtonText: '확인',
	})
	}

	</script>
</body>
</html>