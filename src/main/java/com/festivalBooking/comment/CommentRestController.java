package com.festivalBooking.comment;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.festivalBooking.comment.bo.CommentBO;

import jakarta.servlet.http.HttpSession;

@RestController
public class CommentRestController {
	@Autowired
	private CommentBO commentBO;

	@PostMapping("/comment/create")
	public Map<String, Object> addComment(
			@RequestParam("postId") int postId
			,@RequestParam("comment") String comment
			,HttpSession session
			) {

		int userId = (int)session.getAttribute("userId");
		boolean isaddCommentSuccess = commentBO.createComment(userId, postId, comment);

		Map<String, Object> result = new HashMap<>();

		if(isaddCommentSuccess) {
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("result", "실패");			
		}
		return result;
	}
}
