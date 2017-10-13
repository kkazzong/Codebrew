package com.codebrew.moana.service.reply.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.service.reply.ReplyDAO;

@Repository("replyDAOImpl")
public class ReplyDAOImpl implements ReplyDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;

	public ReplyDAOImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

}
