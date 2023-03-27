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
						<th>공연 관리</th>
						<th>마감 여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${festivalList}" var="festival">
					<tr>
						<td>${festival.id}</td>
						<td><a href="/festival/festival_detail_view?festivalId=${festival.id}">${festival.title}</a></td>
						<td><fmt:formatDate value="${festival.createdAt}" pattern="yyyy-MM-dd"/></td>
						<td>
							<%-- 공연 관리 버튼 --%>
							<div class="dropdown">
								<button class="btn btn-secondary dropdown-toggle" type="button"
									data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">공연 관리</button>
								<div class="dropdown-menu text-center" aria-labelledby="dropdownMenuButton">
									<a class="dropdown-item" href="/book/myFestivalBookingConfirm_view?festivalId=${festival.id}">예매 현황</a>
									<a class="dropdown-item" href="/festival/festival_create_view?isUpdate=true&festivalId=${festival.id}">공연 정보 수정</a>
									<a class="dropdown-item deleteFestivalBtn" href="#" data-festival-id="${festival.id}">공연 삭제</a>
									<a class="dropdown-item" href="/festival/update_expire?festivalId=${festival.id}&isTimeOver=false" id="updateExpireBtn">예매 마감</a>
								</div>
							</div>
						</td>
						<td>
							<c:choose>
								<c:when test="${festival.isTimeOver() == true}">
									<button type="button" id="expired" class="mb-3 btn btn-danger bold">
										예매 마감
									</button>
								</c:when>
								<c:otherwise>
									<button type="button" id="expired" class="mb-3 btn btn-success bold">
										예매중
									</button>
								</c:otherwise>
							</c:choose>
						</td>
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

<script>
	$(document).ready(function() {
		// 공연 관리(내 공연) -> 공연 삭제 (delete)
		$('.deleteFestivalBtn').on('click',function(e){
			e.preventDefault();
			
			Swal.fire({
	            title: '이 공연을 삭제 하시겠습니까?',
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonColor: '#3085d6',
	            cancelButtonColor: '#d33',
	            confirmButtonText: '예',
	            cancelButtonText: '아니오'
	        }).then((result) => { 
	            if (result.isConfirmed) { // 공연 삭제(delete) 확정
	            	let festivalId = $(this).data("festival-id");
	            	let festivalUserId = "${userId}" // 비로그인 시 세션 없을 수도 있으므로 "" 사용

	            	// AJAX
	    			$.ajax({
	    				type:'DELETE'
	    				,url:'/festival/delete'
	    				,data: {"festivalId":festivalId, "festivalUserId":festivalUserId}
	    				,success: function(data) {
	    					if (data.result) {
	    						Swal.fire({
					                title : '공연이 정상적으로 삭제되었습니다.',
					                icon: 'success'
								}).then((result) => { 
						            if (result.isConfirmed) {
						            	location.href="/festival/festival_myList_view";
						            }
								});
	    					}
	    				}
	    				,error: function(jqXHR, textStatus, errorThrown) {
	    					var errorMsg = jqXHR.responseJSON.status;
	    					alert(errorMsg + ":" + textStatus);
	    				}
	    			});
	            }
			});
		});
	});
</script>