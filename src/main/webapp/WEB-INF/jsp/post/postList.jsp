<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="pt-4 d-flex justify-content-center">
	<div class="w-50">
		<div class="pb-3 d-flex justify-content-between align-items-center">
			<h1 class="bold">${postType}</h1>
			<button id="writePostBtn" class="btn btn-primary">
				<a href="/post/post_create_view?postType=${postType}" class="button">글쓰기</a>
			</button>
		</div>
		<table class="table">
			<thead>
				<tr>
					<th>No.</th>
					<th>제목</th>
					<th>게시일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${postList}" var="post">
				<tr>
					<td>${post.id}</td>
					<td><a href="/post/post_detail_view?postId=${post.id}">${post.subject}</a></td>
					<td><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd a hh:mm:ss"/></td>
					<td>조회수</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>