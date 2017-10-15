package com.codebrew.moana.service.domain;

public class Ticket {

	// Field
	private Festival festival; //축제티켓
	private Party party; //파티티켓
	private int ticketNo; //티켓번호
	private int ticketPrice; //티켓가격
	private int ticketCount; //티켓수량

	// Constructor
	public Ticket() {
		System.out.println("Ticket Default Constructor");
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

	@Override
	public String toString() {
		return "Ticket [festival=" + festival + ", party=" + party + ", ticketNo=" + ticketNo + ", ticketPrice="
				+ ticketPrice + ", ticketCount=" + ticketCount + "]";
	}
}
