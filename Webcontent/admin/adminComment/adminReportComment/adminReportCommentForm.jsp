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
				<!-- 여기부터 내용 넣으세요 -->
				<!-- adminReportCommentform -->
				<div class="cont container-fluid mx-5 py-5">
					<!-- 회원정보 탭(여닫기) -->
					<div class="d-flex align-items-center">
						<button type="button" id="sidebarCollapse"
							class="me-2 btn btn-secondary">
							<i class="bi bi-text-left"></i>
						</button>
						<h2 class="fw-bold my-3">신고처리</h2>
					</div>
					<hr />
					<div class="col-md-9 mb-3">
						<table class="table table-bordered mt-4">
							<tr>
								<th class="center">신고자 아이디</th>
								<td class="align-middle">${adminReportCommentform.cmReporter}</td>
							</tr>
							<tr>
								<th class="center">피신고자 아이디</th>
								<td class="align-middle">${adminReportCommentform.memberkey}</td>
							</tr>
							<tr>
								<th class="center">신고사유</th>
								<td class="align-middle">${adminReportCommentform.reportReason}</td>
							</tr>
						</table>

						<div class="mb-3">
							<form id="adminReportCmform" action="adminReportCmProcess"
								method="post" class="needs-validation py-3" novalidate>
								<label for="blackreason" class="form-label">신고처리 내용 작성</label>
								<textarea class="form-control" id="adminReportCmReason"
									name="adminReportCmReason" rows="2"></textarea>
								<input type="hidden" name="reportCmNo" id="reportCmNo"
									class="form-control" value="${adminReportCommentform.reportCmNo}">
								<input type="hidden" name="sessionId" id="sessionId"
									class="form-control" value="${sessionScope.loginId}">
								<button id="reportCmSubmit" class="btn btn-dark" type="submit">처리</button>
								<button id="reportCmList" class="btn btn-dark" type="button"
									onclick="location.href='admin/adminComment/adminReportComment/adminReportCommentList.jsp'">리스트로</button>
							</form>


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
</body>
</html>