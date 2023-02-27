package com.festivalBooking.book.dao;

import org.springframework.stereotype.Repository;

import com.festivalBooking.book.model.Book;

@Repository
public interface BookDAO {

	public void insertBooking(Book book);
}
