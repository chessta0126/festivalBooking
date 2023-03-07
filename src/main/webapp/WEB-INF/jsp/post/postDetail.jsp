<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 글 --%>
<div class="pt-4 container">
	<%-- 글 종류 --%>
	<div class="d-flex justify-content-between align-items-center">
		<h1 class="bold">${post.postType}</h1>
	</div>
	<div class="pt-3 d-flex justify-content-between align-items-center">
		<%-- 제목 --%>
		<div class="w-75">
			<span id="postTitle" class="bold mr-3 title-font-size">제목</span>
			<span class="value-font-size">${post.postTitle}</span>
		</div>
		
		<%-- 수정 / 삭제 버튼 : 작성자와 session 닉네임이 일치할 경우에만 보임 --%>
		<c:if test="${postUserName eq userName}">
		<div class="d-flex">
		<%-- 수정 : postCreate로 넘어가기 --%>
			<button type="button" id="postChangeBtn" class="btn btn-info mr-3">
				<a href="/post/post_create_view?postType=${post.postType}&isUpdate=true&postId=${post.id}" class="button">
					수정하기
				</a>
			</button>
			<button type="button" id="postDeleteBtn" class="btn btn-danger">삭제하기</button>
		</div>
		</c:if>
	</div>
		
	<div class="pt-3 d-flex justify-content-between">
		<%-- 작성자 --%>
		<div class="d-flex align-items-center">
			<span class="bold mr-3 valueTitle-font-size">작성자</span>
			<span id="postUserName" class="value-font-size">${postUserName}</span>
		</div>
		<div class="d-flex">
			<%-- 게시일 --%>
			<div class="pr-3 d-flex align-items-center">
				<span class="bold mr-3 valueTitle-font-size">게시일</span>
				<span class="mr-3 value-font-size">
					<fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/>
				</span>
			</div>
			<%-- 조회수 --%>
			<div class="d-flex align-items-center">
				<span class="bold mr-3 valueTitle-font-size">조회수</span>
				<span id="postLike" class="mr-3 value-font-size">조회수</span>
			</div>
		</div>
	</div>
	
	<%-- 글 내용 --%>
	<div class="pt-4">
		<textarea rows="10" cols="100" id="content" name="content" class="form-control">${post.content}</textarea>
	</div>
	
	<%-- 글 목록 버튼 --%>
	<div class="pt-3 d-flex justify-content-end">
		<button type="button" id="postListBtn" class="btn btn-dark">
			<a href="/post/postList?postType=${post.postType}" class="button">글 목록</a>
		</button>
	</div>
</div>

<%-- 댓글 --%>
<div class="pt-4 container">
	<%-- 댓글 쓰기(본인) : 로그인 시에만 보이게 --%>
	<c:if test="${not empty userId}">
	<div class="d-flex align-items-center">
		<%-- 본인 프로필 사진 --%>
		<img src="${userProfileImageUrl}" width="50px" height="50px" alt="userProfileImage">
		<%-- 본인 이름 --%>
		<span class="pl-2 bold mr-3 valueTitle-font-size">${userName}</span>
		
		<div class="input-group">
			<%-- 댓글 작성란 --%>
			<div class="input-group-prepend">
				<input type="text" id="comment" class="form-control">
			</div>
			<%-- 댓글 버튼 : 어떤 글에 대한 댓글인지 postId 심어두어야 함 --%>
			<div class="input-group-append">
				<button type="submit" id="commentBtn" class="input-group-append btn btn-dark"
				data-post-id="${post.id}">댓글</button>
			</div>
		</div>
	</div>
	<hr>
	</c:if>

	<%-- 전체 댓글 보이기(반복문) --%>
	<c:forEach items="${commentViewList}" var="commentView">
	<div class="d-flex justify-content-between">
		<div class="d-flex align-items-center">
			<%-- 댓글 프로필 사진 --%>
			<img src="${commentView.user.profileImageUrl}" width="50px" height="50px" alt="commentprofileImage">
			<%-- 댓글 닉네임 --%>
			<span class="pl-2 bold mr-3 valueTitle-font-size">${commentView.user.name}</span>
			
			<%-- 댓글 내용 --%>
			<span class="commentContent">${commentView.comment.comment}</span>
			<input type="text" class="updatedComment form-control d-none" value="${commentView.comment.comment}">
		</div>
	
		<%-- 댓글 관리 버튼 : 여러 개이므로, class로 부여 --%>
		<%-- 내 댓글일 때만 나타나기, commentId 심어두기 --%>
		<c:if test="${commentView.user.name eq userName}">
			<div class="d-flex align-items-center">
				<div class="dropdown commentManagementBtn">
					<button class="btn btn-secondary dropdown-toggle ml-5" type="button"
						id="dropdownMenuButton" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">댓글 관리</button>
					<div class="dropdown-menu text-center" aria-labelledby="dropdownMenuButton">
						<a class="dropdown-item commentUpdateBtn" href="#" data-comment-id="${commentView.comment.id}">댓글 수정</a>
						<a class="dropdown-item commentDeleteBtn" href="#" data-comment-id="${commentView.comment.id}">댓글 삭제</a>
					</div>
				</div>
			
				<button type="button" class="btn btn-dark allowUpdatedComment ml-3 d-none button">
					수정 완료
				</button>
			</div>
		</c:if>
	</div>
	<hr>
	</c:forEach>
