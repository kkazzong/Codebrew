package com.codebrew.moana.service.ticket;

import com.codebrew.moana.service.domain.Ticket;

public interface TicketDAO {
	public int addTicket(Ticket ticket); //티켓 insert
	public Ticket getTicket(Ticket ticket); //축제번호 or 파티번호로 티켓정보 get
	public Ticket getTicketByTicketNo(int ticketNo); //티켓번호로 티켓정보 get -> 임가정이 자주 쓸 예정
	public int updateTicket(Ticket ticket); //축제번호 or 파티번호로 티켓정보 get해서 update
	public int updateTicketCount(Ticket ticket); //티켓번호로 티켓정보 get해서 update -> 임가정이 자주 쓸 예정
}
