package com.codebrew.moana.service.domain;

import java.util.List;

public class Review {
		
	private int reviewNo;				// integer(raw) type : reviewNo(sequence)
	private String userId;				// userId : from User(auto)
	private int festivalNo;			 	// festivalNo : from Festival(auto)
	private String festivalName;		// festivalName : from Festival(auto)
	private String addr;				// addr :  from Festival(auto)
	private List<Reply> reply;			// List of the replies
	private String checkCode;			// Flag : checkCode
	private String reviewTitle;			
	private int goodCount;				// how many 'like'
	private List<Image> reviewImageList;
	private int reviewFestivalRating;
	private List<Video> reviewVideoList;
	private String reviewDetail;
	private List<Hashtag> reviewHashtagList;
	private String reviewRegDate;
	
	
	///Generator
	public Review(){
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
	
	public int getFestivalNo() {
		return festivalNo;
	}

	public void setFestivalNo(int festivalNo) {
		this.festivalNo = festivalNo;
	}
	
	public String getFestivalName() {
		return festivalName;
	}

	public void setFestivalName(String festivalName) {
		this.festivalName = festivalName;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public List<Reply> getReply() {
		return reply;
	}

	public void setReply(List<Reply> reply) {
		this.reply = reply;
	}

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	public String getReviewTitle() {
		return reviewTitle;
	}

	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}

	public int getGoodCount() {
		return goodCount;
	}

	public void setGoodCount(int goodCount) {
		this.goodCount = goodCount;
	}
	
	public List<Image> getReviewImageList() {
		return reviewImageList;
	}

	public void setReviewImageList(List<Image> reviewImageList) {
		this.reviewImageList = reviewImageList;
	}

	public int getReviewFestivalRating() {
		return reviewFestivalRating;
	}

	public void setReviewFestivalRating(int reviewFestivalRating) {
		this.reviewFestivalRating = reviewFestivalRating;
	}

	public List<Video> getReviewVideoList() {
		return reviewVideoList;
	}


	public void setReviewVideoList(List<Video> reviewVideoList) {
		this.reviewVideoList = reviewVideoList;
	}

	public String getReviewDetail() {
		return reviewDetail;
	}

	public void setReviewDetail(String reviewDetail) {
		this.reviewDetail = reviewDetail;
	}

	public List<Hashtag> getReviewHashtagList() {
		return reviewHashtagList;
	}

	public void setReviewHashtagList(List<Hashtag> reviewHashtagList) {
		this.reviewHashtagList = reviewHashtagList;
	}

	public String getReviewRegDate() {
		return reviewRegDate;
	}

	public void setReviewRegDate(String reviewRegDate) {
		this.reviewRegDate = reviewRegDate;
	}


	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", userId=" + userId + ", festivalNo=" + festivalNo + ", festivalName="
				+ festivalName + ", addr=" + addr + ", reply=" + reply + ", checkCode=" + checkCode + ", reviewTitle="
				+ reviewTitle + ", goodCount=" + goodCount + ", reviewImageList=" + reviewImageList
				+ ", reviewFestivalRating=" + reviewFestivalRating + ", reviewVideoList=" + reviewVideoList
				+ ", reviewDetail=" + reviewDetail + ", reviewHashtagList=" + reviewHashtagList + ", reviewRegDate="
				+ reviewRegDate + "]";
	}

	
}
