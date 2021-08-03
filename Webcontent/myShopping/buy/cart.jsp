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
<link href="/Project/assets/css/main.css?ver=3" rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
<link rel="stylesheet" href="./10-11.css" />
<script type="text/javascript" src="./10-11.js"></script>
<title>카페</title>
<style>
.basketdiv .row.head {
	border-bottom: 2px solid #888;
	box-sizing: border-box;
	background-color: #f4f4f4;
	font-weight: 500;
}
.basketdiv {
	width: 100%;
	border-top: 1px solid #e0e0e0;
	float: left;
	font-size: 0.9375em;
	margin-bottom: 20px;
}
.basketdiv .data {
	border-bottom: 1px dashed #888;
	box-sizing: border-box;
	cursor: pointer;
	float: left;
	width: 100%;
}

.basketdiv .row>.subdiv {
	display: block;
	float: center;
}

.basketdiv .row>.subdiv:nth-child(1) {
	width: 50%;
}

.basketdiv .row>.subdiv:nth-child(2) {
	width: 40%;
}

.basketdiv .row>.subdiv:nth-child(3) {
	width: 10%;
}

.basketdiv .row>div>div {
	display: block;
	float: left;
	text-align: left;
	margin: 0;
	padding: 12px 0;
}

.basketdiv .data .num .updown {
	color: #0075ff;
	font-size: 2em;
	letter-spacing: -5px;
}

.basketdiv .check {
	width: 10%;
}

.basketdiv .check input[type=checkbox] {
	transform: scale(1.5);
}

.basketdiv .img {
	width: 20%;
}

.basketdiv .pname {
	width: 60%;
}

.basketdiv2 .pname {
	width: 60%;
}

.basketdiv .basketprice {
	width: 33%;
}

.basketdiv .num {
	width: 33%;
	min-width: 105px;
}

.basketdiv .sum {
	width: 34%;
	max-width: 80px;
	color: #000;
}

.basketdiv .point {
	width: 50%;
}

.basketdiv2 .basketprice {
	width: 25%;
}

.basketdiv2 .num {
	width: 25%;
}

.basketdiv2 .sum {
	width: 25%;
	color: #0000aa;
}

.basketdiv2 .point {
	width: 25%;
}

.basketdiv .basketcmd {
	width: 100%;
}


.basketdiv .data .price, .basketdiv .data .sum, .basketdiv .data .point
	{
	text-align: right;
}

.baseform>tbody>tr>td:first-child {
	width: 100px;
}

.buttongroup {
	padding: 11px 0;
	margin: 50px 0;
}

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
	background-color: #6c757d;
}

.red {
	color: #b00;
}

.blue {
	color: #0075ff;
}

.basketrowcmd, .sumcount, .summoney {
	text-align: right;
	margin-bottom: 10px;
}

.sumcount, .summoney {
	font-size: 1.25em;
	font-weight: bold;
}

.buttongroup {
	text-align: center;
}

.buttongroup a {
	text-decoration: none;
}

.cmd a, .cmd span {
	padding: 12px 30px;
	box-sizing: border-box;
	margin-top: 10px;
	font-size: 1.2em;
	color: #000;
	background-color: #f4f4f4;
	border: 1px solid #e0e0e0;
	text-align: center;
}

.cmd.small a, .cmd.small span {
	padding: 6px 20px;
	font-size: 0.8125em;
}

