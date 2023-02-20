<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div class="pt-5 d-flex justify-content-center">
	<div>
		<h2 class="bold pb-5">공연 등록하기</h2>
		
		<label class="switch">
			<input type="checkbox">
			<span class="slider round"></span>
		</label>
		<p id="timeOver">OFF</p>
		<p id="notTimeOver" class="d-none">ON</p>

		<form id="festivalCreateForm" method="post" action="/festival/create">
		<%-- 공연 예매 정보 --%>
		<div class="d-flex">
			<%-- 공연 포스터 --%>
			<div class="pr-5">
				<img width="200" src="${festival.imagePath}" id="posterImg">
			</div>
			
			<%-- 공연 정보 --%>
			<table class="table table-bordered">
				<tr>
					<th>공연 제목</th>
					<td>${festival.title}</td>
				</tr>
				<tr>
					<th>공연 날짜</th>
					<td>${festival.date}</td>
				</tr>
				<tr>
					<th>공연 시간</th>
					<td class="d-flex align-items-center">
						${festival.startTime}
						<span class="bold ml-4 mr-4">~</span>
						${festival.endTime}
					</td>
				</tr>
				<tr>
					<th>공연 장소</th>
					<td>
						${festival.place}
						<c:if test="">
						<div>
							${festival.address}
						</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>예매 가격</th>
					<td class="d-flex align-items-center">
						${festival.price} 원
					</td>
				</tr>
				<tr>
					<th>현장 가격</th>
					<td class="d-flex align-items-center">
						${festival.priceOffline} 원
					</td>
				</tr>
			</table>
		</div>
		
		<%-- 상세 설명 --%>
		<div>
			<%-- 공연 라인업 --%>
			<h2 class="bold pt-5 pb-2">공연 라인업</h2>
			<div class="festival-info-box border border-info">
				<c:if test="">
					${festival.lineUp}
				</c:if>
			</div>
			
			<%-- 공연 설명 --%>
			<h2 class="bold pt-5 pb-2">공연 설명</h2>
			<div class="festival-info-box border border-success">
				<c:if test="">
					${festival.explain}
				</c:if>
			</div>
			
			<%-- 주의사항 --%>
			<h2 class="bold pt-5 pb-2">주의사항</h2>
			<div class="festival-info-box border border-danger">
				<c:if test="">
					${festival.warning}
				</c:if>
			</div>
			
			<%-- 공연 담당자 --%>
			<h2 class="bold pt-5 pb-2">공연 담당자</h2>
			<table class="table">
				<tr>
					<th>담당자 이름</th>
					<td>${festival.festivalMaster}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${festival.askRoot}</td>
				</tr>
			</table>
		</div>
		
		<%-- 작성 완료 버튼 --%>
		<div class="pt-5 d-flex justify-content-center">
			<button type="submit" id="festivalUploadBtn" class="btn btn-dark">공연 등록</button>
		</div>
		</form>
	</div>
</div>

<footer class="pt-5">
	<jsp:include page="../include/footer.jsp" />
</footer>

