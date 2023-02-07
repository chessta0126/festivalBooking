<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<div class="container">
	<div class="pt-4 pb-4">
		<h1 class="bold">ȸ�� ����</h1>
		<form method="Post" action="/user/update">
		<div class="mt-4 d-flex">
			<%-- ������ �̹��� --%>
			<div class="ml-5 col-3">
				<%-- file �±״� ���ܵΰ� �̹����� Ŭ���ϸ� file �±׸� Ŭ���� ��ó�� �̺�Ʈ�� �� ���̴�. --%>
				<input type="file" id="changedFile" class="d-none"
					accept=".gif, .jpg, .png, .jpeg">
				
				<%-- �̹����� ���콺 �ø��� ���콺Ŀ���� ��ũ Ŀ���� ���ϵ��� a �±� ��� --%>
				<a href="#" id="userProfileImage" class="fileChangeBtn">
					<img src="${userProfileImageUrl}" id="profileImage" width="150px">
				</a>
				
				<%-- ���ε� �� �ӽ� ���� �̸� ����� �� --%>
				<div id="changedFileName" class="ml-2"></div>

				<div class="text-center mt-2 mb-2">������ �̹���</div>

				<%-- ��ư ������ ������ �� �ְԲ� �Ѵ�. --%>
				<button class="btn btn-secondary w-100 fileChangeBtn">�����ϱ�</button>
				
			</div>
			
			<%-- ȸ�� ����(text) --%>
			<div class="col-9">
				<table class="table">
					<tr>
						<td class="pr-3">�г���(Ȱ����)</td>
						<td>
							<span id="textName">${userInfo.name}</span>
							<%-- ���� Ŭ�� �ÿ��� ���̱� --%>
							<input type="text" id="changedName" name="changedName"
							class="form-control d-none" placeholder="${userInfo.name}">
						</td>
					</tr>
					<tr>
						<td class="pr-3">���̵�</td>
						<td>
							<span id="textLoginId">${userInfo.loginId}</span>
							<%-- ���� Ŭ�� �ÿ��� ���̱� --%>
							<input type="text" id="changedLoginId" name="changedLoginId"
							class="form-control d-none" placeholder="${userInfo.loginId}">
							
							<%-- ���̵� �ߺ� Ȯ�� ��� --%>
							<div id="idCheckLength" class="small text-danger d-none">ID�� 4�� �̻� �Է����ּ���.</div>
							<div id="idCheckDuplicated" class="small text-danger d-none">�̹� ������� ID�Դϴ�.</div>
							<div id="idCheckOk" class="small text-success d-none">��� ������ ID �Դϴ�.</div>
						</td>
					</tr>
					<%-- �ؽ̵� ��й�ȣ�� ������ ������, ����ڰ� ���⿡ ���� �ʴ�. --%>
					<%-- ������ �ʿ����� �ʴ� �� ����ڿ��� ���� �ڱ� ��й�ȣ�� ������ �ʿ�� ����. ���� Ŭ�� �ÿ��� ���̱� --%>
					<tr id="changedPasswordLine" class="d-none">
						<td class="pr-3">��й�ȣ</td>
						<td>
							<input type="password" id="changedPassword" name="changedPassword" class="form-control">
						</td>
					</tr>
					<tr id="changedPasswordConfirmLine" class="d-none">
						<td class="pr-3">��й�ȣ Ȯ��</td>
						<td>
							<input type="password" id="changedPasswordConfirm" name="changedPasswordConfirm" class="form-control">
						</td>
					</tr>

					<tr>
						<td class="pr-3">e-mail</td>
						<td>
							<span id="textEmail">${userInfo.email}</span>
							<%-- ���� Ŭ�� �ÿ��� ���̱� --%>
							<input type="text" id="changedEmail" name="changedEmail"
							class="form-control d-none" placeholder="${userInfo.email}">
						</td>
					</tr>
				</table>

				<%-- button --%>
				<div class="d-flex justify-content-center">
					<button id="userUpdateBtn" class="btn btn-info mr-5">ȸ�� ���� ����</button>
					<button id="userDeleteBtn" class="btn btn-danger">ȸ�� Ż��</button>
					<button id="userUpdateFinishBtn" class="d-none btn btn-info mr-5">���� �Ϸ�</button>
				</div>
			</div>
		</form>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		// ������ �̹��� ���� 
		$('.fileChangeBtn').on('click', function(e) {
			// alert("���� ����");
			e.preventDefault(); // a �±��� �ö󰡴� ���� ����
			$('#changedFile').click(); // input file�� Ŭ���� �Ͱ� ���� ȿ��
		});
		
		// ����ڰ� �̹����� �������� �� ��ȿ�� Ȯ�� �� ���ε� �� ���� �̸� ����
		$('#changedFile').on('change', function(e) {
			// alert("���� ����");
			let changedFileName = e.target.files[0].name;
			// alert(changedFileName);

			// Ȯ���� ��ȿ�� Ȯ��
			let ext = changedFileName.split(".").pop().toLowerCase();
			if (ext != 'jpg' && ext != 'jpeg' && ext != 'gif' && ext != 'png') {
				alert("jpg, jpeg, gif, png ���ϸ� ���ε� �� �� �ֽ��ϴ�.");
				$('#changedFile').val(''); // ���� �±׿� ���� ���� ����
				$("#changedFileName").text(''); // ���� �̸� ����
				return;
			}
			
			// ��ȿ�� ��� �� ���� �̸� Ȯ��
			// $('#changedFileName').text(changedFileName);
			
			// ���� �̹��� �����
			$('#userProfileImage').addClass('d-none');
		});
		
		// ȸ�� ���� ���� 
		$('#userUpdateBtn').on('click', function(e) {
			e.preventDefault(); // submit ��� ����
			
			// ���� ȸ������ �ؽ�Ʈ �����, ���� ������ input ����
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
		
		// ȸ�� ���� ���� �Ϸ� 
		$('#userUpdateFinishBtn').on('click', function(e) {
			e.preventDefault(); // submit ��� ����

			let changedName = $('#changedName').val().trim();
			let changedLoginId = $('#changedLoginId').val().trim();
			let changedPassword = $('#changedPassword').val();
			let changedConfirmPassword = $('#confirmPassword').val();
			let changedEmail = $('#changedEmail').val().trim();
			let changedFile = $('#changedFile')[0].files[0];
			
			// ��й�ȣ ���� �� ��й�ȣ Ȯ�θ� ��ġ�ϴ��� üũ
			// �������� �ʾƵ� ''�� ��ġ�ؾ� ��
			if(changedPassword != changedConfirmPassword){
				alert("��й�ȣ�� ��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
				return false;
			}
			
			// ���̵� �ߺ�Ȯ�� �Ϸ�ƴ��� Ȯ��(idCheckOk d-none�� ���� ����)
			// -> d-none ������ alert ����
			if($('#changedLoginIdCheckOk').hasClass('d-none')){
				alert("���̵� �ߺ�Ȯ���� �ٽ� ���ּ���");
				return false;
			}
			
			// form�±׸� �ڹٽ�ũ��Ʈ���� �����.
			let formData = new FormData();
			formData.append("name", name);
			formData.append("loginId", loginId);
			formData.append("password", password);
			formData.append("email", email);
			formData.append("file", $('#file')[0].files[0]); // $('#file')[0]�� ù��° input file �±׸� �ǹ�, files[0]�� ���ε�� ù��° ����
			
			// AJAX form ������ ����
			$.ajax({
				type:'POST'
				,url:'/user/update'
				, data: formData
				, enctype: "multipart/form-data"    // ���� ���ε带 ���� �ʼ� ����
				, processData: false    // ���� ���ε带 ���� �ʼ� ����
				, contentType: false    // ���� ���ε带 ���� �ʼ� ����
				, success: function(data) {
					if (data.code == 1) {
						// ����
						alert("������ ȯ���մϴ�! �α��� ���ּ���.");
						location.href="/user/sign_in_view";
					} else{
						// ����
						alert("[error] ��� ������ ���Կ� �����߽��ϴ�. \n ����ڿ��� �������ּ���");
					}
				}
			});
		});
	});
</script>