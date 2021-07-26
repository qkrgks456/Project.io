<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="border" id="sidebar-wrapper">
	<nav id="sidebar" style="transition: all 0.3s;">
		<div class="list-group list-group-flush mt-3">
			<h4 class="fst-italic ms-3 fw-bold text-decoration-none">관리자</h4>
			<a class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/admin/adminSelect/adminSearch.jsp"
				style="cursor: pointer;">관리자조회</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/admin/adminSelect/adminSelect.jsp"
				style="cursor: pointer;">관리자임명</a>
		</div>
		<hr />
		<div class="list-group list-group-flush mt-3">
			<h4 class="fst-italic ms-3 fw-bold text-decoration-none">리스트정보</h4>
			<a class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/admin/adminList/adminMemberList/adminMemberList.jsp"
				style="cursor: pointer;">회원정보</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/admin/adminList/adminCafeList/adminCafeList.jsp"
				style="cursor: pointer;">카페정보</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/admin/adminList/adminProductList/adminProductList.jsp"
				style="cursor: pointer;">상품정보</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/admin/adminList/adminInputCafeList/adminInputCafeList.jsp"
				style="cursor: pointer;">등록카페정보</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/admin/adminList/adminInputProductList/adminInputProductList.jsp"
				style="cursor: pointer;">등록상품정보</a>
		</div>
		<hr />
		<div class="list-group list-group-flush mt-3">
			<h4 class="fst-italic ms-3 fw-bold text-decoration-none">댓글정보</h4>
			<a class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/admin/adminComment/adminNormalComment/adminCommentList.jsp"
				style="cursor: pointer;">일반댓글</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/admin/adminComment/adminReportComment/adminReportCommentList.jsp"
				style="cursor: pointer;">신고댓글</a>
		</div>
		<hr />
	</nav>
</div>