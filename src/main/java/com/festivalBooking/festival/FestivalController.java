package com.festivalBooking.festival;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.festivalBooking.book.bo.BookBO;
import com.festivalBooking.book.model.BookView;
import com.festivalBooking.festival.bo.FestivalBO;
import com.festivalBooking.festival.model.Festival;
import com.festivalBooking.post.model.Post;
import com.festivalBooking.user.model.User;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/festival")
@Controller
public class FestivalController {

	@Autowired
	private FestivalBO festivalBO;

	@Autowired
	private BookBO bookBO;
	
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
	
	// 공연 홍보 글 쓰기, 수정하기 API
	// http://localhost:8080/festival/festival_create_view?isUpdate={isUpdate}&festivalId={festivalId}
	@GetMapping("/festival_create_view")
	public String festivalCreateView(
			@RequestParam("isUpdate") boolean isUpdate
			, @RequestParam(value="festivalId", required=false) Integer festivalId
			, Model model) {
		model.addAttribute("viewName","festival/festivalCreate");

		// 공연 수정(update)인지, 공연 등록(insert)인지 파악(화면 공유)
		if (isUpdate) { // 공연 수정일 경우
			model.addAttribute("isUpdate", true);
			model.addAttribute("festivalId", festivalId);

			// 기존에 작성한 공연 정보를 띄워줘야 함
			Festival festival = festivalBO.getFestivalByFestivalId(festivalId);
			model.addAttribute("festival", festival);
			model.addAttribute("isTimeOver", festival.isTimeOver());
		} else {
			model.addAttribute("isUpdate", false);
			// 그냥 글쓰기로 접근했을 때, ${postId}가 존재하지 않으므로 에러가 떠버림 -> 일단 0으로 둔다.
			// insert할 때 postId는 넘기지 않으니 괜찮다.
			model.addAttribute("postId", 0);
		}
		
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
			,Model model, HttpSession session) {
		
		// 이동 페이지
		model.addAttribute("viewName","festival/festivalDetail");

		// 어떤 공연 상세
		Festival festival = festivalBO.getFestivalByFestivalId(festivalId);
		model.addAttribute("festival",festival);

		// 예매 중지 여부
		model.addAttribute("isTimeOver",festival.isTimeOver());
		
		// 예매 여부(회원 / 비회원)
		// 비로그인 시 아예 session이 없으므로 에러-> 예외처리
		try{ // 회원(로그인)
			int userId = (int)session.getAttribute("userId");
			boolean isBooked = bookBO.isBookedByUserIdFestivalId(userId, festivalId);
			model.addAttribute("isBooked",isBooked);
			
			BookView bookView = bookBO.generateBookViewByUserIdFestivalId(userId, festivalId);
			model.addAttribute("bookView",bookView);
		}catch(Exception e){
			// 비회원(비로그인)일 때는 예매 완료 버튼은 띄우지 않는다(false)
			model.addAttribute("isBooked",false);			
		}
		
		return "template/layout";
	}
}