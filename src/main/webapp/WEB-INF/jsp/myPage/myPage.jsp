<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<div class="container">
	<div class="pt-4 pb-4">
		<h1 class="bold">회원 정보</h1>
		<form method="Post" action="/user/update">
		<div class="mt-4 d-flex">
			<%-- 프로필 이미지 --%>
			<div class="ml-5 col-3">
				<%-- file 태그는 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것처럼 이벤트를 줄 것이다. --%>
				<input type="file" id="changedFile" class="d-none"
					accept=".gif, .jpg, .png, .jpeg">
				
				<%-- 이미지에 마우스 올리면 마우스커서가 링크 커서로 변하도록 a 태그 사용 --%>
				<a href="#" id="userProfileImage" class="fileChangeBtn">
					<img src="${userProfileImageUrl}" id="profileImage" width="150px">
				</a>
				
				<%-- 업로드 된 임시 파일 이름 저장될 곳 --%>
				<div id="changedFileName" class="ml-2"></div>

				<div class="text-center mt-2 mb-2">프로필 이미지</div>

				<%-- 버튼 눌러도 수정할 수 있게끔 한다. --%>
				<button class="btn btn-secondary w-100 fileChangeBtn">수정하기</button>
				
			</div>
			
			<%-- 회원 정보(text) --%>
			<div class="col-9">
				<table class="table">
					<tr>
						<td class="pr-3">닉네임(활동명)</td>
						<td>
							<span id="textName">${userInfo.name}</span>
							<%-- 수정 클릭 시에만 보이기 --%>
							<input type="text" id="changedName" name="changedName"
							class="form-control d-none" placeholder="${userInfo.name}">
						</td>
					</tr>
					<tr>
						<td class="pr-3">아이디</td>
						<td>
							<span id="textLoginId">${userInfo.loginId}</span>
							<%-- 수정 클릭 시에만 보이기 --%>
							<input type="text" id="changedLoginId" name="changedLoginId"
							class="form-control d-none" placeholder="${userInfo.loginId}">
							
							<%-- 아이디 중복 확인 결과 --%>
							<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
							<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
							<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
						</td>
					</tr>
					<%-- 해싱된 비밀번호가 나오기 때문에, 사용자가 보기에 좋지 않다. --%>
					<%-- 수정이 필요하지 않는 한 사용자에게 굳이 자기 비밀번호를 보여줄 필요는 없다. 수정 클릭 시에만 보이기 --%>
					<tr id="changedPasswordLine" class="d-none">
						<td class="pr-3">비밀번호</td>
						<td>
							<input type="password" id="changedPassword" name="changedPassword" class="form-control">
						</td>
					</tr>
					<tr id="changedPasswordConfirmLine" class="d-none">
						<td class="pr-3">비밀번호 확인</td>
						<td>
							<input type="password" id="changedPasswordConfirm" name="changedPasswordConfirm" class="form-control">
						</td>
					</tr>

					<tr>
						<td class="pr-3">e-mail</td>
						<td>
							<span id="textEmail">${userInfo.email}</span>
							<%-- 수정 클릭 시에만 보이기 --%>
							<input type="text" id="changedEmail" name="changedEmail"
							class="form-control d-none" placeholder="${userInfo.email}">
						</td>
					</tr>
				</table>

				<%-- button --%>
				<div class="d-flex justify-content-center">
					<button id="userUpdateBtn" class="btn btn-info mr-5">회원 정보 수정</button>
					<button id="userDeleteBtn" class="btn btn-danger">회원 탈퇴</button>
					<button id="userUpdateFinishBtn" class="d-none btn btn-info mr-5">수정 완료</button>
				</div>
			</div>
		</form>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		// 프로필 이미지 수정 
		$('.fileChangeBtn').on('click', function(e) {
			// alert("파일 선택");
			e.preventDefault(); // a 태그의 올라가는 현상 방지
			$('#changedFile').click(); // input file을 클릭한 것과 같은 효과
		});
		
		// 사용자가 이미지를 선택했을 때 유효성 확인 및 업로드 된 파일 이름 노출
		$('#changedFile').on('change', function(e) {
			// alert("파일 선택");
			let changedFileName = e.target.files[0].name;
			// alert(changedFileName);

			// 확장자 유효성 확인
			let ext = changedFileName.split(".").pop().toLowerCase();
			if (ext != 'jpg' && ext != 'jpeg' && ext != 'gif' && ext != 'png') {
				alert("jpg, jpeg, gif, png 파일만 업로드 할 수 있습니다.");
				$('#changedFile').val(''); // 파일 태그에 실제 파일 제거
				$("#changedFileName").text(''); // 파일 이름 비우기
				return;
			}
			
			// 유효성 통과 후 파일 이름 확인
			// $('#changedFileName').text(changedFileName);
			
			// 기존 이미지 숨기기
			$('#userProfileImage').addClass('d-none');
		});
		
		// 회원 정보 수정 
		$('#userUpdateBtn').on('click', function(e) {
			e.preventDefault(); // submit 기능 중지
			
			// 기존 회원정보 텍스트 지우고, 수정 가능한 input 노출
			$('#textName').addClass('d-none');
			$('#changedName').removeClass('d-none');

			$('#textLoginId').addClass('d-none');
			$('#changedLoginId').removeClass('d-none');
			
			$('#changedPasswordLine').removeClass('d-none');
			$('#changedPasswordConfirmLine').removeClass('d-none');
			
			$('#textEmail').addClass('d-none');
			$('#changedEmail').removeClass('d-none');
			
			$('#userUpdateBtn').addClass('d-none');
			$('#userDeleteBtn').addClass('d-none');
			
			$('#userUpdateFinishBtn').removeClass('d-none');
		});
		
		// 회원 정보 수정 완료 
		$('#userUpdateFinishBtn').on('click', function(e) {
			e.preventDefault(); // submit 기능 중지

			let changedName = $('#changedName').val().trim();
			let changedLoginId = $('#changedLoginId').val().trim();
			let changedPassword = $('#changedPassword').val();
			let changedConfirmPassword = $('#confirmPassword').val();
			let changedEmail = $('#changedEmail').val().trim();
			let changedFile = $('#changedFile')[0].files[0];
			
			// 비밀번호 변경 시 비밀번호 확인만 일치하는지 체크
			// 변경하지 않아도 ''로 일치해야 함
			if(changedPassword != changedConfirmPassword){
				alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
				return false;
			}
			
			// 아이디 중복확인 완료됐는지 확인(idCheckOk d-none이 없는 상태)
			// -> d-none 있으면 alert 띄우기
			if($('#changedLoginIdCheckOk').hasClass('d-none')){
				alert("아이디 중복확인을 다시 해주세요");
				return false;
			}
			
			// form태그를 자바스크립트에서 만든다.
			let formData = new FormData();
			formData.append("name", name);
			formData.append("loginId", loginId);
			formData.append("password", password);
			formData.append("email", email);
			formData.append("file", $('#file')[0].files[0]); // $('#file')[0]은 첫번째 input file 태그를 의미, files[0]는 업로드된 첫번째 파일
			
			// AJAX form 데이터 전송
			$.ajax({
				type:'POST'
				,url:'/user/update'
				, data: formData
				, enctype: "multipart/form-data"    // 파일 업로드를 위한 필수 설정
				, processData: false    // 파일 업로드를 위한 필수 설정
				, contentType: false    // 파일 업로드를 위한 필수 설정
				, success: function(data) {
					if (data.code == 1) {
						// 성공
						alert("가입을 환영합니다! 로그인 해주세요.");
						location.href="/user/sign_in_view";
					} else{
						// 실패
						alert("[error] 통신 문제로 가입에 실패했습니다. \n 담당자에게 문의해주세요");
					}
				}
			});
		});
	});
</script>