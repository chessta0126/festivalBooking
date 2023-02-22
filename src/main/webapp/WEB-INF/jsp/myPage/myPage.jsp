<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
				
				<%-- 기존 프로필 이미지 --%>
				<img src="${userProfileImageUrl}" id="profileImage" width="150px">
				
				<%-- 업로드 된 임시 파일 이름 저장될 곳 --%>
				<div id="changedFileName" class="ml-2"></div>

				<div class="text-center mt-2 mb-2">프로필 이미지</div>

				<%-- 프로필 이미지 수정 버튼 --%>
				<button id="fileChangeBtn" class="btn btn-secondary w-100 d-none">수정하기</button>
				
			</div>
			
			<%-- 회원 정보(text) --%>
			<div class="col-9">
				<table class="table">
					<tr>
						<td class="pr-3">닉네임(활동명)</td>
						<td>
							<%-- 중복확인 버튼 안 보이게 해도 d-flex로 붙여놓지 않으면 밑에 여백이 생기므로 여기까지 묶어준다. --%>
							<div class="d-flex align-items-center">
								<span id="textName">${userInfo.name}</span>
								
								<%-- 수정 클릭 시에만 보이기 --%>
								<input type="text" id="changedName" name="changedName"
								class="form-control d-none" placeholder="${userInfo.name}">
								<button type="button" id="changedNameCheckBtn" class="btn btn-success d-none">중복확인</button>
							</div>
	
							<%-- 닉네임 중복 확인 결과 --%>
							<div id="changedNameLength" class="small text-danger d-none">닉네임을 입력해주세요.</div>
							<div id="changedNameCheckDuplicated" class="small text-danger d-none">이미 사용중인 닉네임 입니다.</div>
							<div id="changedNameCheckOk" class="small text-success d-none">사용 가능한 닉네임 입니다.</div>
						</td>
					</tr>
					<tr>
						<td class="pr-3">아이디</td>
						<td>
							<%-- 중복확인 버튼 안 보이게 해도 d-flex로 붙여놓지 않으면 밑에 여백이 생기므로 여기까지 묶어준다. --%>
							<div class="d-flex align-items-center">
								<span id="textLoginId">${userInfo.loginId}</span>

								<%-- 수정 클릭 시에만 보이기 --%>
								<input type="text" id="changedLoginId" name="changedLoginId"
								class="form-control d-none" placeholder="${userInfo.loginId}">
								<button type="button" id="changedLoginIdCheckBtn" class="btn btn-success d-none">중복확인</button><br>
							</div>

							<%-- 아이디 중복 확인 결과 --%>
							<div id="changedLoginIdLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
							<div id="changedLoginIdCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
							<div id="changedLoginIdCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
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
					<button id="userDeleteBtn" class="btn btn-danger"
					 data-toggle="modal" data-target="#modal" data-user-id="${userInfo.id}">회원 탈퇴</button>
					
					<button id="userUpdateFinishBtn" class="d-none btn btn-info mr-5">수정 완료</button>
					<button id="userUpdateCancelBtn" class="d-none btn btn-danger mr-5">
						<a href="/myPage/myPage_view" class="button">수정 취소</a>
					</button>
				</div>
			</div>
		</div>
		</form>
	</div>
	<hr>
	
	<%-- 이동 버튼 --%>
	<div class="container">
		<button class="w-100 btn btn-dark mt-3 mb-3">
			<a href="#" class="button">내가 작성한 글</a>
		</button>
		<div class="d-flex justify-content-between">
			<button class="w-100 col-5 btn btn-warning">
				<a href="/festival/festival_myList_view" class="button text-dark">공연 홍보하기</a>
			</button>
			<button class="w-100 col-5 btn btn-secondary">
				<a href="#" class="button">예매 확인</a>
			</button>
		</div>
	</div>
</div>


