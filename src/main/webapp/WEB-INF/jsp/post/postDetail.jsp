<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="pt-4 d-flex justify-content-center">
	<div class="container">
		<%-- 글 종류 --%>
		<div class="d-flex justify-content-between align-items-center">
			<h1 class="bold">${post.postType}</h1>
		</div>

		<%-- 제목 --%>
		<div class="w-75 d-flex align-items-center">
			<h5 class="bold mr-3">제목</h5>				<div></div>
		</div>
			
		<div class="pt-3 d-flex justify-content-between">
			<%-- 작성자 --%>
			<div class="d-flex align-items-center">
				<h5 class="bold col-6">작성자</h5>
				<h5 class="bold mr-3">${user.name}</h5>
			</div>
		</div>
		
		<%-- 글 내용 --%>
		<div class="pt-4">
			<textarea rows="10" cols="100" id="content" class="form-control"></textarea>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		$('#postChangeBtn').on('click', function(e) {
			
		});
	});
</script>