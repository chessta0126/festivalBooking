package com.festivalBooking.post;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.festivalBooking.post.bo.PostBO;

@RequestMapping("/post")
@RestController
public class PostRestController {

	@Autowired
	private PostBO postBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("userId") int userId
			,@RequestParam("postType") String postType
			,@RequestParam("postTitle") String postTitle
			,@RequestParam("content") String content
			){
		
		// DB에 insert
		postBO.addPost(userId,postType,postTitle,content);
		
		// 여기까지 내려왔다는 것은 잘 들어갔다는 것
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);		
		result.put("result", true);
		result.put("postType", postType);
		
		return result;
	}
}
