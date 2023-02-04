<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="pr-5 mr-5"></div>
<div class="d-flex justify-content-center align-items-center">
	<h1 class="white-text font-weight-bold">
		<a href="/main/main_view" class="text-white">공연 예매</a>
	</h1>
</div>

<div class="login-info d-flex align-items-center mr-5">
	<%-- 로그인 정보 있을 때만 노출 --%>
	<c:if test="${not empty userName}">
		<span class="text-white">${userName}님 안녕하세요</span>
		<a href="/user/sign_out" class="ml-2 text-white font-weight-bold">로그아웃</a>
	</c:if>
	<%-- 비로그인 시 로그인 /회원가입 노출 --%>
	<c:if test="${empty userName}">
		<div class="d-flex mr-3">
			<button type="button" class="btn btn-danger mr-3">
				<a href="/user/sign_in_view" id="loginBtn">로그인</a>
			</button>
			<button type="button" class="btn btn-info">
				<a href="/user/sign_up_view" id="joinBtn">회원가입</a>
			</button>
		</div>
	</c:if>
</div>