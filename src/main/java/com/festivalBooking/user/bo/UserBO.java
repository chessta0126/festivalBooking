package com.festivalBooking.user.bo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.festivalBooking.common.FileManagerService;
import com.festivalBooking.user.dao.UserDAO;
import com.festivalBooking.user.model.User;

@Service
public class UserBO {

	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private FileManagerService fileManager;
	
	// 테스트
	public List<Map<String,Object>> getUserListTest(){
		return userDAO.selectUserListTest();
	}
	
	// 중복 확인
	public boolean existLoginId(String loginId) {
		return userDAO.existLoginId(loginId);
	}
	
	// 회원가입
	public void addUser(String name, String loginId,String hashedPassword,String email, MultipartFile profileImageUrl) {
		
		// 파일 업로드 => 경로
		String imagePath = null;
		if(profileImageUrl != null) {
			imagePath = fileManager.saveFile(name, profileImageUrl);
		} else {
			imagePath = "/images/★default file/default profileImage.jpg";
		}
				
		// DAO insert
		userDAO.insertUser(name, loginId, hashedPassword, email, imagePath);
	}
	
	// 로그인
	public User getUserByLoginIdPassword(String loginId, String password) {
		return userDAO.selectUserByLoginIdPassword(loginId, password);
	}
	
	// userId로 회원정보 꺼내기
	public User getUserByUserId(Integer userId) {
		return userDAO.selectUserByUserId(userId);
	}
}