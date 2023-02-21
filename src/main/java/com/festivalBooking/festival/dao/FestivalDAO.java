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
	public boolean insertFestival(
			@Param("userId") int userId
			, @Param("title") String title
			, @Param("date") String date
			, @Param("startTime") String startTime
			, @Param("endTime") String endTime
			, @Param("place") String place
			, @Param("address") String address
			, @Param("price") int price
			, @Param("priceOffline") int priceOffline
			, @Param("imagePath") String imagePath
			, @Param("lineUp") String lineUp
			, @Param("explain") String explain
			, @Param("warning") String warning
			, @Param("festivalMaster") String festivalMaster
			, @Param("askRoot") String askRoot
			, @Param("isTimeOver") boolean isTimeOver);
	
	// 공연 목록 가져오기
	public List<Festival> getFestivalList();
	
	// 공연 가져오기 (festivalId)
	public Festival getFestivalByFestivalId(int festivalId);
}
