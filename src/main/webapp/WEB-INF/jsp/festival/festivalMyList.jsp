<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="pt-4 d-flex justify-content-center">
	<div>
		<div class="pb-3 d-flex justify-content-between align-items-center">
			<h1 class="bold">내가 등록한 공연</h1>
		</div>
		
		<c:choose>
			<c:when test="${festivalList[0] != null}">
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
					<c:forEach items="${festivalList}" var="festival">
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

		<button id="writePostBtn" class="w-100 btn btn-primary">
			<a href="/festival/festival_create_view?isUpdate=false" class="button">새로운 공연 등록</a>
		</button>
	</div>
</div>