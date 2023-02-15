package com.festivalBooking.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.festivalBooking.post.dao.PostDAO;
import com.festivalBooking.post.model.Post;

@Service
public class PostBO {

	@Autowired
	private PostDAO postDAO;
	
	// 글 목록 가져오기(postType)
	public List<Post> getPostListByPostType(String postType){
		return postDAO.selectPostListByPostType(postType);
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

	// 글 삭제(delete)
	public void deletePostByPostIdUserId(int postId,int postUserId) {
		postDAO.deletePostByPostIdUserId(postId, postUserId);
	}
	
}
