<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container d-flex justify-content-center">
	<div>
		<!-- 공연 기한 설정 -->
		<div class="pt-4 d-flex align-items-center">
			<h2 class="col-3 font-weight-bold">공연 정보</h2>
			<span class="font-weight-bold">공연 기간 </span>
			<div class="col-3">
				<input type="text" id="startDate" value="시작기한(선택)"
					class="form-control">
			</div>
			~
			<div class="col-3">
				<input type="text" id="endDate" value="끝 기한(선택)" class="form-control">
			</div>
			<button type="button" id="dateLimitBtn" class="btn btn-dark">검색</button>
		</div>
	
		<div class="pt-1">
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
	
			<article class="festival2 mt-3 pr-4 pb-3 d-flex bg-dark">
				<!-- 공연 포스터 이미지-->
				<div class="m-3">
					<a href="#">
						<img src="#" alt="공연 팜플렛2" width="250" height="250">
					</a>
				</div>
				<!-- 공연 정보 -->
				<div class="pl-3">
					<div class="pt-4 font-weight-bold">
						<h4 class="festival-title text-info">카르트 크루 정기공연</h4>
					</div>
					<div class="pt-2 white-text"></div>
					<div class="white-text">쌈디의 극찬을 받은 래퍼 '정진'과 irzest, VALHASH 등
					</div>
					<div class="white-text">카르트 크루 멤버들과 초특급 게스트들이 불태우는 무대</div>
					<div class="pt-3 yellow-text">일시 : 2023년 2월 4일(토)</div>
					<div class="pt-2 text-info">장소 : 홍대 블루프린트 (서울 마포구 와우산로 17길 14
						지층)</div>
					<div class="pt-2">
						<span class="pr-4 text-success">예매: 10,000원 / 현장: 15,000원</span> <span
							class="text-danger">(잔여 예약석: 17명)</span>
					</div>
					<div class="pt-2 text-secondary">
						<span class="pr-4">기획자 : chessta </span> <span>문의사항:
							@chessta0126</span>
					</div>
				</div>
			</article>
	
			<article class="festival3 mt-3 pr-4 pb-3 d-flex bg-dark">
				<!-- 공연 포스터 이미지-->
				<div class="m-3">
					<a href="#">
						<img src="#" alt="공연 팜플렛3" width="250" height="250">
					</a>
				</div>
				<!-- 공연 정보 -->
				<div class="pl-3">
					<div class="pt-4 font-weight-bold">
						<h4 class="festival-title text-danger">크리스가디 단독 쇼케이스</h4>
					</div>
					<div class="pt-2 white-text"></div>
					<div class="white-text">STEAMPUNK, EP앨범 '가디 더 디몬' 발매 기념!!</div>
					<div class="white-text">수많은 래퍼에게 샤라웃을 받고 있는 크리스가디의 단독공연</div>
					<div class="pt-3 yellow-text">일시 : 2023년 1월 14일(토)</div>
					<div class="pt-2 text-info">장소 : 홍대 블루프린트 (서울 마포구 와우산로 17길 14
						지층)</div>
					<div class="pt-2">
						<span class="pr-4 text-success">예매: 15,000원 / 현장: 15,000원</span> <span
							class="text-success">(잔여 예약석: 22명)</span>
					</div>
					<div class="pt-2 text-secondary">
						<span class="pr-4">기획자 : CHRIS GUARDY </span> <span>문의사항:
							010-1234-5678</span>
					</div>
				</div>
			</article>
		</div>
	</div>
</div>

<footer class="pt-5">
	<jsp:include page="../include/footer.jsp" />
</footer>

<script>
	$(document).ready(function() {
		// datepicker 형식
		$.datepicker.setDefaults({
			// 요일 표시 : 한글
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ]

			// 연도-월-일 형식
			, dateFormat : "yy년 mm월 dd일"
		});

		$('#startDate').datepicker({
			minDate : 0
			// 시작일(mindate) 이전은 선택 불가
			, onSelect : function(dateText) {
				// alert(dateText);
				$('#endDate').datepicker('option', 'minDate', dateText);
			}
		});

		$('#endDate').datepicker({
			// 한 달 후 공연까지만 예약 받을 수 있다.
			maxDate : 31
		});

		// 원하는 기한 내 공연 필터링
		$("#dateLimitBtn").on("click", function() {
			// alert($('#startDate').val());
			let startDate = $('#startDate').val();
			let endDate = $('#endDate').val();

			// startDate < 공연 < endDate
			// 데이터 보낸 다음 DB에서 where로 꺼내서 Controller에서 화면 다시 이동
			location.href="/festival/festival_list_view_limit?startDate="+startDate+"&endDate="+endDate;
		});
	});
</script>