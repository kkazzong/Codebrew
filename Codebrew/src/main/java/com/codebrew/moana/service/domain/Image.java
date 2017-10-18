package com.codebrew.moana.service.domain;

public class Image {
	
	private int imageNo;
	private int reviewNo;
	private String reviewImage;
	
	public Image(){}
	
	
	public int getImageNo() {
		return imageNo;
	}
	public void setImageNo(int imageNo) {
		this.imageNo = imageNo;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public String getReviewImage() {
		return reviewImage;
	}
	public void setReviewImage(String reviewImage) {
		this.reviewImage = reviewImage;
	}

	@Override
	public String toString() {
		return "Image [imageNo=" + imageNo + ", reviewNo=" + reviewNo + ", reviewImage=" + reviewImage + "]";
	}
	
}
