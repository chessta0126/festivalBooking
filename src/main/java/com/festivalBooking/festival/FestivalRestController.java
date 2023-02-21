package com.festivalBooking.festival;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.festivalBooking.festival.bo.FestivalBO;
import com.festivalBooking.festival.model.Festival;
import com.festivalBooking.post.model.Post;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/festival")
@RestController
public class FestivalRestController {

	@Autowired
	private FestivalBO festivalBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@ModelAttribute Festival festival
			,@RequestParam("userId") int userId
			,@RequestParam("title") String title
			,@RequestParam("date") String date
			,@RequestParam("startTime") String startTime
			,@RequestParam("endTime") String endTime
			,@RequestParam("place") String place
			,@RequestParam(value="address",required = false) String address
			,@RequestParam("price") int price
			,@RequestParam("priceOffline") int priceOffline
			,@RequestParam(value="imagePath",required = false) MultipartFile imagePath
			,@RequestParam(value="lineUp",required = false) String lineUp
			,@RequestParam(value="explain",required = false) String explain
			,@RequestParam(value="warning",required = false) String warning
			,@RequestParam("festivalMaster") String festivalMaster
			,@RequestParam("askRoot") String askRoot
			,@RequestParam("isTimeOver") String isTimeOver
			,HttpSession session){
		String name = (String)session.getAttribute("userName");
		boolean isTimeOver2 = true;
		if(isTimeOver.equals(true)) {
			isTimeOver2 = true;
		} else{
			isTimeOver2 = false;
		}
		Map<String, Object> result = new HashMap<>();
		boolean isfestivalCreateSuccess = festivalBO.addFestival(
				userId, title, date, startTime, endTime, place, address, price, priceOffline, 
				imagePath, lineUp, explain, warning, festivalMaster, askRoot, isTimeOver2, name);
		if(isfestivalCreateSuccess) {
			result.put("code", 1);		
			result.put("result", true);
			
			// 성공 시 공연 상세(festivalDetail) 화면으로 이동하기 위한 파라미터 Json으로 전송
			result.put("festivalId", festival.getId());
		} else {
			result.put("code", 500);		
			result.put("result", false);
		}
		return result;
	}
}
