package com.festivalBooking.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@RequestMapping("/user")
@Controller
public class UserController {

	/**
	 * 회원가입 API
	 * @param model
	 * @return
	 */
	// http://localhost:8080/user/sign_up_view
	@GetMapping("/sign_up_view")
	public String signUpView(Model model) {
		model.addAttribute("viewName","user/signUp");
		
		return "template/layout";
	}

	/**
	 * 로그인 API
	 * @param model
	 * @return
	 */
	// http://localhost:8080/user/sign_in_view
	@GetMapping("/sign_in_view")
	public String signInView(Model model) {
		model.addAttribute("viewName","user/signIn");
		
		return "template/layout";
	}

	/**
	 * 로그아웃 API(로그인 페이지로 이동)
	 * @param session
	 * @return
	 */
	// http://localhost:8080/user/sign_out
	@GetMapping("/sign_out")
	public String signOut(HttpSession session) {
		session.removeAttribute("userId");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userName");

		return "redirect:/user/sign_in_view"; // 로그아웃 후 로그인 페이지로 redirect
	}
	
	/**
	 * 로그아웃 API(메인 페이지로 이동)
	 * @param session
	 * @return
	 */
	// http://localhost:8080/user/sign_out_main
		@GetMapping("/sign_out_main")
		public String signOutMain(HttpSession session) {
			session.removeAttribute("userId");
			session.removeAttribute("userLoginId");
			session.removeAttribute("userName");

			return "redirect:/main/main_view";
			// 로그아웃 후 main으로 redirect
		}
}
