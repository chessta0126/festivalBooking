<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container pt-3 d-flex justify-content-center">
	<div class="pt-3">
		<div class="d-flex justify-content-between">
			<div>
				<%-- 예매 마감 됐을 경우에만 --%>
				<c:choose>
					<c:when test="${isTimeOver}">
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
				
				<%-- 예매 완료 됐을 경우에만 보이기 : 클릭 시 예매 취소하기 modal --%>
				<c:if test="${isBooked}">
					<button type="button" id="bookingOK" class="mb-3 btn btn-warning bold button"
					data-toggle="modal" data-target="#modalBookingCancel" data-festival-id="${festival.id}">
						예매 완료
					</button>
				</c:if>
			</div>

			<div>
				<%-- 수정 / 삭제 modal - 내가 등록한 공연일 때만 보이기 --%>
				<c:if test="${festival.userId eq userId}">
					<div class="dropdown">
						<button class="btn btn-secondary dropdown-toggle" type="button"
							id="dropdownMenuButton" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false">공연 정보 변경</button>
						<div class="dropdown-menu text-center" aria-labelledby="dropdownMenuButton">
							<a class="dropdown-item" href="/festival/festival_create_view?isUpdate=true&festivalId=${festival.id}">공연 정보 수정</a>
							<a class="dropdown-item" href="#">공연 삭제</a>
							<a class="dropdown-item" href="#">예매 마감</a>
						</div>
					</div>
				</c:if>
			</div>
		</div>

		<%-- 공연 예매 정보 --%>
		<div class="d-flex">
			<%-- 공연 포스터 --%>
			<div class="pr-5">
				<c:choose>
					<c:when test="${isBooked}">
						<div class="d-flex align-items-center">
							<span class="text-info bold">${bookView.book.headCount}매 예매 중</span>
							<%-- 여백을 맞추기 위한 공백 --%>
							<h3 id="afterBookHeadCountAlert" class="bold">&nbsp;</h3>
						</div>
					</c:when>
					<c:otherwise>
						<%-- 여백을 맞추기 위한 공백 --%>
						<h3 class="bold">&nbsp;</h3>
					</c:otherwise>
				</c:choose>
				<img width="300" height="320" src="${festival.imagePath}" id="posterImg">
			</div>
			
			<%-- 공연 정보 --%>
			<div>
				<h3 class="bold">${festival.title}</h3>
				<table class="table table-bordered">
					<tr>
						<th>공연 날짜</th>
						<td>${festival.date}</td>
					</tr>
					<tr>
						<th>공연 시간</th>
						<td class="d-flex align-items-center">
							${festival.startTime}
							<span class="bold ml-4 mr-4">~</span>
							${festival.endTime}
						</td>
					</tr>
					<tr>
						<th>공연 장소</th>
						<td>
							${festival.place}
							<c:if test="${ObjectUtils.isEmpty(festival.address)}">
							<div>
								${festival.address}
							</div>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>예매 가격</th>
						<td class="d-flex align-items-center">
							${festival.price} 원
						</td>
					</tr>
					<tr>
						<th>현장 가격</th>
						<td class="d-flex align-items-center">
							${festival.priceOffline} 원
						</td>
					</tr>
				</table>
				
				<%-- 실제 예매 : 최대 5매까지만 예매할 수 있게 한다. --%>
				<div class="d-flex justify-content-between">
					<div class="d-flex align-items-center">
						<select id="headCount" class="form-control">
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
						</select>
						<span class="ml-2 bold">매</span>
					</div>
					<div class="d-flex align-items-center book-font-size">
						<span class="ml-2 ">총 
							<span id="payMoney" class="bold">${festival.price}</span>
						원</span>
					</div>
				</div>
				
				<div class="pt-3 d-flex justify-content-end">
					<c:choose>
						<%-- 로그인 중 나타나는 회원 예매 버튼 --%>
						<c:when test="${userId ne null}">
							<button type="button" id="memberBookingBtn" class="btn btn-primary"
							data-festival-id="${festival.id}">예매하기</button>
						</c:when>
					
						<%-- 비로그인 시 나타나는 비회원 예매 버튼 --%>
						<c:otherwise>
							<button type="button" id="notMemberBookingBtn" class="btn btn-primary"
							data-toggle="modal" data-target="#modal" data-festival-id="${festival.id}">예매하기</button>
						</c:otherwise>
					</c:choose>

					<%-- 예매 완료 시 나타나는 예매 취소 버튼 --%>
					<c:if test="${isBooked}">
						<button type="button" id="bookCancelBtn" class="ml-3 btn btn-danger">예매 취소</button>
					</c:if>
				</div>
			</div>
		</div>
		
		<%-- 상세 설명 --%>
		<div>
			<%-- 공연 라인업 --%>
			<c:if test="${!empty festival.lineUp}">
				<h2 class="bold pt-5 pb-2">공연 라인업</h2>
				<div class="festival-info-box border border-info">
					<div class="m-2">${festival.lineUp}</div>
				</div>
			</c:if>
			
			<%-- 공연 설명 --%>
			<c:if test="${!empty festival.explain}">
				<h2 class="bold pt-5 pb-2">공연 설명</h2>
				<div class="festival-info-box border border-success">
					<div class="m-2">${festival.explain}</div>
				</div>
			</c:if>
			
			<%-- 주의사항 --%>
			<c:if test="${!empty festival.warning}">
				<h2 class="bold pt-5 pb-2">주의사항</h2>
				<div class="festival-info-box border border-danger">
					<div class="m-2">${festival.warning}</div>
				</div>
			</c:if>
			
			<%-- 오시는 길 --%>
			<jsp:include page="../include/map.jsp" />		
			
			<%-- 공연 담당자 --%>
			<h2 class="bold pt-5 pb-2">공연 담당자</h2>
			<table class="table">
				<tr>
					<th>담당자 이름</th>
					<td>${festival.festivalMaster}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${festival.askRoot}</td>
				</tr>
			</table>
		</div>
		
		<c:choose>
			<%-- 내 공연 목록 버튼 : session이랑 작성자랑 일치할 때만 뜨기 --%>
			<c:when test="${userId eq festival.userId}">
				<div class="pt-5 d-flex justify-content-center">
					<button type="button" id="festivalListBtn" class="btn btn-dark">
						<a href="/festival/festival_myList_view" class="button">공연 목록</a>
					</button>
				</div>
			</c:when>
			<c:otherwise>
				<div class="pt-5 d-flex justify-content-center">
					<button type="button" id="festivalListBtn" class="btn btn-dark">
						<a href="/festival/festival_list_view" class="button">다른 공연</a>
					</button>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<footer class="pt-5">
	<jsp:include page="../include/footer.jsp" />
