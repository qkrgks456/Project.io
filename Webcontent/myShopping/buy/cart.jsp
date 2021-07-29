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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
<link rel="stylesheet" href="./10-11.css" />
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<link href="/Project/assets/css/main.css?ver=3" rel="stylesheet">
<title>카페</title>
<style>

.narrowbuttongroup {
	margin: 15px 0;
}

.buttongroup.center {
	text-align: center;
}

.buttongroup input[type=text], .buttongroup input[type=password] {
	height: 30px;
}

.buttongroup button, .buttongroup a {
	margin-right: 5px;
}

.buttongroup button:last-child, .buttongroup a:last-child {
	margin-right: 0;
}

.abutton, .abutton:link, .abutton:visited, .abutton:active, input[type=button]
	{
	background-color: #383838;
	border: 1px solid #888888;
	color: #ffffff;
	cursor: pointer;
	letter-spacing: -1px;
	padding: 3px 5px;
	margin: 2px 3px;
	width: auto;
	word-break: keep-all;
	border-radius: 5px;
	text-decoration: none;
	font-size: 0.9375em;
}

.abutton-alt {
	background-color: #d3e2c6;
}

.red {
	color: #b00;
}

 .sumcount, .summoney {
	text-align: right;
	margin-bottom: 10px;
}

.basketrowcmd {
	text-align: left;
	
}

.sumcount, .summoney {
	font-size: 1.25em;
	font-weight: bold;
}

.buttongroup {
	text-align: center;
	
}

