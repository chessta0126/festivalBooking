<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header d-flex justify-content-between">
	<%-- logo�� y������ .header�� ����� ��ġ --%>
	<div class="logo d-flex align-items-center">
		<h1 class="text-white ml-3"><a href="/timeline/timeline_view" class="text-white">���� ����</a></h1>
	</div>
	<div class="login-info d-flex align-items-center mr-5">
		<%-- �α��� ���� ���� ���� ���� --%>
		<c:if test="${not empty userName}">
			<span class="text-white">${userName}�� �ȳ��ϼ���</span>
			<a href="/user/sign_out" class="ml-2 text-white font-weight-bold">�α׾ƿ�</a>
		</c:if>
		<%-- ��α��� �� �α��� /ȸ������ ���� --%>
		<c:if test="${empty userName}">
			<a href="/user/sign_in_view" class="text-white font-weight-bold p-3">�α���</a>
			<a href="/user/sign_up_view" class="text-white font-weight-bold">ȸ������</a>
		</c:if>
	</div>
</div>