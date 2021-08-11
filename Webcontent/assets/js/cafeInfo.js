$(document).ready(function() {
	/* 이미지 오버시 이벤트 */
	$('.imgUpdate').mouseover(function() {
		$(this).attr('style', 'width: 150px; height: 140px; object-fit: cover; cursor: pointer;');
		$(this).prevAll('.marks').addClass("visually-hidden");
		$(this).prevAll('.marks2').removeClass("visually-hidden");
	});
	$('.imgUpdate').mouseleave(function() {
		$(this).attr('style', 'width: 150px; height: 140px; object-fit: cover;');
		$(this).prevAll('.marks').removeClass("visually-hidden");
		$(this).prevAll('.marks2').addClass("visually-hidden");
	});
	/* 마크 오버시 이벤트 */
	$('.marks').mouseover(function() {
		$(this).addClass("visually-hidden");
		$(this).next().removeClass("visually-hidden");
	});
	$('.marks').mouseleave(function() {
		$(this).removeClass("visually-hidden");
		$(this).next().addClass("visually-hidden");
	});
	/* 선택삭제 fileIdx담기 */
	var arr = [];
	$('.imgUpdate').click(function() {
		arr.push($(this).attr("title"));
		$(this).parent('div').detach();
	})
	$('.marks2').click(function() {
		arr.push($(this).attr("title"));
		$(this).parent('div').detach();
	})
	/* 이미지 9장 이상 불가 */
	$('#cafeImg').change(function() {
		if ($(this)[0].files.length > 9) {
			$(this).attr("class", "form-control is-invalid");
		} else {
			$(this).attr("class", "form-control");
		}
	})
	/* 필수정보 유효성 검사 */
	$(".nullcheckgo").on("propertychange change keyup paste input", function() {
		if ($(this).val().trim() != "") {
			$(this).attr("class", "form-control nullcheckgo");
		}
		else {
			$(this).attr("class", "form-control is-invalid");
		}
	});
	/* 수정 클릭 유효성 검사 및 ajax */
	$("#cafeUpdateBtn").click(function() {
		/* 필수정보 유효성 검사 */
		$('.nullcheckgo').each(function() {
			if ($(this).val() == "") {
				$(this).addClass("is-invalid");
			}
		})
		/* 이미지 0장일시 알림 효과 */
		$('#redalert').addClass("visually-hidden");
		if ($('#cafeImg')[0].files.length == 0 && !$('.imagego').length) {
			$('#redalert').removeClass("visually-hidden");
			var imagecheck = false;
		} else {
			imagecheck = true;
		}
		/* 이미지 총합 9장 이상시 알림 효과 */
		$('#redalert2').addClass("visually-hidden");
		if ($('#cafeImg')[0].files.length + $('.imagego').length > 9) {
			$('#redalert2').removeClass("visually-hidden");
			var imagechecktwo = false;
		} else {
			imagechecktwo = true;
		}

		if ($("#cafeName").attr("class") == "form-control nullcheckgo"
			&& $("#cafeAddress").attr("class") == "form-control nullcheckgo"
			&& $("#cafePhone").attr("class") == "form-control nullcheckgo"
			&& $("#cafeTime").attr("class") == "form-control nullcheckgo"
			&& imagecheck == true && imagechecktwo == true) {
			Swal.fire({
				title: '정말 이대로 수정하시겠습니까?',
				text: "",
				icon: 'question',
				showDenyButton: true,
				confirmButtonColor: '#000',
				confirmButtonText: '수정하기',
				denyButtonText: '취소'
			}).then((result) => {
				if (result.isConfirmed) {
					var formData = new FormData();
					var cafeImg = $("input[name='cafeImg']");
					var files = cafeImg[0].files;
					formData.append('cafeName', $("input[name='cafeName']").val());
					formData.append('cafeLocation', $("select[name='cafeLocation']").val());
					formData.append('cafeAddress', $("input[name='cafeAddress']").val());
					formData.append('cafePhone', $("input[name='cafePhone']").val());
					formData.append('cafeTime', $("input[name='cafeTime']").val());
					formData.append('cafeDetail', $("textarea[name='cafeDetail']").val());
					formData.append('parkingCheck', $("input[name='parkingCheck']:checked").val());
					formData.append('petCheck', $("input[name='petCheck']:checked").val());
					formData.append('childCheck', $("input[name='childCheck']:checked").val());
					formData.append('rooftopCheck', $("input[name='rooftopCheck']:checked").val());
					formData.append('groupCheck', $("input[name='groupCheck']:checked").val());
					for (var i = 0; i < files.length; i++) {
						formData.append("cafeImg", files[i]);
					}
					for (var i = 0; i < arr.length; i++) {
						formData.append("delFileIdx", arr[i]);
					}
					$.ajax({
						type: "POST",//방식
						url: "./cafeUpdate",//주소
						data: formData,
						contentType: false,
						processData: false,
						dataType: 'JSON',
						success: function(data) {
							console.log(data);
							if (data.suc > 0) {
								Swal.fire(
									{
										title: '수정완료',
										icon: 'success',
										confirmButtonColor: '#000',
										confirmButtonText: '확인',
									}
								).then((result) => {
									location.href='/Project/cafeDetail?cafeKey='+data.cafeKey+'&pageCheck=cafeInfo'
								})
							}
						},
						error: function(e) {//실패시
							console.log(e);
						}
					})
				}
			})
		}
	})
})