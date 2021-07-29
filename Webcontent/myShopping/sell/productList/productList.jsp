<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript">
	function setCheckUserList() {
		
		//체크된 체크박스 개수구하기
		console.log("length: "+$("input:checkbos[name=userList]:checked").length);
	
		var idList = "";
		var nameList = "";
		
		//체크된 체크박스 가져오기
		var checkbox=$("input:checkbox[name=userList]:checked");
		
		//체크된 체크박스의 값을 반복해 불러오기
		checkbox.each(function(i){
			
			var tr = checkbox.parent().parent()eq(i);
			var td = tr.children();
			
			var name = td.eq(0).text();
			var userid = td.eq(1).text();
			
			nameList +=name+"/";
			idList +=userid+"/";
			
			
		});
		
		nameList = nameList.subString(0,nameList.length-1);
		idList=idList.substring(0,idList.length-1); //끝에 '/'삭제
		$("seluserNmList").val(nameList);
		$("#userIdList").val(idList);
	
	}

	
</script>

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
			<div class="cont container-fluid mx-3 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>



					<h2 class="fw-bold my-3">상품정보</h2>
				</div>
				<div class="container">
					<table class="table table-hover mt-1">
						<thead class="table-light">
							<tr>
								<th class="text-center" scope="col">#</th>
								<th class="text-center" scope="col">이미지</th>
								<th class="text-center" scope="col">상품명</th>
								<th class="text-center" scope="col">상품코드</th>
								<th class="text-center" scope="col">가격</th>
								<th class="text-center" scope="col">관리</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="align-middle" scope="row"><input type="checkbox"
									name="seller"></th>
								<td><img src="/Project/assets/img/p1.jpg"
									class="img-thumbnail"
									style="width: 80px; height: 80px; object-fit: cover;" /></td>
								<td class="align-middle">에티오피아 예가체프 G2</td>
								<td class="align-middle">30120</td>
								<td class="align-middle">8,900원</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm" onclick="location.href='/Project/MainProduct/product.jsp'">상세보기</a> <a
											class="btn btn-secondary btn-sm" onclick="location.href='/Project/myShopping/sell/productInput/productInput.jsp'">삭제</a>
									</div>
								</td>
							</tr>
							<tr>
								<th class="align-middle" scope="row"><input type="checkbox"
									name="seller"></th>
								<td><img src="/Project/assets/img/p1.jpg"
									class="img-thumbnail"
									style="width: 80px; height: 80px; object-fit: cover;" /></td>
								<td class="align-middle">에티오피아 예가체프 G2</td>
								<td class="align-middle">30120</td>
								<td class="align-middle">8,900원</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm" onclick="location.href='/Project/MainProduct/product.jsp'">상세보기</a> <a
											class="btn btn-secondary btn-sm" onclick="location.href='/Project/myShopping/sell/productInput/productInput.jsp'">삭제</a>
									</div>
								</td>
							</tr>
							<tr>
								<th class="align-middle" scope="row"><input type="checkbox"
									name="seller"></th>
								<td><img src="/Project/assets/img/p1.jpg"
									class="img-thumbnail"
									style="width: 80px; height: 80px; object-fit: cover;" /></td>
								<td class="align-middle">에티오피아 예가체프 G2</td>
								<td class="align-middle">30120</td>
								<td class="align-middle">8,900원</td>
								<td>
									<div class="d-grid gap-2 col-6 mx-auto mt-1">
										<a class="btn btn-secondary btn-sm" onclick="location.href='/Project/MainProduct/product.jsp'">상세보기</a> <a
											class="btn btn-secondary btn-sm" onclick="location.href='/Project/myShopping/sell/productInput/productInput.jsp'">삭제</a>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<script>
		$("#selectBtn").click(function() {
			var rowData = new Array();
			var tdArr = new Array();
			var checkbox = $("input[name=user_CheckBox]:checked");

			//체크된 체크박스값 가져오기
			checkbox.each(function(i) {

				//checkbox.parent():checkbox의 부모는 <td>
				//checkbox.parent().parent():<td>의 부모이므로 <tr>

				var tr = checkbox.parent().parent().eq(i);
				var td = tr.chidren();

				//체크된 row의 모든 값을 배열에 담기
				rowData.push(tr.text());

				//td.eq(0)은 체크박스 이므로 td.eq(1)의 값부터 가져온다.

				var no = td.eq(1).text + ", "
				var userid = td.eq(2).text() + ", ";
				var name = td.eq(3).text() + ", ";
				var email = td.eq(4).text() + ", ";

				//가져온 값을 배열에 담기
				tdArr.push(no);
				tdArr.push(userid);
				tdArr.push(name);
				tdArr.push(email);

			});

			$("#ex3_Result1").html("*체크된 Row의 모든 데이터=" + rowData);
			$("$ex3_Result2").html(tdArr);

		});
	</script>

	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=4"></script>
</body>

</html>