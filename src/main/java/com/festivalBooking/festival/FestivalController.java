package com.festivalBooking.festival;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/festival")
@Controller
public class FestivalController {

	// 공연 예매 (공연 정보 리스트)
	@GetMapping("/festival_list_view")
	public String festivalListView(Model model) {
		model.addAttribute("viewName","festival/festivalList");
		
		return "template/layout";
	}

	// 내가 등록한 공연
	@GetMapping("/festival_myList_view")
	public String festivalMyListView(Model model) {
		model.addAttribute("viewName","festival/festivalMyList");
		
		return "template/layout";
	}
	
	// 공연 홍보 글쓰기
	@GetMapping("/festival_create_view")
	public String festivalCreateView(Model model) {
		model.addAttribute("viewName","festival/festivalCreate");
		
		return "template/layout";
	}
}
