package com.festivalBooking.post.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.festivalBooking.post.model.Post;

@Repository
public interface PostDAO {
	// 글 목록 가져오기(postType)
	public List<Post> selectPostListByPostType(String postType);
	
	// 글 작성(insert)
	public void insertPost(
			@Param("userId") int userId
			,@Param("postType") String postType
			,@Param("postTitle") String postTitle
			,@Param("content") String content);
	
	// 글 번호로 글 가져오기(select)
	public Post selectPostByPostId(int postId);
}
