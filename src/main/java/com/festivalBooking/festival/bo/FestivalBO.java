package com.festivalBooking.festival.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.festivalBooking.festival.dao.FestivalDAO;
import com.festivalBooking.festival.model.Festival;

@Service
public class FestivalBO {

	@Autowired
	private FestivalDAO festivalDAO;
	
	// 공연 추가
	public boolean addFestival(Festival festival) {
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
