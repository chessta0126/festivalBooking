<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="pr-5 mr-5"></div>
<div class="d-flex justify-content-center align-items-center">
	<h1 class="white-text font-weight-bold">
		<a href="/main/main_view" class="text-white">���� ����</a>
	</h1>
</div>

<div class="login-info d-flex align-items-center mr-5">
	<%-- �α��� ���� ���� ���� ���� --%>
	<c:if test="${not empty userName}">
		<span class="text-white">${userName}�� �ȳ��ϼ���</span>
		<a href="/user/sign_out" class="ml-2 text-white font-weight-bold">�α׾ƿ�</a>
	</c:if>
	<%-- ��α��� �� �α��� /ȸ������ ���� --%>
	<c:if test="${empty userName}">
		<div class="d-flex mr-3">
			<button type="button" class="btn btn-danger mr-3">
				<a href="/user/sign_in_view" id="loginBtn">�α���</a>
			</button>
			<button type="button" class="btn btn-info">
				<a href="/user/sign_up_view" id="joinBtn">ȸ������</a>
			</button>
		</div>
	</c:if>
</div>