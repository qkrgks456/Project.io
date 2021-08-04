<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
					href="/Project/MainProduct/productList.jsp">상품구매</a></li>
			</ul>
			<div class="d-flex" id="menu">
				<a type="button" id="loginbtn"
					class="btn btn-outline-light btn-sm" href="/Project/login/login.jsp">로그인</a>
				<a href="/Project/signUp/agree.jsp" role="button" id="memberbtn"
					class="btn btn-outline-light btn-sm mx-2">회원가입</a>
			</div>
		</div>
	</div>
</nav>
