package com.festivalBooking.book.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.festivalBooking.book.model.Book;
import com.festivalBooking.book.model.BookView;

@Repository
public interface BookDAO {

	// 예매 내역 객체 형태로 보내기(insert)
	public void insertBooking(Book book);
	
	// 내 예매 내역 가져오기(select)
	public List<Book> selectMyBookList(int userId);
}
