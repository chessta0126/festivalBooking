<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="pt-4 d-flex justify-content-center">
	<div class="container">
		<%-- 글 종류 --%>
		<div class="d-flex justify-content-between align-items-center">
			<h1 class="bold">${postType}</h1>
		</div>

		<div class="pt-3 d-flex justify-content-between">
			<%-- 제목 --%>
			<div class="w-75 d-flex align-items-center">
				<h5 class="bold mr-3">제목</h5>
				<input type="text" id="postTitle" class="col-8 form-control">
			</div>
			
			<%-- 작성자 --%>
			<div class="d-flex align-items-center">
				<h5 class="bold col-7">작성자</h5>
				<h5 class="bold mr-3">${user.name}</h5>
			</div>
		</div>
		
		<%-- 글 내용 --%>
		<div class="pt-4">
			<textarea rows="10" cols="100" id="content" class="form-control"></textarea>
		</div>

		<%-- 작성 완료(글쓰기 insert) 버튼 --%>
		<div class="pt-4 d-flex justify-content-center">
			<button type="button" id="postInsertBtn" class="btn btn-dark">작성 완료</button>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		$('#postInsertBtn').on('click', function(e) {
			// validation check
			let userId = ${user.id};
			let postType = "${postType}";
			let postTitle = $('#postTitle').val().trim();
			let content = $('#content').val().trim();
			/* alert("userId : " + userId + "\n"
					+ "postType : " + postType + "\n" 
					+ "postTitle : " + postTitle + "\n" 
					+ "content : " + content); */
			
			if(postTitle == ''){
				alert("제목을 입력해주세요");
				 return;
			}
			if(content == ''){
				alert("내용을 입력해주세요");
				 return;
			}
				
			// AJAX 통신
			$.ajax({
				type:'POST'
				,url:'/post/create'
				, data:{"userId":userId, "postType":postType, "postTitle":postTitle,"content":content}
				, success: function(data) {
					if (data.code == 1) {
						// 성공
						alert("게시글이 성공적으로 업로드 되었습니다.");
						
						// 방금 내가 작성한 글 상세 페이지(postDetail)로 이동해야 함 -> postId 필요
						location.href="/post/postList?postType=data.postType";
					} else{
						// 실패
						alert("[error] 웹 통신문제 : 게시글을 업로드 할 수 없습니다. \n 담당자에게 문의해주세요");
					}
				}
			});
		});
	});
</script>