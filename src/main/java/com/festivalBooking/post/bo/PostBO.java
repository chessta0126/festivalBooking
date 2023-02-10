package com.festivalBooking.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	// 글 작성(insert)
	public void addPost(int userId, String postType, String postTitle, String content) {
		postDAO.insertPost(userId, postType, postTitle, content);;
	}}
