package com.festivalBooking.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.festivalBooking.post.model.Post;

@Repository
public interface PostDAO {
	// 글 목록 가져오기(postType)
	public List<Post> selectPostListByPostType(String postType);
	
	/*
	 * // 글 작성(insert) public void insertPost(
	 * 
	 * @Param("userId") int userId ,@Param("postType") String postType
	 * ,@Param("postTitle") String postTitle ,@Param("content") String content);
	 */
	
	// 글 작성 post 형태로 보내기(insert)
		public void insertPost(Post post);
	
	// 글 번호로 글 가져오기(select)
	public Post selectPostByPostId(int postId);
	
	// 글 삭제(delete)
		public void deletePostByPostIdUserId(
				@Param("postId") int postId
				,@Param("postUserId") int postUserId);
}
