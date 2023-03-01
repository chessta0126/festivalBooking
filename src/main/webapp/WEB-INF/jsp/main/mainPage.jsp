<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<div class="container">
	<%-- 최신 공연 정보 --%>
	<div class="pt-4 pb-4">
		<h1 class="bold">최신 공연 정보</h1>
		<c:forEach items="${festivalList}" var="festival">
			<article class="w-100 festivalCard mt-3 pr-4 pb-3 d-flex bg-dark">
				<!-- 공연 포스터 이미지-->
				<div class="m-3 pt-3 pl-2">
					<a href="/festival/festival_detail_view?festivalId=${festival.id}">
						<img src="${festival.imagePath}" alt="공연 팜플렛" width="250" height="250">
					</a>
				</div>
				<!-- 공연 정보 -->
				<div class="pl-3">
					<div class="pt-4 font-weight-bold">
						<h4>
							<a href="/festival/festival_detail_view?festivalId=${festival.id}" class="festival-title">${festival.title}</a>
						</h4>
					</div>
					<div class="pt-2 white-text"></div>
					<div class="white-text festival-explain">${festival.explain}</div>
					<div class="pt-3 yellow-text">일시 : ${festival.date}</div>
					<div class="pt-2 text-info">
						장소 : ${festival.place}
						<c:if test="!${ObjectUtils.isEmpty(festival.address)}">
							(${festival.address})
						</c:if>
					</div>
					<div class="pt-2">
						<span class="pr-4 text-success">예매: ${festival.price}원 / 현장: ${festival.priceOffline}원</span>
					</div>
					<div class="pt-2 text-secondary">
						<span class="pr-4">기획자 : ${festival.festivalMaster}</span>
						<span>문의사항 : ${festival.askRoot}</span>
					</div>
				</div>
			</article>
			</c:forEach>
	</div>
	
	<div class="d-flex justify-content-between">
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
	
	<%-- 예매 확인 --%>
	<div class="pl-3 pt-4 pb-4">
		<h1 class="bold">예매 확인</h1>
		<div class="book-confirm-box white-text bold">
			<%-- 회원 / 비회원 선택 --%>
			<div class="d-flex justify-content-center pt-3 mb-3">
				<div class="mr-5">
					<label for="notMember" class="mr-1">비회원</label>
					<input type="radio" id="memberNot" name="isMember" value="false" checked>
				</div>
				<div>
					<label for="member" class="mr-1">회원</label>
					<input type="radio" id="member" name="isMember" value="true">
				</div>
			</div>
			
			<%-- 비회원일 경우 : 이름, 전화번호 --%>
			<div id="memberNotBox" class="container">
				<div class="d-flex align-items-center mb-3">
					<label for="bookName" class="ml-3 col-4">예약자</label>
					<input type="text" id="bookName" name="bookName" class="form-control" placeholder="예약자 이름">
				</div>
				<div class="d-flex align-items-center mb-4">
					<label for="phoneNumber" class="ml-3 col-4">전화번호</label>
					<input type="text" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="전화번호">
				</div>
				
				<button class="w-100 btn btn-dark">확인하기</button>
			</div>
			
			<%-- 회원일 경우 : 예매 확인 페이지로 넘어가는 버튼 --%>
			<div id="memberBox" class="container d-none">
				<button class="w-100 btn btn-dark">
					<a href="/book/myBooking_view" class="button">예매 목록</a>
				</button>
			</div>
		</div>
	</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		// 회원/ 비회원 상자 toggle
        $('#member').on('click',function(){
            // 선택창 체크 토글
            $('#memberNot').prop("checked",false);
            $('#member').prop("checked",true);

            // 입력창 박스 토글
            $('#memberNotBox').addClass("d-none");
            $('#memberBox').removeClass("d-none");
        });
		
        $('#memberNot').on('click',function(){
            // 선택창 체크 토글
            $('#member').prop("checked",false);
            $('#memberNot').prop("checked",true);

            // 입력창 박스 토글
            $('#memberBox').addClass("d-none");
            $('#memberNotBox').removeClass("d-none");
        });
	});
</script>