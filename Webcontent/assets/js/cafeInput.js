$(document).ready(function() {
	$('#cafeImg').change(function() {
		if ($(this)[0].files.length > 9) {
			$("#nineMust").removeClass("visually-hidden");
			$("#oneMust").addClass("visually-hidden");
			$(this).attr("class", "form-control is-invalid");
		} else if ($(this)[0].files.length == 0) {
			$("#oneMust").removeClass("visually-hidden");
			$("#nineMust").addClass("visually-hidden");
			$(this).attr("class", "form-control is-invalid");
		} else {
			$(this).attr("class", "form-control is-valid");
		}
	})

	$('#ownerNoImg').change(function() {
		if ($(this)[0].files.length == 0) {
			$(this).attr("class", "form-control is-invalid");
		} else {
			$(this).attr("class", "form-control is-valid");
		}
	})
	$("#cafeInputbtn").click(function() {
		$('.nullchecks').each(function() {
			if ($(this).val().trim()==""){
				$(this).addClass("is-invalid");
			}
		})
		if ($("#cafeName").attr("class") == "form-control is-valid"
			&& $("#cafeAddress").attr("class") == "form-control is-valid"
			&& $("#cafePhone").attr("class") == "form-control is-valid"
			&& $("#cafeTime").attr("class") == "form-control is-valid"
			&& $("#ownerNo").attr("class") == "form-control is-valid"
			&& $("#ownerNoImg").attr("class") == "form-control is-valid"
			&& $("#cafeImg").attr("class") == "form-control is-valid") {
			Swal.fire({
				title: '정말 이대로 등록하시겠습니까?',
				text: "검수기간동안 다시 등록할 수 없습니다",
				icon: 'question',
				showDenyButton: true,
				confirmButtonColor: '#000',
				confirmButtonText: '등록하기',
				denyButtonText: '취소'
			}).then((result) => {
				if (result.isConfirmed) {
					var formData = new FormData();
					var ownerNoImg = $("input[name='ownerNoImg']");
					var cafeImg = $("input[name='cafeImg']");
					var filestwo = ownerNoImg[0].files;
					var files = cafeImg[0].files;
					formData.append('cafeName', $("input[name='cafeName']").val());
					formData.append('cafeLocation', $("select[name='cafeLocation']").val());
					formData.append('cafeAddress', $("input[name='cafeAddress']").val());
					formData.append('cafePhone', $("input[name='cafePhone']").val());
					formData.append('cafeTime', $("input[name='cafeTime']").val());
					formData.append('cafeDetail', $("textarea[name='cafeDetail']").val());
					formData.append('ownerNo', $("input[name='ownerNo']").val());
					formData.append('parkingCheck', $("input[name='parkingCheck']:checked").val());
					formData.append('petCheck', $("input[name='petCheck']:checked").val());
					formData.append('childCheck', $("input[name='childCheck']:checked").val());
					formData.append('rooftopCheck', $("input[name='rooftopCheck']:checked").val());
					formData.append('groupCheck', $("input[name='groupCheck']:checked").val());
					for (var i = 0; i < files.length; i++) {
						formData.append("cafeImg", files[i]);
					}
					for (var i = 0; i < filestwo.length; i++) {
						formData.append("ownerNoImg", filestwo[i]);
					}
					$.ajax({
						type: "POST",//방식
						url: "/Project/cafewrite",//주소
						data: formData,
						contentType: false,
						processData: false,
						dataType: 'JSON',
						success: function(data) {
							console.log(data);
							if (data.suc > 0) {
								location.href = '/Project/myPage/cafeMenu/cafeInput/cafeInputResult.jsp';
							} else {
								console.log("실패지롱");
								Swal.fire(
									{
										title: '등록실패',
										icon: 'error',
										confirmButtonColor: '#000',
										text: '이미 카페가 등록되어 있습니다',
										confirmButtonText: '확인',
									}
								).then((result) => {

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
		if ($("#ownerNo").attr("class") == "form-control") {
			$("#ownerNo").addClass("is-invalid");
		}
		if ($('#cafeImg')[0].files.length > 9) {
			$('#cafeImg').addClass("is-invalid");
		} else if ($('#cafeImg')[0].files.length == 0) {
			$("#oneMust").removeClass("visually-hidden");
			$("#nineMust").addClass("visually-hidden");
			$('#cafeImg').addClass("is-invalid");
		}
		if ($('#ownerNoImg')[0].files.length == 0) {
			$('#ownerNoImg').addClass("is-invalid");
		}

	})

	$("#ownerNobtn").click(function() {
		if ($('#ownerNo').val() == "") {
			$('#ownerNo').addClass("is-invalid");
		} else {
			var ownerNum = $('#ownerNo').val()
			$.ajax({
				type: "POST",//방식
				url: "/Project/ownerCheck",//주소
				data: {
					ownerNo: ownerNum
				},
				dataType: 'JSON',
				success: function(data) { //성공시
					console.log(data.ownerCheck);
					if (data.ownerCheck == false) {
						$('#ownerNo').attr('class',
							'form-control is-valid');
					} else {
						$('#ownerNo').attr('class',
							'form-control is-invalid');
					}
				},
				error: function(e) { //실패시
					console.log(e);
				}
			});
		}
	})

})