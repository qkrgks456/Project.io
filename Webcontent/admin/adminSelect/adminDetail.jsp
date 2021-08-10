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
<style>
	#authority{
		color:#ff0000;
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
		<!-- 사이드바 배치 -->
		<div class="d-flex" style="height: auto; min-height: 100vh;">
		<!-- 사이드바 불러오기 -->
			<jsp:include page="/admin/adminSideBar.jsp"></jsp:include>
			<div class="cont container-fluid mx-5 py-5">
			<!-- 여기부터 내용 넣으세요 -->
				<!-- 오른쪽내용 -->
			<div class="cont container-fluid mx-5 py-5">
				<!-- 회원정보 탭(여닫기) -->
					<div class="d-flex align-items-center">
						<button type="button" id="sidebarCollapse"
							class="me-2 btn btn-secondary">
							<i class="bi bi-text-left"></i>
						</button>
						<h2 class="fw-bold my-3">관리자 상세</h2>
					</div>
					<hr />
					
					<!-- 아래 내용 -->
					<!-- 관리자 상세 테이블 -->
					<div class="cont container">
					
					
					<div class = "col-md-9 mb-3"><!-- md 미디엄 -->
					
					<table class="table table-bordered mt-4">
						<tr>
							<th class="center" width="30%">아이디</th>
							<td class="align-middle" width="70%">${adminDetail.dto.memberkey}</td>
						</tr>
						<tr>
							<th class="center">이름</th>
							<td class="align-middle">${adminDetail.dto.name}</td>
						</tr>
						<tr>
							<th class="center">이메일</th>
							<td class="align-middle">${adminDetail.dto.email}</td>
						</tr>
						
						<tr>
							<th class="center">주소 </th>
							<td class="align-middle">${adminDetail.dto.address}</td>
						</tr>
						
						<tr>
							<th class="center">등급</th>
							<td class="align-middle">${adminDetail.dto.authority}</td>
						</tr>
					
					</table>
					<div>
					<c:if test="${adminDetail.success eq 2}">
						<a id="authority">"권한이 없습니다."</a>
					</c:if>

					</div>
					<form id="deleteauthorityForm" action="/Project/authorityDelete" method="post">
					<div class="form-group">
						<input class = form-control type="hidden" name = "sessionId" id= "sessionId" value="${sessionScope.loginId}">
						<input class = form-control type="hidden" name = "memberkey" id= "memberkey" value="${adminDetail.dto.memberkey}">
						<button id="deleteauthority" class="btn btn-dark" type="submit">권한 삭제</button>
						<button id="deleteauthority" class="btn btn-dark" type="button" onclick ="location.href='/Project/adminSearch'">리스트로</button>
					</div>
					</form>
					<c:if test="${adminDetail.success eq 1}">
					<script type="text/javascript">
					Swal.fire(
							{
								title: '권한 삭제완료',
								icon: 'success',
								confirmButtonColor: '#000',
								confirmButtonText: '확인',
							}
						)
						
					
					</script>
					</c:if>
					
					</div>
					</div>
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
	<script>
	$.ajax({
		type:'post',
		url:'/adminDetail',
		data:{},
		dataType:'JSON',
		success:function(data){
			console.log("관리자 권한이 있습니다.");
		},
		error: function(e){
			console.log("관리자 권한이 없습니다.");
		}
		
		
	});
	</script>
</body>
</html>