package com.festivalBooking.festival.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.festivalBooking.festival.model.Festival;

@Repository
public interface FestivalDAO {
	// 공연 추가
	// public boolean insertFestival(Festival festival);
	public boolean insertFestival(Festival festival);
	
	// 공연 목록 가져오기
	public List<Festival> getFestivalList();
	
	// 기간 내 공연 목록 가져오기
	public List<Festival> getFestivalListByLimit(
			@Param("startDate") String startDate
			, @Param("endDate") String endDate);
	
	// 내 공연 목록 가져오기
	public List<Festival> getFestivalListByUserId(int userId);
	
	// 공연 가져오기 (festivalId)
	public Festival getFestivalByFestivalId(int festivalId);
}
