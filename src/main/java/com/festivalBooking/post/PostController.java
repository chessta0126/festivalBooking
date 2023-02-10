package com.festivalBooking.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.festivalBooking.post.bo.PostBO;
import com.festivalBooking.post.model.Post;
import com.festivalBooking.user.bo.UserBO;
import com.festivalBooking.user.model.User;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/post")
@Controller
public class PostController {

	@Autowired
	private PostBO postBO;

	@Autowired
	private UserBO userBO;
	
	// 글 목록 화면
	// http://localhost:8080/post/postList?postType={postType}
	@RequestMapping(value="/postList", method=RequestMethod.GET)
	public String postList(String postType, Model model) {
		
		List<Post> postList = postBO.getPostListByPostType(postType);
		
		model.addAttribute("viewName","post/postList");
		model.addAttribute("postList",postList);
		model.addAttribute("postType",postType);
		
		return "template/layout";
	}
	
	// 글쓰기 화면
	// http://localhost:8080/post/post_create_view?postType={postType}
	@GetMapping("/post_create_view")
	public String postCreateView(
			@RequestParam("postType") String postType
			, Model model, HttpSession session) {
		
		model.addAttribute("viewName","post/postCreate");
		model.addAttribute("postType",postType);
		
		// 누가 작성한 글인지 알아야 함
		Integer userId = (Integer)session.getAttribute("userId");
		User user = userBO.getUserByUserId(userId);
		model.addAttribute("user",user);
		
		return "template/layout";
	}
}