package com.festivalBooking.myPage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.festivalBooking.festival.bo.FestivalBO;
import com.festivalBooking.festival.model.Festival;
import com.festivalBooking.post.bo.PostBO;
import com.festivalBooking.post.model.Post;
import com.festivalBooking.user.bo.UserBO;
import com.festivalBooking.user.model.User;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/myPage")
@Controller
public class myPageController {
	@Autowired
	private UserBO userBO;

	@Autowired
	private PostBO postBO;
	
	@Autowired
	private FestivalBO festivalBO;

	/**
	 * 마이페이지 API
	 * @param model
	 * @param session
	 * @return
	 */
	// http://localhost:8080/myPage/myPage_view
	@GetMapping("/myPage_view")
	public String myPageView(Model model, HttpSession session) {
		Integer userId = (Integer)session.getAttribute("userId");
		// 로그인 시 마이페이지로, 비로그인 시 로그인 페이지로 이동
		if(userId != null) {
			User userInfo = userBO.getUserByUserId(userId);
			model.addAttribute("viewName","myPage/myPage");
			model.addAttribute("userInfo",userInfo);
		} else {
			model.addAttribute("viewName","user/signIn");
		}
		
		return "template/layout";
	}

	/**
	 * 내가 작성한 글, 등록한 공연 API
	 * @param model
	 * @param session
	 * @return
	 */
	// http://localhost:8080/myPage/myPost_myFestival_view
	@GetMapping("/myPost_myFestival_view")
	public String myPostMyFestivalView(Model model, HttpSession session) {
		Integer userId = (Integer)session.getAttribute("userId");
		// 로그인 시 마이페이지로, 비로그인 시 로그인 페이지로 이동
		if(userId != null) {
			// 내가 작성한 글, 등록한 공연 페이지로 이동
			model.addAttribute("viewName","myPage/myPostMyFestival");

			// 내 글 목록 - 공지사항
			String postType = "공지사항";
			List<Post> myPostListAlert = postBO.getPostListByUserIdPostType(userId,postType);
			model.addAttribute("myPostListAlert",myPostListAlert);
			
			// 내 글 목록 - 자유게시판
			postType = "자유게시판";
			List<Post> myPostListCommunity = postBO.getPostListByUserIdPostType(userId,postType);
			model.addAttribute("myPostListCommunity",myPostListCommunity);
			
			// 내 공연 목록
			List<Festival> myFestivalList = festivalBO.getFestivalListByUserId(userId);
			model.addAttribute("myFestivalList",myFestivalList);
		} else {
			model.addAttribute("viewName","user/signIn");
		}
		
		return "template/layout";
	}
	
}
