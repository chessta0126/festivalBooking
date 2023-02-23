<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="pt-4 d-flex justify-content-center">
	<div>
		<%-- my festivalList --%>
		<div class="pb-5">
			<div class="pb-3 d-flex justify-content-between align-items-center">
				<h1 class="bold">My festival List</h1>
			</div>
			
			<c:choose>
				<c:when test="${myFestivalList[0] != null}">
				<table class="table text-center">
					<thead>
						<tr>
							<th>No.</th>
							<th>공연명</th>
							<th>게시일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${myFestivalList}" var="festival">
						<tr>
							<td>${festival.id}</td>
							<td><a href="/festival/festival_detail_view?festivalId=${festival.id}">${festival.title}</a></td>
							<td><fmt:formatDate value="${festival.createdAt}" pattern="yyyy-MM-dd"/></td>
							<td>조회수</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				</c:when>
				
				<c:otherwise>
				<div class="p-3 d-flex justify-content-center">
					<img width="250" src="\images\★default file/no-image-found-360x250-1-300x208.png" alt="thereIsNoFestival">
				</div>
				</c:otherwise>
			</c:choose>
	
			<button id="writePostBtn" class="w-100 btn btn-dark">
				<a href="/festival/festival_create_view" class="button">새로운 공연 등록</a>
			</button>
		</div>
		<hr>
		
		<%-- my postList - 공지사항 --%>
		<div class="pt-3 pb-3">
			<div class="pb-3 d-flex justify-content-between align-items-center">
				<h1 class="bold">공지사항</h1>
				<c:if test="${userId != null}">
					<button id="writePostBtn" class="btn btn-danger">
						<a href="/post/post_create_view?postType=자유게시판&isUpdate=false" class="button">글쓰기</a>
					</button>
				</c:if>
			</div>
			<table class="table text-center">
				<thead>
					<tr>
						<th>No.</th>
						<th>제목</th>
						<th>게시일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${myPostListAlert}" var="post">
					<tr>
						<td>${post.id}</td>
						<td><a href="/post/post_detail_view?postType=${post.postType}&postId=${post.id}">${post.postTitle}</a></td>
						<td><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/></td>
						<td>조회수</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<hr>

		<%-- my postList - 자유게시판 --%>
		<div class="pt-3">
			<div class="pb-3 d-flex justify-content-between align-items-center">
				<h1 class="bold">자유게시판</h1>
				<c:if test="${userId != null}">
					<button id="writePostBtn" class="btn btn-info">
						<a href="/post/post_create_view?postType=자유게시판&isUpdate=false" class="button">글쓰기</a>
					</button>
				</c:if>
			</div>
			<table class="table text-center">
				<thead>
					<tr>
						<th>No.</th>
						<th>제목</th>
						<th>게시일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${myPostListCommunity}" var="post">
					<tr>
						<td>${post.id}</td>
						<td><a href="/post/post_detail_view?postType=${post.postType}&postId=${post.id}">${post.postTitle}</a></td>
						<td><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/></td>
						<td>조회수</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>