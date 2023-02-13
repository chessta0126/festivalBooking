<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div class="d-flex justify-content-center">
	<div>
		<!-- 공연 기한 설정 -->
		<div class="pt-4 d-flex align-items-center">
			<h2 class="col-3 font-weight-bold">공연 정보</h2>
			<span class="font-weight-bold">공연 기한 </span>
			<div class="col-3">
				<input type="text" id="startDate" value="시작기한(선택)"
					class="form-control">
			</div>
			~
			<div class="col-3">
				<input type="text" id="endDate" value="끝 기한(선택)" class="form-control">
			</div>
			<button type="button" id="dateLimit" class="btn btn-dark">검색</button>
		</div>
	
		<div class="pt-1">
			<article class="festival1 mt-3 pr-4 d-flex bg-dark">
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
	
			<article class="festival2 mt-3 pr-4 d-flex bg-dark">
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
	
			<article class="festival3 mt-3 pr-4 d-flex bg-dark">
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
	
			<article class="festival4 mt-3 pr-4 d-flex bg-dark">
				<!-- 공연 포스터 이미지-->
				<div class="m-3">
					<a href="#">
						<img src="#" alt="공연 팜플렛4" width="250" height="250">
					</a>
				</div>
				<!-- 공연 정보 -->
				<div class="pl-3">
					<div class="pt-4 font-weight-bold">
						<h4 class="festival-title">FRESH HOUSE 클럽공연</h4>
					</div>
					<div class="pt-2 white-text"></div>
					<div class="white-text">힙합으로 즐기는 화려한 밤!! 공연 이후 11시부터 애프터
						파티까지..!!</div>
					<div class="text-danger">* 미성년자는 입장하실 수 없습니다.</div>
					<div class="pt-3 yellow-text">일시 : 2022년 11월 18일(금) - 10PM ~
						6AM</div>
					<div class="pt-2 text-info">장소 : coc (서울 강남구 도산대로 53길 39 B1층)</div>
					<div class="pt-2">
						<span class="pr-4 text-success">예매: ???원 / 현장: ???원</span> <span
							class="text-success">(잔여 예약석: 37명)</span>
					</div>
					<div class="pt-2 text-secondary">
						<span class="pr-4">기획자 : 송승휘 </span> <span>문의사항:
							@jaskionthelit_99kr</span>
					</div>
				</div>
			</article>
	
			<article class="festival5 mt-3 pr-4 d-flex bg-dark">
				<!-- 공연 포스터 이미지-->
				<div class="m-3">
					<a href="#">
						<img src="#" alt="공연 팜플렛5" width="250" height="250">
					</a>
				</div>
				<!-- 공연 정보 -->
				<div class="pl-3">
					<div class="pt-4 font-weight-bold">
						<h4 class="festival-title text-success">홍대 윗잔다리 싸이퍼 2회</h4>
					</div>
					<div class="pt-2 white-text"></div>
					<div class="white-text">홍대 길거리 문화를 살리기 위해 기획한 싸이퍼</div>
					<div class="white-text">누구나 자유롭게 참여할 수 있다.</div>
					<div class="pt-3 yellow-text">일시 : 2023년 1월 14일(토)</div>
					<div class="pt-2 text-info">장소 : 홍대 윗잔다리 공원 (서울 마포구 와우산로 17길
						14 지층)</div>
					<div class="pt-2">
						<span class="pr-2 text-success">가격: 무료</span> <span
							class="text-success">(* 제한 인원이 없으므로, 안전에 주의해주시기 바랍니다.)</span>
					</div>
					<div class="pt-2 text-secondary">
						<span class="pr-4">기획자 : chessta </span> <span>문의사항:
							@chessta0126</span>
					</div>
				</div>
			</article>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		// datepicker 형식
		$.datepicker.setDefaults({
			// 요일 표시 : 한글
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ]

			// 연도-월-일 형식
			,
			dateFormat : "yy년 mm월 dd일"
		});

		$('#startDate').datepicker({
			minDate : 0
			// 시작일(mindate) 이전은 선택 불가
			,
			onSelect : function(dateText) {
				// alert(dateText);
				$('#endDate').datepicker('option', 'minDate', dateText);
			}
		});

		$('#endDate').datepicker({
			// 한 달 후 공연까지만 예약 받을 수 있다.
			maxDate : 31
		});

		// 원하는 기한 내 공연 필터링(미완)
		$("#dateLimit").on("click", function() {
			// alert($('#startDate').val());
			let startDate = $('#startDate').val();
			let endDate = $('#endDate').val();

		});
	});
</script>