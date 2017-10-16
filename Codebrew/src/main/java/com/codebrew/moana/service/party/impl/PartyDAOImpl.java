package com.codebrew.moana.service.party.impl;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.party.PartyDAO;


@Repository("partyDAOImpl")
public class PartyDAOImpl implements PartyDAO {

	///Field///
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	///Constructor///
	public PartyDAOImpl() {
		super();
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}


	///Method///
	@Override
	public void addParty(Party party) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("PartyMapper.addParty", party);
	}

	@Test
	@Override
	public Party getParty(int partyNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PartyMapper.getParty", partyNo);
	}

}
