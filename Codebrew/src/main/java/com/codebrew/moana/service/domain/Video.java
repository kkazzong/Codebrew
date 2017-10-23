package com.codebrew.moana.service.domain;

public class Video {
	
	private int videoNo;
	private int reviewNo;
	private String reviewVideo;
	
	public Video(){}

	public int getVideoNo() {
		return videoNo;
	}

	public void setVideoNo(int videoNo) {
		this.videoNo = videoNo;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public String getReviewVideo() {
		return reviewVideo;
	}

	public void setReviewVideo(String reviewVideo) {
		this.reviewVideo = reviewVideo;
	}

	@Override
	public String toString() {
		return "Video [videoNo=" + videoNo + ", reviewNo=" + reviewNo + ", reviewVideo=" + reviewVideo + "]";
	}
	

}
