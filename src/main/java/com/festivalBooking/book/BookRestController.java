package com.festivalBooking.book;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.festivalBooking.book.bo.BookBO;
import com.festivalBooking.book.model.Book;

@RequestMapping("/book")
@RestController
public class BookRestController {

	@Autowired
	private BookBO bookBO;
	
	@PostMapping("/addBooking")
	public Map<String, Object> addBooking(
			@ModelAttribute Book book){
		
		// DB insert
		bookBO.addBooking(book);
		
		// 여기까지 내려왔다는 것은 잘 들어갔다는 것
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);		
		result.put("result", true);
		
		return result;
	}
	
	@PutMapping("/updateBooking")
	public Map<String, Object> updateBooking(
			@RequestParam("headCount") int headCount
			,@RequestParam("festivalId") int festivalId
			,@RequestParam("userId") int userId
			,@RequestParam("payMoney") int payMoney
			){
		
		// DB update
		bookBO.updateBooking(headCount, festivalId, userId, payMoney);
		
		// 여기까지 내려왔다는 것은 잘 수정됐다는 것
		Map<String, Object> result = new HashMap<>();
		result.put("result", true);
		
		return result;
	}
	
	@DeleteMapping("/deleteBooking")
	public Map<String, Object> deleteBooking(
			@RequestParam("festivalId") int festivalId
			,@RequestParam("userId") int userId
			){
		
		// DB delete
		bookBO.deleteBooking(festivalId, userId);
		
		// 여기까지 내려왔다는 것은 잘 수정됐다는 것
		Map<String, Object> result = new HashMap<>();
		result.put("result", true);
		
		return result;
	}
}
