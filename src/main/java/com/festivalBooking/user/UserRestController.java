package com.festivalBooking.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.festivalBooking.common.EncryptUtils;
import com.festivalBooking.user.bo.UserBO;
import com.festivalBooking.user.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RequestMapping("/user")
@RestController
public class UserRestController {
	
	@Autowired
	private UserBO userBO;
	
	@GetMapping("/is_duplicated_name")
	public Map<String, Object> isDuplicatedName(
			@RequestParam("name") String name) {
		
		Map<String, Object> result = new HashMap<>();
		boolean isDuplicated = userBO.existName(name);
		if(isDuplicated) { // 중복
			result.put("code", 1);		
			result.put("result", true);
		} else { // 사용 가능
			result.put("code", 1);		
			result.put("result", false);
		}
		return result;
	}

	@GetMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		
		Map<String, Object> result = new HashMap<>();
		boolean isDuplicated = userBO.existLoginId(loginId);
		if(isDuplicated) { // 중복
			result.put("code", 1);		
			result.put("result", true);
		} else { // 사용 가능
			result.put("code", 1);		
			result.put("result", false);
		}
		return result;
	}
	
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(
		@RequestParam("name") String name
		,@RequestParam("loginId") String loginId
		,@RequestParam("password") String password
		,@RequestParam("email") String email
		,@RequestParam(value="file", required=false) MultipartFile file
			){
		// 비밀번호 해싱 - mb5
		// 복호화 불가
		String hashedPassword = EncryptUtils.md5(password);

		// DB insert
		userBO.addUser(name, loginId, hashedPassword, email, file);

		// DB에 안 들어가고 문제 생기면 위에서 에러가 뜨므로, 여기까지 내려왔다는 건 성공했다는 뜻

		Map<String, Object> result = new HashMap<>();
			result.put("code", 1);		
			result.put("result", "성공");
			
		return result;
	}

	@PostMapping("/sign_in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId
			,@RequestParam("password") String password
			, HttpServletRequest request
			){
		// 비밀번호 해싱 - mb5
		String hashedPassword = EncryptUtils.md5(password);
		
		// DB select
		User user = userBO.getUserByLoginIdPassword(loginId, hashedPassword);
		
		Map<String, Object> result = new HashMap<>();
		if(user != null) {
			// 행이 있으면 로그인
			result.put("code", 1);
			result.put("result", "성공");
			
			// 세션에 유저 정보를 담는다. (로그인 상태 유지)
			HttpSession session = request.getSession();
			session.setAttribute("userId", user.getId());
			session.setAttribute("userName", user.getName());
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userProfileImageUrl", user.getProfileImageUrl());
		} else {
			// 행이 없으면 로그인 실패
			result.put("code", 500);
			result.put("errorMessage", "존재하지 않는 사용자입니다.");
		}
		
		return result;
	}
	
	@PostMapping("/update_user")
	public Map<String, Object> updateUser(
		@RequestParam(value="changedName", required=false) String changedName
		,@RequestParam(value="changedLoginId", required=false) String changedLoginId
		,@RequestParam(value="changedPassword", required=false) String changedPassword
		,@RequestParam(value="changedEmail", required=false) String changedEmail
		,@RequestParam(value="changedFile", required=false) MultipartFile changedFile
		,HttpSession session
			) {
		// 모두 비필수 파라미터로 설정. 비어있을 경우 null로 넘어가도록 설정(미입력은 null과 다르다)
		
		// DB select (session을 이용하여 회원정보 받아오기)
		Integer userId = (Integer)session.getAttribute("userId");
		User user = userBO.getUserByUserId(userId);

		// 수정하지 않은 정보들은 null 처리
		
		// 이름은 파일이름 저장할 때 써야되므로 여기서 처리
		if(changedName.equals("")) {
			changedName = user.getName();
		}
		
		if(changedLoginId.equals("")) {
			changedLoginId = null;
		}

		String hashedPassword = null;
		if(!changedPassword.equals("")) {
			// 비밀번호 해싱 - mb5
			hashedPassword = EncryptUtils.md5(changedPassword);
		}
		
		if(changedEmail.equals("")) {
			changedEmail = null;
		}
		
		// changedFile은 없으면 그냥 끝까지 null로 보내서 DB에서 조건문으로 null이 아닐 경우에만 업데이트
		
		// -> 쓸데없는 기존 정보 업데이트를 줄이기 위해 그냥 DB까지 null로 넘겨서 DB조건문으로 null이 아닌 것만 선별적 Update
		
		boolean isUpdateSuccess = userBO.updateUserByUserId(userId, changedName, changedLoginId, hashedPassword, changedEmail, changedFile);
		
		Map<String, Object> result = new HashMap<>();
		
		if(isUpdateSuccess) { // 수정 성공
			result.put("code", 1);		
			result.put("result", true);
		} else { // 수정 실패
			result.put("code", 1);		
			result.put("result", false);
		}
		
		return result;
	}
}