<script>
	$(document).ready(function() {
		// on / off toggle
		var check = $("input[type='checkbox']");
		check.click(function(){
			if($('#notTimeOver').hasClass("d-none")){ // 공연 만료 상태				
				$('#timeOver').addClass("d-none");
				$('#notTimeOver').removeClass("d-none");
				return;
			} else{
				$('#notTimeOver').addClass("d-none");
				$('#timeOver').removeClass("d-none");
				return;				
			}
		});
		
		// datepicker 형식
		$.datepicker.setDefaults({
			// 요일 표시 : 한글
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ]

			// 연도-월-일 형식
			, dateFormat : "yy년 mm월 dd일"
		});

		$('#date').datepicker({
			// 시작일(mindate) 이전은 선택 불가
			minDate : 0			
		});

		
		// 파일업로드 이미지 클릭 => 숨겨져있는 file을 동작시킴
		$('.posterUploadBtn').on('click', function(e) {
			e.preventDefault(); // a 태그의 올라가는 현상 방지
			$('#poster').click(); // input file을 클릭한 것과 같은 효과
		});
		
		// 사용자가 이미지를 선택했을 때 유효성 확인 및 업로드 된 파일 이름 노출
		$('#poster').on('change', function(e) {
			//alert("파일 선택");
			let posterFileName = e.target.files[0].name;
			//alert(posterFileName);
			
			// 확장자 유효성 확인
			let ext = posterFileName.split(".").pop().toLowerCase();
			if (ext != 'jpg' && ext != 'jpeg' && ext != 'gif' && ext != 'png') {
				alert("jpg, jpeg, gif, png 파일만 업로드 할 수 있습니다.");
				$('#poster').val(''); // 파일 태그에 실제 파일 제거
				$("#posterFileName").text(''); // 파일 이름 비우기
				return;
			}
			
			// 기본 이미지 -> 선택한 이미지로 변경
			let filePath = URL.createObjectURL(event.target.files[0]);
			$("#posterImg").attr("src",filePath);
		});
		
		// 공연 등록 (insert)
		$('#festivalUploadBtn').on('click', function(e) {
			e.preventDefault(); // submit 기능 중단
			
			// validation check
			let userId = ${userId};
			let title = $('#title').val().trim();
			let date = $('#date').val();
			let startTime = $('#startTime').val().trim();
			let endTime = $('#endTime').val().trim();
			let place = $('#place').val().trim();
			let address = $('#address').val();
			let price = $('#price').val().trim();
			let priceOffline = $('#priceOffline').val().trim();
			let imagePath = $('#posterImg').val();
			let lineUp = $('#lineUp').val().trim();
			let explain = $('#explain').val().trim();
			let warning = $('#warning').val().trim();
			let festivalMaster = $('#festivalMaster').val().trim();
			let askRoot = $('#askRoot').val().trim();
			if($('#timeOver').hasClass("d-none")){ // 예매 중 상태
				var isTimeOver = false;
			} else{
				var isTimeOver = true;
			}
			
			if(title == ""){
				alert("공연 제목을 입력해주세요");
				return false;
			}
			if(date == ""){
				alert("공연 날짜를 입력해주세요");
				return false;
			}
			if(startTime == ""){
				alert("공연이 시작하는 시간을 입력해주세요");
				return false;
			}
			if(endTime == ""){
				alert("공연이 끝나는 시간을 입력해주세요");
				return false;
			}
			if(place == ""){
				alert("공연 장소를 입력해주세요");
				return false;
			}
			if(price == ""){
				alert("티켓 예매 가격을 입력해주세요");
				return false;
			}
			if(priceOffline == ""){
				alert("티켓 현장 구매 가격을 입력해주세요");
				return false;
			}
			if(festivalMaster == ""){
				alert("공연 담당자 이름을 입력해주세요");
				return false;
			}
			if(askRoot == ""){
				alert("연락처를 입력해주세요");
				return false;
			}
			
			// form태그를 자바스크립트에서 만든다.
			let formData = new FormData();
			formData.append("userId", userId);
			formData.append("title", title);
			formData.append("date", date);
			formData.append("startTime", startTime);
			formData.append("endTime", endTime);
			formData.append("place", place);
			formData.append("address", address);
			formData.append("price", price);
			formData.append("priceOffline", priceOffline);
			formData.append("imagePath", imagePath);
			formData.append("lineUp", lineUp);
			formData.append("explain", explain);
			formData.append("warning", warning);
			formData.append("festivalMaster", festivalMaster);
			formData.append("askRoot", askRoot);
			formData.append("isTimeOver", isTimeOver);
			
			// AJAX form 데이터 전송
			$.ajax({
				type:'POST'
				,url:'/festival/create'
				, data: formData
				, enctype: "multipart/form-data"    // 파일 업로드를 위한 필수 설정
				, processData: false    // 파일 업로드를 위한 필수 설정
				, contentType: false    // 파일 업로드를 위한 필수 설정
				, success: function(data) {
					if (data.code == 1) {
						// 성공
						alert("공연이 등록되었습니다.");
						location.href="/book/festival_detail_view";
					} else{
						// 실패
						alert("[error] 공연 등록에 실패했습니다. \n 담당자에게 문의해주세요");
					}
				}
				, error : function(jqXHR, textStatus, errorThrown) {
					var errorMsg = jqXHR.responseJSON.status;
					alert(errorMsg + ":" + textStatus);
				}
			});
		});
	});
</script>