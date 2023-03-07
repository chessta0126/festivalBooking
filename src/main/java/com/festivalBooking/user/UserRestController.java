package com.festivalBooking.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.festivalBooking.common.EncryptUtils;
import com.festivalBooking.user.bo.UserBO;
import com.festivalBooking.user.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
		
		// 회원 정보 수정에 접근했다는 것은, 마이페이지의 로그인여부 확인 조건을 뚫었다는 것 -> Integer가 아닌 int로 해도 에러날 일 없음
		// 세션 만료 설정도 하지 않아 페이지에 접근된 상태로 중간에 로그아웃 될 일도 없다.
		
		// DB select (session을 이용하여 회원정보 받아오기)
		int userId = (int)session.getAttribute("userId");
		User user = userBO.getUserByUserId(userId);

		// 수정하지 않은 정보들은 null 처리
		
		// 이름은 파일이름 저장할 때 써야되므로 여기서 처리
		// 자료형 상관없이 null check 해주는(List 등) 방법
		// .equals("")는 String만 가능하며, 미입력은 null로 보내지지도 않기 때문에 이 방법을 사용하는 것이 낫다.
		if(ObjectUtils.isEmpty(changedName)) {
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
	
	// 회원 탈퇴
	@DeleteMapping("/delete")
	public Map<String, Object> deleteUser(@RequestParam int userId) {

		Map<String, Object> result = new HashMap<>();

		boolean isDeleteUserSuccess = userBO.deleteUserByUserId(userId);
		if(isDeleteUserSuccess) {
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "회원 탈퇴 실패");
		}
		
		return result;
	}
}
