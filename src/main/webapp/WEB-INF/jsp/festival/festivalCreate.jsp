<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<div class="pt-5 d-flex justify-content-center">
	<div>
		<div class="d-flex justify-content-between">
			<h2 class="bold pb-3">공연 등록하기</h2>
			
			<div>
				<label class="switch">
					<input type="checkbox">
					<span class="slider round"></span>
				</label>
				<p id="timeOver" class="text-danger">예매 중지</p>
				<p id="notTimeOver" class="d-none text-success">예매 가능</p>
			</div>
		</div>

		<form id="festivalCreateForm" method="post" action="/festival/create">
		<%-- 공연 예매 정보 --%>
		<div class="d-flex">
			<%-- 공연 포스터 --%>
			<div class="pr-5">
				<%-- 이미지를 클릭하면 file 태그 클릭됨 --%>
				<input type="file" id="poster" class="d-none"
					accept=".gif, .jpg, .png, .jpeg">
				
				<%-- 이미지에 마우스 올리면 마우스커서가 링크 커서로 변하도록 a 태그 사용 --%>
				<%-- default 이미지 --%>
				<div>
					<a href="#" class="posterUploadBtn">
						<img width="250" src="\images\★default file/no-image-found-360x250-1-300x208.png" id="posterImg">
					</a>
					<div class="pt-3 d-flex justify-content-center">
						<button type="button" class="posterUploadBtn btn btn-secondary">공연 포스터</button>
					</div>
				</div>
				
				<%-- 업로드 된 임시 파일 이름 저장될 곳 --%>
				<div id="posterFileName" class="ml-2"></div>
			</div>
			
			<%-- 공연 정보 --%>
			<table class="table table-bordered">
				<tr>
					<th>공연 제목</th>
					<td>
						<input type="text" id="title" class="form-control" placeholder="공연 제목을 입력하세요.">
					</td>
				</tr>
				<tr>
					<th>공연 날짜</th>
					<td>
						<input type="text" id="date" class="form-control" placeholder="공연 날짜 (클릭)">
					</td>
				</tr>
				<tr>
					<th>공연 시간</th>
					<td class="d-flex align-items-center">
						<input type="text" id="startTime" class="form-control" placeholder="공연 시작 시간">
						<span class="bold ml-4 mr-4">~</span>
						<input type="text" id="endTime" class="form-control" placeholder="공연 끝나는 시간">
					</td>
				</tr>
				<tr>
					<th>공연 장소</th>
					<td class="d-flex input-group">
						<div class="input-group-prepend">
							<input type="text" id="place" class="form-control" placeholder="직접 입력">
						</div>
						<div class="input-group-append">
							<button class="btn btn-dark">주소 찾기</button>
						</div>
					</td>
				</tr>
				<tr>
					<th>예매 가격</th>
					<td class="d-flex align-items-center">
						<input type="text" id="price" class="mr-2 form-control" placeholder="예매 가격">
						원
					</td>
				</tr>
				<tr>
					<th>현장 가격</th>
					<td class="d-flex align-items-center">
						<input type="text" id="priceOffline" class="mr-2 form-control" placeholder="현장 가격">
						원
					</td>
				</tr>
			</table>
		</div>
		
		<%-- 상세 설명 --%>
		<div>
			<%-- 공연 라인업 --%>
			<h2 class="bold pt-5 pb-2">공연 라인업</h2>
			<textarea rows="5" id="lineUp" class="form-control"></textarea>
			
			<%-- 공연 설명 --%>
			<h2 class="bold pt-5 pb-2">공연 설명</h2>
			<textarea rows="5" id="explain" class="form-control"></textarea>
			
			<%-- 주의사항 --%>
			<h2 class="bold pt-5 pb-2">주의사항</h2>
			<textarea rows="10" id="warning" class="form-control"></textarea>
			
			<%-- 공연 담당자 --%>
			<h2 class="bold pt-5 pb-2">공연 담당자</h2>
			<table class="table">
				<tr>
					<th>담당자 이름</th>
					<td><input type="text" id="festivalMaster" class="form-control" placeholder="담당자 이름"></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" id="askRoot" class="form-control" placeholder="전화번호, 이메일, 인스타그램 등"></td>
				</tr>
			</table>
		</div>
		
		<c:choose>
			<%-- 수정 완료 버튼 : update --%>
			<c:when test="${isUpdate}">
				<div class="pt-5 d-flex justify-content-center">
					<button type="submit" id="festivalUpdateBtn" class="btn btn-dark">수정 완료</button>
				</div>
			</c:when>
			<%-- 작성 완료 버튼 : insert --%>
			<c:otherwise>
				<div class="pt-5 d-flex justify-content-center">
					<button type="submit" id="festivalUploadBtn" class="btn btn-dark">공연 등록</button>
				</div>
			</c:otherwise>
		</c:choose>
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

		// 등록 시에는 처음에 예매 가능으로 뜨도록 설정
		// 수정하는 경우에는 예매 여부 클릭되면 안 된다.
		if(!${isUpdate}){
			check.click();
		}
		
		// 페이지에 접근했을 때, 공연 등록(insert)/ 공연 수정(update) 여부 파악
		if(${isUpdate}){
			// 기존 정보 수정할 수 있도록 value로 넣어줌
			$("#posterImg").attr("src","${festival.imagePath}");
			$('#title').attr('value',"${festival.title}");
			$('#date').attr('value',"${festival.date}");
			$('#startTime').attr('value',"${festival.startTime}");
			$('#endTime').attr('value',"${festival.endTime}");
			$('#place').attr('value',"${festival.place}");
			$('#address').attr('value',"${festival.address}");
			$('#price').attr('value',"${festival.price}");
			$('#priceOffline').attr('value',"${festival.priceOffline}");
			
			// textarea는 value로 안 들어간다.
			document.getElementById("lineUp").value =`${festival.lineUp}`; 
			document.getElementById("explain").value =`${festival.explain}`; 
			document.getElementById("warning").value =`${festival.warning}`; 
			
			$('#festivalMaster').attr('value',"${festival.festivalMaster}");
			$('#askRoot').attr('value',"${festival.askRoot}");
			if("${isTimeOver}" == "false"){
				check.click();
			}
		}
			
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
			let posterImg = $('#poster')[0].files[0];
			let lineUp = $('#lineUp').val().trim();
			let explain = $('#explain').val().trim();
			let warning = $('#warning').val().trim();
			let festivalMaster = $('#festivalMaster').val().trim();
			let askRoot = $('#askRoot').val().trim();
			let isTimeOver = false;
			if(!$('#timeOver').hasClass("d-none")){ // 예매 중 상태
				isTimeOver = true;
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
				place = "미정";
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
			formData.append("posterImg", posterImg);
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
						location.href="/festival/festival_detail_view?festivalId="+data.festivalId;
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

		// 공연 정보 수정 (update)
		$('#festivalUpdateBtn').on('click', function(e) {
			e.preventDefault(); // submit 기능 중단
			
			// validation check
			let id = "${festival.id}";
			let title = $('#title').val().trim();
			let date = $('#date').val();
			let startTime = $('#startTime').val().trim();
			let endTime = $('#endTime').val().trim();
			let place = $('#place').val().trim();
			let address = $('#address').val();
			let price = $('#price').val().trim();
			let priceOffline = $('#priceOffline').val().trim();
			let posterImg = $('#poster')[0].files[0];
			let lineUp = $('#lineUp').val().trim();
			let explain = $('#explain').val().trim();
			let warning = $('#warning').val().trim();
			let festivalMaster = $('#festivalMaster').val().trim();
			let askRoot = $('#askRoot').val().trim();
			let isTimeOver = false;
			if(!$('#timeOver').hasClass("d-none")){ // 예매 중 상태
				isTimeOver = true;
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
				place = '미정';
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
			formData.append("id", id);
			formData.append("title", title);
			formData.append("date", date);
			formData.append("startTime", startTime);
			formData.append("endTime", endTime);
			formData.append("place", place);
			formData.append("address", address);
			formData.append("price", price);
			formData.append("priceOffline", priceOffline);
			formData.append("posterImg", posterImg);
			formData.append("lineUp", lineUp);
			formData.append("explain", explain);
			formData.append("warning", warning);
			formData.append("festivalMaster", festivalMaster);
			formData.append("askRoot", askRoot);
			formData.append("isTimeOver", isTimeOver);
			
			// AJAX form 데이터 전송
			$.ajax({
				type:'PUT'
				,url:'/festival/update'
				, data: formData
				, enctype: "multipart/form-data"    // 파일 업로드를 위한 필수 설정
				, processData: false    // 파일 업로드를 위한 필수 설정
				, contentType: false    // 파일 업로드를 위한 필수 설정
				, success: function(data) {
					if (data.code == 1) {
						// 성공
						alert("수정이 완료되었습니다.");
						location.href="/festival/festival_detail_view?festivalId="+data.festivalId;
					} else{
						// 실패
						alert("[error] 공연 정보 수정에 실패했습니다. \n 담당자에게 문의해주세요");
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