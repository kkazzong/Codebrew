package com.codebrew.moana.service.domain;

public class Reply {

	private int replyNo;
	private String userId;
	private int reviewNo;
	private String replyDetail;
	private String replyRegDate;
	
	
	///Generator
	public Reply(){}
	
	
	///get, set Method
	public int getReplyNo() {
		return replyNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public String getReplyDetail() {
		return replyDetail;
	}

	public void setReplyDetail(String replyDetail) {
		this.replyDetail = replyDetail;
	}

	public String getReplyRegDate() {
		return replyRegDate;
	}

	public void setReplyRegDate(String replyRegDate) {
		this.replyRegDate = replyRegDate;
	}

	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	
}
