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
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">상품정보</h2>
				</div>
				<div class="container">
					<table class="table table-hover mt-2">
						<thead class="table-light">
							<tr>
								<th scope="col"><input id="allCheck" type="checkbox"
									class="form-check" onclick="allChk(this);" /></th>
								<th scope="col">상품명</th>
								<th scope="col">상품코드</th>
								<th scope="col">가격</th>
								<th scope="col">수량</th>
								<th class="text-center" scope="col">관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${requestMap.userList}">
								<tr>
									<td class="text_ct"><input ﻿ name="RowCheck"
										type="checkbox" value="${result.user_id}" /></td>


									</th>
									<td class="align-middle">과테말라 안티구아${result.user_id}</td>
									<td class="align-middle">30133${result.duty}</td>
									<td class="align-middle">8,900원${result.position_nm}</td>
									<td class="align-middle">53개${result.email}</td>
									<td>
										<div class="d-grid gap-2 col-6 mx-auto mt-1">
											<button class="btn btn-secondary btn-sm" type="button"
												onclick="location.href='/Project/myShopping/sell/productInput/productInput.jsp'">상세보기</button>
											<a class="btn btn-secondary btn-sm"
												onclick="location.href='/Project/myShopping/sell/productList/productDelResult.jsp'">삭제하기</a>
										</div>
										</div>
										</div>
									</td>
								</tr>


								<tr>
									<th class="align-middle" scope="row">
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckDefault">

										</div>
									</th>
									<td class="align-middle">에티오피아 예가체프 G2</td>
									<td class="align-middle">30323</td>
									<td class="align-middle">8,000원</td>
									<td class="align-middle">82개</td>
									<td>
										<div class="d-grid gap-2 col-6 mx-auto mt-1">
											<button class="btn btn-secondary btn-sm" type="button"
												onclick="location.href='/Project/myShopping/sell/productInput/productInput.jsp'">상세보기</button>
											<a class="btn btn-secondary btn-sm"
												onclick="location.href='/Project/myShopping/sell/productList/productDelResult.jsp'">삭제하기</a>

										</div>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<!-- 상품삭제(상품블라인드처리 부분) -->
					<input type="hidden"  class = "form-control" id="blackpruductId" name="blackproductId" value="">
						<button id="blackaddsubmit" class="btn btn-dark" type="submit">선택 상품 삭제</button>

				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.jsp"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<script type="text/javascript">

// 1.모두 체크
  function allChk(obj){
      var chkObj = document.getElementsByName("RowCheck");
      var rowCnt = chkObj.length - 1;
      var check = obj.checked;
      if (check) {﻿
          for (var i=0; i<=rowCnt; i++){
           if(chkObj[i].type == "checkbox")
               chkObj[i].checked = true;
          }
      } else {
          for (var i=0; i<=rowCnt; i++) {
           if(chkObj[i].type == "checkbox"){
               chkObj[i].checked = false;
           }
          }
      }
  } 

﻿ ﻿ 

//﻿2. 체크박스 선택된 것 삭제 처리 (N개) 
   function fn_userDel(){

  var userid = "";
  var memberChk = document.getElementsByName("RowCheck");
  var chked = false;
  var indexid = false;
  for(i=0; i < memberChk.length; i++){
   if(memberChk[i].checked){
    if(indexid){
      userid = userid + '-';
    }
    userid = userid + memberChk[i].value;
    indexid = true;
   }
  }
  if(!indexid){
   alert("삭제할 상품 정보를 체크해 주세요");
   return;
  }
  document.userForm.delUserid.value = userid;      

  
  var agree=confirm("삭제 하시겠습니까?");
     if (agree){
   document.userForm.execute.value = "userDel";
     document.userForm.submit();
     }
  }﻿

  public void userDel(Map requestMap) throws Exception {
	  ﻿
	  String delUser = requestMap.get(Management.DEL_USER).toString();
	  System.out.println("Service ======= delUser>>" + delUser);
	  
	  String[] userArr = delUser.split("-");                     // '-'로 연결된 userid를 split으로 잘라 배열에 넣음.
	  
	     if(userArr != null && userArr.length>0){
	       for(int i=0 ; i<userArr.length ; i++){
	        requestMap.put(Parameter.USER_ID , userArr[i]);
	        System.out.println("==============    "+i +"번째 userid ==  " + requestMap.get(Parameter.USER_ID));
	        manageDao.userDel(requestMap);
	       }
	     } 
	 }
 

</script>

	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=4"></script>
</body>

</html>