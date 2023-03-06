package com.festivalBooking.festival.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;

import com.festivalBooking.common.FileManagerService;
import com.festivalBooking.festival.dao.FestivalDAO;
import com.festivalBooking.festival.model.Festival;

@Service
public class FestivalBO {

	@Autowired
	private FestivalDAO festivalDAO;
	
	@Autowired
	private FileManagerService fileManager;
	
	// 공연 추가 + 포스터 이미지 저장
	public boolean addFestival(Festival festival, MultipartFile posterImg, String name) {
		// 파일 업로드 => 경로
		String imagePath = null;
		if(!ObjectUtils.isEmpty(posterImg)) {
			imagePath = fileManager.saveFile(name, posterImg);
		} else {
			imagePath = "/images/★default file/no-image-found-360x250-1-300x208.png";
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
}
