package com.codebrew.moana.service.domain;

import java.util.List;

public class Review {
		
	private int reviewNo;				// integer(raw) type : reviewNo(sequence)
	private String writerId;				
	private int festivalNo;			 
	private String festivalName;
	private String festivalAddr;
	private List<Reply> reply;			// List of the replies
	private String checkCode;			// Flag : checkCode
	private String reviewTitle;			
	private int goodCount;				// how many 'like'
	private List<Image> reviewImage;
	private int reviewFestivalRating;
	private String reviewVideo;
	private String reviewDetail;
	private List<Hashtag> reviewHashtag;
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

	public String getWriterId() {
		return writerId;
	}

	public void setWriterId(String writerId) {
		this.writerId = writerId;
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

	public String getFestivalAddr() {
		return festivalAddr;
	}

	public void setFestivalAddr(String festivalAddr) {
		this.festivalAddr = festivalAddr;
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
	
	public List<Image> getReviewImage() {
		return reviewImage;
	}

	public void setReviewImage(List<Image> reviewImage) {
		this.reviewImage = reviewImage;
	}

	public int getReviewFestivalRating() {
		return reviewFestivalRating;
	}

	public void setReviewFestivalRating(int reviewFestivalRating) {
		this.reviewFestivalRating = reviewFestivalRating;
	}

	public String getReviewVideo() {
		return reviewVideo;
	}

	public void setReviewVideo(String reviewVideo) {
		this.reviewVideo = reviewVideo;
	}

	public String getReviewDetail() {
		return reviewDetail;
	}

	public void setReviewDetail(String reviewDetail) {
		this.reviewDetail = reviewDetail;
	}

	public List<Hashtag> getReviewHashtag() {
		return reviewHashtag;
	}

	public void setReviewHashtag(List<Hashtag> reviewHashtag) {
		this.reviewHashtag = reviewHashtag;
	}

	public String getReviewRegDate() {
		return reviewRegDate;
	}

	public void setReviewRegDate(String reviewRegDate) {
		this.reviewRegDate = reviewRegDate;
	}


	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", writerId=" + writerId + ", festivalNo=" + festivalNo
				+ ", festivalName=" + festivalName + ", festivalAddr=" + festivalAddr + ", reply=" + reply
				+ ", checkCode=" + checkCode + ", reviewTitle=" + reviewTitle + ", goodCount=" + goodCount
				+ ", reviewImage=" + reviewImage + ", reviewFestivalRating=" + reviewFestivalRating + ", reviewVideo="
				+ reviewVideo + ", reviewDetail=" + reviewDetail + ", reviewHashtag=" + reviewHashtag
				+ ", reviewRegDate=" + reviewRegDate + "]";
	}

	
}
