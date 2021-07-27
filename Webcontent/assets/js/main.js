$(document).ready(function() {

	/* 좌측메뉴 집어넣기 */
	$('#sidebarCollapse').on('click', function() {
		$('#sidebar').toggleClass('active');
	});

	/* 툴팁 생성 */
	var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
		return new bootstrap.Tooltip(tooltipTriggerEl);
	})

	/* 좋아요 hover 이벤트 */
	$('#good').mouseover(function() {
		$('#goodicon').css("color", "#0d6efd");
	});
	$('#good').mouseleave(function() {
		$('#goodicon').css("color", "black");
	});
	/* 카페 이미지 마우스 올릴시 투명해짐 */
	$('.imgs').mouseover(function() {
		$(this).attr('style', 'width: 150px; height: 140px; object-fit: cover; opacity: 0.7; cursor: pointer;')
	});
	$('.imgs').mouseleave(function() {
		$(this).attr('style', 'width: 150px; height: 140px; object-fit: cover;')
	});

	/* 이미지에 주소값이 있어야만 이미지 태그가 보여짐 */
	$('.imgs').each(function(i) {
		if ($(this).attr("src") != '') {
			$(this).removeClass('visually-hidden');
		}
	})

	/* 이미지 클릭시 대표이미지로 보여짐 */
	$('.imgs').click(function() {
		$('#mainimg').attr('src', $(this).attr('src'));
	});


	/* 회원탈퇴 버튼 누를시 회원탈퇴폼 보여짐 */
	$('#exit').click(function() {
		$('#myinfoform').addClass('visually-hidden');
		$('#exitform').removeClass('visually-hidden');
	})
	/* 탈퇴에서 돌아가기 누를시 내정보폼 보여짐 */
	$('#turnbtn').click(function() {
		$('#myinfoform').removeClass('visually-hidden');
		$('#exitform').addClass('visually-hidden');
	})

	/* 알림창 hover 이벤트 */
	$('#navalert').mouseover(function() {
		$('#navalertnum').attr('class', 'border border-dark position-absolute top-0 mx-3 badge bg-warning text-dark rounded-pill mt-2');
		$('#bell').css("color", "#ffc107");
	})
	$('#navalert').mouseleave(function() {
		$('#bell').css("color", "white");
		$('#navalertnum').addClass('bg-white');
	})

	/* 장바구니 hover 이벤트 */
	$('#cartalert').mouseover(function() {
		$('#cartalertnum').attr('class', 'border border-dark position-absolute top-0 mx-3 badge bg-warning text-dark rounded-pill mt-2');
		$('#cart').css("color", "#ffc107");
	})
	$('#cartalert').mouseleave(function() {
		$('#cart').css("color", "white");
		$('#cartalertnum').addClass('bg-white');
	})

	/*현재 페이지 이름 가져온후 메뉴 활성화*/
	$(".nav-item a").each(function(i) {
		if ($(location).attr('href').split('/').pop()
			== $('.nav-item a').eq(i).attr('href').split('/').pop()) {
			$('.nav-item a').eq(i).addClass("active")
		}
	})

	/* 로그인버튼 누르면 로그인창 초기화*/
	$('#loginbtn').click(function() {

	})

	/* 약관동의 사이트 이동 */
	$("#allCheck").click(function() { //만약 전체 선택 체크박스가 체크된상태일경우 
		if ($("#allCheck").prop("checked")) {
			//해당화면에 전체 checkbox들을 체크해준다 
			$("input[type=checkbox]").prop("checked", true);
		}
		else {  // 전체선택 체크박스가 해제된 경우 
			//해당화면에 모든 checkbox들의 체크를해제시킨다.	
			$("input[type=checkbox]").prop("checked", false);
		}
	})

	/* 일반회원 회원가입 페이지로 */
	$('#member').click(function() {
		if (($('input[name=Check]:checked').length) == $('input[name=Check]').length) {
			location.href = '/Project/signUp/join.jsp';
		}
		else {
			$("input:checkbox[name='Check']").each(function() {
				if ($(this).is(":checked") == false) {
					$(this).addClass('form-check-input is-invalid');
				} else {
					$(this).removeClass('form-check-input is-invalid');
					$(this).addClass('form-check-input');
				}
			});
		}
	})
	/* 엔터치면 로그인 */
	$("#InputPassword").keyup(function(e) {
		if (e.keyCode == 13) {
			$('#login').click();
		}
	})

	/* 로그인창 로그인 버튼 클릭시 유효성 검사*/
	var path = $(location).attr('href').split('/').pop();
	$('#login').click(function() {
		if ($('#InputId').val() == "" && $('#InputPassword').val() == "") {
			$('#InputId').addClass('form-control is-invalid');
			$('#InputPassword').addClass('form-control is-invalid');
		}
		else if ($('#InputPassword').val() == "") {
			$('#InputPassword').addClass('form-control is-invalid');

		}
		else if ($('#InputId').val() == "") {
			$('#InputId').addClass('form-control is-invalid');
		} else { /* 모두 공백이 아닐경우 서버로 데이터 전송 */
			var InputId = $("#InputId").val();
			var InputPassword = $("#InputPassword").val();
			$.ajax({
				url: "/Project/login",
				type: "POST",
				dataType: "text",
				data: {
					"path": path,
					"InputId": InputId,
					"InputPassword": InputPassword,
				},
				success: function(data) {
					/* 로그인 정보가 맞을경우 */
					if (data == "1") {
						location.href = "../index.jsp";
					} else {/* 로그인 정보가 틀릴경우 */
						$('#redalert').removeClass('visually-hidden');
					}
				},
				error: function() {
					alert("안 보내짐");
				}

			})
		}
	})
	// 로그인창 글자수 검사
	$("#InputId").on("propertychange change keyup paste input", function() {
		if ($(this).val().length >= 1) {
			$(this).attr('class', 'form-control is-valid');
		} else {
			$(this).attr('class', 'form-control is-invalid');
		}
	});

	$("#InputPassword").on("propertychange change keyup paste input", function() {
		if ($(this).val().length >= 1) {
			$(this).attr('class', 'form-control is-valid');
		} else {
			$(this).attr('class', 'form-control is-invalid');
		}
	});
	/* 회원가입시 포커스 */
	$("input[name=UserId]").focus();

	/* 회원가입시 공백 검사 */
	$("#UserId").on("propertychange change keyup paste input", function() {
		if ($(this).val().length >= 6) {
			$(this).attr("class", "form-control is-valid");
		}
		else {
			$(this).attr("class", "form-control is-invalid");
		}
	});

	$("#UserPw").on("propertychange change keyup paste input", function() {
		if ($(this).val().length >= 10) {
			$(this).attr("class", "form-control is-valid");
		}
		else {
			$(this).attr("class", "form-control is-invalid");
		}
	});

	$("#UserPwch").on("propertychange change keyup paste input", function() {
		if ($("#UserPw").val() == $(this).val()) {
			$(this).attr("class", "form-control is-valid");
		}
		else {
			$(this).attr("class", "form-control is-invalid");
		}
	});
	$(".nullchecks").on("propertychange change keyup paste input", function() {
		if ($(this).val().length >= 1) {
			$(this).attr("class", "form-control is-valid");
		}
		else {
			$(this).attr("class", "form-control is-invalid");
		}
	});

	/* 회원가입시 유효성 검사 */
	$("#signupbtn").click(function() {
		$('.nullcheck').each(function() {
			if ($(this).val() == "") {
				$(this).addClass = ("is-invalid");
			}
		});

		if ($("#UserId").attr("class") == "form-control is-valid"
			&& $("#UserPw").attr("class") == "form-control is-valid"
			&& $("#UserPwch").attr("class") == "form-control is-valid"
			&& $("#UserName").attr("class") == "form-control is-valid"
			&& $("#UserEmail").attr("class") == "form-control is-valid"
			&& $("#UserAddress").attr("class") == "form-control is-valid"
			&& $("#UserDate").attr("class") == "form-control is-valid"
			&& $("#Userphone").attr("class") == "form-control is-valid") {
			$(this).attr("type", "submit");
		}
	})

	/* 사이드바 활성화 */
	$("div.list-group a").each(function(i) {
		if ($(location).attr('href').split('/').pop()
			== $("div.list-group a").eq(i).attr('href').split('/').pop()) {
			$("div.list-group a").eq(i).addClass("active")
		}
	})
	/* 댓글 클릭시 하단 이동*/
	$("#commenticon").click(function() {
		$("html").animate({
			scrollTop: $('#comments').offset().top
		}, 0);
	})
	/* 댓글 over 이벤트 */
	$('#commenticon').mouseover(function() {
		$('#commenticons').css("color", "#ffc107");
	});
	$('#commenticon').mouseleave(function() {
		$('#commenticons').css("color", "black");
	});
	
	/* 카페등록 유효성 검사 */
	
})





