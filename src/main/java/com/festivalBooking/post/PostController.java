package com.festivalBooking.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.festivalBooking.post.bo.PostBO;
import com.festivalBooking.post.model.Post;
import com.festivalBooking.user.bo.UserBO;
import com.festivalBooking.user.model.User;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/post")
@Controller
public class PostController {

	@Autowired
	private PostBO postBO;

	@Autowired
	private UserBO userBO;
	
	// 글 목록 화면
	// http://localhost:8080/post/postList?postType={postType}
	@RequestMapping(value="/postList", method=RequestMethod.GET)
	public String postList(String postType, Model model) {
		
		List<Post> postList = postBO.getPostListByPostType(postType);
		
		model.addAttribute("viewName","post/postList");
		model.addAttribute("postList",postList);
		model.addAttribute("postType",postType);
		
		return "template/layout";
	}
	
	// 글쓰기 화면
	// http://localhost:8080/post/post_create_view?postType={postType}
	@GetMapping("/post_create_view")
	public String postCreateView(
			@RequestParam("postType") String postType
			, Model model, HttpSession session) {
		
		model.addAttribute("viewName","post/postCreate");
		model.addAttribute("postType",postType);
		
		// 누가 작성한 글인지 알아야 함
		Integer userId = (Integer)session.getAttribute("userId");
		User user = userBO.getUserByUserId(userId);
		model.addAttribute("user",user);
		
		return "template/layout";
	}

	// 글 상세 화면
	// http://localhost:8080/post/post_detail_view?postType={postType}&postId=${postId}
	@GetMapping("/post_detail_view")
	public String postDetailView(
			@RequestParam("postType") String postType
			, @RequestParam("postId") int postId
			, Model model, HttpSession session) {
		
		model.addAttribute("viewName","post/postDetail");
		
		// 어떤 글인지 알아야 함
		Post post = postBO.getPostByPostId(postId);
		model.addAttribute("post",post);

		// 누가 작성한 글인지 알아야 함 (비로그인 상태일 수 있고, 내가 쓴게 아닐 수 있으므로-> session에서 뽑아오면 안 됨)
		int postUserId = post.getUserId();
		User postUser = userBO.getUserByUserId(postUserId);
		// 작성자 이름(그 외의 작성자 회원정보는 보안 우려가 있기 때문에, 내려주지 않는다.)
		model.addAttribute("postUserName",postUser.getName());

		// 댓글 가져오기
		
		return "template/layout";
	}
}