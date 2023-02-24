<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<ul class="nav w-100 justify-content-around">
	<div>
		<li class="nav-item">
			<a href="/festival/festival_list_view" class="nav-link">공연 예매</a>
		</li>
	</div>
	
	<div>
		<li class="nav-item">
		<c:choose>
			<c:when test="${userId != null}">
				<a href="/festival/festival_myList_view" class="nav-link">공연 홍보</a>
			</c:when>
			<c:otherwise>
				<a href="/user/sign_in_view" class="nav-link">공연 홍보</a>
			</c:otherwise>
		</c:choose>
		</li>
	</div>
	
	<div>
		<li class="nav-item">
			<a href="#" class="nav-link">라인업 신청/모집</a>
		</li>
	</div>
	
	<div>
		<li class="nav-item">
			<a href="/post/postList?postType=공지사항" class="nav-link">공지사항</a>
		</li>
	</div>

	<div>
		<li class="nav-item">
			<a href="/post/postList?postType=자유게시판" class="nav-link">자유게시판</a>
		</li>
	</div>

	<div>
		<li class="nav-item">
			<a href="/myPage/myPage_view" class="nav-link">마이페이지</a>
		</li>
	</div>
</ul>
