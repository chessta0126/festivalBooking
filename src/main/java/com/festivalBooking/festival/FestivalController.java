package com.festivalBooking.festival;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.festivalBooking.festival.bo.FestivalBO;
import com.festivalBooking.festival.model.Festival;

@RequestMapping("/festival")
@Controller
public class FestivalController {

	@Autowired
	private FestivalBO festivalBO;
	
	// 공연 예매 (공연 정보 리스트)
	@GetMapping("/festival_list_view")
	public String festivalListView(Model model) {
		List<Festival> festivalList = festivalBO.getFestivalList();
		
		model.addAttribute("viewName","festival/festivalList");
		model.addAttribute("festivalList",festivalList);
		
		return "template/layout";
	}

	// 내가 등록한 공연 목록
	@GetMapping("/festival_myList_view")
	public String festivalMyListView(Model model) {
		
		List<Festival> festivalList = festivalBO.getFestivalList();
		
		model.addAttribute("viewName","festival/festivalMyList");
		model.addAttribute("festivalList",festivalList);
		
		return "template/layout";
	}
	
	// 공연 홍보 글쓰기
	@GetMapping("/festival_create_view")
	public String festivalCreateView(Model model) {
		model.addAttribute("viewName","festival/festivalCreate");
		
		return "template/layout";
	}

	// 공연 홍보 글 상세
	// http://localhost:8080/festival/festival_detail_view?festivalId={festivalId}
	@GetMapping("/festival_detail_view")
	public String festivalDetailView(
			@RequestParam("festivalId") int festivalId
			,Model model) {
		
		Festival festival = festivalBO.getFestivalByFestivalId(festivalId);
		
		model.addAttribute("viewName","festival/festivalDetail");
		model.addAttribute("festival",festival);
		
		return "template/layout";
	}
}
