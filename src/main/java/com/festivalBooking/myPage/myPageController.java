package com.festivalBooking.myPage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.festivalBooking.user.bo.UserBO;
import com.festivalBooking.user.model.User;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/myPage")
@Controller
public class myPageController {
	@Autowired
	private UserBO userBO;

	@GetMapping("/myPage_view")
	public String myPageView(Model model, HttpSession session) {
		Integer userId = (Integer)session.getAttribute("userId");
		// 로그인 시 마이페이지로, 비로그인 시 로그인 페이지로 이동
		if(userId != null) {
			User userInfo = userBO.getUserByUserId(userId);
			model.addAttribute("viewName","myPage/myPage");
			model.addAttribute("userInfo",userInfo);
		} else {
			model.addAttribute("viewName","user/signIn");
		}
		
		return "template/layout";
	}
	
}
