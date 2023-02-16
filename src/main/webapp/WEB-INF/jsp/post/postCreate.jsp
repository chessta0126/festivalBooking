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
				<input type="text" id="postTitle" class="col-9 form-control" placeholder="제목을 입력하세요">
			</div>
			
			<%-- 작성자 --%>
			<div class="d-flex align-items-center">
				<h5 class="bold mr-3">작성자</h5>
				<h5 class="bold mr-3">${user.name}</h5>
			</div>
		</div>
		
		<%-- 글 내용 --%>
		<div class="pt-4">
			<textarea rows="10" cols="100" id="content" class="form-control" placeholder="내용을 입력하세요"></textarea>
		</div>

		<%-- 작성 완료(글쓰기 insert) 버튼 --%>
		<div class="pt-4 d-flex justify-content-center">
			<button type="button" id="postInsertBtn" class="btn btn-dark">작성 완료</button>
		</div>
		<%-- 수정 완료(update) 버튼 : isUpdate = true에만 드러남 --%>
		<div class="d-flex justify-content-center">
			<button type="button" id="postUpdateBtn" class="btn btn-dark d-none">수정 완료</button>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		// 페이지에 접근했을 때, 글쓰기(insert)/ 글 수정(update) 여부 파악
		if(${isUpdate}){
			$('#postInsertBtn').addClass("d-none");
			$('#postUpdateBtn').removeClass("d-none");
			
			$('#postTitle').attr('placeholder',"${post.postTitle}");
			$('#content').attr('placeholder',"${post.content}");
		}
		
		// 글 쓰기
		$('#postInsertBtn').on('click', function(e) {
			let userId = ${user.id};
			let postType = "${postType}";
			let postTitle = $('#postTitle').val().trim();
			let content = $('#content').val().trim();
			/* alert("userId : " + userId + "\n"
					+ "postType : " + postType + "\n" 
					+ "postTitle : " + postTitle + "\n" 
					+ "content : " + content); */
			
			// validation check
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
						
						// 글 목록 페이지로 이동
						// location.href="/post/postList?postType="+data.postType;
						
						// 방금 내가 작성한 글 상세 페이지(postDetail)로 이동 -> postId 필요
						location.href="/post/post_detail_view?postType="+data.postType+"&postId="+data.postId;
					}
				}
				,error: function(e) {
					// 실패
					alert("[error] 웹 통신문제 : 게시글을 업로드 할 수 없습니다. \n 담당자에게 문의해주세요");
				}
			});
		});
		
		// 글 수정하기
		$('#postUpdateBtn').on('click', function(e) {
			// 어떤 글(postId) / 제목(postTitle) / 내용(content) 수정
			let postId = ${postId};
			let postUpdatedTitle = $('#postTitle').val().trim();
			let updatedContent = $('#content').val().trim();
			
			// validation check
			if(postUpdatedTitle == ''){
				postUpdatedTitle = $('#postTitle').attr("placeholder");
				// alert(postUpdatedTitle);
			}
			if(updatedContent == ''){
				updatedContent = $('#content').attr("placeholder");
				// alert(updatedContent);
			}
			
			// AJAX
			$.ajax({
				type:'PUT'
				,url:'/post/update'
				,data: {"postId":postId, "postUpdatedTitle":postUpdatedTitle, "updatedContent":updatedContent}
				,success: function(data) {
					if (data.result) {
						// 방금 내가 수정한 글 상세 페이지(postDetail)로 이동 -> postId 필요
						alert("글 수정이 완료되었습니다.");
						location.href="/post/post_detail_view?postType="+data.postType+"&postId="+data.postId;
					}
				}
				,error: function(jqXHR, textStatus, errorThrown) {
					var errorMsg = jqXHR.responseJSON.status;
					alert(errorMsg + ":" + textStatus);
				}
			});
		});
	});
</script>