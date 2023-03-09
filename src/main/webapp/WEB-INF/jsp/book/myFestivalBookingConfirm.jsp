<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="pt-4 d-flex justify-content-center">
	<div>
		<div class="pb-3 d-flex justify-content-between align-items-center">
			<h2 class="bold">예매 현황</h2>
		</div>
		<h4 class="bold pb-3">공연명 : <span class="text-info">${festival.title}</span></h4>
		
		<c:choose>
			<c:when test="${bookList[0] != null}">
			<table class="table text-center">
				<thead>
					<tr>
						<th>예매자</th>
						<th>매수</th>
						<th>가격</th>
						<th>연락처</th>
						<th>회원여부</th>
						<th>예매날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${bookList}" var="book">
					<tr>
						<td>${book.bookName}</td>
						<td>${book.headCount}매</td>
						<td>${book.payMoney}원</td>
						<td>${book.phoneNumber}</td>
						<c:choose>
							<c:when test="${book.isMember == 1}">
								<td>회원</td>
							</c:when>
							<c:otherwise>
								<td>비회원</td>
							</c:otherwise>
						</c:choose>
						<td><fmt:formatDate value="${book.createdAt}" pattern="yyyy-MM-dd"/></td>
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

		<button id="writePostBtn" class="w-100 btn btn-secondary">
			<a href="/festival/festival_detail_view?festivalId=${festival.id}" class="button">공연 페이지로 이동</a>
		</button>
	</div>
</div>