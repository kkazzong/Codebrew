package com.codebrew.moana.service.ticket;

import com.codebrew.moana.service.domain.Ticket;

public interface TicketService {
	public Ticket addTicket(Ticket ticket); //티켓 insert
	public Ticket getTicket(int num, String ticketFlag); //num[축제번호 or 파티번호], ticketFlag[1 : 축제, 2 : 파티]
	public Ticket getTicketByTicketNo(int ticketNo); //티켓번호로 티켓정보 get ->임가정이 자주 쓸 예쩡
	public Ticket updateTicket(Ticket ticket); //축제번호 or 파티번호로 티켓정보 get해서 정보 update
	public Ticket updateTicketCount(Ticket ticket); //티켓번호로 티켓정보get해서 update ->임가정이 자주 쓸 예정
}