.orderform .p_num {
	text-align: right;
	width: 40px;
	font-size: 1em;
}
</style>
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

						<form name="orderform" id="orderform" method="post"
							class="orderform" action="/Page" onsubmit="return false;">

							<input type="hidden" name="cmd" value="order">
							<div class="basketdiv" id="basket">
								<div class="row head">
									<div class="subdiv">
										<div class="check">선택</div>
										<div class="img">이미지</div>
										<div class="pname">상품명</div>
									</div>
									<div class="subdiv">
										<div class="basketprice">가격</div>
										<div class="num">수량</div>
										<div class="sum">합계</div>
									</div>
									<div class="subdiv">

										<div class="basketcmd">비고</div>
									</div>
									<div class="split"></div>
								</div>

								<div class="row data">
									<div class="subdiv">
										<div class="check">
											<input type="checkbox" name="buy" value="260" checked=""
												onclick="javascript:basket.checkItem();">&nbsp;
										</div>
										<div class="img">
											<img src="/Project/assets/img/m7.jpg" width="80" height="80">
										</div>
										<div class="pname">
											<span>써머 주스잔</span>
										</div>
									</div>
									<div class="subdiv">
										<div class="basketprice">
											<input type="hidden" name="p_price" id="p_price1"
												class="p_price" value="18000">18,000원
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
										<div class="sum">18,000원</div>
									</div>
									<div class="subdiv">
										<div class="basketcmd">
											<a href="javascript:void(0)" class="abutton"
												onclick="javascript:basket.delItem();">삭제</a>
										</div>
									</div>
								</div>
								<div class="row data">
									<div class="subdiv">
										<div class="check">
											<input type="checkbox" name="buy" value="261" checked=""
												onclick="javascript:basket.checkItem();">&nbsp;
										</div>
										<div class="img">
											<img src="/Project/assets/img/m6.jpg" width="80" height="80">
										</div>
										<div class="pname">
											<span>시럽 세트</span>
										</div>
									</div>
									<div class="subdiv">
										<div class="basketprice">
											<input type="hidden" name="p_price" id="p_price2"
												class="p_price" value="32000">32,000원
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
										<div class="sum">32,000원</div>
									</div>
									<div class="subdiv">
										<div class="basketcmd">
											<a href="javascript:void(0)" class="abutton"
												onclick="javascript:basket.delItem();">삭제</a>
										</div>
									</div>
								</div>
								<div class="row data">
									<div class="subdiv">
										<div class="check">
											<input type="checkbox" name="buy" value="262" checked=""
												onclick="javascript:basket.checkItem();">&nbsp;
										</div>
										<div class="img">
											<img src="/Project/assets/img/p7.jpg" width="80" height="80">
										</div>
										<div class="pname">
											<span>과테말라 안티구아</span>
										</div>
									</div>
									<div class="subdiv">
										<div class="basketprice">
											<input type="hidden" name="p_price" id="p_price3"
												class="p_price" value="9500">9,500원
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
										<div class="sum">9,500원</div>
									</div>
									<div class="subdiv">
										<div class="basketcmd">
											<a href="javascript:void(0)" class="abutton"
												onclick="javascript:basket.delItem();">삭제</a>
										</div>
									</div>
								</div>

							</div>

							<div class="right-align basketrowcmd">
								<a href="javascript:void(0)" class="abutton"
									onclick="javascript:basket.delCheckedItem();">선택상품삭제</a> <a
									href="javascript:void(0)" class="abutton"
									onclick="javascript:basket.delAllItem();">장바구니비우기</a>
							</div>

							<div class="bigtext right-align sumcount" id="sum_p_num">상품갯수:
								4개</div>
							<div class="bigtext right-align box blue summoney"
								id="sum_p_price">합계금액: 74,200원</div>

							<div id="goorder" class="">
								<div class="clear"></div>
								<div class="buttongroup center-align cmd">
									<a href="javascript:void(0);">선택한 상품 주문</a>
								</div>
							</div>
						</form>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<script>
		//이벤트 리스너 등록

		document.addEventListener('DOMContentLoaded', function() {

			// "선택 상품 삭제" 버튼 클릭

			document.querySelector('.basketrowcmd a:first-child')
					.addEventListener('click', function() {

						basket.delCheckedItem();

					});

			// "장바구니 비우기" 버튼 클릭

			document.querySelector('.basketrowcmd a:nth-child(2)')
					.addEventListener('click', function() {

						basket.delAllItem();

					});

			// 장바구니 행 "삭제" 버튼 클릭

			document.querySelectorAll('.basketcmd a').forEach(

			function(item) {

				item.addEventListener('click', function() {

					basket.delItem();

				});

			}

			);

			// 수량변경 - 이벤트 델리게이션으로 이벤트 종류 구분해 처리

			document.querySelectorAll('.updown').forEach(

					function(item, idx) {

						//수량 입력 필드 값 변경

						item.querySelector('input').addEventListener('keyup',
								function() {

									basket.changePNum(idx + 1);

								});

						//수량 증가 화살표 클릭

						item.children[1].addEventListener('click', function() {

							basket.changePNum(idx + 1);

						});

						//수량 감소 화살표 클릭

						item.children[2].addEventListener('click', function() {

							basket.changePNum(idx + 1);

						});

					}

			);

			//앵커 # 대체해 스크롤 탑 차단

			document.querySelectorAll('a[href="#"]').forEach(function(item) {

				item.setAttribute('href', 'javascript:void(0)');

			});

		});
		let basket = {

			totalCount : 0, //전체 갯수 변수

			totalPrice : 0, //전체 합계액 변수

			//체크한 장바구니 상품 비우기

			delCheckedItem : function() {

				document.querySelectorAll("input[name=buy]:checked").forEach(
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

									var count = parseInt(item
											.getAttribute('value'));
									9999

									this.totalCount += count;

									var price = item.parentElement.parentElement.previousElementSibling.firstElementChild
											.getAttribute('value');

									this.totalPrice += count * price;

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

				var item = document.querySelector('input[name=p_num' + pos
						+ ']');

				var p_num = parseInt(item.getAttribute('value'));

				var newval = event.target.classList.contains('up') ? p_num + 1
						: event.target.classList.contains('down') ?

						p_num - 1 : event.target.value;

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

			//상품 삭제

			delItem : function() {

				event.target.parentElement.parentElement.parentElement.remove();

			}

		}
		// 숫자 3자리 콤마찍기

		Number.prototype.formatNumber = function() {

			if (this == 0)
				return 0;

			let regex = /(^[+-]?\d+)(\d)/;

			let nstr = (this + '');

			while (regex.test(nstr))
				nstr = nstr.replace(regex, '$1' + ',' + '$2');

			return nstr;

		};
	</script>
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=5"></script>
</body>
</html>