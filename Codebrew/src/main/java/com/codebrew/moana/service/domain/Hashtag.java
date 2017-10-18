package com.codebrew.moana.service.domain;

public class Hashtag {
	
	private int hashtagNo;
	private int reviewNo;
	private String hashtagDetail;
	
	
	public Hashtag(){}
	
	public int getHashtagNo() {
		return hashtagNo;
	}
	public void setHashtagNo(int hashtagNo) {
		this.hashtagNo = hashtagNo;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public String getHashtagDetail() {
		return hashtagDetail;
	}
	public void setHashtagDetail(String hashtagDetail) {
		this.hashtagDetail = hashtagDetail;
	}
	
	
	@Override
	public String toString() {
		return "Hashtag [hastagNo=" + hashtagNo + ", reviewNo=" + reviewNo + ", hashtagDetail=" + hashtagDetail + "]";
	}
	
}
