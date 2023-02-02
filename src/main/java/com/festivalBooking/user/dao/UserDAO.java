package com.festivalBooking.user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.festivalBooking.user.model.User;

@Repository
public interface UserDAO {
	
	public List<Map<String,Object>> selectUserListTest();
	
	public void insertUser(
			@Param("name") String name
			,@Param("loginId") String loginId
			,@Param("password") String password
			,@Param("email") String email
			, @Param("imagePath") String imagePath);

	public User selectUserByLoginIdPassword(
			@Param("loginId") String loginId
			,@Param("password") String password);
}
