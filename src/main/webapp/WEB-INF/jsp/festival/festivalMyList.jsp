<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="pt-4 d-flex justify-content-center">
	<div>
		<div class="pb-3 d-flex justify-content-between align-items-center">
			<h1 class="bold">내가 등록한 공연</h1>
			<c:if test="${userId eq null}">
			</c:if>
		</div>
		
		<table class="table">
			<thead>
				<tr>
					<th>No.</th>
					<th>공연명</th>
					<th>게시일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${festivalList}" var="festival">
				<tr>
					<td>${festival.id}</td>
					<td><a href="#"></a></td>
					<td><fmt:formatDate value="${festival.createdAt}" pattern="yyyy-MM-dd"/></td>
					<td>조회수</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>

		<button id="writePostBtn" class="w-100 btn btn-primary">
			<a href="/festival/festival_create_view" class="button">새로운 공연 등록</a>
		</button>
	</div>
</div>