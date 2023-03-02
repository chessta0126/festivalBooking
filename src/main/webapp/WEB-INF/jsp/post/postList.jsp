<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="pt-4 d-flex justify-content-center">
	<div>
		<div>
			<div class="pb-3 d-flex justify-content-between align-items-center">
				<h1 class="bold">${postType}</h1>
				<c:if test="${userId != null}">
					<button id="writePostBtn" class="btn btn-primary">
						<a href="/post/post_create_view?postType=${postType}&isUpdate=false" class="button">글쓰기</a>
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
					<c:forEach items="${postList}" var="post">
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
		
		<%-- 페이징 --%>
		<div class="pt-3 d-flex justify-content-center">
			<%-- 현재 페이지 > 페이징 기준 경우에만 이전 표시 --%>
			<c:if test="${currentPage > 3}">
				<a href="/post/postList?postType=${postType}&page=${currentPage-1}">&lt;&lt;</a>
			</c:if>

			<c:forEach begin="1" end="3" step="1" var="page">
				<span class="pl-3 pr-3">
					<a href="/post/postList?postType=${postType}&page=${page}">${page}</a>
				</span>
			</c:forEach>
	
			<%-- 다음 페이지 <= 마지막 페이지 경우에만 다음 표시 --%>
			<c:if test="${currentPage + 1 <= needPage}">
				<a href="/post/postList?postType=${postType}&page=${currentPage + 1}">>></a>
			</c:if>
		</div>
	</div>
</div>