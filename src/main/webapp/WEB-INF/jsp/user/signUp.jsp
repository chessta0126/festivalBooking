<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<h2 class="m-3 font-weight-bold">회원가입</h2>
		<form id="signUpForm" method="post" action="/user/sign_up">
			<table class="sign-up-table table table-bordered">
			<%-- file 태그는 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것처럼 이벤트를 줄 것이다. --%>
					<input type="file" id="file" class="d-none"
						accept=".gif, .jpg, .png, .jpeg">
					<%-- 이미지에 마우스 올리면 마우스커서가 링크 커서로 변하도록 a 태그 사용 --%>
					<a href="#" id="fileUploadBtn"><img width="35"
						src="/img/default_profileImage.jpg"></a>
					<%-- 업로드 된 임시 파일 이름 저장될 곳 --%>
					<div id="fileName" class="ml-2"></div>
				<tr>
					<th>* 이름</th>
					<td><input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요."></td>
				</tr>
				<tr>
					<th>* 아이디(4자 이상)<br></th>
					<td>
						<%-- 인풋박스 옆에 중복확인을 붙이기 위해 div를 하나 더 만들고 d-flex --%>
						<div class="d-flex">
							<input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디를 입력하세요.">
							<button type="button" id="loginIdCheckBtn" class="btn btn-success">중복확인</button><br>
						</div>

						<%-- 아이디 체크 결과 --%>
						<%-- d-none 클래스: display none (보이지 않게) --%>
						<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
						<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
						<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
					</td>
				</tr>
				<tr>
					<th>* 비밀번호</th>
					<td><input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요."></td>
				</tr>
				<tr>
					<th>* 비밀번호 확인</th>
					<td><input type="password" id="confirmPassword" class="form-control" placeholder="비밀번호를 입력하세요."></td>
				</tr>
				<tr>
					<th>* 이메일</th>
					<td><input type="text" id="email" name="email" class="form-control" placeholder="이메일 주소를 입력하세요."></td>
				</tr>
			</table>

			<button type="submit" id="signUpBtn" class="btn btn-primary float-right m-3">회원가입</button>
		</form>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 파일업로드 이미지 클릭 => 숨겨져있는 file을 동작시킴
		$('#fileUploadBtn').on('click', function(e) {
			e.preventDefault(); // a 태그의 올라가는 현상 방지
			$('#file').click(); // input file을 클릭한 것과 같은 효과
		});
		
		// 사용자가 이미지를 선택했을 때 유효성 확인 및 업로드 된 파일 이름 노출
		$('#file').on('change', function(e) {
			//alert("파일 선택");
			let fileName = e.target.files[0].name; // 07_30_01.png
			//alert(fileName);
			
			// 확장자 유효성 확인
			let ext = fileName.split(".").pop().toLowerCase();
			if (ext != 'jpg' && ext != 'jpeg' && ext != 'gif' && ext != 'png') {
				alert("jpg, jpeg, gif, png 파일만 업로드 할 수 있습니다.");
				$('#file').val(''); // 파일 태그에 실제 파일 제거
				$("#fileName").text(''); // 파일 이름 비우기
				return;
			}
			
			// 유효성 통과한 이미지는 상자에 업로드 된 파일 이름 노출
			$('#fileName').text(fileName);
		});
		
		// 중복확인 버튼 클릭
		$('#loginIdCheckBtn').on('click', function() {
			// 초기화(모두 숨김)
			$('#idCheckLength').addClass('d-none');
			$('#idCheckDuplicated').addClass('d-none');
			$('#idCheckOk').addClass('d-none');

			let loginId = $('input[name=loginId]').val().trim();

			if (loginId.length < 4) {
				$('#idCheckLength').removeClass('d-none'); // 경고문구 노출
				return;
			}

			// AJAX 통신 - 중복확인
			$.ajax({
				// request
				url : "/user/is_duplicated_id"
				, data : {"loginId" : loginId}

				// response
				, success : function(data) {
					// 성공
					if (data.result) {
						// 중복
						$('#idCheckDuplicated').removeClass('d-none');
					} else {
						// 사용 가능
						$('#idCheckOk').removeClass('d-none');
					}
				}
				,error:function(e){
					alert("중복 확인에 실패했습니다.");
				}
			});
		});
		
		// 회원가입
		$('#signUpForm').on('submit', function(e) {
			e.preventDefault(); // submit 기능 중단
			
			// validation check
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val();
			let confirmPassword = $('#confirmPassword').val();
			let name = $('#name').val().trim();
			let email = $('#email').val().trim();
			let profileImageUrl = $('#file')[0].files[0];
			
			if(name == ""){
				alert("이름을 입력해주세요");
				return false;
			}
			if(loginId == ""){
				alert("아이디를 입력해주세요");
				return false;
			}
			if(password == ""){
				alert("비밀번호를 입력해주세요");
				return false;
			}
			if(confirmPassword == ""){
				alert("비밀번호를 다시 확인해주세요");
				return false;
			}
			if(password != confirmPassword){
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			if(email == ""){
				alert("이메일을 입력해주세요");
				return false;
			}
			
			// 아이디 중복확인 완료됐는지 확인(idCheckOk d-none이 없는 상태)
			// -> d-none 있으면 alert 띄우기
			if($('#idCheckOk').hasClass('d-none')){
				alert("아이디 중복확인을 다시 해주세요");
				return false;
			}
			
			// AJAX
			let url = $(this).attr('action');
			let params = $(this).serialize(); // 직렬화 : form태그에 있는 name으로 파라미터를 구성
			console.log(params);
			
			$.post(url,params) // request
			.done(function(data){
				// response
				if(data.code == 1){
					// 성공
					alert("가입을 환영합니다! 로그인 해주세요.");
					location.href="/user/sign_in_view";
				} else{
					// 실패
					alert(data.errorMessage);
				}
			});
		});
	});
</script>