package com.festivalBooking.book;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.festivalBooking.book.bo.BookBO;
import com.festivalBooking.book.model.BookView;
import com.festivalBooking.comment.model.Comment;
import com.festivalBooking.comment.model.CommentView;
import com.festivalBooking.user.model.User;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/book")
@Controller
public class BookController {
	
	@Autowired
	private BookBO bookBO;

	// http://localhost:8080/book/myBooking_view
	@GetMapping("/myBooking_view")
	public String myBookingView(Model model, HttpSession session) {

		int userId = (int)session.getAttribute("userId");
		// DB select
	
		List<BookView> myBookingList = bookBO.generateBookViewListByUserId(userId);
		model.addAttribute("myBookingList",myBookingList);
				
		model.addAttribute("viewName","book/myBooking");
		
		return "template/layout";
	}
}
