package com.codebrew.moana.service.ticket.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.ticket.TicketDAO;

@Repository("ticketDAOImpl")
public class TicketDAOImpl implements TicketDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;

	public TicketDAOImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public int addTicket(Ticket ticket) {
		return sqlSession.insert("TicketMapper.addTicket", ticket);
	}

	@Override
	public Ticket getTicket(Ticket ticket) {
		return sqlSession.selectOne("TicketMapper.getTicket", ticket);
	}

	@Override
	public Ticket getTicketByTicketNo(int ticketNo) {
		return sqlSession.selectOne("TicketMapper.getTicketByTicketNo", ticketNo);
	}

	@Override
	public int updateTicket(Ticket ticket) {
		if(ticket.getFestival() == null || ticket.getParty() == null) {
			System.out.println("@@파티나 축제가 null임돠@@");
			return 0;
		}
		return sqlSession.update("TicketMapper.updateTicket", ticket);
	}

	@Override
	public int updateTicketCount(Ticket ticket) {
		return sqlSession.update("TicketMapper.updateTicketCount", ticket);
	}

}
