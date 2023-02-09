package com.festivalBooking.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.festivalBooking.post.bo.PostBO;

@RequestMapping("/post")
@Controller
public class PostController {

	@Autowired
	private PostBO postBO;
	
	@PostMapping("/{postType}")
	public String postList(Model model) {
		model.addAttribute("viewName","post/postList");
		
		return "template/layout";
	}
}
