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
<link href="/Project/assets/css/bootstrap.css?ver=15" rel="stylesheet">
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<link href="/Project/assets/css/main.css?ver=15" rel="stylesheet">
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
		<div class="d-flex" style="height: auto; min-height: 100vh;">
			<jsp:include page="../myPagesideBar.jsp"></jsp:include>
			<!-- 오른쪽 시작 -->
			<div class="cont container-fluid mx-5 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-secondary">
						<i class="bi bi-text-left"></i>
					</button>
					<h2 class="fw-bold my-3">알림리스트</h2>
				</div>
				<hr />
				<!-- 내용시작 -->
				<div id="cafeAlarmBox" class="cont container w-50">
				<c:if test="${cafeAlarmList[0].alarmContent ne null}">
				<c:forEach items="${cafeAlarmList}" var="cafeAlarmLists">				
					<div class="d-flex form-check align-items-center m-0 p-0">
						<input class="form-check-input me-2" type="checkbox" value="${cafeAlarmLists.alarmNum}"
							id="flexCheckChecked" name="cafeAlarmDelNum">
						<div class="mt-3 flex-grow-1 alert alert-warning" role="alert">${cafeAlarmLists.alarmContent}</div>
					</div>				
				</c:forEach>
				<div class="col text-center">
						<button id="cafeAlarmDelBtn"class="btn btn-dark" type="button">삭제</button>
				</div>
				</c:if>
				<c:if test="${cafeAlarmList[0].alarmContent eq null}">
					<div class="text-center text-muted">등록된 알림이 없습니다</div>				
				</c:if>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<script type="text/javascript">
	$(document).on('click','#cafeAlarmDelBtn',function() {
		var cafeAlarmDelNum = [];
		$('input[name="cafeAlarmDelNum"]:checked').each(function(i, element) {
			cafeAlarmDelNum.push($(this).val());
		})
		console.log(cafeAlarmDelNum);
		$.ajax({
			type: "POST",//방식
			url: "/Project/cafeAlarmDel",//주소
			data: {
				cafeAlarmDelNum: cafeAlarmDelNum,
			},
			dataType: 'JSON',
			success: function(data) { //성공시
				console.log(data.cafeAlarmList.length);
				content="";
				if(data.cafeAlarmList.length != 0){
					$.each(data.cafeAlarmList,function(i, item) {
						content +=	'<div class="d-flex form-check align-items-center m-0 p-0">'
							content += '<input class="form-check-input me-2" type="checkbox" value="'+item.alarmNum+'"'
							content +=	' id="flexCheckChecked" name="cafeAlarmDelNum">'
								content += '<div class="mt-3 flex-grow-1 alert alert-warning" role="alert">'+item.alarmContent+'</div>'
								content += '</div>'
					})								
					content += 	'<div class="col text-center">'
					content += 	'<button id="cafeAlarmDelBtn"class="btn btn-dark" type="button">삭제</button>'
					content += 	'</div>'
					
				}else{
					content +='<div class="text-center text-muted">등록된 알림이 없습니다</div>'		
				}

			$('#cafeAlarmBox').empty();
			$('#cafeAlarmBox').append(content);
			},
			error: function(e) { //실패시
				console.log(e);
			}
		});
	})
	
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=2"></script>
</body>
</html>