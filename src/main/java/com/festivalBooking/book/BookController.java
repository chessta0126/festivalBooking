package com.festivalBooking.book;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.festivalBooking.book.bo.BookBO;
import com.festivalBooking.book.model.Book;
import com.festivalBooking.book.model.BookView;
import com.festivalBooking.festival.bo.FestivalBO;
import com.festivalBooking.festival.model.Festival;

@RequestMapping("/book")
@Controller
public class BookController {
	
	@Autowired
	private BookBO bookBO;
	
	@Autowired
	private FestivalBO festivalBO;

	// http://localhost:8080/book/myBooking_view?startDate={startDate}&endDate={endDate}&bookName={bookName}&phoneNumber={phoneNumber}
	@GetMapping("/myBooking_view")
	public String myBookingView(
		@RequestParam(value="startDate",required = false) String startDate
		,@RequestParam(value="endDate",required = false) String endDate
		,@RequestParam(value="bookName",required = false) String bookName
		,@RequestParam(value="phoneNumberHead",required = false) String phoneNumberHead
		,@RequestParam(value="phoneNumberMiddle",required = false) String phoneNumberMiddle
		,@RequestParam(value="phoneNumberEnd",required = false) String phoneNumberEnd
		,Model model, HttpSession session) {

		try { // 회원 예매내역 확인(id 존재)
			int userId = (int)session.getAttribute("userId");
			
			// DB select
			List<BookView> myBookingList = festivalBO.generateBookViewListByUserId(userId);
			if(!ObjectUtils.isEmpty(startDate) && !ObjectUtils.isEmpty(endDate)) {
				myBookingList = festivalBO.generateBookViewListByLimit(startDate, endDate, userId);
			}
			model.addAttribute("myBookingList",myBookingList);
			
		} catch(Exception e) { // 비회원 예매내역 확인
			// DB select
			String phoneNumber = phoneNumberHead+ "-" + phoneNumberMiddle+ "-" + phoneNumberEnd;
			List<BookView> myBookingList = festivalBO.generateBookViewListBybookNamephoneNumber(bookName,phoneNumber);
			model.addAttribute("myBookingList",myBookingList);
		}
		model.addAttribute("viewName","book/myBooking");
		
		// 예매 내역 없을 경우, 최신 공연 n개 추천
		int recommendCount = 3;
		List<Festival> festivalList = festivalBO.getFestivalListLimit(recommendCount);
		model.addAttribute("festivalList",festivalList);
		
		return "template/layout";
	}
	
	
	// http://localhost:8080/book/myFestivalBookingConfirm_view?festivalId={festivalId}
		@GetMapping("/myFestivalBookingConfirm_view")
		public String myFestivalBookingConfirmView(
				@RequestParam("festivalId") int festivalId
				,Model model) {

			// 공연 정보(id, 이름) 내려주기
			Festival festival = festivalBO.getFestivalByFestivalId(festivalId);
			model.addAttribute("festival",festival);			
			
			// 예매 내역
			List<BookView> bookViewList = festivalBO.generateBookViewListByfestivalId(festivalId);
			model.addAttribute("bookViewList",bookViewList);

			// 페이지 이동경로
			model.addAttribute("viewName","book/myFestivalBookingConfirm");
			return "template/layout";
		}
}
