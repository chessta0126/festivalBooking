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
			<table class="table table-bordered">
				<tr>
					<th>공연 제목</th>
					<td>${festival.title}</td>
				</tr>
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
						<c:if test="">
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
		
		<%-- 내 공연 목록 버튼 --%>
		<div class="pt-5 d-flex justify-content-center">
			<button type="button" id="festivalListBtn" class="btn btn-dark">
				<a href="/festival/festival_myList_view" class="button">공연 목록</a>
			</button>
		</div>
	</div>
</div>

<footer class="pt-5">
	<jsp:include page="../include/footer.jsp" />
</footer>