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

	// http://localhost:8080/book/myBooking_view?startDate={startDate}&endDate={endDate}
	@GetMapping("/myBooking_view")
	public String myBookingView(
		@RequestParam(value="startDate",required = false) String startDate
		,@RequestParam(value="endDate",required = false) String endDate
		,@RequestParam(value="bookName",required = false) String bookName
		,@RequestParam(value="phoneNumber",required = false) String phoneNumber
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
}
