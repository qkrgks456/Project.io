<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Calendar"%>
<%
Calendar cal = Calendar.getInstance();
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<!-- 부트스트랩 메타태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<link href="/Project/assets/css/bootstrap.css?ver=4" rel="stylesheet">
<!-- css cdn -->
<jsp:include page="/assets/css/csscdn.jsp"></jsp:include>
<!-- main css 추가 -->
<link href="/Project/assets/css/main.css?ver=6" rel="stylesheet">
<style type="text/css">
.list-group-item {
	border: 1px solid rgba(0, 0, 0, 0.125);
}
</style>
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
		<!-- 들어갈 내용 -->
		<div class="container px-5 mt-5 ">
			<h2 class="fw-bold my-3">신고하기</h2>
			<hr />
			<p>* 허위신고 일 경우,신고자의 서비스 활동이 제한 될 수 있으니 신중하게 신고해주세요</p>
			<div class="container px-4 py-4 my-4 w-75">
				<form class="container" action="/Project/cafeCommentReport"
					method="post">
					<div class="col-md-9 mb-4">
						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">피신고자아이디</h6>
						<input class="form-control" type="text"
							class="form-control col-md-3 mb-4" value="${param.memberKey}"
							name="UserID" id="UserId" readonly>
					</div>
					<div class="col-md-9 mb-4">
						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">신고
							사유</h6>
						<div class="form-check">
							<input class="form-check-input" type="radio" value="광고 / 음란성"
								name="reportReason" id="reportCheck1" checked> <label
								class="form-check-label" for="reportCheck1"> 광고 / 음란성 </label>
						</div>

						<div class="form-check">
							<input class="form-check-input" type="radio" value="욕설 / 부적합한 말"
								name="reportReason" id="reportCheck2"> <label
								class="form-check-label" for="reportCheck2"> 욕설 / 부적합한 말</label>
						</div>

						<div class="form-check">
							<input class="form-check-input" type="radio" value="회원 분란 유도"
								name="reportReason" id="reportCheck3"> <label
								class="form-check-label" for="reportCheck3"> 회원 분란 유도 </label>
						</div>

						<div class="form-check">
							<input class="form-check-input" type="radio" value="회원 비방"
								name="reportReason" id="reportCheck4"> <label
								class="form-check-label" for="reportCheck4"> 회원 비방 </label>
						</div>

						<div class="form-check">
							<input class="form-check-input" type="radio" value="도배성"
								name="reportReason" id="reportCheck5"> <label
								class="form-check-label" for="reportCheck5"> 도배성 </label>
						</div>
						<div class="form-check mt-2">
							<input class="form-check-input mt-2" type="radio"
								name="reportReason" id="reportCheck6"><input type="text"
								class="form-control col-md-3 mb-4" id="reason"
								placeholder="기타사유">
						</div>
						<input type="text" class="visually-hidden form-control col-md-3 mb-4" id="s" name="commentNo"
							value="${param.commentNo}" placeholder="기타사유">
					</div>

					<div class="col-md-9 mb-4">
						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">신고
							댓글</h6>
						<textarea class="form-control" id="exampleFormControlInput1"
							style="resize: none;" readonly>${param.commentContent}</textarea>
					</div>
					<input class="visually-hidden form-check-input" type="text" value="${param.cafeKey}" name="cafeKey">
					<div class="col-md-9 mb-4">
						<h6 class="text-muted mt-2 fw-bold" style="text-align: left;">신고
							날짜</h6>
						<div class="col-md-3 mb-4">
							<%=cal.get(Calendar.YEAR)%>년
							<%=cal.get(Calendar.MONTH) + 1%>월
							<%=cal.get(Calendar.DATE)%>일
						</div>
					</div>
					<div class="col-md-9 mb-4">
						<button class="btn btn-dark" type="submit" id="reportbtn">신고하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 하단 정보 -->
	<jsp:include page="/fixMenu/footer.html"></jsp:include>
	<!-- 스크립트 추가라인  -->
	<jsp:include page="/assets/js/jscdn.jsp"></jsp:include>
	<script type="text/javascript">
		$('input[name="reportReason"]').change(function() {
			console.log("아녕");
			if ($('#reportCheck6').is(':checked')) {
				$('#reason').focus();
			}		
		})
		$('#reason').on("propertychange change keyup paste input", function() {
			$('#reportCheck6').val($(this).val());
			console.log($('#reportCheck6').val());
		});
	</script>
	<!-- main js 추가 -->
	<script src="/Project/assets/js/main.js?var=6"></script>
</body>
</html>