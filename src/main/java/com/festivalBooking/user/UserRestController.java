package com.festivalBooking.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.festivalBooking.user.bo.UserBO;

@RestController
public class UserRestController {
	
	@Autowired
	UserBO userBO;
	
	
}
