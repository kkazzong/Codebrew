package com.codebrew.moana.service.ticket.impl;

import org.springframework.stereotype.Service;

import com.codebrew.moana.service.ticket.TicketService;

@Service("ticketServiceImpl")
public class TicketServiceImpl implements TicketService {

	public TicketServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

}
