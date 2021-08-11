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
<link href="/Project/assets/css/main.css?ver=10" rel="stylesheet">
<title>카페</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
		<div class="container px-4 my-4">
			<h2 class="fw-bold">상품 -> ${map.productName}</h2>
			<hr />
			<div class="card mb-3" style="max-width: 1250px;">
				<div class="row g-0">
					<div class="col-md-4">
						<img src="/photo/${map.newFileName}"
							class="img-fluid rounded-start" alt="...">
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<br>
							<h3 class="bold">${map.productName}</h3>
							<br>
							<p class="text-muted mt-2">
								${map.explanation}
							</p>
							<p class="text-muted bold">(200g 기준 판매)</p>


							<!-- 수량선택 셀렉트바  -->
							<br> <br>
							<h5 class="text-muted mt-2 fw-bold" style="text-align: left;">수량</h5>
							<form name="form1" method="post"
								action="/Project/cartinsert">
								<input type="hidden" name="productId" value="">
								<select name="quantity" id="quantity">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
								</select>&nbsp;개 <br> <br>
								<input type="hidden" name="productn"  id="productn" value="${param.productId}">
								<!-- 가격  -->
								<br>
								<h5 class="text-muted mt-2 fw-bold" style="text-align: left;">가격</h5>
								<input type="text" name="prc" id="prc" value="${map.price}" readonly>

								<h3>
								</h3>
								<br>
								<!-- 구매/장바구니 버튼 -->
								<div class="d-grid gap-2 d-md-flex justify-content-md-end">
									<button type="submit"
										class="btn btn-success btn-lg " value="장바구니에 담기">장바구니</button>
									&nbsp;&nbsp;&nbsp;
									<input type="button" id="purchasebtn"  class="btn btn-secondary btn-lg" style="float: right;" value="구매하기">
								</div>
							</form>
							<!-- 좋아요 댓글 -->
							<div class="position-absolute bottom-0 start-0">
								&nbsp;
								<div id="good" class="d-inline-flex align-items-left">
									<i id="" class=""
										style="font-size: 2.0rem;"></i> &nbsp;
									<p class=" ms-2 mt-3 fw-bold"></p>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<div id="" class="">
										
									
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	

	<!-- 댓글(카페상세 댓글 복붙) -->
	<div class="container px-4 my-4">
		<h3 id="comments" class="fw-bold mt-3">댓글</h3>
				<hr />
				<c:if test="${loginId==null}">
					<div class="d-flex align-items-center">
						<div class="form-floating flex-grow-1 px-2">
							<textarea class="form-control" placeholder="Leave a comment here"
								name="commentContent" id="commentContent"
								style="height: 100px; resize: none;"></textarea>
							<div class="invalid-feedback">1자 이상 입력해주세요.</div>
							<label for="commentContent">로그인 후 이용해주세요.</label>
						</div>
						
					</div>
				</c:if>
				
				<c:if test="${loginId != null}">
					<div class="d-flex align-items-center">
						<div class="form-floating flex-grow-1 px-2">
							<textarea class="form-control" placeholder="Leave a comment here"
								name="commentContent" id="commentContent"
								style="height: 100px; resize: none;"></textarea>
							<div class="invalid-feedback">1자 이상 입력해주세요.</div>
							<label for="commentContent">${loginId}님, 이곳에 댓글을 작성하세요</label>
						</div>
						<a type="button" id="proCommentBtn" class="btn btn-secondary btn-sm" title="${map.productid}">등록</a>
					</div>
				</c:if>
				
				<div id="commentLists" class="container px-5 py-4 my-4">
					<c:forEach items="${map.commentList}" var="commentLists">
						<div class="updateCheck">
							<p class="fw-bold">${commentLists.memberKey}</p>
							<p class="lh-sm">
								${commentLists.cm_content}
								<c:if test="${loginId ne commentLists.memberKey && sessionScope.loginId ne null}">
									<a class="float-end btn btn-secondary btn-sm"
										href="/Project/report/report.jsp?commentNo=${commentLists.commentNo}&memberKey=${commentLists.memberKey}&commentContent=${commentLists.cm_content}&cafeKey=${map.productId}">신고</a>
								</c:if>
								<c:if test="${loginId eq commentLists.memberKey}">
									<a id="commentDelBtn"
										class='commentDelBtn ms-2 float-end btn btn-secondary btn-sm'
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
							title="${map.startPage-1} ${map.productid}" role="button"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
						<c:if test="${i ne map.currPage}">
							<li class="page-item"><a role="button"
								class="page-link pageNum" title="${i} ${map.productid}">${i}</a></li>
						</c:if>
						<c:if test="${i eq map.currPage}">
							<li class="page-item active"><a class="page-link">${i}</a></li>
						</c:if>
					</c:forEach>
					<c:if test="${map.totalPage ne map.endPage}">
						<li class="page-item"><a class="page-link pageNum"
							role="button" title="${map.endPage+1} ${map.productid}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				</ul>
	</div>
