package com.codebrew.moana.service.domain;

public class Weather {
	
	private String baseDate;
	private String baseTime;
	private String fcstDate;
	private String fcstTime;
	private String category;
	private String fcstValue;
	private String nx;
	private String ny;
	
	public Weather() {
		super();
	}

	public String getBaseDate() {
		return baseDate;
	}

	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}

	public String getBaseTime() {
		return baseTime;
	}

	public void setBaseTime(String baseTime) {
		this.baseTime = baseTime;
	}

	public String getFcstDate() {
		return fcstDate;
	}

	public void setFcstDate(String fcstDate) {
		this.fcstDate = fcstDate;
	}

	public String getFcstTime() {
		return fcstTime;
	}

	public void setFcstTime(String fcstTime) {
		this.fcstTime = fcstTime;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getFcstValue() {
		return fcstValue;
	}

	public void setFcstValue(String fcstValue) {
		this.fcstValue = fcstValue;
	}

	public String getNx() {
		return nx;
	}

	public void setNx(String nx) {
		this.nx = nx;
	}

	public String getNy() {
		return ny;
	}

	public void setNy(String ny) {
		this.ny = ny;
	}

	@Override
	public String toString() {
		return "Weather [baseDate=" + baseDate + ", baseTime=" + baseTime + ", fcstDate=" + fcstDate + ", fcstTime="
				+ fcstTime + ", category=" + category + ", fcstValue=" + fcstValue + ", nx=" + nx + ", ny=" + ny + "]";
	}
	
	
	
	
	

}
