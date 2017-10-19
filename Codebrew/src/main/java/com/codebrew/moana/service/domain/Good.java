package com.codebrew.moana.service.domain;

public class Good {

	private int goodNo;
	private int reviewNo;
	private String userId;
	
	
	public Good(){}


	public int getGoodNo() {
		return goodNo;
	}
	public void setGoodNo(int goodNo) {
		this.goodNo = goodNo;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	

	@Override
	public String toString() {
		return "Good [goodNo=" + goodNo + ", reviewNo=" + reviewNo + ", userId=" + userId + "]";
	}

}
