package com.codebrew.moana.service.domain;

public class Festival {

	private int festivalNo;// .
	private String festivalImage; // 축제사진.
	private String festivalName; // 축제명.
	private int readCount; // 조회수.
	private String contentTypeId; // 축제타입아이디.
	private String festivalLongitude; // mapx.
	private String festivalLatitude; // mapy.
	private String addr; // 축제주소.
	private String areaCode; // 지역코드.
	private String sigunguCode; // 시군구코드.
	private String orgPhone; // 연락처.
	private String startDate; // 시작일.
	private String endDate; // 종료일.
	private String festivalDetail; // 축제 내용 (직접등록).
	private String festivalOverview; // 개요.

	private String ageLimit; // agelimit 관람가능연령.
	private String bookingPlace; // bookingplace 예매처.
	private String discount; // discountinfofestival 할인정보.
	private String homepage; // // eventhomepage 행사홈페이지
	private String playTime; // playtime 공연시간.
	private String spendTimeFestival; // spendtimefestival 관람소요시간.
	private String subEvent; // subevent 부대행사.
	private String program; // 행사프로그램.
	private String useTimeFestival; // usetimefestival 이용요금.

	private int ticketPrice; //
	private int ticketCount; // ticket 수량

	private boolean isNull;

	private String deleteFlag;

	public Festival() {

	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public boolean getIsNull() {
		return isNull;
	}

	public void setIsNull(boolean isNull) {
		this.isNull = isNull;
	}

	public String getUseTimeFestival() {
		return useTimeFestival;
	}

	public void setUseTimeFestival(String useTimeFestival) {
		this.useTimeFestival = useTimeFestival;
	}

	public String getProgram() {
		return program;
	}

	public void setProgram(String program) {
		this.program = program;
	}

	public String getAgeLimit() {
		return ageLimit;
	}

	public void setAgeLimit(String ageLimit) {
		this.ageLimit = ageLimit;
	}

	public String getBookingPlace() {
		return bookingPlace;
	}

	public void setBookingPlace(String bookingPlace) {
		this.bookingPlace = bookingPlace;
	}

	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public String getPlayTime() {
		return playTime;
	}

	public void setPlayTime(String playTime) {
		this.playTime = playTime;
	}

	public String getSpendTimeFestival() {
		return spendTimeFestival;
	}

	public void setSpendTimeFestival(String spendTimeFestival) {
		this.spendTimeFestival = spendTimeFestival;
	}

	public String getSubEvent() {
		return subEvent;
	}

	public void setSubEvent(String subEvent) {
		this.subEvent = subEvent;
	}

	public int getTicketPrice() {
		return ticketPrice;
	}

	public void setTicketPrice(int ticketPrice) {
		this.ticketPrice = ticketPrice;
	}

	public int getTicketCount() {
		return ticketCount;
	}

	public void setTicketCount(int ticketCount) {
		this.ticketCount = ticketCount;
	}

	public String getHomepage() {
		return homepage;
	}

	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}

	public int getFestivalNo() {
		return festivalNo;
	}

	public void setFestivalNo(int festivalNo) {
		this.festivalNo = festivalNo;
	}

	public String getFestivalImage() {
		return festivalImage;
	}

	public void setFestivalImage(Object object) {
		this.festivalImage = (String) object;
	}

	public String getFestivalName() {
		return festivalName;
	}

	public void setFestivalName(Object object) {
		this.festivalName = (String) object;
	}

	public String getContentTypeId() {
		return contentTypeId;
	}

	public void setContentTypeId(Object object) {
		this.contentTypeId = (String) object;
	}

	public String getFestivalLongitude() {
		return festivalLongitude;
	}

	public void setFestivalLongitude(Object object) {
		this.festivalLongitude = (String) object;
	}

	public String getFestivalLatitude() {
		return festivalLatitude;
	}

	public void setFestivalLatitude(Object object) {
		this.festivalLatitude = (String) object;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(Object object) {
		this.addr = (String) object;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(Object object) {
		this.areaCode = (String) object;
	}

	public String getSigunguCode() {
		return sigunguCode;
	}

	public void setSigunguCode(Object object) {
		this.sigunguCode = (String) object;
	}

	public String getOrgPhone() {
		return orgPhone;
	}

	public void setOrgPhone(Object object) {
		this.orgPhone = (String) object;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(Object object) {
		this.startDate = (String) object;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(Object object) {
		this.endDate = (String) object;
	}

	public String getFestivalDetail() {
		return festivalDetail;
	}

	public void setFestivalDetail(String festivalDetail) {
		this.festivalDetail = festivalDetail;
	}

	public String getFestivalOverview() {
		return festivalOverview;
	}

	public void setFestivalOverview(String festivalOverview) {
		this.festivalOverview = festivalOverview;
	}

	@Override
	public String toString() {
		return "Festival [festivalNo=" + festivalNo + ", festivalImage=" + festivalImage + ", festivalName="
				+ festivalName + ", readCount=" + readCount + ", contentTypeId=" + contentTypeId
				+ ", festivalLongitude=" + festivalLongitude + ", festivalLatitude=" + festivalLatitude + ", addr="
				+ addr + ", areaCode=" + areaCode + ", sigunguCode=" + sigunguCode + ", orgPhone=" + orgPhone
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", festivalDetail=" + festivalDetail
				+ ", festivalOverview=" + festivalOverview + ", ageLimit=" + ageLimit + ", bookingPlace=" + bookingPlace
				+ ", discount=" + discount + ", playTime=" + playTime + ", spendTimeFestival=" + spendTimeFestival
				+ ", subEvent=" + subEvent + ", program=" + program + ", useTimeFestival=" + useTimeFestival
				+ ", ticketPrice=" + ticketPrice + ", ticketCount=" + ticketCount + "homepage = " + homepage
				+ ", isNull=" + isNull + ", deleteFlag=" + deleteFlag + "]";
	}

}
