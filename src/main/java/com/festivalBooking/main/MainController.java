package com.festivalBooking.main;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/main")
@Controller
public class MainController {

	// http://localhost:8080/user/main_view
		@GetMapping("/main_view")
		public String signUpView(Model model) {
			model.addAttribute("viewName","main/mainPage");
			
			return "template/layout";
		}
}
