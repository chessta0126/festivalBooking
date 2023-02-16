package com.festivalBooking.post;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.festivalBooking.comment.bo.CommentBO;
import com.festivalBooking.comment.model.CommentView;
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

	@Autowired
	private CommentBO commentBO;
	
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
	
	// 글쓰기, 수정 화면
	// http://localhost:8080/post/post_create_view?postType={postType}&isUpdate=${isUpdate}&postId=${postId}
	@GetMapping("/post_create_view")
	public String postCreateView(
			@RequestParam("postType") String postType
			, @RequestParam("isUpdate") boolean isUpdate
			, @RequestParam(value="postId", required=false) Integer postId
			, Model model, HttpSession session) {
		
		model.addAttribute("viewName","post/postCreate");
		model.addAttribute("postType",postType);
		
		// 누가 작성한 글인지 알아야 함
		Integer userId = (Integer)session.getAttribute("userId");
		User user = userBO.getUserByUserId(userId);
		model.addAttribute("user",user);
		
		// 글 수정(update)인지, 글 작성(insert)인지 파악(화면 공유)
		if(isUpdate) { // 글 수정일 경우
			model.addAttribute("isUpdate",true);			
			model.addAttribute("postId",postId);			
		} else {
			model.addAttribute("isUpdate",false);
			// 그냥 글쓰기로 접근했을 때, ${postId}가 존재하지 않으므로 에러가 떠버림 -> 일단 0으로 둔다.
			// insert할 때 postId는 넘기지 않으니 괜찮다.
			model.addAttribute("postId",0);		
		}
		return "template/layout";
	}

	// 글 상세 화면(글, 댓글 내려주기)
	// http://localhost:8080/post/post_detail_view?postType={postType}&postId=${postId}
	@GetMapping("/post_detail_view")
	public String postDetailView(
			@RequestParam("postType") String postType
			, @RequestParam("postId") int postId
			, Model model) {
		
		model.addAttribute("viewName","post/postDetail");
		
		// 어떤 글인지 알아야 함
		Post post = postBO.getPostByPostId(postId);
		model.addAttribute("post",post);

		// 누가 작성한 글인지 알아야 함 (비로그인 상태일 수 있고, 내가 쓴게 아닐 수 있으므로-> session에서 뽑아오면 안 됨)
		int postUserId = post.getUserId();
		User postUser = userBO.getUserByUserId(postUserId);
		// 작성자 이름,userId(그 외의 작성자 회원정보는 보안 우려가 있기 때문에, 내려주지 않는다.)
		model.addAttribute("postUserName",postUser.getName());
		model.addAttribute("postUserId",postUser.getId());

		// 댓글 가져오기 (댓글쓴이-댓글이 매칭되어 있는 commentView 형태의 List)
		List<CommentView> commentViewList = commentBO.generateCommentViewListByPostId(postId);
		model.addAttribute("commentViewList",commentViewList);
		
		return "template/layout";
	}
}