.buttongroup a {
	text-decoration: gray;
}
.cmd a, .cmd span {
    padding: 12px 30px;
    box-sizing: border-box;
    margin-top: 10px;
    font-size: 1.2em;
    color: #000;
    background-color: #343a40;
    border-radius: 5px;
    text-align: center;
 	color:#ffffff;
	border: 1px solid #888888;

</style>
<script type="text/javascript">
	let basket = {
		totalCount : 0,
		totalPrice : 0,
		//체크한 장바구니 상품 비우기
		delCheckedItem : function() {
			document.querySelectorAll("input[name=buy]:checked")
					.forEach(
							function(item) {
								item.parentElement.parentElement.parentElement
										.remove();
							});
			//AJAX 서버 업데이트 전송

			//전송 처리 결과가 성공이면
			this.reCalc();
			this.updateUI();
		},
		//장바구니 전체 비우기
		delAllItem : function() {
			document.querySelectorAll('.row.data').forEach(function(item) {
				item.remove();
			});
			//AJAX 서버 업데이트 전송

			//전송 처리 결과가 성공이면
			this.totalCount = 0;
			this.totalPrice = 0;
			this.reCalc();
			this.updateUI();
		},
		//재계산
		reCalc : function() {
			this.totalCount = 0;
			this.totalPrice = 0;
			document
					.querySelectorAll(".p_num")
					.forEach(
							function(item) {
								if (item.parentElement.parentElement.parentElement.previousElementSibling.firstElementChild.firstElementChild.checked == true) {
									var count = parseInt(item
											.getAttribute('value'));
									this.totalCount += count;
									var price = item.parentElement.parentElement.previousElementSibling.firstElementChild
											.getAttribute('value');
									this.totalPrice += count * price;
								}
							}, this); // forEach 2번째 파라메터로 객체를 넘겨서 this 가 객체리터럴을 가리키도록 함. - thisArg
		},
		//화면 업데이트
		updateUI : function() {
			document.querySelector('#sum_p_num').textContent = '상품갯수: '
					+ this.totalCount.formatNumber() + '개';
			document.querySelector('#sum_p_price').textContent = '합계금액: '
					+ this.totalPrice.formatNumber() + '원';
		},
		//개별 수량 변경
		changePNum : function(pos) {
			var item = document.querySelector('input[name=p_num' + pos + ']');
			var p_num = parseInt(item.getAttribute('value'));
			var newval = event.target.classList.contains('up') ? p_num + 1
					: event.target.classList.contains('down') ? p_num - 1
							: event.target.value;

			if (parseInt(newval) < 1 || parseInt(newval) > 99) {
				return false;
			}

			item.setAttribute('value', newval);
			item.value = newval;

			var price = item.parentElement.parentElement.previousElementSibling.firstElementChild
					.getAttribute('value');
			item.parentElement.parentElement.nextElementSibling.textContent = (newval * price)
					.formatNumber()
					+ "원";
			//AJAX 업데이트 전송

			//전송 처리 결과가 성공이면    
			this.reCalc();
			this.updateUI();
		},
		checkItem : function() {
			this.reCalc();
			this.updateUI();
		},
		delItem : function() {
			event.target.parentElement.parentElement.parentElement.remove();
			this.reCalc();
			this.updateUI();
		}
	}

	// 숫자 3자리 콤마찍기
	Number.prototype.formatNumber = function() {
		if (this == 0)
			return 0;
		let regex = /(^[+-]?\d+)(\d{3})/;
		let nstr = (this + '');
		while (regex.test(nstr))
			nstr = nstr.replace(regex, '$1' + ',' + '$2');
		return nstr;
	};
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
			<jsp:include page="../myShoppingsideBar.jsp"></jsp:include>
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">장바구니</h2>
				</div>
				<div class="container">
					<table class="table table-hover mt-2">
						<thead class="table-light">
							<tr>



								<th scope="col">#</th>
								<th scope="col">이미지</th>
								<th scope="col">상품명</th>
								<th scope="col">가격</th>
								<th scope="col">수량</th>
								<th scope="col">합계</th>
								<th class="text-center" scope="col">상세보기</th>
							</tr>
						</thead>
						<tbody>
							<tr class="visually-hidden">
								<th class="align-middle" scope="row">1</th>
								<td><img src="/Project/assets/img/12.jpg"
									class="img-thumbnail"
									style="width: 80px; height: 80px; object-fit: cover;" /></td>

								<td class="align-middle">상품명</td>
								<td class="align-middle">상품코드</td>
								<td class="align-middle">합계</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm">상세보기</a> <a
											class="btn btn-secondary btn-sm">좋아요취소</a>
									</div>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<div class="visually-hidden subdiv">
									<div class="basketprice">가격</div>
									<div class="num">수량</div>
									<div class="sum">합계</div>
								</div>
								<th><div class="check">
										<input type="checkbox" name="buy" value="260" checked=""
											onclick="javascript:basket.checkItem();">&nbsp;
									</div></th>
								<th><img src="/Project/assets/img/p1.jpg"
									class="img-thumbnail"
									style="width: 80px; height: 80px; object-fit: cover;" /></th>
								<th>에티오피아 예가체프 G2</th>
								<th>

									<div class="subdiv">
										<div class="basketprice">
											<input type="hidden" name="p_price" id="p_price1"
												class="p_price" value="8000">8,000원
										</div>
										<div class="num">
											<div class="updown">
												<input type="text" name="p_num1" id="p_num1" size="2"
													maxlength="4" class="p_num" value="2"
													onkeyup="javascript:basket.changePNum(1);"> <span
													onclick="javascript:basket.changePNum(1);"><i
													class="fas fa-arrow-alt-circle-up up"></i></span> <span
													onclick="javascript:basket.changePNum(1);"><i
													class="fas fa-arrow-alt-circle-down down"></i></span>
											</div>
										</div>
										<div class="sum">40,000원</div>
									</div>
									</div>
									</div>

								</th>

								<th>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary btn-sm"
									onclick="location.href='/Project/MainProduct/product.jsp'">상세보기</a></th>
								<th colspan="6"></th>
							</tr>

							<th><div class="check">
									<input type="checkbox" name="buy" value="260" checked=""
										onclick="javascript:basket.checkItem();">&nbsp;
								</div></th>
							<th><img src="/Project/assets/img/m0.jpg"
								class="img-thumbnail"
								style="width: 80px; height: 80px; object-fit: cover;" /></th>
							<th>빈티지 머그</th>
							<th>
								<div class="subdiv">
									<div class="basketprice">
										<input type="hidden" name="p_price" id="p_price2"
											class="p_price" value="18000">18,000원
									</div>
									<div class="num">
										<div class="updown">
											<input type="text" name="p_num2" id="p_num2" size="2"
												maxlength="4" class="p_num" value="1"
												onkeyup="javascript:basket.changePNum(2);"> <span
												onclick="javascript:basket.changePNum(2);"><i
												class="fas fa-arrow-alt-circle-up up"></i></span> <span
												onclick="javascript:basket.changePNum(2);"><i
												class="fas fa-arrow-alt-circle-down down"></i></span>
										</div>
									</div>
									<div class="sum">19,000원</div>
								</div>

							</th>
						
							<th>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary btn-sm"
								onclick="location.href='/Project/MainProduct/product.jsp'">상세보기</a></th>
							<th colspan="6"></th>
							</tr>

							<th><div class="check">
									<input type="checkbox" name="buy" value="260" checked=""
										onclick="javascript:basket.checkItem();">&nbsp;
								</div></th>
							<th><img src="/Project/assets/img/m6.jpg"
								class="img-thumbnail"
								style="width: 80px; height: 80px; object-fit: cover;" /></th>
							<th>시럽 세트</th>
							<th>


								<div class="subdiv">
									<div class="basketprice">
										<input type="hidden" name="p_price" id="p_price3"
											class="p_price" value="32000">32,000원
									</div>
									<div class="num">
										<div class="updown">
											<input type="text" name="p_num3" id="p_num3" size="2"
												maxlength="4" class="p_num" value="1"
												onkeyup="javascript:basket.changePNum(3);"> <span
												onclick="javascript:basket.changePNum(3);"><i
												class="fas fa-arrow-alt-circle-up up"></i></span> <span
												onclick="javascript:basket.changePNum(3);"><i
												class="fas fa-arrow-alt-circle-down down"></i></span>
										</div>
									</div>
									<div class="sum">15,200원</div>
								</div>
							</th>
							
							<th>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary btn-sm"
								onclick="location.href='/Project/MainProduct/product.jsp'">상세보기</a></th>
							<th colspan="6"></th>
							</tr>


						</tfoot>
					</table>
					<div class="right-align basketrowcmd">
						<a href="javascript:void(0)" class="abutton"
							onclick="javascript:basket.delCheckedItem();">선택상품 삭제</a> <a
							href="javascript:void(0)" class="abutton"
							onclick="javascript:basket.delCheckedItem();">장바구니 비우기</a>
					</div>

					<div class="bigtext right-align sumcount" id="sum_p_num">상품
						개수: 개</div>
					<div class="bigtext right-align red summoney" id="sum_p_price">합계금액:
						74,200원</div>

					<div id="goorder" class="">
						<div class="clear"></div>
						<div class="buttongroup center-align cmd">
							<a href="/Project/MainProduct/productResult.jsp">선택한 상품 주문</a>
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
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=2"></script>
</body>
</html>