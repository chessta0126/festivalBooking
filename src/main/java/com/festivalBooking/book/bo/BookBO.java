package com.festivalBooking.book.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.festivalBooking.book.dao.BookDAO;
import com.festivalBooking.book.model.Book;
import com.festivalBooking.book.model.BookView;
import com.festivalBooking.festival.bo.FestivalBO;
import com.festivalBooking.festival.model.Festival;

@Service
public class BookBO {

	@Autowired
	private BookDAO bookDAO;
	
	// 예매 내역 객체 형태로 보내기(insert)
	public void addBooking(Book book) {
		bookDAO.insertBooking(book);
	}

	// 내 예매 내역 가져오기(select)
	public List<Book> getMyBookList(int userId) {
		return bookDAO.selectMyBookList(userId);
	}

	// 기간 내 예매 내역 가져오기(select)
	public List<Book> getMyBookListByLimit(
			String startDate, String endDate, int userId) {
		return bookDAO.selectMyBookListByLimit(startDate,endDate,userId);
	}

	// 내 예매 정보 1개 가져오기(select)
	public Book getMyBook(int userId, int festivalId) {
		return bookDAO.selectMyBook(userId,festivalId);
	}
	
	// 회원 예매 여부 확인(userId, festivalId)
	public boolean isBookedByUserIdFestivalId(int userId, int festivalId) {
		return bookDAO.isBookedByUserIdFestivalId(userId,festivalId);
	}

	// 비회원 예매 여부 확인(bookName,phoneNumber / festivalId)
	public boolean isBookedNotMember(int bookName, int phoneNumber, int festivalId) {
		return bookDAO.isBookedNotMember(bookName,phoneNumber,festivalId);
	}
	
	
	
	// 추가 예매 (update)
	public void updateBooking(int headCount, int festivalId, int userId, int payMoney) {
		bookDAO.updateBooking(headCount, festivalId, userId, payMoney);
	}
	
	// 예매 취소 (delete)
	public void deleteBooking(int festivalId, int userId) {
		bookDAO.deleteBooking(festivalId, userId);
	}

	// 공연에 대한 모든 예매내역 삭제 (delete) - festivalId
	public void deleteBookingByFestivalId(int festivalId) {
		bookDAO.deleteBookingByFestivalId(festivalId);
	}
}
