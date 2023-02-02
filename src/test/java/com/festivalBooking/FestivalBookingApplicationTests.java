package com.festivalBooking;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.util.ObjectUtils;

@SpringBootTest
class FestivalBookingApplicationTests {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// 단축키 : alt + shift + x , t
	@Test
	void contextLoads() {
		logger.info("####### Logger test");
	}
	
	@Test
	void plusTest() {
		logger.info("++++++++ plus test");
		int a = 10;
		int b = 20;
		
		assertEquals(30, a+b); // 같을 때 초록색이 뜸
	}
	
	@Test
	void nullCheck() {
		String a = null;
		if(ObjectUtils.isEmpty(a)) {
			logger.info("비어있음");
		} else {
			logger.info("비어있지 않다.");
		}
		
		List<String> list = null;
		logger.info(ObjectUtils.isEmpty(list)+"");
	}

}
