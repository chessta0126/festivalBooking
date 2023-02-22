<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<div class="container">
	<%-- 최신 공연 정보 --%>
	<div class="pt-4 pb-4">
		<h1 class="bold">최신 공연 정보</h1>
		<div class="contents-box white-text">
		</div>
	</div>
	
	<div class="d-flex justify-content-between">
	<%-- 공지사항 --%>
	<div class="pt-4 pb-4">
		<h1 class="bold">공지사항</h1>
		<div class="alert-box">
			<table class="table">
				<thead>
					<th>No.</th>
					<th>제목</th>
					<th>게시일</th>
				</thead>
				<tbody>
				<%-- 반복문으로 최근(createdAt) 공지(desc) 3건 노출 --%>
				<c:forEach items="${postList}" var="post">
					<tr>
						<td>${post.id}</td>
						<td>${post.postTitle}</td>
						<td><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<%-- 예약 확인 --%>
	<div class="pt-4 pb-4">
		<h1 class="bold">예약 확인</h1>
		<div class="book-confirm-box white-text bold">
			<%-- 회원 / 비회원 선택 --%>
			<div class="d-flex justify-content-center pt-3 mb-3">
				<div class="mr-5">
					<label for="notMember" class="mr-1">비회원</label>
					<input type="radio" id="notMember" name="isMember" value="false">
				</div>
				<div>
					<label for="member" class="mr-1">회원</label>
					<input type="radio" id="member" name="isMember" value="true">
				</div>
			</div>
			
			<%-- 비회원일 경우 : 이름, 전화번호 --%>
			<div class="container">
				<div class="d-flex align-items-center mb-3">
					<label for="bookName" class="ml-3 col-4">이름</label>
					<input type="text" id="bookName" name="bookName" class="form-control" placeholder="예약자 이름">
				</div>
				<div class="d-flex align-items-center mb-4">
					<label for="phoneNumber" class="ml-3 col-4">전화번호</label>
					<input type="text" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="전화번호">
				</div>
				
				<button class="w-100 btn btn-dark">확인하기</button>
			</div>
		</div>
	</div>
	</div>
</div>