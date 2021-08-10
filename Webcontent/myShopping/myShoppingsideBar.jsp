<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="border" id="sidebar-wrapper">
	<nav id="sidebar" style="transition: all 0.3s;">
		<div class="list-group list-group-flush mt-3">
			<h4 class="fst-italic ms-3 fw-bold text-decoration-none">구매</h4>
			<a class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/purchaseList" style="cursor: pointer;">구매내역</a><a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/cartList" style="cursor: pointer;">장바구니</a>
		</div>
		<hr />
		<div class="list-group list-group-flush mt-3">
			<h4 class="fst-italic ms-3 fw-bold text-decoration-none">판매</h4>
			<a class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/myShopping/sell/sellList.jsp" style="cursor: pointer;">판매내역</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/myShopping/sell/productInput/productInput.jsp" style="cursor: pointer;">상품등록</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/myProductList" style="cursor: pointer;">상품정보</a>
		</div>
		<hr />
	</nav>
</div>