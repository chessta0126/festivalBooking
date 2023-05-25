package com.festivalBooking.festival.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;

import com.festivalBooking.book.bo.BookBO;
import com.festivalBooking.book.model.Book;
import com.festivalBooking.book.model.BookView;
import com.festivalBooking.common.FileManagerService;
import com.festivalBooking.festival.dao.FestivalDAO;
import com.festivalBooking.festival.model.Festival;
import com.festivalBooking.user.bo.UserBO;
import com.festivalBooking.user.model.User;

@Service
public class FestivalBO {

	@Autowired
	private FestivalDAO festivalDAO;

	@Autowired
	private BookBO bookBO;

	@Autowired
	private UserBO userBO;
	
	@Autowired
	private FileManagerService fileManager;
	
	// 공연 추가 + 포스터 이미지 저장
	public boolean addFestival(Festival festival, MultipartFile posterImg, String name) {
		// 파일 업로드 => 경로
		String imagePath = null;
		if(!ObjectUtils.isEmpty(posterImg)) {
			imagePath = fileManager.saveFile(name, posterImg);
		} else {
			imagePath = "/images/★default file/image_icon-icons.com_50366.png";
		}
		
		// MultipartFile이 넘어올 때 Festival 객체 형태가 되면서 String으로 이상하게 들어온 것
		// -> 올바른 imagepath로 정정해서 다시 setting
		festival.setImagePath(imagePath);

		return festivalDAO.insertFestival(festival);
	}

	// 공연 목록 가져오기
	public List<Festival> getFestivalList() {
		return festivalDAO.selectFestivalList();
	}
	
	// 공연 목록 몇 개만 가져오기
	public List<Festival> getFestivalListLimit(int limit){
		return festivalDAO.selectFestivalListLimit(limit);
	};
		
	// 기간 내 공연 목록 가져오기
	public List<Festival> getFestivalListByLimit(String startDate, String endDate) {
		return festivalDAO.selectFestivalListByLimitDate(startDate,endDate);
	}
	
	// 내 공연 목록 가져오기
	public List<Festival> getFestivalListByUserId(int userId) {
		return festivalDAO.selectFestivalListByUserId(userId);
	}

	// 공연 가져오기 (festivalId)
	public Festival getFestivalByFestivalId(int festivalId) {
		return festivalDAO.selectFestivalByFestivalId(festivalId);
	}
	
	
	// 공연 정보 수정 (update) + 포스터 이미지 저장
	public boolean updateFestival(Festival festival, MultipartFile posterImg, String name) {
		// 파일 업로드 => 경로
		String imagePath = null;
		if(!ObjectUtils.isEmpty(posterImg)) {
			imagePath = fileManager.saveFile(name, posterImg);
		} else {
			// 기존에 등록했던 이미지
			imagePath = festivalDAO.selectFestivalByFestivalId(festival.getId()).getImagePath();
		}
		
		// MultipartFile이 넘어올 때 Festival 객체 형태가 되면서 String으로 이상하게 들어온 것
		// -> 올바른 imagepath로 정정해서 다시 setting
		festival.setImagePath(imagePath);
		
		return festivalDAO.updateFestival(festival);
	}
	
	// 공연 삭제 (delete)
	public void deleteFestivalByFestivalIdUserId(int festivalId, int festivalUserId) {
		// 기존 공연 가져오기
		Festival festival = getFestivalByFestivalId(festivalId);
		
		// 공연 포스터 파일 있으면 삭제
		if(festival.getImagePath() != null) {
			fileManager.deleteFile(festival.getImagePath());
		}

		// 공연(festival) 삭제 - DAO 메서드를 통해
		festivalDAO.deleteFestivalByFestivalIdUserId(festivalId, festivalUserId);
		
		// 예약 내역(book) 삭제
		bookBO.deleteBookingByFestivalId(festivalId);
	}
	
	

	// 공연, 예매, 회원 정보 매칭(userId)
	public List<BookView> generateBookViewListByUserId(int userId) {
		// 결과물
		List<BookView> bookViewList = new ArrayList<>();
		// 예매 내역(위에서 만든 메서드)
		List<Book> bookList = bookBO.getMyBookList(userId);
		
		// 반복문 => 각 BookView(공연-예매 내역이 한 쌍) => 결과물에 넣는다.
		for(Book book : bookList) {
			BookView bookView = new BookView();
			
			// 예매 내역
			bookView.setBook(book);

			// 회원 정보
			User user = userBO.getUserByUserId(book.getUserId());
			bookView.setUser(user);
			
			// 공연 정보
			Festival festival = getFestivalByFestivalId(book.getFestivalId());
			bookView.setFestival(festival);
					
			// 공연-예매 내역 1쌍 담기
			bookViewList.add(bookView);
		}
	
		// 결과물 리턴
		return bookViewList;
	}
	
	// 공연, 예매, 회원 정보 매칭(festivalId)
	public List<BookView> generateBookViewListByfestivalId(int festivalId) {
		// 결과물
		List<BookView> bookViewList = new ArrayList<>();
		
		// 공연에 대한 전체 예매 내역 가져오기
		List<Book> bookList = bookBO.getBookListByFestivalId(festivalId);

		// 반복문 => 각 BookView(공연-예매 내역이 한 쌍) => 결과물에 넣는다.
		for(Book book : bookList) {
			BookView bookView = new BookView();

			// 예매 내역
			bookView.setBook(book);

			// 회원 정보
			User user = userBO.getUserByUserId(book.getUserId());
			bookView.setUser(user);
			
			// 공연 정보
			Festival festival = festivalDAO.selectFestivalByFestivalId(festivalId);
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
		List<Book> bookList = bookBO.getMyBookListByLimit(startDate, endDate, userId);
		
		// 반복문 => 각 BookView(공연-예매 내역이 한 쌍) => 결과물에 넣는다.
		for(Book book : bookList) {
			BookView bookView = new BookView();
			
			// 예매내역
			bookView.setBook(book);
			
			Festival festival = getFestivalByFestivalId(book.getFestivalId());
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
		Book book = bookBO.getMyBook(userId, festivalId);
		bookView.setBook(book);
		
		// 공연 정보
		Festival festival = getFestivalByFestivalId(festivalId);
		bookView.setFestival(festival);
			
		// 결과물 리턴
		return bookView;
	}
	
	// 공연과 예약 정보 매칭(비회원)
	public List<BookView> generateBookViewListBybookNamephoneNumber(String bookName, String phoneNumber) {
		// 결과물
		List<BookView> bookViewList = new ArrayList<>();
		// 예매 내역(위에서 만든 메서드)
		List<Book> bookList = bookBO.getMyBookListNotMember(bookName,phoneNumber);

		// 반복문 => 각 BookView(공연-예매 내역이 한 쌍) => 결과물에 넣는다.
		for(Book book : bookList) {
			BookView bookView = new BookView();

			// 예매내역
			bookView.setBook(book);

			Festival festival = getFestivalByFestivalId(book.getFestivalId());
			bookView.setFestival(festival);

			// 공연-예매 내역 1쌍 담기
			bookViewList.add(bookView);
		}

		// 결과물 리턴
		return bookViewList;
	}
}
