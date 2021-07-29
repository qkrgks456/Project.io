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
					<form
						action="/Project/admin/adminList/adminInputProductList/adminInputProductList.jsp"
						method="post" class="needs-validation" novalidate>
						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">상품명</h6>
						<div class="form-floating col-md-9 mb-3">
							<input type="text" class="nullchecks nullcheck form-control"
								id="ProductName" placeholder="상품명"
								aria-describedby="inputGroupPrepend" required> <label
								for="validationTooltip04" class="fw-bold">상품명</label>
							<div class="invalid-feedback">필수 정보입니다</div>
						</div>


						<h6 class="text-muted mt-1 fw-bold" style="text-align: left;">카테고리</h6>
						<div class="form-floating col-md-9 mb-3">
							<select class="form-select">
								<option selected disabled value="">필수선택</option>
								<option>원두</option>
								<option>MD</option>
							</select>
							<div class="invalid-feedback">카테고리를 설정해주세요</div>
						</div>

						<!-- 옵션추가 -->
						<h6 class="text-muted mt-1 fw-bold" style="text-align: left;">옵션</h6>
						<table width="400" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td colspan="2" align="left">
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<div class="text-secondary">
												<td colspan="5" height="25" align="left"><input
													class="btn btn-secondary btn-sm  type="
													button" onClick="insRow()" value="추가"> *버튼으로 옵션을
													추가해주세요
											</div>
											</td>
										</tr>
										<tr>
											<td height="25">
												<table id="addTable" width="400" cellspacing="0"
													cellpadding="0" border="0">
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<table width="400" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="10"></td>
							</tr>
						</table>

						<!-- 수량 -->
						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">수량</h6>
						<div class="form-floating col-md-9 mb-3">
							<input type="text" class="nullchecks nullcheck form-control"
								id="Quantity" placeholder="수량" required> <label
								for="validationTooltip04" class="fw-bold">수량</label>
							<div class="invalid-feedback">필수 정보입니다</div>
						</div>


						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">가격</h6>
						<div class="form-floating col-md-9 mb-3">
							<input type="text" class="nullchecks nullcheck form-control"
								id="Price" placeholder="가격" required> <label
								for="validationTooltip04" class="fw-bold">가격</label>
							<div class="invalid-feedback">필수 정보입니다</div>
						</div>

						<br>
						<div class="mb-3">
							<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">상품
								대표 이미지</h6>
							<input class="form-control" type="file" id="formFileMultiple"
								multiple>
						</div>

						<br>
						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">판매여부</h6>
						<div class="form-floating col-md-9 mb-3">
							<div class="form-check">
								<input class="form-check-input" type="radio"
									name="flexRadioDefault" id="flexRadioDefault1"> <label
									class="form-check-label" for="flexRadioDefault1"> 판매</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="radio"
									name="flexRadioDefault" id="flexRadioDefault2" checked>
								<label class="form-check-label" for="flexRadioDefault2">
									미판매 </label>
							</div>
						</div>


						<div class="form-check mt-4">

							<input type="checkbox" name="agree"
								onClick="agreeCheck(this.form)"> <label
								class="form-check-label fw-bold" for="update">관리자의 심사가
								있어야 상품이 최종 승인됩니다. 정보 재확인 바랍니다. <br>이에 동의하십니까?
							</label>
							<div class="invalid-feedback">동의해야만 등록이 가능합니다</div>
							<div class="d-grid gap-3 d-md-flex justify-content-md-end">
								<div class="invalid-feedback">필수 동의입니다</div>

								<button class="btn btn-dark type="
									button" name="checkButton" value=" 확 인 "
									 disabled>등록</button>

								<button class="btn btn-dark me-md-1" type="button"
									onclick="location.href='/Project/myShopping/sell/productList/productList.jsp'">취소</button>
							</div>
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
		$(document).ready(function(){
		    $('#확인').click(function() {
		        var result = confirm('최종 등록 신청 하시겠습니까?');
		        if(result) {
		           //yes
		            location.href='/Project/myShopping/sell/productList/productUpdateResult.jsp';
		        } else {
		           location.href='/Project/index.jsp';
		        }
		    });
		});
	</script>

	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=4"></script>


</body>
</html>