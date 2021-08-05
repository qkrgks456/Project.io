<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<meta charset="utf-8">
<!-- 부트스트랩 메타태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<link href="/Project/assets/css/bootstrap.css?ver=3" rel="stylesheet">
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<link href="/Project/assets/css/main.css?ver=3" rel="stylesheet">
<title>카페</title>
<style>
.box.on {
	color: #999;
}
</style>

<script>
	var oTbl;
	function insRow() {//옵션 추가
		oTbl = document.getElementById("addTable");
		var oRow = oTbl.insertRow();
		oRow.onmouseover = function() {
			oTbl.clickedRowIndex = this.rowIndex
		}; //clickedRowIndex - 클릭한 옵션의 위치를 확인;
		var oCell = oRow.insertCell();

		//삽입될 Form Tag

		var frmTag = "<div class='mt-2 d-flex'>"
		frmTag += "<input class='form-control' type='text' name='addText'> ";
		frmTag += "<input type='button' class='btn btn-dark ms-2' value='삭제' onClick='removeRow()' style='cursor:hand'>";
		frmTag += "</div>"
		oCell.innerHTML = frmTag;
	}
	//옵션 삭제
	function removeRow() {
		oTbl.deleteRow(oTbl.clickedRowIndex);
	}

	function frmCheck() {
		var frm = document.form;

		for (var i = 0; i <= frm.elements.length - 1; i++) {
			if (frm.elements[i].name == "addText") {
				if (!frm.elements[i].value) {
					alert("텍스트박스에 값을 입력하세요");
					frm.elements[i].focus();
					return;
				}
			}
		}
	}
</script>
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
		<div class="d-flex" style="height: auto; min-height: 100vh;">
			<jsp:include page="/myShopping/myShoppingsideBar.jsp"></jsp:include>
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">상품 등록</h2>
				</div>
				<hr />
				<!-- 사이드 바 메뉴-->
				<!-- 들어갈 내용 -->


				<div class="container px-4 py-4 my-4 border shadow-lg" id="cont">
					<h4 class="mb-3 fw-bold">상품 등록</h4>
					<hr />
					<form action="/Project/productinsert" method="post"
						class="needs-validation" enctype="multipart/form-data" novalidate>

						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">상품명</h6>
						<div class="col-md-9 mb-3">
							<input type="text" class="nullchecks nullcheck form-control"
								id="productName" name="productName"
								aria-describedby="inputGroupPrepend" required>
							<div class="invalid-feedback">필수 정보입니다</div>
						</div>


						<h6 class="text-muted mt-1 fw-bold" style="text-align: left;">카테고리</h6>
						<div class="col-md-9 mb-3">
							<select class="form-select" id="categoryName" name="categoryName">
								<option selected disabled value="">필수선택</option>
								<option value="원두">원두</option>
								<option value="엠디">MD</option>
							</select>
							<div class="invalid-feedback">카테고리를 설정해주세요</div>
						</div>
					
						<!-- 수량 -->
						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">수량</h6>
						<div class="col-md-9 mb-3">
							<input type="text" class="nullchecks nullcheck form-control"
								id="productQuantity" name="productQuantity" required>
							<div class="invalid-feedback">필수 정보입니다</div>
						</div>


						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">가격</h6>
						<div class="col-md-9 mb-3">
							<input type="text" class="nullchecks nullcheck form-control"
								id="Price" name="Price" required>
							<div class="invalid-feedback">필수 정보입니다</div>
						</div>

						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">제품
							설명</h6>
						<div class="col-md-9 mb-3">
							<input type="text" class="nullchecks nullcheck form-control"
								id="explanation" name="explanation" required>
							<div class="invalid-feedback">필수 정보입니다</div>
						</div>

						<br>
						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">상품
								대표 이미지</h6>
						<div class="col-md-9 mb-3">						
							<input class="form-control" type="file" id="formFileMultiple"
								name="photo" id="photo">
						</div>

						<br>
						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">판매여부</h6>
						<div class="form-floating col-md-9 mb-3" id="sellCheck">
							<div class="form-check">
								<input class="form-check-input" type="radio" name="selCheck"
									value="Y" id="flexRadioDefault1"> <label
									class="form-check-label" for="flexRadioDefault1"> 판매</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="radio" name="selCheck"
									value="N" id="flexRadioDefault2" checked> <label
									class="form-check-label" for="flexRadioDefault2"> 미판매 </label>
							</div>
						</div>

						<div class="d-flex">
						<div class="form-check mt-3">
							<div class="form-check ">
								<input class="form-check-input" type="checkbox" id="agreeupdate"
									onClick="agreeCheck(this.form)" name="Check"
									id="flexRadioDefault2">
							</div>
						</div>
						<label class="form-check-label fw-bold" for="agreeupdate">
							관리자의 심사가 있어야 상품이 최종 승인됩니다. 정보 재확인 바랍니다. <br/>이에 동의하십니까?
						</label>
						</div>

						<div class="invalid-feedback">동의해야만 등록이 가능합니다</div>
						<div class="d-grid gap-3 d-md-flex justify-content-md-end">
							<div class="invalid-feedback">필수 동의입니다</div>

							<button class="btn btn-dark" type="submit" name="checkButton"
								disabled>등록</button>

							<button class="btn btn-dark me-md-1" type="button"
								onclick="location.href='/Project/myShopping/sell/productList/productList.jsp'">취소</button>
						</div>
				</form>
				</div>
			</div>
		</div>
	</div>




	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<script type="text/javascript">
		function agreeCheck(frm) {
			if (frm.checkButton.disabled == true)
				frm.checkButton.disabled = false
			else
				frm.checkButton.disabled = true
		}
		
		
	
	</script>

	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=4"></script>
	<!-- 하단 고정 퀵메뉴 -->
	<c:if test="${sessionScope.loginId eq 'qkrgks456'}">
		<jsp:include page="/fixMenu/quickMenu.html"></jsp:include>
	</c:if>

</body>
</html>