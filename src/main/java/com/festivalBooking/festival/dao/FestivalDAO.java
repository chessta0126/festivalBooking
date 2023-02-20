package com.festivalBooking.festival.dao;

import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.festivalBooking.festival.model.Festival;

@Repository
public interface FestivalDAO {
	// 공연 추가
	public boolean insertFestival(Festival festival);
}
