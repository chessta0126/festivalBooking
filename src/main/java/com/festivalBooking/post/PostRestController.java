package com.festivalBooking.post;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.festivalBooking.comment.bo.CommentBO;
import com.festivalBooking.post.bo.PostBO;
import com.festivalBooking.post.model.Post;

@RequestMapping("/post")
@RestController
public class PostRestController {

	@Autowired
	private PostBO postBO;

	@Autowired
	private CommentBO commentBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("userId") int userId
			,@RequestParam("postType") String postType
			,@RequestParam("postTitle") String postTitle
			,@RequestParam("content") String content
			,@ModelAttribute Post post
			){
		
		// DB에 insert
		postBO.addPost(userId,postType,postTitle,content);
		
		// 여기까지 내려왔다는 것은 잘 들어갔다는 것
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);		
		result.put("result", true);
		
		// 성공시 글 상세(postDetail) 화면으로 이동하기 위한 파라미터 Json으로 전송
		// DB select
		result.put("postType", postType);
		result.put("postId", post.getId());
		
		return result;
	}
	
	@DeleteMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("postId") int postId
			,@RequestParam("postUserId") int postUserId
			){
		// 어떤 글인지 (postId), 누가 썼는지(postUserId) 알아야 지움
		
		// 삭제 후 이동할 페이지의 파라미터로 쓰일 postType을 result에 담아 보내기
		Post post = postBO.getPostByPostId(postId);
		String postType = post.getPostType();
		
		// 글(post) 삭제
		postBO.deletePostByPostIdUserId(postId,postUserId);
		
		// 댓글(comment) 전체 삭제
		commentBO.deleteCommentsByPostId(postId);
		
		// 좋아요(like) 삭제
		
		// 조회수(view) 삭제
		
		// 삭제 시 에러가 없으면 성공한 것
		Map<String, Object> result = new HashMap<>();
		result.put("result", true);
		result.put("postType", postType);
		
		return result;
 	}
}
