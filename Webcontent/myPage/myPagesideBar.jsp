<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="border" id="sidebar-wrapper">
	<nav id="sidebar" style="transition: all 0.3s;">
		<div class="list-group list-group-flush mt-3">
			<h4 class="fst-italic ms-3 fw-bold text-decoration-none">마이페이지</h4>
			<a class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/myInfo"
				style="cursor: pointer;">내정보</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/myPage/myPageMenu/memberDrop.jsp"
				style="cursor: pointer;">회원탈퇴</a><a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/myPage/myPageMenu/passChangeCheck.jsp"
				style="cursor: pointer;">비밀번호변경</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/cafeAlarmList" style="cursor: pointer;">알림리스트</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/cafeGoodList"
				style="cursor: pointer;">좋아요카페</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/myPage/myPageMenu/goodProduct.jsp"
				style="cursor: pointer;">좋아요상품</a>
		</div>
		<hr />
		<div class="list-group list-group-flush mt-3">
			<h4 class="fst-italic ms-3 fw-bold text-decoration-none">댓글</h4>
			<a class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/cafeMypageCommetList"
				style="cursor: pointer;">카페댓글</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/myPage/commentMenu/productComment.jsp"
				style="cursor: pointer;">상품댓글</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/commentReport"
				style="cursor: pointer;">신고한댓글</a>
		</div>

		<hr />
		<div class="list-group list-group-flush mt-3">
			<h4 class="fst-italic ms-3 fw-bold text-decoration-none">카페</h4>
			<a class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/cafeInputCheck"
				style="cursor: pointer;">카페등록</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/cafeInfoMyPage"
				style="cursor: pointer;">카페정보</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/cafeExist?menu=a"
				style="cursor: pointer;">카페삭제</a> <a
				class="ps-4 fw-bold list-group-item list-group-item-action"
				href="/Project/confusionInfo"
				style="cursor: pointer;">혼잡도설정</a>
		</div>
	</nav>
</div>