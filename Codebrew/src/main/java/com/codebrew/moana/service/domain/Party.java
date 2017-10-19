package com.codebrew.moana.service.domain;

import org.springframework.web.multipart.MultipartFile;

public class Party {

	///Field///
	private int partyNo;
	private String partyFlag;
	private String partyName;
	private String partyDate;
	private String partyTime;
	private String hour;
	private String minutes;
	private int partyMemberLimit;
	private MultipartFile uploadFile;
	private String partyImage;
	private String partyDetail;
	private String partyPlace;
	private String partyRegDate;
	private String deleteFlag;
	
	private float femalePercentage;
	private float malePercentage;
	private int femaleAgeAverage;
	private int maleAgeAverage;
	
	private Festival festival;
	private User user;
	
	private int ticketCount;
	private int ticketPrice;

	
	///Constructor///
	public Party() {
		super();
		// TODO Auto-generated constructor stub
	}


	///Method///
	public int getPartyNo() {
		return partyNo;
	}


	public String getPartyFlag() {
		return partyFlag;
	}


	public String getPartyName() {
		return partyName;
	}


	public String getPartyDate() {
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


	public String getPartyRegDate() {
		return partyRegDate;
	}


	public String getDeleteFlag() {
		return deleteFlag;
	}


	public float getFemalePercentage() {
		return femalePercentage;
	}


	public float getMalePercentage() {
		return malePercentage;
	}


	public int getFemaleAgeAverage() {
		return femaleAgeAverage;
	}


	public int getMaleAgeAverage() {
		return maleAgeAverage;
	}


	public Festival getFestival() {
		return festival;
	}


	public User getUser() {
		return user;
	}


	public int getTicketCount() {
		return ticketCount;
	}


	public int getTicketPrice() {
		return ticketPrice;
	}


	public void setPartyNo(int partyNo) {
		this.partyNo = partyNo;
	}


	public void setPartyFlag(String partyFlag) {
		this.partyFlag = partyFlag;
	}


	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}


	public void setPartyDate(String partyDate) {
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


	public void setPartyRegDate(String partyRegDate) {
		this.partyRegDate = partyRegDate;
	}


	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}


	public void setFemalePercentage(float femalePercentage) {
		this.femalePercentage = femalePercentage;
	}


	public void setMalePercentage(float malePercentage) {
		this.malePercentage = malePercentage;
	}


	public void setFemaleAgeAverage(int femaleAgeAverage) {
		this.femaleAgeAverage = femaleAgeAverage;
	}


	public void setMaleAgeAverage(int maleAgeAverage) {
		this.maleAgeAverage = maleAgeAverage;
	}


	public void setFestival(Festival festival) {
		this.festival = festival;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public void setTicketCount(int ticketCount) {
		this.ticketCount = ticketCount;
	}


	public void setTicketPrice(int ticketPrice) {
		this.ticketPrice = ticketPrice;
	}


	@Override
	public String toString() {
		return "\n\n Party [ @@@ partyNo=" + partyNo + ", partyFlag=" + partyFlag + ", partyName=" + partyName + ", partyDate="
				+ partyDate + ", partyTime=" + partyTime + ", hour=" + hour + ", minutes=" + minutes
				+ ", partyMemberLimit=" + partyMemberLimit + ", uploadFile=" + uploadFile + ", partyImage=" + partyImage
				+ ", partyDetail=" + partyDetail + ", partyPlace=" + partyPlace + ", partyRegDate=" + partyRegDate
				+ ", deleteFlag=" + deleteFlag + ", femalePercentage=" + femalePercentage + ", malePercentage="
				+ malePercentage + ", femaleAgeAverage=" + femaleAgeAverage + ", maleAgeAverage=" + maleAgeAverage
				+ ",\n @@@ festival=" + festival + ",\n @@@ user=" + user + ",\n @@@ ticketCount=" + ticketCount + ", ticketPrice="
				+ ticketPrice + "]";
	}


	
	
}
