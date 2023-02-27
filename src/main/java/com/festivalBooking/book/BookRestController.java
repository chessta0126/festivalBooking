package com.festivalBooking.book;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
		
		// 성공 시 공연 상세(festivalDetail) 화면으로 이동하기 위한 파라미터 Json으로 전송
		// -> 어떤 공연 (festivalId) 예약한 건지
		
		return result;
	}
}
