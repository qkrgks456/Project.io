<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 상단 메뉴바 -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark bg-gradient">
	<div class="container-fluid">
		<a class="navbar-brand fw-bold" href="/Project">You Are
			Here</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0" id="menubar">
				<li class="nav-item"><a class="nav-link"
					href="/Project/search.jsp">통합검색</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/Project/cafeList">카페정보</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/Project/productList">상품구매</a></li>
				
				<c:if test="${sessionScope.authority ne '일반'}">
					<li class="nav-item"><a class="nav-link"
						href="/Project/adminSearch">관리자</a></li>
				</c:if>
			</ul>
			<!-- 쇼핑카트 알림 -->
			<div class="d-none d-lg-block">
				<div class="d-flex">
					<div class="d-flex" id="cartalert"
						onclick="location.href='/Project/myShopping/buy/cart.jsp'">
						<i id="cart" class="bi bi-cart-fill"
							style="font-size: 1.8rem; color: white"></i> <span
							id="cartalertnum"
							class="border border-dark position-absolute top-0 mx-3 badge bg-white text-dark rounded-pill mt-2">0</span>
					</div>
					<!-- 혼잡도 알림 -->
					<div class="d-flex mx-3 position-relative" id="navalert" onclick="location.href='/Project/cafeAlarmList'">
					<i id="bell" class="bi bi-bell-fill"
							style="font-size: 1.8rem; color: white"></i>
					</div>
				</div>
			</div>
			<div class="d-flex" id="loginmenu">
				<a href="/Project/myShopping/buy/buyList.jsp" role="button"
					id="mypage" class="btn btn-outline-light btn-sm mx-1">쇼핑</a> <a
					href="/Project/myInfo" role="button" id="mypage"
					class="btn btn-outline-light btn-sm mx-1">마이페이지</a> <a
					href="/Project/logout" role="button" id="logout"
					class="btn btn-outline-light btn-sm mx-1">로그아웃</a>
			</div>
		</div>
	</div>
</nav>
<!-- 스크립트 추가라인  -->
<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
<script>
/* realTimeAlarm();
timerId = setInterval(function(){
	realTimeAlarm();
	console.log('안녕');
}, 2000);
function realTimeAlarm(){
	$.ajax({
		type: "POST",//방식
		url: "/Project/realTimeAlarm",//주소
		data: {
		},
		dataType: 'JSON',
		success: function(data) { //성공시
			content = "";
			if(data.check){			
				content += '<i id="bell" class="bi bi-bell-fill"'
				content += ' style="font-size: 1.8rem; color: white"></i>'
				content += '<span class="position-absolute top-0 start-100 translate-middle p-2 bg-danger border border-light rounded-circle mt-2 me-3">'
				content += '<span class="visually-hidden">New alerts</span>'
				content += '</span>'
			}else{
				content +=	'<i id="bell" class="bi bi-bell-fill"'
				content +=	'style="font-size: 1.8rem; color: white"></i>'
			}
			$('#navalert').empty();
			$('#navalert').append(content);
		},
		error: function(e) { //실패시
			console.log(e);
		}				
	})
} */
</script>
