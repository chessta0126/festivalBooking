package com.festivalBooking.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.festivalBooking.user.bo.UserBO;

@Controller
public class TestController {
	@Autowired
	private UserBO userBO;
	
	// 1. String 문장 확인 : @ResponseBody + String return
	// http://localhost:8080/test1
	@GetMapping("/test1")
	@ResponseBody
	public String test1() {
		return "Hello World!";
	}
	
	// 2. JSON 확인 : @ResponseBody + String return
	// http://localhost:8080/test2
	@GetMapping("/test2")
	@ResponseBody
	public Map<String,Object> test2() {
		Map<String,Object> result = new HashMap<>();
		result.put("key1", 111);
		result.put("key2", 222);
		result.put("key3", 333);

		return result;
	}
	
	// 3. JSP 동작 확인 : String return
	@GetMapping("/test3")
	public String test3() {
		return "test/test";
	}

	// 4. DB 연동 확인 : 어노테이션 제거, DB 설정 java, yml 접속정보 추가, config, logback.xml
	@GetMapping("/test4")
	@ResponseBody
	public List<Map<String,Object>> test4() {
		return userBO.getUserListTest();
	}
}
