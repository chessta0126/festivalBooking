package com.festivalBooking.festival.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.festivalBooking.common.FileManagerService;
import com.festivalBooking.festival.dao.FestivalDAO;
import com.festivalBooking.festival.model.Festival;

import jakarta.servlet.http.HttpSession;

@Service
public class FestivalBO {

	@Autowired
	private FestivalDAO festivalDAO;
	
	@Autowired
	private FileManagerService fileManager;
	
	// 공연 추가 + 포스터 이미지 저장
	public boolean addFestival(int userId, String title, String date, String startTime, String endTime, String place, String address, int price, int priceOffline, 
			MultipartFile posterImg, String lineUp, String explain, String warning, String festivalMaster, String askRoot, boolean isTimeOver, String name) {
		// 파일 업로드 => 경로
		String imagePath = null;
		if(posterImg != null) {
			imagePath = fileManager.saveFile(name, posterImg);
		} else {
			imagePath = "/images/★default file/no-image-found-360x250-1-300x208.png";
		}

		return festivalDAO.insertFestival(userId, title, date, startTime, endTime, place, address, price, priceOffline, 
				imagePath, lineUp, explain, warning, festivalMaster, askRoot, isTimeOver);
	}

	// 공연 목록 가져오기
	public List<Festival> getFestivalList() {
		return festivalDAO.getFestivalList();
	}

	// 공연 가져오기 (festivalId)
	public Festival getFestivalByFestivalId(int festivalId) {
		return festivalDAO.getFestivalByFestivalId(festivalId);
	}
}
