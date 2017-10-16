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
	
	@Override
	public Ticket addTicket(Ticket ticket) {
		
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
