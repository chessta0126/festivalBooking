package com.festivalBooking.festival.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

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
}
