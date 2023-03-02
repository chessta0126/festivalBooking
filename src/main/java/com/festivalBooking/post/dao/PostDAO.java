package com.festivalBooking.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.festivalBooking.post.model.Post;

@Repository
public interface PostDAO {
	// 내가 작성한 글 목록 가져오기
	public List<Post> selectPostListByUserIdPostType(
			@Param("userId") int userId
			, @Param("postType") String postType);
	
	// 글 목록 가져오기(postType)
	public List<Post> selectPostListByPostType(String postType);

	// 페이징 - 글 목록 가져오기(postType,from,limit)
	public List<Post> selectPostListByPostTypeFromLimit(
			@Param("postType") String postType
			,@Param("from") int from
			,@Param("limit")  int limit);
	
	// 페이징 - 글의 총 개수(postType)
	public int selectPostCountByPostType(String postType);
	
	// 글 작성 post 형태로 보내기(insert)
		public void insertPost(Post post);
	
	// 글 번호로 글 가져오기(select)
	public Post selectPostByPostId(int postId);
	
	// 글 수정(Update)
	public void updatePost(
			@Param("postId") int postId
			, @Param("postUpdatedTitle") String postUpdatedTitle
			, @Param("updatedContent") String updatedContent);
	
	// 글 삭제(delete)
		public void deletePostByPostIdUserId(
				@Param("postId") int postId
				,@Param("postUserId") int postUserId);
}
