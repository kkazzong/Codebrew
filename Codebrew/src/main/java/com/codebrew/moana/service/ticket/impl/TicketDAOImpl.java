package com.codebrew.moana.service.ticket.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.service.ticket.TicketDAO;

@Repository("ticketDAOImpl")
public class TicketDAOImpl implements TicketDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;

	public TicketDAOImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

}
