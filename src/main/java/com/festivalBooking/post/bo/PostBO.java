package com.festivalBooking.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.festivalBooking.comment.bo.CommentBO;
import com.festivalBooking.post.dao.PostDAO;
import com.festivalBooking.post.model.Post;

@Service
public class PostBO {

	@Autowired
	private PostDAO postDAO;

	@Autowired
	private CommentBO commentBO;
	
	// 내가 작성한 글 목록(userId, postType)
	public List<Post> getPostListByUserIdPostType(int userId, String postType){
		return postDAO.selectPostListByUserIdPostType(userId, postType);
	}
	// 글 목록 가져오기(postType)
	public List<Post> getPostListByPostType(String postType){
		return postDAO.selectPostListByPostType(postType);
	}
	// 글 목록 가져오기(postType, limit)
	public List<Post> getPostListByPostTypeLimit(String postType, int limit){
		return postDAO.selectPostListByPostTypeLimit(postType,limit);
	}
	
	/*
	 * // 글 작성(insert) public void addPost(int userId, String postType, String
	 * postTitle, String content) { postDAO.insertPost(userId, postType, postTitle,
	 * content); }
	 */

	// 글 작성 post 형태로 보내기(insert)
	public void addPost(@ModelAttribute Post post) {
		postDAO.insertPost(post);
	}
	
	// 글 가져오기(select)
	public Post getPostByPostId(int postId) {
		return postDAO.selectPostByPostId(postId);
	}

	// 글 수정(Update)
	public void updatePost(int postId, String postUpdatedTitle, String updatedContent) {
		postDAO.updatePost(postId, postUpdatedTitle, updatedContent);
	}
	
	// 글 삭제(delete)
	public void deletePostByPostIdUserId(int postId,int postUserId) {
		// 글(post) 삭제 - DAO 메서드를 통해
		postDAO.deletePostByPostIdUserId(postId, postUserId);

		// 댓글(comment) 전체 삭제
		commentBO.deleteCommentsByPostId(postId);
		
		// 좋아요(like) 삭제
		
		// 조회수(view) 삭제
	}
	
}
