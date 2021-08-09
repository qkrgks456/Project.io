$(document).ready(function() {

	/* 등록 ajax */
	$('#cafeCommentBtn').click(function() {
	console.log("안녕");
		var commentContent = $('#commentContent').val();
		if (commentContent.trim() != "") {
			$('#commentContent').removeClass('is-invalid');
			var cafeKey = $('#cafeCommentBtn').attr("title");
			$.ajax({
				type: "POST",//방식
				url: "/Project/cafeCommentInput",//주소
				data: {
					commentContent: commentContent,
					cafeKey: cafeKey,
				},
				dataType: 'JSON',
				success: function(data) { //성공시
					commentList(data);
					$('#commentContent').val("");
				},
				error: function(e) { //실패시
					console.log(e);
				}
			});

		} else {
			$('#commentContent').addClass('is-invalid');
		}
	})

	/* 삭제 ajax */
	$('#commentLists').on('click', '.commentDelBtn', function() {
		var commentNo = $(this).attr('title');
		var cafeKey = $('#cafeCommentBtn').attr("title");
		$.ajax({
			type: "POST",//방식
			url: "/Project/cafeCommentDel",//주소
			data: {
				commentNo: commentNo,
				cafeKey: cafeKey,
			},
			dataType: 'JSON',
			success: function(data) { //성공시
				commentList(data);
			},
			error: function(e) { //실패시
				console.log(e);
			}
		});
	})
	/* 페이지 네이션 클릭시 ajax */
	$('#paginations').on('click', '.pageNum', function() {
		var pageAndCafeKey = $(this).attr('title');
		var pageArr = pageAndCafeKey.split(' ');
		var page = pageArr[0];
		var cafeKey = pageArr[1];
		$.ajax({
			type: "POST",//방식
			url: "/Project/cafeCommentList",//주소
			data: {
				page: page,
				cafeKey: cafeKey,
			},
			dataType: 'JSON',
			success: function(data) { //성공시
				commentList(data);
			},
			error: function(e) { //실패시
				console.log(e);
			}
		});
	})

	/* 업데이트 ajax */
	$(document).on('click', '.commentUpdateContentBtn', function() {
		var commentNo = $(this).attr('title');
		var cafeKey = $('#cafeCommentBtn').attr("title");
		var commentUpdateContent = $(this).parent().prev().children('.commentUpdateContent').val();
		console.log(commentUpdateContent);
		if (commentUpdateContent.trim() != "") {
			$.ajax({
				type: "POST",//방식
				url: "/Project/cafeCommentUpdate",//주소
				data: {
					commentUpdateContent: commentUpdateContent,
					commentNo: commentNo,
					cafeKey: cafeKey,
				},
				dataType: 'JSON',
				success: function(data) { //성공시
					commentList(data);
				},
				error: function(e) { //실패시
					console.log(e);
				}
			});
		} else {
			$(this).parent().prev().children('.commentUpdateContent').addClass('is-invalid');
		}
	})

	/* 수정 누를시 폼 변환 */
	$('#commentLists').on('click', '.commentUpdateBtn', function() {
		$(this).parents('.updateCheck').addClass("visually-hidden");
		$(this).parents('.updateCheck').next('.updateForm').removeClass("visually-hidden");
	})
	$('#commentLists').on('click', '.cmUpdateCancel', function() {
		$(this).parents('.updateForm').addClass("visually-hidden");
		$(this).parents('.updateForm').prev('.updateCheck').removeClass("visually-hidden");
	})
	/* 좋아요 버튼 누를시 크기 변경 색상변경 */

	$('#good').mousedown(function() {
		$('#goodicon').css("font-size", "1.8rem");
	})


	/* 댓글 버튼 누를시 크기 변경 */
	$('#commenticon').mousedown(function() {
		$('#commenticons').css("font-size", "1.8rem");
	})
	$('#commenticon').mouseup(function() {
		$('#commenticons').css("font-size", "2.0rem");
	})

	/* 댓글 클릭시 하단 이동*/
	$("#commenticon").click(function() {
		$("html").animate({
			scrollTop: $('#comments').offset().top
		}, 0);
	})

	/* 댓글 리스트 메서드 */
	function commentList(data) {
		console.log(data);
		var content = "";
		var sessionId = data.sessionId;

		$.each(data.list, function(i, item) {
			var check = sessionId == item.memberKey;
			content += "<div class='updateCheck'>"
			content += "<p class='fw-bold'>" + item.memberKey + "</p>";
			content += "<p class='lh-sm'>";
			content += item.cm_content;
			if (!check) {
				content += "<a href='/Project/report/report.jsp' class='float-end btn btn-secondary btn-sm'>신고</a>";
			} else {
				content += "<a class='commentDelBtn mx-2 float-end btn btn-secondary btn-sm' title='" + item.commentNo + "'>삭제</a>";
				content += "<a class='commentUpdateBtn float-end btn btn-secondary btn-sm'>수정</a>";
			}
			content += "</p>";
			content += "<hr/>";
			content += "</div>";
			content += "<div class='updateForm visually-hidden'>"
			content += "<p class='fw-bold'>" + item.memberKey + "</p>"
			content += "<div class='form-floating flex-grow-1 px-2'>"
			content += "<textarea class='commentUpdateContent form-control' placeholder='Leave a comment here'"
			content += "name='commentUpdateContent' id='commentUpdateContent' style='height: 100px'>" + item.cm_content + "</textarea>"
			content += "<div class='invalid-feedback'>1자 이상 입력해주세요</div>"
			content += "<label for='commentUpdateContent'>수정할 댓글을 작성하세요</label>"
			content += "</div>"
			content += "<div class='d-flex justify-content-end mt-2' id='commentUpdateOut'>"
			content += "<a id='commentUpdateContentBtn' class='commentUpdateContentBtn btn btn-secondary btn-sm mx-2' title='" + item.commentNo + "'>등록</a>"
			content += "<a class='cmUpdateCancel btn btn-secondary btn-sm'>취소</a>"
			content += "</div>"
			content += "<hr />"
			content += "</div>"
		});
		$('#commentLists').empty();
		$('#commentLists').append(content);

		content = "";
		content += "<i id='commenticons' class='bi bi-chat-square-text-fill mt-1' style='font-size: 2.0rem;'></i>"
		content += "<p  class='ms-2 mt-3 fw-bold'>댓글(" + data.commentCount + ")</p>"
		$('#commenticon').empty();
		$('#commenticon').append(content);
		/* 페이지네이션 불러오기 욕나오네 */
		content = "";
		content += '<ul id="paginations1" class="pagination justify-content-center">'
		if (data.startPage != 1) {
			content += '<li class="page-item"><a class="page-link pageNum"'
			content += 'title="' + (data.startPage - 1) +" "+data.cafeKey+'" role="button"'
			content += 'aria-label="Previous"> <span aria-hidden="true">&laquo;</span>'
			content += '</a></li>'
		}
		for (var i = data.startPage; i <= data.endPage; i++) {
			console.log(data.currPage)
			if (data.currPage != i) {
				content += '<li class="page-item"><a role="button" class="page-link pageNum"'
				content += ' title="' + i + " " + data.cafeKey + '">' + i + '</a></li>'
			} else {
				content += '<li class="page-item active"><a class="page-link">' + i + '</a></li>'
			}
		}
		if (data.totalPage != data.endPage) {
			content += '<li class="page-item"><a class="page-link pageNum" role="button"'
			content += 'title="' + (data.endPage + 1)+" "+data.cafeKey+'" aria-label="Next">'
			content += '<span aria-hidden="true">&raquo;</span>'
			content += '</a></li>'
		}
		content += '</ul>'
		$('#paginations').empty();
		$('#paginations').prepend(content);
	}
	// 변수 가져오기
	var goodCheckBtn = $('#goodicon').attr("title");
	var cafeKey = $('#cafeCommentBtn').attr("title");
	// 좋아요 체크
	if (goodCheckBtn == 'false') {
		$('#goodicon').css("font-size", "2.0rem");
		$('#goodicon').css("color", "#0d6efd");
		$('#goodtext').addClass("text-primary");
	} else {
		$('#goodicon').css("font-size", "2.0rem");
		$('#goodicon').css("color", "black");
		$('#goodtext').removeClass("text-primary");
	}
	// 좋아요 ajax
	$('#good').mouseup(function() {
		if (goodCheckBtn == 'true') {
			$.ajax({
				type: "POST",//방식
				url: "/Project/cafeGood",//주소
				data: {
					goodCheckBtn: goodCheckBtn,
					cafeKey: cafeKey,
				},
				dataType: 'JSON',
				success: function(data) { //성공시

					console.log(data);
					goodCheckBtn = 'false';
					content = "";
					content += '<i id="goodicon" class="bi bi-hand-thumbs-up-fill" title="' + goodCheckBtn + '"';
					content += ' style="font-size: 2.0rem;"></i>';
					content += '<p id="goodtext" class="ms-2 mt-3 fw-bold">좋아요(' + data.cafeGoodCount + ')</p>'
					$('#good').empty();
					$('#good').append(content);
					$('#goodicon').css("color", "#0d6efd");
					$('#goodtext').addClass("text-primary");
				},
				error: function(e) { //실패시
					console.log(e);
				}
			})

		} else {

			$.ajax({
				type: "POST",//방식
				url: "/Project/cafeGood",//주소
				data: {
					goodCheckBtn: goodCheckBtn,
					cafeKey: cafeKey,
				},
				dataType: 'JSON',
				success: function(data) { //성공시
					console.log(data);
					goodCheckBtn = 'true';
					content = "";
					content += '<i id="goodicon" class="bi bi-hand-thumbs-up-fill" title="' + goodCheckBtn + '"';
					content += ' style="font-size: 2.0rem;"></i>';
					content += '<p id="goodtext" class="ms-2 mt-3 fw-bold">좋아요(' + data.cafeGoodCount + ')</p>'
					$('#good').empty();
					$('#good').append(content);
					$('#goodicon').css("color", "black");
					$('#goodtext').removeClass("text-primary");

				},
				error: function(e) { //실패시
					console.log(e);
				}
			})
		}
	})

})