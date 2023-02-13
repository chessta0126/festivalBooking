package com.festivalBooking.comment.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.festivalBooking.comment.dao.CommentDAO;
import com.festivalBooking.comment.model.Comment;
import com.festivalBooking.comment.model.CommentView;
import com.festivalBooking.user.bo.UserBO;
import com.festivalBooking.user.model.User;

@Service
public class CommentBO {
	@Autowired
	private CommentDAO commentDAO;

	@Autowired
	private UserBO userBO;
	
	// 댓글 쓰기(누가(userId) / 어떤 글에(postId) / 뭘(comment))
	public boolean createComment(int userId, int postId, String comment) {
		return commentDAO.insertComment(userId, postId, comment);
	}

	// 글 하나에 달린 모든 댓글 가져오기(select)
	private List<Comment> getCommentListByPostId(int postId) {
		return commentDAO.selectCommentListByPostId(postId);
	}

	// 글 하나에 달린 모든 댓글 + 각 댓글마다 댓글쓴이 매칭
	// input: 글번호
	// output: 글번호에 해당하는 댓글목록(+댓글쓴이 정보)을 가져온다.
	public List<CommentView> generateCommentViewListByPostId(int postId) {
		// 결과물
		List<CommentView> commentViewList = new ArrayList<>();

		// 댓글 목록(위에서 만든 메서드)
		List<Comment> commentList = getCommentListByPostId(postId);
		
		// 반복문 => 각 CommentView(댓글-댓글쓴이 한 쌍) => 결과물에 넣는다.
		for(Comment comment : commentList) {
			CommentView commentView = new CommentView();
			
			// 댓글 1개
			commentView.setComment(comment);
			
			// 각 댓글 객체(Comment)에 저장되어 있는 댓글쓴이Id로 댓글쓴이 정보(User) 불러오기
			User user = userBO.getUserByUserId(comment.getUserId());
			commentView.setUser(user);
			
			// 댓글-댓글쓴이 1쌍 담기
			commentViewList.add(commentView);
		}
		// 결과물 리턴
		return commentViewList;
	}
	
	// 글 번호로 -> 소속된 댓글 삭제
	public void deleteCommentsByPostId(int postId) {
		commentDAO.deleteCommentsByPostId(postId);
	}
}
