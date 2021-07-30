<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<style>
.rating .rate_radio, label {
	position: relative;
	display: inline-block;
	margin-left: -4px;
	z-index: 10;
	width: 60px;
	height: 60px;
	background-image: url('./img/starrate.png');
	background-repeat: no-repeat;
	background-size: 60px 60px;
	cursor: pointer;
	background-color: #f0f0f0;
}

.rating .rate_radio:checked+label {
	background-color: #ff8;
}

.cmd {
	margin-top: 20px;
	text-align: right;
}

.cmd input[type="button"] {
	padding: 10px 20px;
	border: 1px solid #e8e8e8;
	background-color: #fff;
	background-color: #000;
	color: #fff;
}

.warning_msg {
	display: none;
	position: relative;
	text-align: center;
	background: #ffffff;
	line-height: 26px;
	width: 100%;
	color: red;
	padding: 10px;
	box-sizing: border-box;
	border: 1px solid #e0e0e0;
}
</style>
<head>
<meta charset="utf-8">
<!-- 부트스트랩 메타태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<link href="/Project/assets/css/bootstrap.css?ver=3" rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
<link rel="stylesheet" href="./10-11.css" />

<script type="text/javascript" src="./10-11.js">
	document.addEventListener('DOMContentLoaded', function() {
		document.querySelector('.basketrowcmd a:first-child').addEventListener(
				'click', function() {

					basket.delCheckedItem();

				});
		document.querySelector('.basketrowcmd a:nth-child(2)')
				.addEventListener('click', function() {

					basket.delAllItem();

				});
		document.querySelectorAll('.basketcmd a').forEach(

		function(item) {

			item.addEventListener('click', function() {

				basket.delItem();

			});

		}

		);
		document.querySelectorAll('.updown').forEach(

		function(item, idx) {

			//수량 입력 필드 값 변경

			item.querySelector('input').addEventListener('keyup', function() {

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
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<title>카페</title>
</head>
<body>

	<div class="wrap p-0 m-0">
		<!-- 상단 메뉴바 -->
		<!-- 섹션에 아이디가 있다면 -->
		<c:if test="${sessionScope.loginId ne null}">
			<jsp:include page="/fixMenu/loginnav.jsp"></jsp:include>
		</c:if>
		<!-- 섹션에 아이디가 없다면 -->
		<c:if test="${sessionScope.loginId eq null}">
			<jsp:include page="/fixMenu/navbar.jsp"></jsp:include>
		</c:if>

		<!-- 들어갈 내용 -->
		<!-- 들어갈 내용 -->
		<div class="d-flex" style="height: auto; min-height: 100vh;">
			<jsp:include page="../myShoppingsideBar.jsp"></jsp:include>
			<!-- 내용시작 -->
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
							<tr class="">
								<th class="align-middle" scope="row">


									<div class="check">
										<input type="checkbox" name="buy" value="260" checked="">
									</div>
								<td><div class="img">
										<img src="/Project/assets/img/p11.jpg" class="img-thumbnail"
											style="width: 80px; height: 80px; object-fit: cover;" />
									</div></td>

								<td class="align-middle">브라질 버본 산토스 No.2</td>

								<td class="align-middle">
									<div class="subdiv">
										<div class="basketprice">
											<input type="hidden" name="p_price" id="p_price1"
												class="p_price" value="9500">9,500원
										</div>
									</div>
								</td>

								<td class="align-middle">
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
															
								</td>
								<td class="align-middle">
									<div class="sum">40,000원</div>
								</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm">상세보기</a> <a
											class="btn btn-secondary btn-sm" onclick="javascript:basket.delItem();">삭제하기</a>
									</div>
								</td>
							</tr>
						</tbody>

						<tr class="">
							<th class="align-middle" scope="row">
								<div class="check">
									<input type="checkbox" name="buy" value="260" checked="">
								</div>
							<td><div class="img">
									<img src="/Project/assets/img/m4.jpg" class="img-thumbnail"
										style="width: 80px; height: 80px; object-fit: cover;" />
								</div></td>
							<td class="align-middle">텀블러</td>
							<td class="align-middle">35,000원</td>
							<td class="align-middle">
								<div class="updown">
									<input type="text" name="p_num1" id="p_num1" size="2"
										maxlength="4" class="p_num" value="2"> <span><i
										class="fas fa-arrow-alt-circle-up up"></i></span> <span><i
										class="fas fa-arrow-alt-circle-down down"></i></span>
								</div>
								</div>
							</td>
							<td class="align-middle">
								<div class="sum">40,000원</div>
							</td>
							<td>
								<div class="d-grid gap-2 col-6 mx-auto mt-1">
									<a class="btn btn-secondary btn-sm">상세보기</a> <a
										class="btn btn-secondary btn-sm">삭제하기</a>
								</div>
							</td>
						</tr>
						</tbody>

						<tr class="">
							<th class="align-middle" scope="row">
								<div class="check">
									<input type="checkbox" name="buy" value="260" checked="">
								</div>
							<td><div class="img">
									<img src="/Project/assets/img/m6.jpg" class="img-thumbnail"
										style="width: 80px; height: 80px; object-fit: cover;" />
								</div></td>
							<td class="align-middle">시럽 세트</td>
							<td class="align-middle">32,000원</td>
							<td class="align-middle">
								<div class="updown">
									<input type="text" name="p_num1" id="p_num1" size="2"
										maxlength="4" class="p_num" value="2"> <span><i
										class="fas fa-arrow-alt-circle-up up"></i></span> <span><i
										class="fas fa-arrow-alt-circle-down down"></i></span>
								</div>
								</div>
							</td>
							<td class="align-middle">
								<div class="sum">40,000원</div>
							</td>
							<td>
								<div class="d-grid gap-2 col-6 mx-auto mt-1">
									<a class="btn btn-secondary btn-sm">상세보기</a> <a
										class="btn btn-secondary btn-sm">삭제하기</a>
								</div>
							</td>
						</tr>
						</tbody>

						<tr class="">
							<th class="align-middle" scope="row">
								<div class="check">
									<input type="checkbox" name="buy" value="260" checked="">
								</div>
							<td><div class="img">
									<img src="/Project/assets/img/p7.jpg" class="img-thumbnail"
										style="width: 80px; height: 80px; object-fit: cover;" />
								</div></td>
							<td class="align-middle">과테말라 안티구아</td>
							<td class="align-middle">8,900원</td>
							<td class="align-middle">
								<div class="updown">
									<input type="text" name="p_num1" id="p_num1" size="2"
										maxlength="4" class="p_num" value="2"> <span><i
										class="fas fa-arrow-alt-circle-up up"></i></span> <span><i
										class="fas fa-arrow-alt-circle-down down"></i></span>
								</div>
								</div>
							</td>
							<td class="align-middle">
								<div class="sum">40,000원</div>
							</td>
							<td>
								<div class="d-grid gap-2 col-6 mx-auto mt-1">
									<a class="btn btn-secondary btn-sm">상세보기</a> <a
										class="btn btn-secondary btn-sm">삭제하기</a>
								</div>
							</td>
						</tr>
						</tbody>

						<tr class="">
							<th class="align-middle" scope="row">
								<div class="check">
									<input type="checkbox" name="buy" value="260" checked="">
								</div>
							<td><div class="img">
									<img src="/Project/assets/img/m7.jpg" class="img-thumbnail"
										style="width: 80px; height: 80px; object-fit: cover;" />
								</div></td>
							<td class="align-middle">써머 주스잔</td>
							<td class="align-middle">16,000원</td>
							<td class="align-middle">
								<div class="updown">
									<input type="text" name="p_num1" id="p_num1" size="2"
										maxlength="4" class="p_num" value="2"> <span><i
										class="fas fa-arrow-alt-circle-up up"></i></span> <span><i
										class="fas fa-arrow-alt-circle-down down"></i></span>
								</div>
								</div>
							</td>
							<td class="align-middle">
								<div class="sum">40,000원</div>
							</td>
							<td>
								<div class="d-grid gap-2 col-6 mx-auto mt-1">
									<a class="btn btn-secondary btn-sm">상세보기</a> <a
										class="btn btn-secondary btn-sm">삭제하기</a>
								</div>
							</td>
						</tr>
						</tbody>













						<tfoot>
							<tr>
								<th>합계</th>
								<th>수량 : 3</th>
								<th>가격 : 65000</th>
								<th colspan="3"></th>
							</tr>
						</tfoot>
					</table>


					<hr />
					<div class="right-align basketrowcmd">

						<a href="#" class="abutton">선택상품삭제</a> <a href="#" class="abutton">장바구니비우기</a>

						<div class="bigtext right-align sumcount" id="sum_p_num">상품갯수:
							4개</div>

						<div class="bigtext right-align box blue summoney"
							id="sum_p_price">합계금액: 74,200원</div>



					</div>


				</div>
			</div>
		</div>
	</div>


	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
</html>