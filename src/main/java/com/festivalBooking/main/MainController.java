package com.festivalBooking.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.festivalBooking.festival.bo.FestivalBO;
import com.festivalBooking.festival.model.Festival;
import com.festivalBooking.post.bo.PostBO;
import com.festivalBooking.post.model.Post;

@RequestMapping("/main")
@Controller
public class MainController {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private FestivalBO festivalBO;

	// http://localhost:8080/user/main_view
		@GetMapping("/main_view")
		public String signUpView(Model model) {
			// 최신 공연 정보
			int recommendFestivalLimit = 5;
			List<Festival> festivalList = festivalBO.getFestivalListLimit(recommendFestivalLimit);
			model.addAttribute("festivalList",festivalList);
			model.addAttribute("recommendFestivalLimit",recommendFestivalLimit);
			
			// 이동할 페이지 주소
			model.addAttribute("viewName","main/mainPage");
			
			// 공지사항
			String postType = "공지사항";
			List<Post> postList = postBO.getPostListByPostTypeFromLimit(postType,0,3);
			model.addAttribute("postList",postList);
			
			return "template/layout";
		}
}
