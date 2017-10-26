package com.codebrew.moana.service.domain;

public class Ticket {

	// Field
	private Festival festival; // 축제티켓
	private Party party; // 파티티켓
	private int ticketNo; // 티켓번호
	private int ticketPrice; // 티켓가격
	private int ticketCount; // 티켓수량
	private String ticketFlag; // 티켓플래그[null : 기본티켓 , nolimit : 무제한티켓 , free : 무료티켓]
	private String ticketName;

	// Constructor
	public Ticket() {
	}

	// getter, setter
	public Festival getFestival() {
		return festival;
	}

	public void setFestival(Festival festival) {
		this.festival = festival;
	}

	public Party getParty() {
		return party;
	}

	public void setParty(Party party) {
		this.party = party;
	}

	public int getTicketNo() {
		return ticketNo;
	}

	public void setTicketNo(int ticketNo) {
		this.ticketNo = ticketNo;
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

	public String getTicketFlag() {
		return ticketFlag;
	}

	public void setTicketFlag(String ticketFlag) {
		this.ticketFlag = ticketFlag;
	}

	public String getTicketName() {
		return ticketName;
	}

	public void setTicketName(String ticketName) {
		this.ticketName = ticketName;
	}

	@Override
	public String toString() {
		return "Ticket [festival=" + festival + ", party=" + party + ", ticketNo=" + ticketNo + ", ticketPrice="
				+ ticketPrice + ", ticketCount=" + ticketCount + ", ticketFlag=" + ticketFlag + ", ticketName="
				+ ticketName + "]";
	}


}
