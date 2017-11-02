package com.codebrew.moana.service.domain;

public class Statistics {

	// Field
	private Purchase purchase;
	private int totalPrice; // 총판매금액
	private int totalCount; // 총판매수량
	private String statFlag; // 통계플래그 [1:일단위,2:월단위,3:분기단위]
	private String statDate; // 날짜
	private String startDate; // 조회시 시작날짜
	private String endDate; // 조회시 끝 날짜
	private int referNo; //참조번호
	private String name;
	private String image; //이미지
	private String addr; //주소
	
	// Constructor
	public Statistics() {
	}

	public Purchase getPurchase() {
		return purchase;
	}

	public void setPurchase(Purchase purchase) {
		this.purchase = purchase;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public String getStatFlag() {
		return statFlag;
	}

	public void setStatFlag(String statFlag) {
		this.statFlag = statFlag;
	}

	public String getStatDate() {
		return statDate;
	}

	public void setStatDate(String statDate) {
		this.statDate = statDate;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getReferNo() {
		return referNo;
	}

	public void setReferNo(int referNo) {
		this.referNo = referNo;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "Statistics [purchase=" + purchase + ", totalPrice=" + totalPrice + ", totalCount=" + totalCount
				+ ", statFlag=" + statFlag + ", statDate=" + statDate + ", startDate=" + startDate + ", endDate="
				+ endDate + ", referNo=" + referNo + ", name=" + name + ", image=" + image + ", addr=" + addr + "]";
	}

}
