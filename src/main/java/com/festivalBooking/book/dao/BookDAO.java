package com.festivalBooking.book.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.festivalBooking.book.model.Book;

@Repository
public interface BookDAO {

	// 예매 내역 객체 형태로 보내기(insert)
	public void insertBooking(Book book);
	
	// 내 예매 내역 가져오기(select)
	public List<Book> selectMyBookList(int userId);

	// 기간 내 예매 내역 가져오기(select)
	public List<Book> selectMyBookListByLimit(
			@Param("startDate") String startDate
			, @Param("endDate") String endDate
			, @Param("userId") int userId);
	
	// 내 예매 정보 1개 가져오기(select)
	public Book selectMyBook(
			@Param("userId") int userId
			, @Param("festivalId") int festivalId);
	
	// 회원 예매 여부 확인(festivalId)
	public boolean isBookedByUserIdFestivalId(
			@Param("userId") int userId
			, @Param("festivalId") int festivalId);
	
	// 비회원 예매 여부 확인(bookName,phoneNumber / festivalId)
	public boolean isBookedNotMember(
			@Param("bookName") int bookName
			, @Param("phoneNumber") int phoneNumber
			, @Param("festivalId") int festivalId);
}
