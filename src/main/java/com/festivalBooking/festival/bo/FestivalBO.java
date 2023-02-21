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
		return festivalDAO.getFestivalList();
	}

	// 공연 가져오기 (festivalId)
	public Festival getFestivalByFestivalId(int festivalId) {
		return festivalDAO.getFestivalByFestivalId(festivalId);
	}
}
