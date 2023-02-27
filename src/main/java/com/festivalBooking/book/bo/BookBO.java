package com.festivalBooking.book.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.festivalBooking.book.dao.BookDAO;
import com.festivalBooking.book.model.Book;

@Service
public class BookBO {

	@Autowired
	private BookDAO bookDAO;
	
	// 글 작성 post 형태로 보내기(insert)
	public void addBooking(Book book) {
		bookDAO.insertBooking(book);
	}
}
