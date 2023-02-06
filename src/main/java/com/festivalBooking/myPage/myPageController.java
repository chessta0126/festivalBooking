package com.festivalBooking.myPage;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/myPage")
@Controller
public class myPageController {

	@GetMapping("/myPage_view")
	public String myPageView(Model model) {
		model.addAttribute("viewName","myPage/myPage");
		
		return "template/layout";
	}
}