</div>
	<!-- 하단 고정 퀵메뉴 -->
	<c:if test="${sessionScope.cafeInputCheck eq true}">
		<jsp:include page="/fixMenu/quickMenu.jsp"></jsp:include>
	</c:if>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6">
	
	</script>
	<script type="text/javascript">
	$(document).on('click', '#proCommentBtn', function() {
		var commentContent = $('#commentContent').val();
		var productn = $(this).attr('title');
			console.log(commentContent);
			if (commentContent.trim() != "") {
				$('#commentContent').removeClass('is-invalid');			
				$.ajax({
					type: 'POST',//방식
					url: '/Project/productiptcomment',//주소
					data: {
						commentContent: commentContent,
						productn : productn 
					},
					dataType: 'JSON',
					success: function(data) { //성공시
						commentList(data);
						$('#commentContent').val("");
					},
					error: function(e) { //실패시
						console.log(e);
					}
				});
			} else {
				$('#commentContent').addClass('is-invalid');
			}			
			
		})
		
		function commentList(data) {
		console.log(data);
		var content = "";
		var sessionId = data.sessionId;

		$.each(data.list, function(i, item) {
			var check = sessionId == item.memberKey;
			var checkT = sessionId
			content += "<div class='updateCheck'>"
			content += "<p class='fw-bold'>" + item.memberKey + "</p>";
			content += "<p class='lh-sm'>";
			content += item.cm_content;
			if (!check && checkT) {
				content += "<a href='/Project/report/report.jsp?commentNo="+item.commentNo+"&memberKey="+item.memberKey+"&commentContent="+item.cm_content+"&cafeKey="+data.cafeKey+"'"
				content += " class='float-end btn btn-secondary btn-sm'>신고</a>";
			}else if(check){
				content += "<a class='commentDelBtn mx-2 float-end btn btn-secondary btn-sm' title='" + item.commentNo + "'>삭제</a>";
				content += "<a class='commentUpdateBtn float-end btn btn-secondary btn-sm'>수정</a>";
			}
			
			content += "</p>";
			content += "<hr/>";
			content += "</div>";
			content += "<div class='updateForm visually-hidden'>"
			content += "<p class='fw-bold'>" + item.memberKey + "</p>"
			content += "<div class='form-floating flex-grow-1 px-2'>"
			content += "<textarea class='commentUpdateContent form-control' placeholder='Leave a comment here'"
			content += "name='commentUpdateContent' id='commentUpdateContent' style='height: 100px'>" + item.cm_content + "</textarea>"
			content += "<div class='invalid-feedback'>1자 이상 입력해주세요</div>"
			content += "<label for='commentUpdateContent'>수정할 댓글을 작성하세요</label>"
			content += "</div>"
			content += "<div class='d-flex justify-content-end mt-2' id='commentUpdateOut'>"
			content += "<a id='commentUpdateContentBtn' class='commentUpdateContentBtn btn btn-secondary btn-sm mx-2' title='" + item.commentNo + "'>등록</a>"
			content += "<a class='cmUpdateCancel btn btn-secondary btn-sm'>취소</a>"
			content += "</div>"
			content += "<hr />"
			content += "</div>"
		});
		$('#commentLists').empty();
		$('#commentLists').append(content);

	//	content = "";
	//	content += "<i id='commenticons' class='bi bi-chat-square-text-fill mt-1' style='font-size: 2.0rem;'></i>"
	//	content += "<p  class='ms-2 mt-3 fw-bold'>댓글(" + data.commentCount + ")</p>"
		$('#commenticon').empty();
		$('#commenticon').append(content);
		
		content = "";
		content += '<ul id="paginations1" class="pagination justify-content-center">'
		if (data.startPage != 1) {
			content += '<li class="page-item"><a class="page-link pageNum"'
			content += 'title="' + (data.startPage - 1) +" "+data.cafeKey+'" role="button"'
			content += 'aria-label="Previous"> <span aria-hidden="true">&laquo;</span>'
			content += '</a></li>'
		}
		for (var i = data.startPage; i <= data.endPage; i++) {
			console.log(data.currPage)
			if (data.currPage != i) {
				content += '<li class="page-item"><a role="button" class="page-link pageNum"'
				content += ' title="' + i + " " + data.cafeKey + '">' + i + '</a></li>'
			} else {
				content += '<li class="page-item active"><a class="page-link">' + i + '</a></li>'
			}
		}
		if (data.totalPage != data.endPage) {
			content += '<li class="page-item"><a class="page-link pageNum" role="button"'
			content += 'title="' + (data.endPage + 1)+" "+data.cafeKey+'" aria-label="Next">'
			content += '<span aria-hidden="true">&raquo;</span>'
			content += '</a></li>'
		}
		content += '</ul>'
		$('#paginations').empty();
		$('#paginations').prepend(content);
		
		
	}
	
	$(document).on('click', '.pageNum', function() {
		var pageAndCafeKey = $(this).attr('title');
		var pageArr = pageAndCafeKey.split(' ');
		var page = pageArr[0];
		var cafeKey = pageArr[1];
		$.ajax({
			type: "POST",//방식
			url: "/Project/productcommentlist",//주소
			data: {
				page: page,
				productn: cafeKey,
			},
			dataType: 'JSON',
			success: function(data) { //성공시
				commentList(data);
			},
			error: function(e) { //실패시
				console.log(e);
			}
		});
	})
	
	$('#commentLists').on('click', '.commentDelBtn', function() {
		var commentNo = $(this).attr('title');
		var cafeKey = $('#proCommentBtn').attr("title");
		$.ajax({
			type: "POST",//방식
			url: "/Project/productcommentdel",//주소
			data: {
				commentNo: commentNo,
				productn: cafeKey,
			},
			dataType: 'JSON',
			success: function(data) { //성공시
			commentList(data);			
			
			},
			error: function(e) { //실패시
				console.log(e);
			}
		});
	})
	
	$('#commentLists').on('click', '.commentUpdateBtn', function() {
		$(this).parents('.updateCheck').addClass("visually-hidden");
		$(this).parents('.updateCheck').next('.updateForm').removeClass("visually-hidden");
	})
	$('#commentLists').on('click', '.cmUpdateCancel', function() {
		$(this).parents('.updateForm').addClass("visually-hidden");
		$(this).parents('.updateForm').prev('.updateCheck').removeClass("visually-hidden");
	})
	
	$(document).on('click', '.commentUpdateContentBtn', function() {
		var commentNo = $(this).attr('title');
		var cafeKey = $('#proCommentBtn').attr("title");
		var commentUpdateContent = $(this).parent().prev().children('.commentUpdateContent').val();
		console.log(commentUpdateContent);
		if (commentUpdateContent.trim() != "") {
			$.ajax({
				type: "POST",//방식
				url: "/Project/productcommentupdate",//주소
				data: {
					commentUpdateContent: commentUpdateContent,
					commentNo: commentNo,
					productn: cafeKey,
				},
				dataType: 'JSON',
				success: function(data) { //성공시
					commentList(data);
				},
				error: function(e) { //실패시
					console.log(e);
				}
			});
		} else {
			$(this).parent().prev().children('.commentUpdateContent').addClass('is-invalid');
		}
	})
	
	$(document).on('click', '#purchasebtn', function() {
		var prc = $('#prc').val();
		var pid = $('#productn').val();
		var qty = $('#quantity').val();
					console.log(prc);
					console.log(pid);
					console.log(qty);
					
				$.ajax({
					type: 'POST',//방식
					url: '/Project/purchaseInsert',//주소
					data: {
						prc: prc,
						productn : pid,
						quantity: qty
					},
					dataType: 'JSON',
					success: function(data) { //성공시
						location.href='/Project/MainProduct/productResult.jsp';
					},
					error: function(e) { //실패시
						console.log(e);
					}		
			});
	});
		
				
	</script>
</body>
</html>