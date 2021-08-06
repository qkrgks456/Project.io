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
			<jsp:include page="../myPagesideBar.jsp"></jsp:include>
			<!-- 오른쪽 시작 -->
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">비밀번호변경</h2>
				</div>
				<hr />
				<div class="cont container w-50">
					<!-- 내 정보 수정 폼 -->
					<!--  구상.. 내정보수정을 입력하면->비밀번호 변경하라는 페이지로 이동해서 수정을 ? -->
					<form id="myinfoforms" action="/Project/passwordFind" method="post"
						class="needs-validation py-3" novalidate>
						<div class="text-center">
							<h3 class="fw-bold">본인확인</h3>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<input type="text" class="nullchecks form-control" id="UserIds"
								name="UserId" placeholder="아이디" value="" required> <label
								for="validationTooltip02" class="fw-bold">아이디</label>
							<div class="invalid-feedback">필수 정보 입니다</div>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<input type="password" class="nullchecks form-control"
								id="UserPws" name="UserPw" placeholder="비밀번호" value="" required>
							<label for="validationTooltip02" class="fw-bold">비밀번호</label>
							<div class="invalid-feedback">필수 정보 입니다</div>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<input type="password" class="form-control" id="UserPwchs"
								name="UserPwch" placeholder="비밀번호확인" value="" required>
							<label for="validationTooltip02" class="fw-bold">비밀번호확인</label>
							<div class="invalid-feedback">동일한지 확인해주세요</div>
						</div>
						<div class="text-center">
							<input id="infochangecheck" class="btn btn-dark" type="button"
								value="확인">
							<c:if test="${pwfindsuc eq 'false'}">
								<div id="redalert"
									class="mt-2 alert alert-danger d-flex align-items-center"
									role="alert">
									<svg class="bi flex-shrink-0 me-2" width="24" height="24"
										role="img" aria-label="Danger:">
						<use xlink:href="#exclamation-triangle-fill" /></svg>
									<div>정보를 확인해주세요</div>
								</div>
							</c:if>
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
		$('#infochangecheck').click(function() {  //button id값 infochangecheck에 .clcik(기능)을 넣어준다
			console.log($('#UserIds').val().trim()); // val().=value() 의 줄임말
			if($('#UserIds').val().trim()==""){ //userIds의 값을 가져온다 . ""(공백)이면 . trim (잘라준다)
				console.log("dk"); //콘솔에 dk을 출력 
				$('#UserIds').attr('class','nullchecks form-control is-invalid');
				//userIds에 클래스 속성에 nullchecks form-control is-invalid 을 추가해준다.
			}
			if($('#UserPws').val().trim()==""){ //UserPws의 val=값에 "" 이면 트림 
				
				$('#UserPws').attr('class','nullchecks form-control is-invalid');
			//UserPws 클래스 속성에 nullchecks form-control is-invalid 를 추가해준다.
			}	if($('#UserPwchs').val().trim()==""){
				//UserPwchs에 value=값이 "" 이면 트림 
				$('#UserPwchs').attr('class','form-control is-invalid');
				//UserPwchs의 클래스속성에 form-control is-invalid 를 추가해준다.
			}
			
							if ($('#UserIds').attr('class') == 'form-control is-valid'
									// 만약 UserIds의  클래스 속성에 form-control is-valid 이라면! 
									&& $('#UserPws').attr('class') == 'form-control is-valid'
									//&& 그리고 UserPws의 클래스속성이  form-control is-valid 이고
									&& $('#UserPwchs').attr('class') == 'form-control is-valid') {
								// &&= 그리고 UserPwchs의 클래스 속성에 form-control is-valid 이다 .
								console.log("안녕"); 
								//콘솔에 안녕을 찍어준다.
								$(this).attr('type', 'submit');
								//inforchange 요소에 type 속성을 추가하고 속성의 값은 submit으로 적용합니다.		
							}
						})

		$("#UserPwchs").on("propertychange change keyup paste input",function() {
					if ($("#UserPws").val() == $(this).val()) {
						$(this).attr("class", "form-control is-valid");
					} else {
						$(this).attr("class", "form-control is-invalid");
					}
				});
	</script>
</body>
</html>