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

	@Autowired
	private FestivalBO festivalBO;
	
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
	
	// 공연과 예약 정보 매칭
	public List<BookView> generateBookViewListByUserId(int userId) {
		// 결과물
		List<BookView> bookViewList = new ArrayList<>();
		// 예매 내역(위에서 만든 메서드)
		List<Book> bookList = getMyBookList(userId);
		
		// 반복문 => 각 BookView(공연-예매 내역이 한 쌍) => 결과물에 넣는다.
		for(Book book : bookList) {
			BookView bookView = new BookView();
			
			// 예매내역
			bookView.setBook(book);
			
			Festival festival = festivalBO.getFestivalByFestivalId(book.getFestivalId());
			bookView.setFestival(festival);
					
			// 공연-예매 내역 1쌍 담기
			bookViewList.add(bookView);
		}
	
		// 결과물 리턴
		return bookViewList;
	}

	// 공연과 예약 정보 매칭(Limit으로 제한해서 가져오기)
	public List<BookView> generateBookViewListByLimit(
			String startDate, String endDate, int userId) {
		// 결과물
		List<BookView> bookViewList = new ArrayList<>();
		
		// 예매 내역(위에서 만든 메서드)
		List<Book> bookList = getMyBookListByLimit(startDate, endDate, userId);
		
		// 반복문 => 각 BookView(공연-예매 내역이 한 쌍) => 결과물에 넣는다.
		for(Book book : bookList) {
			BookView bookView = new BookView();
			
			// 예매내역
			bookView.setBook(book);
			
			Festival festival = festivalBO.getFestivalByFestivalId(book.getFestivalId());
			bookView.setFestival(festival);
			
			// 공연-예매 내역 1쌍 담기
			bookViewList.add(bookView);
		}
		
		// 결과물 리턴
		return bookViewList;
	}

	// 공연과 예약 정보 매칭 1건
	public BookView generateBookViewByUserIdFestivalId(int userId,int festivalId) {
		// 결과물
		BookView bookView = new BookView();
		
		// 예매 정보(위에서 만든 메서드)
		Book book = getMyBook(userId, festivalId);
		bookView.setBook(book);
		
		// 공연 정보
		Festival festival = festivalBO.getFestivalByFestivalId(festivalId);
		bookView.setFestival(festival);
			
		// 결과물 리턴
		return bookView;
	}
}
