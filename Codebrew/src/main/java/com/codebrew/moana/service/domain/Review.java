package com.codebrew.moana.service.domain;

import java.util.List;

public class Review {
		
	private int reviewNo;				// integer(raw) type : reviewNo(sequence)
	private String writerId;				// User Object
	private int festivalNo;			// Festival Object
	private List<Reply> reply;			// List of the replies
	private int checkCode;				// Flag : checkCode
	private String reviewTitle;			
	private int goodCount;				// how many 'like'
	private List<Image> reviewImage;	// 추가 : 가능하면 위의 1, 2, 3, 4, 5 삭제
	private int reviewFestivalRating;
	private String reviewVideo;
	private String reviewDetail;
	private List<Hashtag> hashtag;		// 추가 : 가능하면 위의 1, 2, 3 삭제
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

	public List<Reply> getReply() {
		return reply;
	}

	public void setReply(List<Reply> reply) {
		this.reply = reply;
	}

	public int getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(int checkCode) {
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

	public List<Hashtag> getHashtag() {
		return hashtag;
	}

	public void setHashtag(List<Hashtag> hashtag) {
		this.hashtag = hashtag;
	}

	public String getReviewRegDate() {
		return reviewRegDate;
	}

	public void setReviewRegDate(String reviewRegDate) {
		this.reviewRegDate = reviewRegDate;
	}
	
}
