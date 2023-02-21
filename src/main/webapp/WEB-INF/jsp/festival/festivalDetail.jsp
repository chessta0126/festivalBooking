<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="pt-5 d-flex justify-content-center">
	<div>
		<h2 class="bold pb-5">공연 등록하기</h2>

		<%-- 공연 예매 정보 --%>
		<div class="d-flex">
			<%-- 공연 포스터 --%>
			<div class="pr-5">
				<img width="200" src="${festival.imagePath}" id="posterImg">
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
							<button type="button" id="placeMapBtn" class="btn btn-dark">지도</button>
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
				
				<%-- 로그인 중 나타나는 회원 예매 버튼 --%>
				
				
				<%-- 비로그인 시 나타나는 비회원 예매 버튼 --%>
				<c:if test="${userId eq null}">
					<div class="pt-3 d-flex justify-content-end">
						<button type="button" id="notMemberBooking" class="btn btn-primary"
						data-toggle="modal" data-target="#modal" data-festival-id="${festival.id}">예매하기</button>
					</div>
				</c:if>
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
		
		<%-- 내 공연 목록 버튼 : session이랑 작성자랑 일치할 때만 뜨기 --%>
		<c:if test="${userId eq festival.userId}">
			<div class="pt-5 d-flex justify-content-center">
				<button type="button" id="festivalListBtn" class="btn btn-dark">
					<a href="/festival/festival_myList_view" class="button">공연 목록</a>
				</button>
			</div>
		</c:if>
	</div>
</div>

<footer class="pt-5">
	<jsp:include page="../include/footer.jsp" />
</footer>


<!-- Modal -->
<div class="modal fade" id="modal">
<%-- modal-sm : 작은 모달 창 --%>
<%-- modal-dialog-centered : 모달 창을 수직으로 가운데 정렬 --%>
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content text-center">
      		<div class="py-3 border-bottom">
      			<a href="#" id="loginForBooking">로그인</a>
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


<script>
	$(document).ready(function() {
		// 가격 동적 변경 (티켓 매수에 따라)
		$('#headCount').on('change', function(e) {
			let headCount = $('#headCount').val();
			// alert(headCount);
			let payMoney = headCount * ${festival.price}
			// alert(payMoney);
			$('#payMoney').text(payMoney);
		});
		
		// 지도 버튼 클릭
		$('#placeMapBtn').on('click', function(e) {
			
		});

		// 로그인 상태일 경우 바로 AJAX로 예매 정보 넘기기
		
		
		// 비로그인 상태 : 예매하기 버튼 클릭 -> modal 작동
		$('#notMemberBookingBtn').on('click', function(e) {
			e.preventDefault();
			// getting
			let festivalId = $(this).data("festival-id");
			
			// setting : modal 태그에 data-festival-id 심어줌
			$('#modal').data("festival-id", festivalId);
			
		});
		
		// modal -> 로그인 클릭
		$('#modal #loginForBooking').on('click',function(e){
			e.preventDefault();
		});

		// modal -> 비회원 예매 클릭
		$('#modal #notMemberBooking').on('click',function(e){
			e.preventDefault();
		});
	});
</script>