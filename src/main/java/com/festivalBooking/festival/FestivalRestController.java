package com.festivalBooking.festival;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.festivalBooking.festival.bo.FestivalBO;
import com.festivalBooking.festival.model.Festival;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/festival")
@RestController
public class FestivalRestController {

	@Autowired
	private FestivalBO festivalBO;
	
	// 공연 등록
	@PostMapping(value="/create", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
	public Map<String, Object> create(
			@ModelAttribute Festival festival
			,@RequestParam(value="posterImg",required = false) MultipartFile posterImg
			,HttpSession session){
		
		// 파일 이름 만들 때 BO 에서 필요
		String name = (String)session.getAttribute("userName");
		
		// DB insert
		boolean isfestivalCreateSuccess = festivalBO.addFestival(festival, posterImg, name);

		Map<String, Object> result = new HashMap<>();
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
