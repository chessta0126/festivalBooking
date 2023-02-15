package com.festivalBooking.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.festivalBooking.comment.model.Comment;

@Repository
public interface CommentDAO {
	// 댓글 쓰기(누가(userId) / 어떤 글에(postId) / 뭘(comment))
	public boolean insertComment(
			@Param("userId") int userId, 
			@Param("postId") int postId, 
			@Param("comment") String comment);

	// 글 하나에 달린 모든 댓글 가져오기(select)
	public List<Comment> selectCommentListByPostId(int postId);
	
	// 글 번호로 -> 소속된 댓글 삭제
	public void deleteCommentsByPostId(int postId);
	
	// 본인 댓글 1개 삭제
	public boolean deleteCommentByCommentId(int commentId);
}