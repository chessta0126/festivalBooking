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
							<%-- �ߺ�Ȯ�� ��ư �� ���̰� �ص� d-flex�� �ٿ����� ������ �ؿ� ������ ����Ƿ� ������� �����ش�. --%>
							<div class="d-flex align-items-center">
								<span id="textName">${userInfo.name}</span>
								
								<%-- ���� Ŭ�� �ÿ��� ���̱� --%>
								<input type="text" id="changedName" name="changedName"
								class="form-control d-none" placeholder="${userInfo.name}">
								<button type="button" id="changedNameCheckBtn" class="btn btn-success d-none">�ߺ�Ȯ��</button>
							</div>
	
							<%-- ���̵� �ߺ� Ȯ�� ��� --%>
							<div id="changedNameLength" class="small text-danger d-none">�г����� �Է����ּ���.</div>
							<div id="changedNameCheckDuplicated" class="small text-danger d-none">�̹� ������� �г��� �Դϴ�.</div>
							<div id="changedNameCheckOk" class="small text-success d-none">��� ������ �г��� �Դϴ�.</div>
						</td>
					</tr>
					<tr>
						<td class="pr-3">���̵�</td>
						<td>
							<%-- �ߺ�Ȯ�� ��ư �� ���̰� �ص� d-flex�� �ٿ����� ������ �ؿ� ������ ����Ƿ� ������� �����ش�. --%>
							<div class="d-flex align-items-center">
								<span id="textLoginId">${userInfo.loginId}</span>

								<%-- ���� Ŭ�� �ÿ��� ���̱� --%>
								<input type="text" id="changedLoginId" name="changedLoginId"
								class="form-control d-none" placeholder="${userInfo.loginId}">
								<button type="button" id="changedLoginIdCheckBtn" class="btn btn-success d-none">�ߺ�Ȯ��</button><br>
							</div>

							<%-- ���̵� �ߺ� Ȯ�� ��� --%>
							<div id="changedLoginIdLength" class="small text-danger d-none">ID�� 4�� �̻� �Է����ּ���.</div>
							<div id="changedLoginIdCheckDuplicated" class="small text-danger d-none">�̹� ������� ID�Դϴ�.</div>
							<div id="changedLoginIdCheckOk" class="small text-success d-none">��� ������ ID �Դϴ�.</div>
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
		</div>
		</form>
	</div>
	<hr>
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
		
		// �г��� �ߺ�Ȯ�� ��ư Ŭ��
		$('#changedNameCheckBtn').on('click', function() {
			// �ʱ�ȭ(��� ����)
			$('#changedNameLength').addClass('d-none');
			$('#changedNameCheckDuplicated').addClass('d-none');
			$('#changedNameCheckOk').addClass('d-none');

			let changedName = $('input[name=changedName]').val().trim();
			// alert(changedName);
			
			if (changedName.length == '') {
				$('#changedNameLength').removeClass('d-none'); // ����� ����
				return;
			}
			
			// AJAX ��� - �г��� �ߺ�Ȯ��
			$.ajax({
				// request
				url : "/user/is_duplicated_name"
				, data : {"name" : changedName}

				// response
				, success : function(data) {
					// ����
					if (data.result) {
						// �ߺ�
						$('#changedNameCheckDuplicated').removeClass('d-none');
					} else {
						// ��� ����
						$('#changedNameCheckOk').removeClass('d-none');
					}
				}
				,error:function(e){
					alert("�ߺ� Ȯ�ο� �����߽��ϴ�.");
				}
			});
		});
		
		// Id �ߺ�Ȯ�� ��ư Ŭ��
		$('#changedLoginIdCheckBtn').on('click', function() {
			// �ʱ�ȭ(��� ����)
			$('#changedLoginIdLength').addClass('d-none');
			$('#changedLoginIdCheckDuplicated').addClass('d-none');
			$('#changedLoginIdCheckOk').addClass('d-none');

			let changedLoginId = $('input[name=changedLoginId]').val().trim();
			// alert(changedLoginId);
			
			if (changedLoginId.length < 4) {
				$('#changedLoginIdLength').removeClass('d-none'); // ����� ����
				return;
			}

			// AJAX ��� - ���̵� �ߺ�Ȯ��
			$.ajax({
				// request
				url : "/user/is_duplicated_id"
				, data : {"loginId" : changedLoginId}

				// response
				, success : function(data) {
					// ����
					if (data.result) {
						// �ߺ�
						$('#changedLoginIdCheckDuplicated').removeClass('d-none');
					} else {
						// ��� ����
						$('#changedLoginIdCheckOk').removeClass('d-none');
					}
				}
				,error:function(e){
					alert("�ߺ� Ȯ�ο� �����߽��ϴ�.");
				}
			});
		});
		
		// ȸ�� ���� ���� 
		$('#userUpdateBtn').on('click', function(e) {
			e.preventDefault(); // submit ��� ����
			
			// ���� ȸ������ �ؽ�Ʈ �����, ���� ������ input ����
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
		});
		
		// ȸ�� ���� ���� �Ϸ� 
		$('#userUpdateFinishBtn').on('click', function(e) {
			e.preventDefault(); // submit ��� ����

			let changedName = $('#changedName').val().trim();
			let changedLoginId = $('#changedLoginId').val().trim();
			let changedPassword = $('#changedPassword').val();
			let changedPasswordConfirm = $('#changedPasswordConfirm').val();
			let changedEmail = $('#changedEmail').val().trim();
			let changedFile = $('#changedFile')[0].files[0];
			
			// ��й�ȣ ���� �� ��й�ȣ Ȯ�θ� ��ġ�ϴ��� üũ
			// �������� �ʴ� ��쿡�� �׳� ���� �����ϵ��� ''�� �ƴ� ��쿡�� üũ�Ѵ�.
			if(changedPassword != changedPasswordConfirm
				&& changedPassword != ''
			){
				alert("��й�ȣ�� ��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
				return false;
			}
			
			// �������� ��쿡��, �ߺ�Ȯ�� �Ϸ�ƴ��� Ȯ��(d-none�� ���� ����)
			// -> d-none ������ alert ����
			if(changedName.length > 0 &&
				$('#changedNameCheckOk').hasClass('d-none')){
				alert("�г��� �ߺ�Ȯ���� �ٽ� ���ּ���");
				return false;
			}
			if(changedLoginId.length > 0 &&
				$('#changedLoginIdCheckOk').hasClass('d-none')){
				alert("���̵� �ߺ�Ȯ���� �ٽ� ���ּ���");
				return false;
			}
			
			// form�±׸� �ڹٽ�ũ��Ʈ���� �����.
			let formData = new FormData();
			formData.append("changedName", changedName);
			formData.append("changedLoginId", changedLoginId);
			formData.append("changedPassword", changedPassword);
			formData.append("changedEmail", changedEmail);
			formData.append("changedFile", changedFile);

			// AJAX form ������ ����
			$.ajax({
				type:'POST'
				,url:'/user/update_user'
				, data: formData
				, enctype: "multipart/form-data"    // ���� ���ε带 ���� �ʼ� ����
				, processData: false    // ���� ���ε带 ���� �ʼ� ����
				, contentType: false    // ���� ���ε带 ���� �ʼ� ����
				, success: function(data) {
					if (data.code == 1) {
						// ����
						alert("ȸ�� ���� ������ �Ϸ�Ǿ����ϴ�. \n �ٽ� �α������ּ���");
						location.href="/user/sign_in_view";
					} else{
						// ����
						alert("[error] ��� ������ ȸ�� ���� ������ �����߽��ϴ�. \n ����ڿ��� �������ּ���");
					}
				}
			});
		});
	});
</script>