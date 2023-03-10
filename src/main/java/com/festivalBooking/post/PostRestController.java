package com.festivalBooking.post;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
	
	// 글 쓰기
	@PostMapping("/create")
	public Map<String, Object> create(
			@ModelAttribute Post post){
		
		// DB에 insert
		// postBO.addPost(userId,postType,postTitle,content);
		postBO.addPost(post);
		
		// 여기까지 내려왔다는 것은 잘 들어갔다는 것
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);		
		result.put("result", true);
		
		// 성공 시 글 상세(postDetail) 화면으로 이동하기 위한 파라미터 Json으로 전송
		result.put("postType", post.getPostType());
		result.put("postId", post.getId());
		
		return result;
	}
	
	@PutMapping("/update")
	public Map<String, Object> update(
			@RequestParam("postId") int postId
			,@RequestParam("postUpdatedTitle") String postUpdatedTitle
			,@RequestParam("updatedContent") String updatedContent
			){
		
		// DB Update
		postBO.updatePost(postId, postUpdatedTitle, updatedContent);
		
		// 여기까지 내려왔다는 것은 잘 수정됐다는 것
		Map<String, Object> result = new HashMap<>();
		result.put("result", true);
		
		// 글 수정 성공 시 글 상세(postDetail) 화면으로 이동하기 위한 파라미터 Json으로 전송
		Post post = postBO.getPostByPostId(postId);
		result.put("postType", post.getPostType());
		result.put("postId", post.getId());
		
		return result;
	}
	
	// 글 삭제
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
		
		// 삭제 시 에러가 없으면 성공한 것
		Map<String, Object> result = new HashMap<>();
		result.put("result", true);
		result.put("postType", postType);
		
		return result;
 	}
}
