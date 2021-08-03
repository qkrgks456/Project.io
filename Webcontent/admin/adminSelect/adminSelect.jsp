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
				<!-- 오른쪽내용 -->
				<div class="cont container-fluid mx-5 py-5">
					<!-- 회원정보 탭(여닫기) -->
					<div class="d-flex align-items-center">
						<button type="button" id="sidebarCollapse"
							class="me-2 btn btn-secondary">
							<i class="bi bi-text-left"></i>
						</button>
						<h2 class="fw-bold my-3">관리자 임명</h2>
					</div>
					<hr />
					<!-- 아래 내용 -->
					<div class="cont container">
						<form id="adminSelectform" action="/Project/adminSelect"
							method="post">
							<!-- 셀렉/text/검색 3개 -->
							<div class="row mb-1">
								<!-- 셀렉트 -->
								<div class="form-group col-2 m-0 p-0">
									<select class="form-select" name="adminSearchSelect">
										<option value="name" selected>이름</option>
										<option value="memberkey">아이디</option>
										<option value="email">이메일</option>
									</select>
								</div>
								<!-- 검색/버튼 -->
								<div class="col-10 m-0 p-0">
									<!-- 왼쪽으로 당기기 -->
									<div class="row">
										<!-- 검색 공간 -->
										<div class="form-group col-10 mp-0 me-0">
											<input type="text" class="form-control" id="adminSelect"
												name="adminSelect" /> <input type="hidden"
												class="form-control" id="adminSelectSession"
												name="adminSelectSession" value="${sessionScope.loginId}" />
										</div>
										<!-- 검색 버튼 공간 -->
										<div class="form-group col-2 p-0 m-0">
											<button class="btn btn-dark" type="submit">검색</button>
										</div>
									</div>
								</div>
							</div>
						</form>

						<!-- 출력 부분  -->
						<div class="row mb-1">
							<table class="table table-bordered mt-4">
								<tr>
									<th class="center">아이디</th>
									<th>이름</th>
									<th>이메일</th>
									<th>성별</th>
									<th>비고</th>
								</tr>
								<c:if test="${empty adminSelect}">
									<tr>
										<td colspan="6">해당 데이터가 존재하지 않습니다.</td>
									</tr>
								</c:if>
								<!-- 검색 리스트 출력 -->
								<c:if test="${!empty adminSelect}">
									<c:forEach items="${adminSelect}" var="selectMember">
										<tr>
											<td class="align-middle">${selectMember.memberkey}</td>
											<td class="align-middle">${selectMember.name}</td>
											<td class="align-middle">${selectMember.email}</td>
											<td class="align-middle">${selectMember.gender}</td>
											<td class="align-middle">
												<button class="btn btn-dark"
													onclick="location.href='/Project/memberAppoint?memberKey=${selectMember.memberkey}&sessionId=${sessionScope.loginId}'">임명</button>
											</td>
										</tr>
									</c:forEach>
								</c:if>
							</table>
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
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
</html>