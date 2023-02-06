<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<div class="container">
	<%-- 최신 공연 정보 --%>
	<div class="pt-4 pb-4">
		<h1 class="bold">회원 정보</h1>
		<div>
			<%-- 프로필 이미지 --%>
			<div class="m-5 col-3">
				<img src="${userProfileImageUrl}" width="150px">
				<div class="text-center mt-2">프로필 이미지</div>
				<input type="file" class="btn btn-secondary">
			</div>
			
		</div>
	</div>
</div>