</footer>


<!-- 예매하기 Modal -->
<div class="modal fade" id="modal">
<%-- modal-sm : 작은 모달 창 --%>
<%-- modal-dialog-centered : 모달 창을 수직으로 가운데 정렬 --%>
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content text-center">
      		<div class="py-3 border-bottom">
      			<a href="/user/sign_in_view" id="loginForBooking">로그인</a>
      		</div>
      		<div class="py-3 border-bottom">
      			<a href="#" id="notMemberBooking">비회원으로 예매</a>
      		</div>
      		<div class="py-3">
      			<%-- data-dismiss="modal" : modal창 닫힘 --%>
      			<a href="#" data-dismiss="modal">취소하기</a>
      		</div>
		</div>
	</div>
</div>	

<!-- 예매 완료 버튼 Modal -->
<div class="modal fade" id="modalBookingCancel">
<%-- modal-sm : 작은 모달 창 --%>
<%-- modal-dialog-centered : 모달 창을 수직으로 가운데 정렬 --%>
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content text-center">
      		<div class="py-3 border-bottom">
      			<a href="/book/myBooking_view" id="myBookList">예매 목록 확인</a>
      		</div>
      		<div class="py-3">
      			<%-- data-dismiss="modal" : modal창 닫힘 --%>
      			<a href="#" data-dismiss="modal">창 닫기</a>
      		</div>
		</div>
	</div>
</div>	


