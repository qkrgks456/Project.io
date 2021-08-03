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
<link href="/Project/assets/css/main.css?ver=65" rel="stylesheet">
<title>카페</title>
</head>
<body>
	<div class="wrap">
		<!-- 상단 메뉴바 -->
		<c:set var="loginId">${sessionScope.loginId}</c:set>
		<!-- 섹션에 아이디가 있다면 -->
		<c:if test="${loginId!=''}">
			<jsp:include page="/fixMenu/loginnav.jsp"></jsp:include>
		</c:if>
		<!-- 섹션에 아이디가 없다면 -->
		<c:if test="${loginId==''}">
			<jsp:include page="/fixMenu/navbar.jsp"></jsp:include>
		</c:if>
		<!-- 들어갈 내용 -->
		<div class="container px-5 mt-5 my-2">
			<div class="row">
				<div class="d-flex">
					<p class="fw-bold mt-4 h1" id="cafename">${map.cafeName}</p>
					<div class="col d-flex justify-content-end mt-4">
						<div class="d-inline-flex justify-content-end"
							style="height: 42px;">
							<button class="btn btn-secondary"
								onclick="location.href='/Project/cafeList?page=${map.cafePages}'">리스트</button>
						</div>
					</div>
				</div>
				<hr />
			</div>
			<div class="container px-5 mt-3">
				<div class="row">
					<div class="col-md-6">
						<img src="/photo/${map.mainImage}"
							class="rounded img-fluid float-end"
							style="width: 450px; height: 435px; object-fit: cover;"
							id="mainimg" />
					</div>
					<div class="col-md-6">
						<div class="row row-col-3 d-float">
							<c:forEach items="${map.fileList}" var="fileLists">
								<div class="col-4 p-1" style="width: 150px; height: 145px">
									<img src="/photo/${fileLists}"
										class="visually-hidden rounded imgs h-100 w-100"
										style="object-fit: cover;" />
								</div>
							</c:forEach>
						</div>
					</div>
				</div>

			</div>
			<!--카페 상세정보 테이블-->
			<div class="container px-5 mt-4">
				<h3 class="fw-bold">정보</h3>
				<hr />

				<div class="container px-5 mt-4">
					<div class="row">
						<c:if test="${loginId!=''}">
							<div class="col-md-3 d-flex justify-content-center">
								<div id="good" class="d-inline-flex align-items-center"
									style="cursor: pointer;">
									<i id="goodicon" class="bi bi-hand-thumbs-up-fill"
										title="${map.goodCheck}" style="font-size: 2.0rem;"></i>
									<p id="goodtext" class="ms-2 mt-3 fw-bold">좋아요(${map.goodCount})</p>
								</div>
							</div>
						</c:if>
						<c:if test="${loginId==''}">
							<div class="col-md-3 d-flex justify-content-center">
								<div id="goodq" class="d-inline-flex align-items-center"
									style="cursor: default;">
									<i id="goodiconq" class="bi bi-hand-thumbs-up-fill"
										title="${map.goodCheck}" style="font-size: 2.0rem;"></i>
									<p id="goodtextq" class="ms-2 mt-3 fw-bold">좋아요(${map.goodCount})</p>
								</div>
							</div>
						</c:if>
						<div class="col-md-3 d-flex justify-content-center">
							<div id="commenticon" class="d-inline-flex align-items-center"
								style="cursor: pointer;">
								<i id="commenticons" class="bi bi-chat-square-text-fill mt-1"
									style="font-size: 2.0rem;"></i>
								<p class="ms-2 mt-3 fw-bold">댓글(${map.commentCount})</p>
							</div>
						</div>
						<div class="col-md-3 p-0 d-flex justify-content-center">
							<div id="commenticon" class="d-inline-flex align-items-center"
								style="cursor: default">
								<i id="commenticons" class="bi bi-sunglasses mt-1"
									style="font-size: 2.2rem;"></i>
								<p class="ms-2 mt-3 fw-bold">조회수(${map.bHit})</p>
							</div>
						</div>
						<div class="col-md-3 d-flex justify-content-center">
							<c:if test="${map.confusion eq '혼잡'}">
								<div id="commenticon" class="d-inline-flex align-items-center"
									style="cursor: default">
									<i id="commenticons" class="bi bi-people-fill mt-1 text-danger"
										style="font-size: 2.0rem;"></i>
									<p class="ms-2 mt-3 fw-bold text-danger">혼잡도(혼잡)</p>
								</div>
							</c:if>
							<c:if test="${map.confusion eq '보통'}">
								<div id="commenticon" class="d-inline-flex align-items-center"
									style="cursor: default">
									<i id="commenticons" class="bi bi-people-fill mt-1 text-dark"
										style="font-size: 2.0rem;"></i>
									<p class="ms-2 mt-3 fw-bold text-dark">혼잡도(보통)</p>
								</div>
							</c:if>
							<c:if test="${map.confusion eq '쾌적'}">
								<div id="commenticon" class="d-inline-flex align-items-center"
									style="cursor: default">
									<i id="commenticons"
										class="bi bi-people-fill mt-1 text-success"
										style="font-size: 2.0rem;"></i>
									<p class="ms-2 mt-3 fw-bold text-success">혼잡도(쾌적)</p>
								</div>
							</c:if>
						</div>
					</div>
					<div class="row justify-content-md-center">
						<div class="col-sm-6 my-2 table-responsive h-100">
							<table class="table table-borderless my-2 ">
								<tbody class="">
									<tr class="row">
										<th class="col-sm-3">카페설명</th>
										<td class="col "><p class="text-break">${map.cafeDetail}</p></td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">주소</th>
										<td class="col">${map.cafeAddress}</td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">영업시간</th>
										<td class="col">${map.cafeTime}</td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">연락처</th>
										<td class="col">${map.cafePhone}</td>
									</tr>
									<tr class="row">
										<th class="col-sm-3">주차</th>
										<c:if test="${map.parkingCheck eq 'Y'}">
											<td class="col">가능</td>
										</c:if>
										<c:if test="${map.parkingCheck eq 'N'}">
											<td class="col">불가</td>
										</c:if>
									</tr>
									<tr class="row">
										<th class="col-sm-3">단체석</th>
										<c:if test="${map.groupCheck eq 'Y'}">
											<td class="col">유</td>
										</c:if>
										<c:if test="${map.groupCheck eq 'N'}">
											<td class="col">무</td>
										</c:if>
									</tr>
									<tr class="row">

										<th class="col-sm-3">루프탑</th>
										<c:if test="${map.rooftopCheck eq 'N'}">
											<td class="col">무</td>
										</c:if>
										<c:if test="${map.rooftopCheck eq 'Y'}">
											<td class="col">무</td>
										</c:if>
									</tr>
									<tr class="row">
										<th class="col-sm-3">유아동반</th>
										<c:if test="${map.childCheck eq 'Y'}">
											<td class="col">가능</td>
										</c:if>
										<c:if test="${map.childCheck eq 'N'}">
											<td class="col">불가</td>
										</c:if>
									</tr>
									<tr class="row">
										<th class="col-sm-3">반려동물동반</th>
										<c:if test="${map.petCheck eq 'Y'}">
											<td class="col">가능</td>
										</c:if>
										<c:if test="${map.petCheck eq 'N'}">
											<td class="col">가능</td>
										</c:if>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="col-sm-5 my-2 pt-3">
							<!-- 지도 -->
							<div id="map" class="border shadow"
								style="width: 100%; height: 350px;"></div>
						</div>
					</div>
				</div>
				<div>
					<h3 class="fw-bold">메뉴</h3>
					<hr />
					
					<div class="container px-5 my-2">
						<c:if test="${map.productList[0].productName ne null}">
						<table class="table table-hover mt-2">
							<thead class="">
								<tr>
									<th scope="col">상품이미지</th>
									<th scope="col">상품명</th>
									<th scope="col">상품설명</th>
									<th scope="col">가격</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${map.productList}" var="productLists">
								<tr class="">
									<td><img src="/photo/${productLists.newFileName}" class="rounded"
										style="width: 80px; height: 80px; object-fit: cover;" /></td>
									<td class="align-middle">${productLists.productName}</td>
									<td class="align-middle">${productLists.explanation}</td>
									<td class="align-middle">${productLists.price}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						</c:if>
					</div>
				</div>
				<div>
					<h3 class="fw-bold">판매상품</h3>
					<hr />
					<div class="container px-5 my-2">
					<c:if test="${map.sellProductList[0].productName ne null}">
						<table class="table table-hover mt-2">
							<thead class="">
								<tr>
									<th scope="col">상품이미지</th>
									<th scope="col">상품명</th>
									<th scope="col">상품설명</th>
									<th scope="col">가격</th>
									<th class="text-center" scope="col">상세보기</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${map.sellProductList}" var="sellProductLists">
								<tr class="">
									<td><img src="/photo/${sellProductList.newFileName}" class="rounded"
										style="width: 80px; height: 80px; object-fit: cover;" /></td>
									<td class="align-middle">${sellProductList.productName}</td>
									<td class="align-middle">${sellProductList.explanation}</td>
									<td class="align-middle">${sellProductList.price}</td>
									<td class="align-middle">
										<div class="d-grid gap-2 col-6 mx-auto mt-1">
											<a href="${sellProductList.productId}"class="btn btn-secondary btn-sm">상세보기</a>
										</div>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						</c:if>
					</div>
				</div>
				<h3 id="comments" class="fw-bold mt-3">댓글</h3>
				<hr />
				<c:if test="${loginId!=''}">
					<div class="d-flex align-items-center">
						<div class="form-floating flex-grow-1 px-2">
							<textarea class="form-control" placeholder="Leave a comment here"
								name="commentContent" id="commentContent"
								style="height: 100px; resize: none;"></textarea>
							<div class="invalid-feedback">1자 이상 입력해주세요</div>
							<label for="commentContent">${loginId}님, 이곳에 댓글을 작성하세요</label>
						</div>
						<a id="cafeCommentBtn" class="btn btn-secondary btn-sm"
							title="${map.cafeKey}">등록</a>
					</div>
				</c:if>
				<div id="commentLists" class="container px-5 py-4 my-4">
					<c:forEach items="${map.commentList}" var="commentLists">
						<div class="updateCheck">
							<p class="fw-bold">${commentLists.memberKey}</p>
							<p class="lh-sm">
								${commentLists.cm_content}
								<c:if test="${loginId ne commentLists.memberKey}">
									<a class="float-end btn btn-secondary btn-sm"
										href="/Project/report/report.jsp?commentNo=${commentLists.commentNo}">신고</a>
								</c:if>
								<c:if test="${loginId eq commentLists.memberKey}">
									<a id="commentDelBtn"
										class='commentDelBtn mx-2 float-end btn btn-secondary btn-sm'
										title="${commentLists.commentNo}">삭제</a>
									<a class='commentUpdateBtn float-end btn btn-secondary btn-sm'>수정</a>
								</c:if>
							</p>
							<hr />
						</div>
						<div class="updateForm visually-hidden" id="updateForm">
							<p class="fw-bold">${commentLists.memberKey}</p>
							<div class="form-floating flex-grow-1 px-2">
								<textarea class="commentUpdateContent form-control"
									placeholder="Leave a comment here" name="commentUpdateContent"
									id="commentUpdateContent" style="height: 100px; resize: none;">${commentLists.cm_content} </textarea>
								<label for="commentUpdateContent">수정할 댓글을 작성하세요</label>
								<div class="invalid-feedback">1자 이상 입력해주세요</div>
							</div>
							<div class="d-flex justify-content-end mt-2"
								id="commentUpdateOut">
								<a class='commentUpdateContentBtn btn btn-secondary btn-sm mx-2'
									id="commentUpdateContentBtn" title="${commentLists.commentNo}">등록</a>
								<a class='cmUpdateCancel btn btn-secondary btn-sm'>취소</a>
							</div>
							<hr />
						</div>
					</c:forEach>
				</div>
				<ul id="paginations" class="pagination justify-content-center">
					<c:if test="${map.startPage ne 1}">
						<li class="page-item"><a class="page-link pageNum"
							title="${map.startPage-1} ${map.cafeKey}" role="button"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
						<c:if test="${i ne map.currPage}">
							<li class="page-item"><a role="button"
								class="page-link pageNum" title="${i} ${map.cafeKey}">${i}</a></li>
						</c:if>
						<c:if test="${i eq map.currPage}">
							<li class="page-item active"><a class="page-link">${i}</a></li>
						</c:if>
					</c:forEach>
					<c:if test="${map.totalPage ne map.endPage}">
						<li class="page-item"><a class="page-link pageNum"
							role="button" title="${map.endPage+1} ${map.cafeKey}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<!-- 하단 고정 퀵메뉴 -->
	<c:if test="${sessionScope.loginId eq 'qkrgks456'}">
		<jsp:include page="/fixMenu/quickMenu.html"></jsp:include>
	</c:if>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=15"></script>
	<!-- cafe.js 추가 -->
	<script src="/Project/assets/js/cafe.js?var=45"></script>
	<!-- 카카오맵 api 추가 -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=96f67dd6c088728e30743d7db32a6789&libraries=services"></script>
	<script src="/Project/assets/js/map.js?var=10"></script>
</body>
</html>