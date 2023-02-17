package com.festivalBooking.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.festivalBooking.post.bo.PostBO;
import com.festivalBooking.post.model.Post;

@RequestMapping("/main")
@Controller
public class MainController {
	
	@Autowired
	private PostBO postBO;

	// http://localhost:8080/user/main_view
		@GetMapping("/main_view")
		public String signUpView(Model model) {
			
			String postType = "공지사항";
			List<Post> postList = postBO.getPostListByPostType(postType);
			
			model.addAttribute("viewName","main/mainPage");
			model.addAttribute("postList","postList");
			
			return "template/layout";
		}
}
