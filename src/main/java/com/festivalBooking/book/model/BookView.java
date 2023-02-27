package com.festivalBooking.book.model;

import com.festivalBooking.festival.model.Festival;

// 예약 내역과 공연 정보를 매칭해서 보여주도록 이어준다.
public class BookView {

	// 예약 내역
	private Book book;
	
	// 공연 정보
	private Festival festival;

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public Festival getFestival() {
		return festival;
	}

	public void setFestival(Festival festival) {
		this.festival = festival;
	}
}
