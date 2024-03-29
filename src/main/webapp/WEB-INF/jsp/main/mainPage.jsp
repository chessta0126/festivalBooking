<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<div class="container">
	<%-- 최신 공연 정보 --%>
	<div class="pt-4 pb-4">
		<h1 class="bold">최신 공연 정보</h1>
		<c:forEach items="${festivalList}" var="festival" varStatus="status">
		<div name="${status.count}" class="mainRecommendFestivalCard">
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
		</div>
		</c:forEach>
	</div>
	
	<div class="d-flex justify-content-between">
	<%-- 공지사항 --%>
	<div class="pt-4 pb-4 col-6 bg-secondary">
		<h1 class="bold">공지사항</h1>
		<div class="alert-box w-100">
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
	<div class="pl-3 pt-4 pb-4 col-6 bg-secondary">
		<h1 class="bold">예매 확인</h1>
		<div class="w-100 book-confirm-box white-text bold">
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
			<form id="bookedFestivalConfirm" method="get" action="/book/myBooking_view">
				<div class="d-flex align-items-center mb-3">
					<label for="bookName" class="ml-3 col-3">예약자</label>
					<input type="text" id="bookName" name="bookName" class="form-control" placeholder="예약자 이름">
				</div>
				<div class="d-flex align-items-center mb-4">
					<label for="phoneNumber" class="ml-3 col-3">전화번호</label>
					<div class="d-flex justify-content-between">
						<input type="text" id="phoneNumberHead" name="phoneNumberHead" class="form-control mr-2">
						-
						<input type="text" id="phoneNumberMiddle" name="phoneNumberMiddle" class="form-control ml-2 mr-2">
						-
						<input type="text" id="phoneNumberEnd" name="phoneNumberEnd" class="form-control ml-2">
					</div>
				</div>
				
				<button type="submit" class="w-100 btn btn-dark">확인하기</button>
			</form>	
			</div>
			
			<%-- 회원일 경우 : 예매 확인 페이지로 넘어가는 버튼 --%>
			<div id="memberBox" class="container d-none">
				<button class="w-100 btn btn-dark">
					<c:choose>
						<c:when test="${userId != null}">
							<a href="/book/myBooking_view" class="button">예매 목록</a>
						</c:when>
						<c:otherwise>
							<a href="/user/sign_in_view" class="button">로그인</a>
						</c:otherwise>
					</c:choose>
				</button>
			</div>
		</div>
	</div>
	</div>
</div>

<footer class="pt-5">
	<jsp:include page="../include/footer.jsp" />
</footer>

<script>
	$(document).ready(function(){
		// 추천 공연 전부 숨기기
		$(".mainRecommendFestivalCard").addClass("d-none");
		if(${recommendFestivalLimit} != 0){
			$(".mainRecommendFestivalCard[name=1]").removeClass("d-none");
		}
		
		// 메인이미지 5초마다 순환 : setInterval
        let festivalCardList = [];
		for(let i = 1; i <= ${recommendFestivalLimit}; i++){
			festivalCardList.push($(".mainRecommendFestivalCard[name="+i+"]"));
		}
        setInterval(function(){
            for(let i = 0; i < festivalCardList.length; i++){
                if(festivalCardList[i].is(":visible")){
                	festivalCardList[i].addClass("d-none");
                    // 마지막 카드일 때 처음으로 돌아가기, 아니면 다음 카드 보이기
                	if(i == festivalCardList.length-1){
                    	festivalCardList[0].removeClass("d-none");
                        break;
                    } else{
                    	festivalCardList[i+1].removeClass("d-none");
                        // 안 끊어주면 로직이 계속 실행됨. (다음 카드가 visible로 바뀌고 처음으로 돌아가기 때문에 계속 true가 되고, 사진이 쭉 넘어가서 맨 끝 사진만 보여주고 끝난다.)
                        // -> 여기서는 다시 처음으로 돌아오게 해놨기 때문에 맨 끝 사진으로 끝나는 것이 아니라 무한루프를 실행한다.
                        // 변하지 않는 것처럼 보이지만 무한히 실행되고 있는 중
                        // -> break;로 function 완료 후 5000이 적용되고, setInterval에 의해 다시 for이 시작되는 것이다.
                        break;
                    }
                }
            }
        }, 5000);
		
		// 예매 확인 - 회원/ 비회원 상자 toggle
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
		
		// 로그인 중일 경우 회원으로 뜨게 하기
		if("${userId}" != ""){
			$('#member').click();
		}
	});
</script>