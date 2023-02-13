<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 글 --%>
<div class="pt-4 container">
	<%-- 글 종류 --%>
	<div class="d-flex justify-content-between align-items-center">
		<h1 class="bold">${post.postType}</h1>
	</div>
	<%-- 제목 --%>
	<div class="pt-3 w-75 d-flex align-items-center">
		<span class="bold mr-3 title-font-size">제목</span>
		<span class="value-font-size">${post.postTitle}</span>
	</div>
		
	<div class="pt-3 d-flex justify-content-between">
		<%-- 작성자 --%>
		<div class="d-flex align-items-center">
			<span class="bold mr-3 valueTitle-font-size">작성자</span>
			<span class="value-font-size">${postUserName}</span>
		</div>
		<div class="d-flex">
			<%-- 게시일 --%>
			<div class="pr-3 d-flex align-items-center">
				<span class="bold mr-3 valueTitle-font-size">게시일</span>
				<span class="mr-3 value-font-size">
					<fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/>
				</span>
			</div>
			<%-- 조회수 --%>
			<div class="d-flex align-items-center">
				<span class="bold mr-3 valueTitle-font-size">조회수</span>
				<span class="mr-3 value-font-size">조회수</span>
			</div>
		</div>
	</div>
	
	<%-- 글 내용 --%>
	<div class="pt-4">
		<textarea rows="10" cols="100" id="content" class="form-control"></textarea>
	</div>
</div>

<%-- 댓글 --%>
<div class="pt-4 container">
	<%-- 댓글 달기(본인) : 로그인 시에만 보이게 --%>
	<c:if test="${userId != null}">
	<div class="d-flex">
		<div class="w-100 d-flex align-items-center">
			<%-- 본인 프로필 사진 --%>
			<img src="${userProfileImageUrl}" width="50px" height="50px" alt="userProfileImage">
			<%-- 본인 이름 --%>
			<span class="pl-2 bold mr-3 valueTitle-font-size">${userName}</span>
			<%-- 댓글 작성란 --%>
			<input type="text" id="comment" class="form-control">
		</div>
	</div>
	</c:if>
</div>

<script>
	$(document).ready(function(){
		$('#postChangeBtn').on('click', function(e) {
			
		});
	});
</script>