package com.codebrew.moana.service.ticket.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.ticket.TicketDAO;
import com.codebrew.moana.service.ticket.TicketService;

@Service("ticketServiceImpl")
public class TicketServiceImpl implements TicketService {

	@Autowired
	@Qualifier("ticketDAOImpl")
	private TicketDAO ticketDAO;
	
	public TicketServiceImpl() {
		System.out.println(this.getClass());
	}
	
	/*
	 * ticketFlag : 티켓 가격과 티켓 수량에 따라 다름
	 * 	1. 기본티켓 (가격 > 0, 수량 > 0) => null
	 *  2. 무료티켓 (가격 = 0, 수량 > 0) => free
	 *  3. 무제한티켓 (가격 > 0, 수량 = 0) => nolimit
	 *  4. 딜릿티켓 (가격 = 0, 수량 = 0) => del 
	 * */
	@Override
	public Ticket addTicket(Ticket ticket) {
		
		if(ticket.getTicketPrice() == 0) { 
			if(ticket.getTicketCount() == 0) {
				//딜릿 티켓(가격 0, 수량 0)
				ticket.setTicketFlag("del");
			} else {
				//무료 티켓
				ticket.setTicketFlag("free");
			}
		} else if(ticket.getTicketCount() == 0) {
			//무제한티켓
			ticket.setTicketFlag("nolimit");
		}
		
		int result = ticketDAO.addTicket(ticket);
		System.out.println("ticketNo : "+ticket.getTicketNo());
		
		if(result == 1) {
			return ticketDAO.getTicket(ticket);
		} else {
			return null;
		}
		
	}

	@Override
	public Ticket getTicket(int num, String ticketFlag) {
		
		Ticket ticket = new Ticket();
		
		switch(ticketFlag) {
			case "1" : //축제티켓
				Festival festival = new Festival();
				festival.setFestivalNo(num);
				ticket.setFestival(festival);
				ticket = ticketDAO.getTicket(ticket);
				break;
			case "2" : //파티티켓
				Party party = new Party();
				party.setPartyNo(num);
				ticket.setParty(party);
				ticket = ticketDAO.getTicket(ticket);
				break;
		}
		
		return ticket;
	}

	@Override
	public Ticket getTicketByTicketNo(int ticketNo) {
		return ticketDAO.getTicketByTicketNo(ticketNo);
	}

	@Override
	public Ticket updateTicket(Ticket ticket) {
		
		if(ticket.getTicketPrice() == 0) { 
			if(ticket.getTicketCount() == 0) {
				//딜릿 티켓(가격 0, 수량 0)
				ticket.setTicketFlag("del");
			} else {
				//무료 티켓
				ticket.setTicketFlag("free");
			}
		} else if(ticket.getTicketCount() == 0) {
			//무제한티켓
			ticket.setTicketFlag("nolimit");
		}
		
		int result = ticketDAO.updateTicket(ticket);
		if(result == 1) {
			return ticketDAO.getTicket(ticket);
		} else {
			return null;
		}
	}

	@Override
	public Ticket updateTicketCount(Ticket ticket) {
		
		
		int result = ticketDAO.updateTicketCount(ticket);
		if(result == 1) {
			return ticketDAO.getTicket(ticket);
		} else {
			return null;
		}
	}

}
