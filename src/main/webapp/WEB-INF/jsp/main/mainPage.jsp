<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<div class="container">
	<%-- 최신 공연 정보 --%>
	<div class="pt-4 pb-4">
		<h1 class="bold">최신 공연 정보</h1>
		<div class="contents-box white-text">
			<article class="festival1 mt-3 pr-4 pb-3 d-flex bg-dark">
				<!-- 공연 포스터 이미지-->
				<div class="m-3">
					<a href="#">
						<img src="#" alt="공연 팜플렛1" width="250" height="250">
					</a>
				</div>
				<!-- 공연 정보 -->
				<div class="pl-3">
					<div class="pt-4 font-weight-bold">
						<h4 class="festival-title">라이징 언더그라운드 hiphop festival</h4>
					</div>
					<div class="pt-2 white-text"></div>
					<div class="white-text">언더에서 주목할 만한 실력자 래퍼들이 뭉쳤다..!!</div>
					<div class="white-text">힙합씬의 next 자리를 노리는 핫루키들의 공연</div>
					<div class="pt-3 yellow-text">일시 : 2023년 10월 7일(토)</div>
					<div class="pt-2 text-info">장소 : 홍대 블루프린트 (서울 마포구 와우산로 17길 14
						지층)</div>
					<div class="pt-2">
						<span class="pr-4 text-success">예매: 10,000원 / 현장: 15,000원</span> <span
							class="text-success">(잔여 예약석: 30명)</span>
					</div>
					<div class="pt-2 text-secondary">
						<span class="pr-4">기획자 : chessta </span> <span>문의사항:
							@chessta0126</span>
					</div>
				</div>
			</article>
		</div>
	</div>
	
	<div class="d-flex justify-content-around">
	<%-- 공지사항 --%>
	<div class="pt-4 pb-4">
		<h1 class="bold">공지사항</h1>
		<div class="alert-box">
			<table class="table text-center">
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
						<td><a href="/post/post_detail_view?postType=${post.postType}&postId=${post.id}">${post.postTitle}</a></td>
						<td><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<%-- 예약 확인 --%>
	<div class="pl-3 pt-4 pb-4">
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