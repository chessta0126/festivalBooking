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

import jakarta.servlet.http.HttpSession;

@RequestMapping("/festival")
@Controller
public class FestivalController {

	@Autowired
	private FestivalBO festivalBO;
	
	/**
	 * 공연 예매 (공연 정보 리스트) API
	 * @param model
	 * @return
	 */
	// http://localhost:8080/festival/festival_list_view
	@GetMapping("/festival_list_view")
	public String festivalListView(Model model) {
		List<Festival> festivalList = festivalBO.getFestivalList();
		
		model.addAttribute("viewName","festival/festivalList");
		model.addAttribute("festivalList",festivalList);
		
		return "template/layout";
	}
	/**
	 * 공연 기간 검색 후 기간 내 공연 다시 뿌리기 API
	 * @param startDate
	 * @param endDate
	 * @param model
	 * @return
	 */
	// http://localhost:8080/festival/festival_list_view_limit?startDate={startDate}&endDate={endDate}
	@GetMapping("/festival_list_view_limit")
	public String festivalListLimitView(
			@RequestParam("startDate") String startDate
			,@RequestParam("endDate") String endDate
			,Model model) {
		List<Festival> festivalListByLimit = festivalBO.getFestivalListByLimit(startDate,endDate);
		
		model.addAttribute("viewName","festival/festivalList");
		model.addAttribute("festivalList",festivalListByLimit);
		
		return "template/layout";
	}

	/**
	 * 내가 등록한 공연 목록 API
	 * @param model
	 * @param session
	 * @return
	 */
	// http://localhost:8080/festival/festival_myList_view
	@GetMapping("/festival_myList_view")
	public String festivalMyListView(Model model, HttpSession session) {
		
		Integer userId = (Integer)session.getAttribute("userId");
		List<Festival> festivalList = festivalBO.getFestivalListByUserId(userId);
		
		model.addAttribute("viewName","festival/festivalMyList");
		model.addAttribute("festivalList",festivalList);
		
		return "template/layout";
	}
	
	/**
	 * 공연 홍보 글쓰기 API
	 * @param model
	 * @return
	 */
	// http://localhost:8080/festival/festival_create_view
	@GetMapping("/festival_create_view")
	public String festivalCreateView(Model model) {
		model.addAttribute("viewName","festival/festivalCreate");
		
		return "template/layout";
	}

	/**
	 * 공연 홍보 글 상세 API
	 * @param festivalId
	 * @param model
	 * @return
	 */
	// http://localhost:8080/festival/festival_detail_view?festivalId={festivalId}
	@GetMapping("/festival_detail_view")
	public String festivalDetailView(
			@RequestParam("festivalId") int festivalId
			,Model model) {
		
		Festival festival = festivalBO.getFestivalByFestivalId(festivalId);
		
		model.addAttribute("viewName","festival/festivalDetail");
		model.addAttribute("festival",festival);
		model.addAttribute("isTimeOver",festival.isTimeOver());
		
		return "template/layout";
	}
}