</div>

<script>
	$(document).ready(function(){
		// 글 삭제
		$('#postDeleteBtn').on('click', function(e) {
			Swal.fire({
	            title: '게시글을 삭제 하시겠습니까?',
	            text: "다시 되돌릴 수 없습니다. 신중하세요.",
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonColor: '#3085d6',
	            cancelButtonColor: '#d33',
	            confirmButtonText: '삭제',
	            cancelButtonText: '취소'
	        }).then((result) => { // 최종 삭제를 눌렀을 경우 Delete AJAX 실행
	            if (result.isConfirmed) {
					let postId = ${post.id};
					let postUserId = ${postUserId};
					// alert(postId);
					// alert(postUserId);
					
					// AJAX
					$.ajax({
						type:'DELETE'
						,url:'/post/delete'
						,data: {"postId":postId, "postUserId":postUserId}
						,success: function(data) {
							if (data.result) {
								Swal.fire({
						            icon: 'success',
						            title: '게시글이 삭제되었습니다.',
						        }).then((value)=>{
									location.href="/post/postList?postType="+ data.postType;
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
		
		// 댓글 쓰기
		$('#commentBtn').on('click', function(e) {
			// 글 번호, 댓글 내용
			let postId = $(this).data('post-id');
			// alert(postId);
			
			let comment = $('#comment').val().trim();
			// alert(comment);
			
			if(comment == ''){
				alert("댓글 내용을 입력하세요");
				return;
			}
			
			// AJAX
			$.ajax({
				type:'POST'
				,url:'/comment/create'
				,data: {"postId":postId, "comment":comment}
				,success: function(data) {
					if (data.code == 1) {
						location.reload(); // 새로고침
					} else if (data.code == 500) {
						alert("로그인을 해주세요.");
						location.href = "/user/sign_in_view";
					}
				}
				,error: function(jqXHR, textStatus, errorThrown) {
					var errorMsg = jqXHR.responseJSON.status;
					alert(errorMsg + ":" + textStatus);
				}
			});
		});
		
		// 댓글 삭제
		$('.commentDeleteBtn').on('click', function(e) {
			// 댓글 번호
			let commentId = $(this).data('comment-id');
			// alert(commentId);
			
			// AJAX
			$.ajax({
				type:'DELETE'
				,url:'/comment/delete'
				,data: {"commentId":commentId}
				,success: function(data) {
					if (data.code == 1) {
						location.reload(); // 새로고침
					} else if (data.code == 500) {
						alert("삭제 실패!");
					}
				}
				,error: function(jqXHR, textStatus, errorThrown) {
					var errorMsg = jqXHR.responseJSON.status;
					alert(errorMsg + ":" + textStatus);
				}
			});
		});
		
		// 댓글 수정(Update)
		$('.commentUpdateBtn').on('click', function(e) {
			// 댓글 내용 수정 가능하게 하기 : 수정하고자 하는 댓글만 지정
			$(".commentContent").addClass("d-none");
			$(".updatedComment").removeClass("d-none");

			// 버튼 toggle
			$(".commentManagementBtn").addClass("d-none");
			// 수정하고자 하는 댓글만 지정
			$(".allowUpdatedComment").removeClass("d-none");
		});
		
		// 댓글 수정 - 수정 완료 버튼
		$('.allowUpdatedComment').on('click', function(e) {
			// 댓글 번호
			let commentId = $(this).data('comment-id');
		
			// 수정 내용 넘기기
			let updatedComment = $(this).parents('input').val().trim();
			alert(updatedComment);
			
			// 내용이 없으면 입력하라고 alert
			if(updatedComment == ''){
				alert("내용을 입력해 주세요");
				return;
			}
			
			// AJAX
			$.ajax({
				type:'PUT'
				,url:'/comment/update'
				,data: {"commentId":commentId, "updatedComment":updatedComment}
				,success: function(data) {
					if (data.code == 1) {
						location.reload(); // 새로고침
					} else if (data.code == 500) {
						alert("댓글 수정 실패!");
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