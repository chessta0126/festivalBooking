package com.festivalBooking.user;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.festivalBooking.user.bo.UserBO;
import com.festivalBooking.user.model.User;

@SpringBootTest
class UserRestControllerTest {

	@Autowired
	UserBO userBO;
	
	@Test
	void test() {
		User user = userBO.getUserByLoginIdPassword("aaaa","aaaa");
		assertNotNull(user);
	}
	
	@Transactional // rollback -> 데이터 insert 기능을 수행하고 지워준다.(test 데이터이므로)
	@Test
	void userPlusTest() {
		MultipartFile file = null;
		userBO.addUser("bbbb","bbbb","테스트","test@test.com",file);
	}

}