<script>
	$(document).ready(function() {
		if(${isBooked}){
			let memberBookingBtn = document.getElementById("memberBookingBtn");
			memberBookingBtn.innerText = "추가 예매";
		}
		
		// 가격 동적 변경 (티켓 매수에 따라)
		$('#headCount').on('change', function(e) {
			let headCount = $('#headCount').val();
			// alert(headCount);
			let payMoney = headCount * ${festival.price}
			// alert(payMoney);
			$('#payMoney').text(payMoney);
		});
		
		// 로그인 예매 : 로그인 상태일 경우 바로 AJAX로 예매 정보 넘기기
		$('#memberBookingBtn').on('click', function(e) {
			e.preventDefault();
			// 추가 예매 상태 : 이미 예매한 경우 다중 insert 방지
			// book 정보 수정(update) 창 뜨기
			if(${isBooked}){
				let alreadyHeadCount = "${bookView.book.headCount}";
				let addHeadCount = $('#headCount option:selected').val();
				let totalHeadCount = parseInt(alreadyHeadCount) + parseInt(addHeadCount);
				
				Swal.fire({
		            title: '이미 예매한 공연입니다. <br> 추가 예매 하시겠습니까?',
		            text: alreadyHeadCount + "매 -> " + totalHeadCount + "매",
		            icon: 'warning',
		            showCancelButton: true,
		            confirmButtonColor: '#3085d6',
		            cancelButtonColor: '#d33',
		            confirmButtonText: '추가 예매',
		            cancelButtonText: '취소'
		        }).then((result) => { 
		            if (result.isConfirmed) { // 추가 예매(Update) 확정
		            	let festivalId = ${festival.id};
		            	let userId = "${userId}" // 비로그인 시 세션 없을 수도 있으므로 "" 사용

		            	let alreadyPayMoney = "${bookView.book.payMoney}";
						let addPayMoney = $('#payMoney').text();
						let totalPayMoney = parseInt(alreadyPayMoney) + parseInt(addPayMoney);
		            	
		            	// AJAX
		    			$.ajax({
		    				type:'PUT'
		    				,url:'/book/updateBooking'
		    				,data: {"headCount":totalHeadCount, "festivalId":festivalId, "userId":userId, "payMoney":totalPayMoney}
		    				,success: function(data) {
		    					if (data.result) {
		    						Swal.fire({
						                title : '추가 예매가 완료되었습니다.',
						                text : '예매완료 버튼 / 마이페이지 > 예매 확인 탭 등에서 예약을 수정하실 수 있습니다.',
						                icon: 'success'
									}).then((result) => { 
							            if (result.isConfirmed) {
											location.reload();
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
				
				return;
			}
			
			// 예매하기(insert)
			let festivalId = ${festival.id};
			let userId = "${userId}";
			let headCount = $('#headCount option:selected').val();
			let payMoney = $('#payMoney').text();
			let isMember = true;
			if(isMember){
				isMember = 1;
			} else{
				isMember = 0;
			}

			Swal.fire({
	            title: '예매 하시겠습니까?',
	            text: "수량 : " + headCount + "매 , 가격 : " + payMoney + "원",
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonColor: '#3085d6',
	            cancelButtonColor: '#d33',
	            confirmButtonText: '예',
	            cancelButtonText: '아니오'
	        }).then((result) => { 
	            if (result.isConfirmed) { // 예매 확정(insert)
					// AJAX 전송
					$.ajax({
						type:'POST'
						,url:'/book/addBooking'
						, data: {"festivalId":festivalId, "userId":userId, "payMoney":payMoney, "headCount":headCount, "isMember":isMember}
						, success: function(data) {
							if (data.code == 1) {
								// 성공
								Swal.fire({
					                title : '예매가 완료되었습니다.',
					                text : '예매완료 버튼 / 마이페이지 > 예매 확인 탭 등에서 예약을 수정하실 수 있습니다.',
					                icon: 'success'
								}).then((result) => { 
						            if (result.isConfirmed) {
										location.reload();
						            }
								});
							} else{
								// 실패
								alert("[error] 공연 예매에 실패했습니다. \n 담당자에게 문의해주세요");
							}
						}
						, error : function(jqXHR, textStatus, errorThrown) {
							var errorMsg = jqXHR.responseJSON.status;
							alert(errorMsg + ":" + textStatus);
						}
					});
	            }
			});
		});
		
		// 비로그인 상태 : 예매하기 버튼 클릭 -> modal 작동
		$('#notMemberBookingBtn').on('click', function(e) {
			e.preventDefault();
			// getting
			let festivalId = $(this).data("festival-id");
			
			// setting : modal 태그에 data-festival-id 심어줌
			$('#modal').data("festival-id", festivalId);
			
		});
		
		// 비로그인 modal -> 비회원 예매 클릭
		$('#modal #notMemberBooking').on('click',function(e){
			e.preventDefault();
			
			(async () => {
			    const { value: bookName } = await Swal.fire({
			        title: '예매자의 이름을 입력하세요.',
			        input: 'text',
			        inputPlaceholder: '이름을 입력하세요..'
			    })

			    // 이후 처리되는 내용.
			    if (bookName) {
			        const { value: phoneNumber } = await Swal.fire({
				        title: '연락처를 입력하세요.',
				        input: 'text',
				        inputPlaceholder: '연락처를 입력하세요..'
				    })
			    
				    if (phoneNumber) { // 전화번호까지 입력 완료되었을 때 변수 설정, 예매 final 확인
				    	let festivalId = ${festival.id};
						let headCount = $('#headCount option:selected').val();
						let payMoney = $('#payMoney').text();
						let isMember = false;
						if(isMember){
							isMember = 1;
						} else{
							isMember = 0;
						}
						
				    	Swal.fire({
				            title: '예매 하시겠습니까?',
				            text: "수량 : " + headCount + "매 , 가격 : " + payMoney + "원",
				            icon: 'warning',
				            showCancelButton: true,
				            confirmButtonColor: '#3085d6',
				            cancelButtonColor: '#d33',
				            confirmButtonText: '예',
				            cancelButtonText: '아니오'
				        }).then((result) => { 
				            if (result.isConfirmed) { // 예매 확정(insert)
								// AJAX 전송
								$.ajax({
									type:'POST'
									,url:'/book/addBooking'
									, data: {"festivalId":festivalId, "payMoney":payMoney, "headCount":headCount, "isMember":isMember, "bookName":bookName,"phoneNumber":phoneNumber}
									, success: function(data) {
										if (data.code == 1) {
											// 성공
											Swal.fire({
								                title : '예매가 완료되었습니다.',
								                text : '예매완료 버튼 / 마이페이지 > 예매 확인 탭 등에서 예약을 수정하실 수 있습니다.',
								                icon: 'success'
											}).then((result) => { 
									            if (result.isConfirmed) {
													location.reload();
									            }
											});
										} else{
											// 실패
											alert("[error] 예매에 실패했습니다. \n 담당자에게 문의해주세요");
										}
									}
									, error : function(jqXHR, textStatus, errorThrown) {
										var errorMsg = jqXHR.responseJSON.status;
										alert(errorMsg + ":" + textStatus);
									}
								});
				            }
						});
				    }
			    }
			})()
		});
		
		// 예매 취소(delete)
		$('#bookCancelBtn').on('click',function(e){
			e.preventDefault();
			
			Swal.fire({
	            title: '예매를 취소 하시겠습니까?',
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonColor: '#3085d6',
	            cancelButtonColor: '#d33',
	            confirmButtonText: '예',
	            cancelButtonText: '아니오'
	        }).then((result) => { 
	            if (result.isConfirmed) { // 예매 취소(delete) 확정
	            	let festivalId = ${festival.id};
	            	let userId = "${userId}" // 비로그인 시 세션 없을 수도 있으므로 "" 사용

	            	// AJAX
	    			$.ajax({
	    				type:'DELETE'
	    				,url:'/book/deleteBooking'
	    				,data: {"festivalId":festivalId, "userId":userId}
	    				,success: function(data) {
	    					if (data.result) {
	    						Swal.fire({
					                title : '예매 취소가 완료되었습니다.',
					                icon: 'success'
								}).then((result) => { 
						            if (result.isConfirmed) {
										location.reload();
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