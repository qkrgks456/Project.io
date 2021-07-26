<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 상단 메뉴바 -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark bg-gradient">
	<div class="container-fluid">
		<a class="navbar-brand fw-bold" href="/Project/index.jsp">You Are
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
					href="/Project/cafe.jsp">카페정보</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/Project/product.jsp">상품구매</a></li>
				<c:if test="${sessionScope.loginId eq 'qkrgks456'}">
					<li class="nav-item"><a class="nav-link"
						href="/Project/admin/admin.jsp">관리자</a></li>
				</c:if>
			</ul>
			<!-- 쇼핑카트 알림 -->
			<div class="d-none d-lg-block">
				<div class="d-flex">
					<div class="d-flex" id="cartalert"
						onclick="location.href='/Project/myShopping/buy/cart.jsp'">
						<i id="cart" class="bi bi-cart-fill"
							style="font-size: 1.7rem; color: white"></i> <span
							id="cartalertnum"
							class="border border-dark position-absolute top-0 mx-3 badge bg-white text-dark rounded-pill mt-2">0</span>
					</div>
					<!-- 혼잡도 알림 -->
					<div class="d-flex mx-3" id="navalert"
						onclick="location.href='/Project/myPage/myPageMenu/alerm.jsp'">
						<i id="bell" class="bi bi-bell-fill"
							style="font-size: 1.7rem; color: white"></i> <span
							id="navalertnum"
							class="border border-dark position-absolute top-0 mx-3 badge bg-white text-dark rounded-pill mt-2">0</span>
					</div>
				</div>
			</div>
			<div class="d-flex" id="loginmenu">
				<a href="/Project/myShopping/buy/buy.jsp" role="button" id="mypage"
					class="btn btn-outline-light btn-sm mx-1">쇼핑</a> <a
					href="/Project/myPage/myPageMenu/myInfo.jsp" role="button"
					id="mypage" class="btn btn-outline-light btn-sm mx-1">마이페이지</a> <a
					href="/Project/logout" role="button" id="logout"
					class="btn btn-outline-light btn-sm mx-1">로그아웃</a>
			</div>
		</div>
	</div>
</nav>
