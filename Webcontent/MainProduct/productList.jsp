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
<link href="/Project/assets/css/main.css?ver=25" rel="stylesheet">
<title>카페</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="wrap">
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

		<div class="container" >
			<!-- 검색창 -->
		<!-- 	<div class="row">
				<div class="d-flex">
					
					<div class="col d-flex justify-content-end mt-4">
						<form class="d-inline-flex justify-content-end"	style="height: 42px" 
						action="/Project/searchproduct">
						
							<input class="form-control me-1" type="search"
								placeholder="키워드를 입력해주세요" aria-label="Search" name="prosearch" id="prosearch">
							<button class="btn btn-outline-secondary" type="submit" id="startserach">search</button>
							
						</form>
					</div>
				</div>			
			</div> -->
			
					
			<!-- 판매창 -->
			<div id="searchtbody">
			<p class="fw-bold mt-2 h1" >원두</p>
			<hr/> 
			<div class="row row-cols-1 row-cols-md-4 g-4" id="titleo">
			<c:forEach items="${productlistWD }" var="WD">
			<form action="/Project/productdetail?productId=${WD.productId}" method="post">
				<div class="col">
					<div class="card h-100">
					<a href="/Project/productdetail?productId=${WD.productId}"><img src="/photo/${WD.newFileName }" class="card-img-top"> </a>
						<div class="card-body">
						
						<input type="hidden" value="${WD.productId }" name="wdId" id="wdId">
						
							<h5 class="fw-bold">${WD.productName }</h5>
							<p class="target text-muted mt-2">${WD.explanation }</p>
							<div class="d-grid gap-2 col-6 mx-auto">
								<button type="submit" class="btn btn-outline-secondary">자세히보기</button>
							</div>
						</div>
					</div>
				</div>
			</form>			
			</c:forEach>			
			</div>
		<br/>
			<!-- MD 상품 코너 -->
			<h1 class="fw-bold mt-2" >MD</h1>
			<hr />
			<div class="row row-cols-1 row-cols-md-4 g-4" id="titlet">
			<c:forEach items="${productlistMD }" var="MD">
					<input type="hidden" value="${MD.productId }" name="mdId" id="mdId">
			<form action="/Project/productdetail?productId=${MD.productId}" method="post">
				<div class="col">
					<div class="card h-100">
					<a href="/Project/productdetail?productId=${MD.productId}">	<img src="/photo/${MD.newFileName }" class="card-img-top"> </a>
						<div class="card-body">
						
							<h5 class="fw-bold">${MD.productName }</h5>
							<p class="text-muted mt-2">${MD.explanation }</p>
							<div class="d-grid gap-2 col-6 mx-auto">
								<button type="submit" class="btn btn-outline-secondary"	>자세히보기</button>
							</div>
						</div>
					</div>
				</div>
				</form>
		</c:forEach>
			</div>
		
		</div>
	</div>
</div>
	<!-- 하단 고정 퀵메뉴 -->
	<c:if test="${sessionScope.loginId eq 'qkrgks456'}">
		<jsp:include page="/fixMenu/quickMenu.jsp"></jsp:include>
	</c:if>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
<script>
var param = {};
$("#startsearch").click(function(){
	param = $("#prosearch").val();
	if(param != null){
	$("#titleo").addClass("visually-hidden");
	$("#titlet").addClass("visually-hidden");
	}
};

/* 
var param = {};
$("#startsearch").click(function(){
	param = $(this).val();
	if(param != null){
		console.log("파람 값 왜 안나와 : " + param);
		SetSearch(param);
		$("#titleo").addClass("visually-hidden");
		$("#titlet").addClass("visually-hidden");		
	}	
})

function SetSearch(param){
	$.ajax({    type : 'POST',
		url : '/Project/searchproduct',
		data : {
			
			prosearch : param
		},
		dataType : 'JSON',
		success : function(data) {
			console.log(data);
			content = "";
			$.each(data.list,function(i, item) {
				console.log(item.newFileName);				
				content += 	'<div class="col">'
				content += 	'<div class="card h-100">'
				content += 	'<img src="/photo/'+item.newFileName+'" class="card-img-top">'
				content += 	'<div class="card-body">'
				content += 	'<input type="hidden" value="'+item.productId +'" name="wdId" id="wdId">'
				content += 	'<h5 class="fw-bold">'+item.productName+'</h5>'
				content += 	'<p class="target text-muted mt-2">'+WD.explanation+'</p>'
				content += 		'<div class="d-grid gap-2 col-6 mx-auto">'
				content += 			'<button type="submit" class="btn btn-outline-secondary">자세히보기</button>'
				content += 		'</div>'
				content += 	'</div>'
				content += '</div>'
				content += '</div>'				

			})
			console.log(content); 
			$("#searchtbody").empty();
			$("#searchtbody").append(content);
			
			},
			error : function(e) {
			console.log(e);
			}
	});
};

 */</script>
</html>