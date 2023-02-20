package com.festivalBooking.festival;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.festivalBooking.festival.bo.FestivalBO;
import com.festivalBooking.festival.model.Festival;

@RequestMapping("/festival")
@RestController
public class FestivalRestController {

	@Autowired
	private FestivalBO festivalBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@ModelAttribute Festival festival){
		
		Map<String, Object> result = new HashMap<>();
		boolean isfestivalCreateSuccess = festivalBO.addFestival(festival);
		if(isfestivalCreateSuccess) {
			result.put("code", 1);		
			result.put("result", true);
		} else {
			result.put("code", 500);		
			result.put("result", false);
		}
		return result;
	}
}
