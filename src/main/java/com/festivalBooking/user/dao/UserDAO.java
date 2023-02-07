package com.festivalBooking.user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.festivalBooking.user.model.User;

@Repository
public interface UserDAO {
	
	// 테스트
	public List<Map<String,Object>> selectUserListTest();
	
	// 중복 확인
	public boolean existLoginId(String loginId);
	
	// 회원가입
	public void insertUser(
			@Param("name") String name
			,@Param("loginId") String loginId
			,@Param("password") String password
			,@Param("email") String email
			, @Param("imagePath") String imagePath);

	// 로그인
	public User selectUserByLoginIdPassword(
			@Param("loginId") String loginId
			,@Param("password") String password);
	
	// userId로 회원정보 꺼내기
	public User selectUserByUserId(Integer userId);
}
