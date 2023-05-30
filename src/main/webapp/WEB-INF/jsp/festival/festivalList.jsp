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
					class="form-control" readonly/>
			</div>
			~
			<div class="col-3">
				<input type="text" id="endDate" value="끝 기한(선택)" class="form-control" readonly/>
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