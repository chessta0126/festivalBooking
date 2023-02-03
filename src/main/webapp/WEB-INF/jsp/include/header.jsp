<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header d-flex justify-content-between">
	<%-- logo를 y축으로 .header의 가운데에 위치 --%>
	<div class="logo d-flex align-items-center">
		<h1 class="text-white ml-3"><a href="/timeline/timeline_view" class="text-white">공연 예매</a></h1>
	</div>
	<div class="login-info d-flex align-items-center mr-5">
		<%-- 로그인 정보 있을 때만 노출 --%>
		<c:if test="${not empty userName}">
			<span class="text-white">${userName}님 안녕하세요</span>
			<a href="/user/sign_out" class="ml-2 text-white font-weight-bold">로그아웃</a>
		</c:if>
		<%-- 비로그인 시 로그인 /회원가입 노출 --%>
		<c:if test="${empty userName}">
			<a href="/user/sign_in_view" class="text-white font-weight-bold p-3">로그인</a>
			<a href="/user/sign_up_view" class="text-white font-weight-bold">회원가입</a>
		</c:if>
	</div>
</div>