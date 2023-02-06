<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<div class="container">
	<%-- �ֽ� ���� ���� --%>
	<div class="pt-4 pb-4">
		<h1 class="bold">�ֽ� ���� ����</h1>
		<div class="contents-box white-text">
		</div>
	</div>
	
	<div class="d-flex justify-content-between">
	<%-- �������� --%>
	<div class="pt-4 pb-4">
		<h1 class="bold">��������</h1>
		<div class="alert-box">
			<table class="table">
				<thead>
					<th>No.</th>
					<th>����</th>
					<th>�Խ���</th>
				</thead>
				<tbody>
				<%-- �ݺ������� �ֱ�(createdAt) ����(desc) 3�� ���� --%>
					<tr>
						<td>1</td>
						<td>�����ε� EL�� �޾ƿð���</td>
						<td>�Խ��ϵ� EL�� �޾ƿð�</td>
					</tr>
					<tr>
						<td>2</td>
						<td>�����ε� EL�� �޾ƿð���</td>
						<td>�Խ��ϵ� EL�� �޾ƿð�</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<%-- ���� Ȯ�� --%>
	<div class="pt-4 pb-4">
		<h1 class="bold">���� Ȯ��</h1>
		<div class="book-confirm-box white-text bold">
			<%-- ȸ�� / ��ȸ�� ���� --%>
			<div class="d-flex justify-content-center pt-3 mb-3">
				<div class="mr-5">
					<label for="notMember" class="mr-1">��ȸ��</label>
					<input type="radio" id="notMember" name="isMember" value="false">
				</div>
				<div>
					<label for="member" class="mr-1">ȸ��</label>
					<input type="radio" id="member" name="isMember" value="true">
				</div>
			</div>
			
			<%-- ��ȸ���� ��� : �̸�, ��ȭ��ȣ --%>
			<div class="container">
				<div class="d-flex align-items-center mb-3">
					<label for="bookName" class="ml-3 col-4">�̸�</label>
					<input type="text" id="bookName" name="bookName" class="form-control" placeholder="������ �̸�">
				</div>
				<div class="d-flex align-items-center mb-4">
					<label for="phoneNumber" class="ml-3 col-4">��ȭ��ȣ</label>
					<input type="text" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="��ȭ��ȣ">
				</div>
				
				<button class="w-100 btn btn-dark">Ȯ���ϱ�</button>
			</div>
		</div>
	</div>
	</div>
</div>