package com.codebrew.moana.service.domain;

public class Zzim {

	private int zzimNo;
	private int festivalNo;
	private String userId;

	public Zzim() {
		super();
	}
	
	

	public Zzim( String userId,int festivalNo) {
		super();
		this.festivalNo = festivalNo;
		this.userId = userId;
	}



	public Zzim(int zzimNo, int festivalNo, String userId) {
		super();
		this.zzimNo = zzimNo;
		this.festivalNo = festivalNo;
		this.userId = userId;
	}

	public int getZzimNo() {
		return zzimNo;
	}

	public void setZzimNo(int zzimNo) {
		this.zzimNo = zzimNo;
	}

	public int getFestivalNo() {
		return festivalNo;
	}

	public void setFestivalNo(int festivalNo) {
		this.festivalNo = festivalNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Zzim [zzimNo=" + zzimNo + ", festivalNo=" + festivalNo + ", userId=" + userId + "]";
	}

}