<!-- Modal -->
<div class="modal fade" id="modal">
<%-- modal-sm : 작은 모달 창 --%>
<%-- modal-dialog-centered : 모달 창을 수직으로 가운데 정렬 --%>
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content text-center">
      		<div class="py-3 border-bottom">
      			<a href="#" id="userDeleteAgreeBtn">회원탈퇴</a>
      		</div>
      		<div class="py-3">
      			<%-- data-dismiss="modal" : modal창 닫힘 --%>
      			<a href="#" data-dismiss="modal">취소하기</a>
      		</div>
		</div>
	</div>
</div>	


<script>
	$(document).ready(function(){
		// 프로필 이미지 수정 
		$('#fileChangeBtn').on('click', function(e) {
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
			
			// 기존 이미지 -> 선택한 이미지로 변경
			let filePath = URL.createObjectURL(event.target.files[0]);
			$("#profileImage").attr("src",filePath);
		});
		
		// 닉네임 중복확인 버튼 클릭
		$('#changedNameCheckBtn').on('click', function() {
			// 초기화(모두 숨김)
			$('#changedNameLength').addClass('d-none');
			$('#changedNameCheckDuplicated').addClass('d-none');
			$('#changedNameCheckOk').addClass('d-none');

			let changedName = $('input[name=changedName]').val().trim();
			// alert(changedName);
			
			if (changedName.length == '') {
				$('#changedNameLength').removeClass('d-none'); // 경고문구 노출
				return;
			}
			
			// AJAX 통신 - 닉네임 중복확인
			$.ajax({
				// request
				url : "/user/is_duplicated_name"
				, data : {"name" : changedName}

				// response
				, success : function(data) {
					// 성공
					if (data.result) {
						// 중복
						$('#changedNameCheckDuplicated').removeClass('d-none');
					} else {
						// 사용 가능
						$('#changedNameCheckOk').removeClass('d-none');
					}
				}
				,error:function(e){
					alert("중복 확인에 실패했습니다.");
				}
			});
		});
		
		// Id 중복확인 버튼 클릭
		$('#changedLoginIdCheckBtn').on('click', function() {
			// 초기화(모두 숨김)
			$('#changedLoginIdLength').addClass('d-none');
			$('#changedLoginIdCheckDuplicated').addClass('d-none');
			$('#changedLoginIdCheckOk').addClass('d-none');

			let changedLoginId = $('input[name=changedLoginId]').val().trim();
			// alert(changedLoginId);
			
			// 입력 했는데(수정 의사 있음) 4글자 미만일 때
			if (changedLoginId.length > 0 && changedLoginId.length < 4) {
				$('#changedLoginIdLength').removeClass('d-none'); // 경고문구 노출
				return;
			}

			// AJAX 통신 - 아이디 중복확인
			$.ajax({
				// request
				url : "/user/is_duplicated_id"
				, data : {"loginId" : changedLoginId}

				// response
				, success : function(data) {
					// 성공
					if (data.result) {
						// 중복
						$('#changedLoginIdCheckDuplicated').removeClass('d-none');
					} else {
						// 사용 가능
						$('#changedLoginIdCheckOk').removeClass('d-none');
					}
				}
				,error:function(e){
					alert("중복 확인에 실패했습니다.");
				}
			});
		});
		
		// 회원 정보 수정 
		$('#userUpdateBtn').on('click', function(e) {
			e.preventDefault(); // submit 기능 중지
			
			// 기존 회원정보 텍스트 지우고, 수정 가능한 input 노출
			$('#fileChangeBtn').removeClass('d-none');

			$('#textName').addClass('d-none');
			$('#changedName').removeClass('d-none');
			$('#changedNameCheckBtn').removeClass('d-none');

			$('#textLoginId').addClass('d-none');
			$('#changedLoginId').removeClass('d-none');
			$('#changedLoginIdCheckBtn').removeClass('d-none');
			
			$('#changedPasswordLine').removeClass('d-none');
			$('#changedPasswordConfirmLine').removeClass('d-none');
			
			$('#textEmail').addClass('d-none');
			$('#changedEmail').removeClass('d-none');
			
			$('#userUpdateBtn').addClass('d-none');
			$('#userDeleteBtn').addClass('d-none');
			
			$('#userUpdateFinishBtn').removeClass('d-none');
			$('#userUpdateCancelBtn').removeClass('d-none');
		});
		
		// 회원 정보 수정 완료 
		$('#userUpdateFinishBtn').on('click', function(e) {
			e.preventDefault(); // submit 기능 중지

			let changedName = $('#changedName').val().trim();
			let changedLoginId = $('#changedLoginId').val().trim();
			let changedPassword = $('#changedPassword').val();
			let changedPasswordConfirm = $('#changedPasswordConfirm').val();
			let changedEmail = $('#changedEmail').val().trim();
			let changedFile = $('#changedFile')[0].files[0];
			
			// 비밀번호 변경 시 비밀번호 확인만 일치하는지 체크
			// 변경하지 않는 경우에는 그냥 제출 가능하도록 ''이 아닐 경우에만 체크한다.
			if(changedPassword != changedPasswordConfirm
				&& changedPassword != ''
			){
				alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
				return false;
			}
			
			// 수정했을 경우에만, 중복확인 완료됐는지 확인(d-none이 없는 상태)
			// -> d-none 있으면 alert 띄우기
			if(changedName.length > 0 &&
				$('#changedNameCheckOk').hasClass('d-none')){
				alert("닉네임 중복확인을 다시 해주세요");
				return false;
			}
			if(changedLoginId.length > 0 &&
				$('#changedLoginIdCheckOk').hasClass('d-none')){
				alert("아이디 중복확인을 다시 해주세요");
				return false;
			}
			
			// form태그를 자바스크립트에서 만든다.
			let formData = new FormData();
			formData.append("changedName", changedName);
			formData.append("changedLoginId", changedLoginId);
			formData.append("changedPassword", changedPassword);
			formData.append("changedEmail", changedEmail);
			formData.append("changedFile", changedFile);

			// AJAX form 데이터 전송
			$.ajax({
				type:'POST'
				,url:'/user/update_user'
				, data: formData
				, enctype: "multipart/form-data"    // 파일 업로드를 위한 필수 설정
				, processData: false    // 파일 업로드를 위한 필수 설정
				, contentType: false    // 파일 업로드를 위한 필수 설정
				, success: function(data) {
					if (data.code == 1) {
						// 성공
						alert("회원 정보 수정이 완료되었습니다. \n 다시 로그인해주세요");
						// 로그아웃 후 로그인 페이지로 이동됨(redirect)
						location.href="/user/sign_out";
					} else{
						// 실패
						alert("[error] 통신 문제로 회원 정보 수정에 실패했습니다. \n 담당자에게 문의해주세요");
					}
					
				}
			});
		});
		
		// 회원 탈퇴 버튼(delete) -> modal 작동
		$('#userDeleteBtn').on('click', function(e) {
			e.preventDefault();
			// getting
			let userId = $(this).data("user-id");
			
			// setting : modal 태그에 data-user-id 심어줌
			$('#modal').data("user-id", userId);
		});

		
		// modal 안에 있는 삭제하기 버튼 클릭
		$('#modal #userDeleteAgreeBtn').on('click',function(e){
			e.preventDefault();
			let userId = $('#modal').data('user-id');
			
			// AJAX - 회원 탈퇴
			$.ajax({
				// request
				type:"DELETE"
				,url:"/user/delete"
				, data:{"userId":userId}
			
				// response
				,success:function(data){
					if(data.result == "성공"){
						alert("회원 탈퇴가 정상적으로 완료되었습니다.");
						location.href = "/user/sign_out_main";
					} else {
						alert(data.errorMessage);
					}
				}
				,error:function(e){
					alert("[error] 회원 탈퇴에 실패했습니다. 담당자에게 문의해주세요");
				}
			});
		});
	});
</script>