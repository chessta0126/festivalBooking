package com.festivalBooking.comment.model;

import com.festivalBooking.user.model.User;

// 댓글과 댓글쓴이를 매칭해서 보여주도록 이어준다.
public class CommentView {
	// 댓글 1개
	private Comment comment;

	// 댓글쓴이
	private User user;

	public Comment getComment() {
		return comment;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}
