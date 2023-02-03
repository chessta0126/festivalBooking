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

@RequestMapping("/user")
@RestController
public class UserRestController {
	
	@Autowired
	UserBO userBO;
	
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
		,@RequestParam(value="profileImageUrl", required=false) MultipartFile profileImageUrl
			){
		// 비밀번호 해싱 - mb5
		// 복호화 불가
		String hashedPassword = EncryptUtils.md5(password);

		// DB insert
		userBO.addUser(name, loginId, hashedPassword, email, profileImageUrl);

		// DB에 안 들어가고 문제 생기면 위에서 에러가 뜨므로, 여기까지 내려왔다는 건 성공했다는 뜻

		Map<String, Object> result = new HashMap<>();
			result.put("code", 1);		
			result.put("result", "성공");
			
		return result;
	}
}
