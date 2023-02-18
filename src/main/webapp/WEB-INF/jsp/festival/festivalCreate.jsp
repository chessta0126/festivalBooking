<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div class="pt-5 d-flex justify-content-center">
	<div>
		<h2 class="bold pb-5">공연 등록하기</h2>
		
		<%-- 공연 예매 정보 --%>
		<div class="d-flex">
			<%-- 공연 포스터 --%>
			<div class="pr-5">
				<%-- 이미지를 클릭하면 file 태그 클릭됨 --%>
				<input type="file" id="poster" class="d-none"
					accept=".gif, .jpg, .png, .jpeg">
				
				<%-- 이미지에 마우스 올리면 마우스커서가 링크 커서로 변하도록 a 태그 사용 --%>
				<%-- default 이미지 --%>
				<a href="#" id="posterUploadBtn">
					<img width="200" src="\images\★default file/default profileImage.jpg" id="posterImg">
				</a>
				
				<%-- 업로드 된 임시 파일 이름 저장될 곳 --%>
				<div id="posterFileName" class="ml-2"></div>
			</div>
			
			<%-- 공연 정보 --%>
			<table class="table table-bordered">
				<tr>
					<th>공연 제목</th>
					<td>
						<input type="text" id="title" name="title" class="form-control" placeholder="공연 제목을 입력하세요.">
					</td>
				</tr>
				<tr>
					<th>공연 날짜</th>
					<td>
						<input type="text" id="date" name="date" class="form-control" placeholder="공연 날짜 (클릭)">
					</td>
				</tr>
				<tr>
					<th>공연 시간</th>
					<td class="d-flex align-items-center">
						<input type="text" id="startTime" name="startTime" class="form-control" placeholder="공연 시작 시간">
						<span class="bold ml-4 mr-4">~</span>
						<input type="text" id="endTime" name="endTime" class="form-control" placeholder="공연 끝나는 시간">
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
					<td><input type="text" id="price" name="price" class="form-control" placeholder="예매 가격"></td>
				</tr>
				<tr>
					<th>현장 가격</th>
					<td><input type="text" id="priceOffline" name="priceOffline" class="form-control" placeholder="현장 가격"></td>
				</tr>
			</table>
		</div>
		
		<%-- 상세 설명 --%>
	</div>
</div>

<script>
	$(document).ready(function() {
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
		$('#posterUploadBtn').on('click', function(e) {
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
			
			// 유효성 통과한 이미지는 상자에 업로드 된 파일 이름 노출
			// $('#posterFileName').text(posterFileName);
			
			// 기본 이미지 -> 선택한 이미지로 변경
			let filePath = URL.createObjectURL(event.target.files[0]);
			$("#posterImg").attr("src",filePath);
		});
	});
</script>