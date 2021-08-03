$(document).ready(function() {
	
	// 유효성 체크
	$('.numCheck').on("propertychange change keyup paste input",function(){
		if(isNaN($(this).val())||$(this).val().trim()==""){
			$(this).addClass("is-invalid");
		}else{
			$(this).removeClass("is-invalid");
		}
	})

	// 좌석변경 ajax
	$(document).on('click', '#tableChange', function() {
		if ($('#cafeTotalTable').val().trim() == "") {
			$('#cafeTotalTable').addClass("is-invalid");
		}
		if ($('#cafeCurrentTable').val().trim() == "") {
			$('#cafeCurrentTable').addClass("is-invalid");
		}

		if ($('#cafeTotalTable').attr('class') == 'numCheck form-control' &&
			$('#cafeCurrentTable').attr('class') == 'numCheck form-control') {
			var cafeTotalTable = $('#cafeTotalTable').val();
			var cafeCurrentTable = $('#cafeCurrentTable').val();
			$.ajax({
				type: "POST",//방식
				url: "/Project/confusionTableChange",//주소
				data: {
					cafeTotalTable: cafeTotalTable,
					cafeCurrentTable: cafeCurrentTable,
				},
				dataType: 'JSON',
				success: function(data) { //성공시
					console.log(data);
					Swal.fire({
						title: '수정완료',
						icon: 'success',
						confirmButtonColor: '#000',
						confirmButtonText: '확인',
					}).then((result) => {
						if (result.isConfirmed) {
							var content = "";
							content += '<label for="cafeTotalTable" class="fw-bold">총좌석</label> <input'
							content += ' type="text" class="numCheck form-control" id="cafeTotalTable" name="cafeTotalTable"'
							content += 'placeholder="숫자를 입력해주세요" value="' + data.cafeTotalTable + '" required>'
							content += '<div class="invalid-feedback">숫자를 입력해주세요</div>'
							$('#totalTable').empty();
							$('#totalTable').append(content);
							content = "";
							content += '<label for="cafeCurrentTable" class="fw-bold">현재좌석</label> <input'
							content += ' type="text" class="numCheck form-control" id="cafeCurrentTable" name="cafeCurrentTable"'
							content += 'placeholder="숫자를 입력해주세요" value="' + data.cafeCurrentTable + '" required>'
							content += '<div class="invalid-feedback">숫자를 입력해주세요</div>'
							$('#curTable').empty();
							$('#curTable').append(content);
						}
					})
				},
				error: function(e) { //실패시
					console.log(e);
				}
			})
		}
	})



	// 기준변경 ajax
	$(document).on('click', '#standardChange' ,function() {
		if ($('#leisurely').val().trim()  ==  "") {
			$('#leisurely').addClass("is-invalid");
		}
		if ($('#normal').val().trim() == "")  {
			$('#normal').addClass("is-invalid");
		}
		if ($('#congest').val().trim() == "")  {
			$('#congest').addClass("is-invalid");
		}

		if ($('#leisurely').attr('class')  ==  'numCheck form-control' &&
			$('#normal').attr('class') ==  'numCheck form-control' &&
				$('#congest').attr('class') == 'numCheck form-control') {
		var leisurely = $('#leisurely').val();
		var normal = $('#normal').val();
		var congest = $('#congest').val();
		$.ajax({
			type: "POST",//방식
			url: "/Project/standardChange",//주소
			data: {
				leisurely: leisurely,
				normal: normal,
				congest: congest,
			},
			dataType: 'JSON',
			success: function(data) { //성공시
				console.log(data);
				Swal.fire({
					title: '수정완료',
					icon: 'success',
					confirmButtonColor: '#000',
					confirmButtonText: '확인',
				}).then((result) => {
						if (result.isConfirmed) {
						var content = "";
						content += '<label for="leisurely" class="fw-bold">여유</label> <input'
						content += ' type="text" class="numCheck form-control" id="leisurely"'
						content += ' name="leisurely" placeholder="숫자를 입력해주세요"'
						content += 'value="'  + data.leisurely  + '" required>'
						content += '<div class="invalid-feedback">숫자를 입력해주세요</div>'
						$('#leisurelyBox').empty();
						$('#leisurelyBox').append(content);
						content = "";
						content +='<label for="normal" class="fw-bold">보통</label>'
						content +='<input type="text" class="numCheck form-control" id="normal" name="normal" placeholder="숫자를 입력해주세요" value="'+data.normal +'" required>'
						content += '<div class="invalid-feedback">숫자를 입력해주세요</div>'
							$('#normalBox').empty();
						$('#normalBox').append(content);
						content = "";
						content += '<label for="congest" class="fw-bold">혼잡</label> <input'
						content += ' type="text" class="numCheck form-control" id="congest"'
						content += ' name="congest" placeholder="숫자를 입력해주세요" value="' + data.congest + '" required>'
						content += '<div class="invalid-feedback">숫자를 입력해주세요</div>'
						$('#congestBox').empty();
						$('#congestBox').append(content);
					}
				})
			},
			error: function(e) { //실패시
				console.log(e);
			}
		})
	}
})










})

