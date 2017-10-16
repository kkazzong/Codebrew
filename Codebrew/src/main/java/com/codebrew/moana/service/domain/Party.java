package com.codebrew.moana.service.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Party {

	//파티도메인 필드 추가
	///Field///
	private int partyNo;
	private String partyName;
	private Festival festival;
	private User user;
	private Date partyDate;
	private String partyTime;
	private String hour;
	private String minutes;
	private int partyMemberLimit;
	private MultipartFile uploadFile;
	private String partyImage;
	private String partyDetail;
	private String partyPlace;
	private int ticketCount;
	private int ticketPrice;
	private Date partyRegDate;
	private String deleteFlag;
	private double femalePercentage;
	private double malePercentage;
	private int femaleAgeAverage;
	private int maleAgeAverage;

	
	///Constructor///
	public Party() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
	///Method///
	public int getPartyNo() {
		return partyNo;
	}


	public String getPartyName() {
		return partyName;
	}


	public Festival getFestival() {
		return festival;
	}


	public User getUser() {
		return user;
	}


	public Date getPartyDate() {
		return partyDate;
	}


	public String getPartyTime() {
		return partyTime;
	}


	public String getHour() {
		return hour;
	}


	public String getMinutes() {
		return minutes;
	}


	public int getPartyMemberLimit() {
		return partyMemberLimit;
	}


	public MultipartFile getUploadFile() {
		return uploadFile;
	}


	public String getPartyImage() {
		return partyImage;
	}


	public String getPartyDetail() {
		return partyDetail;
	}


	public String getPartyPlace() {
		return partyPlace;
	}


	public int getTicketCount() {
		return ticketCount;
	}


	public int getTicketPrice() {
		return ticketPrice;
	}


	public Date getPartyRegDate() {
		return partyRegDate;
	}


	public String getDeleteFlag() {
		return deleteFlag;
	}


	public double getFemalePercentage() {
		return femalePercentage;
	}


	public double getMalePercentage() {
		return malePercentage;
	}


	public int getFemaleAgeAverage() {
		return femaleAgeAverage;
	}


	public int getMaleAgeAverage() {
		return maleAgeAverage;
	}


	public void setPartyNo(int partyNo) {
		this.partyNo = partyNo;
	}


	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}


	public void setFestival(Festival festival) {
		this.festival = festival;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public void setPartyDate(Date partyDate) {
		this.partyDate = partyDate;
	}


	public void setPartyTime(String partyTime) {
		this.partyTime = partyTime;
	}


	public void setHour(String hour) {
		this.hour = hour;
	}


	public void setMinutes(String minutes) {
		this.minutes = minutes;
	}


	public void setPartyMemberLimit(int partyMemberLimit) {
		this.partyMemberLimit = partyMemberLimit;
	}


	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}


	public void setPartyImage(String partyImage) {
		this.partyImage = partyImage;
	}


	public void setPartyDetail(String partyDetail) {
		this.partyDetail = partyDetail;
	}


	public void setPartyPlace(String partyPlace) {
		this.partyPlace = partyPlace;
	}


	public void setTicketCount(int ticketCount) {
		this.ticketCount = ticketCount;
	}


	public void setTicketPrice(int ticketPrice) {
		this.ticketPrice = ticketPrice;
	}


	public void setPartyRegDate(Date partyRegDate) {
		this.partyRegDate = partyRegDate;
	}


	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}


	public void setFemalePercentage(double femalePercentage) {
		this.femalePercentage = femalePercentage;
	}


	public void setMalePercentage(double malePercentage) {
		this.malePercentage = malePercentage;
	}


	public void setFemaleAgeAverage(int femaleAgeAverage) {
		this.femaleAgeAverage = femaleAgeAverage;
	}


	public void setMaleAgeAverage(int maleAgeAverage) {
		this.maleAgeAverage = maleAgeAverage;
	}


	@Override
	public String toString() {
		return "Party [partyNo=" + partyNo + ", partyName=" + partyName + ", festival=" + festival + ", user=" + user
				+ ", partyDate=" + partyDate + ", partyTime=" + partyTime + ", hour=" + hour + ", minutes=" + minutes
				+ ", partyMemberLimit=" + partyMemberLimit + ", partyImage=" + partyImage + ", partyDetail="
				+ partyDetail + ", partyPlace=" + partyPlace + ", ticketCount=" + ticketCount + ", ticketPrice="
				+ ticketPrice + ", partyRegDate=" + partyRegDate + ", deleteFlag=" + deleteFlag + ", femalePercentage="
				+ femalePercentage + ", malePercentage=" + malePercentage + ", femaleAgeAverage=" + femaleAgeAverage
				+ ", maleAgeAverage=" + maleAgeAverage + "]";
	}


	
	
}
