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
					<h2 class="fw-bold my-3">카페댓글</h2>
				</div>
				<hr />
				<!-- 내용시작 -->

				<div class="cont container">
					<c:if test="${cafeMypageCommetList[0] ne null}">
						<table class="table table-hover mt-2">
							<thead class="table-light">
								<tr>
									<th scope="col">카페명</th>
									<th scope="col">댓글내용</th>
									<th class="text-center" scope="col">상세보기</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${cafeMypageCommetList}" var="list">
									<tr>
										<td class="align-middle">${list.cafeName}</td>
										<td class="align-middle">${list.cm_content}</td>
										<td><button id="adminDetail" class="btn btn-dark"
												type="button"
												onclick="location.href='/Project/cafeDetail?cafeKey=${list.division}&pageCheck=cafeComment'">상세보기</button></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
					<c:if test="${cafeMypageCommetList[0] eq null}">
						<div class="text-center text-muted">작성한 댓글이 없습니다</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=60"></script>
</body>
</html>