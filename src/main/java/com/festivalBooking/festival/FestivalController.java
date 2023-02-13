package com.festivalBooking.festival;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/festival")
@Controller
public class FestivalController {

	@GetMapping("/festival_list_view")
	public String festivalListView(Model model) {
		model.addAttribute("viewName","festival/festivalList");
		
		return "template/layout";
	}
}
