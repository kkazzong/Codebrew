package com.codebrew.moana.service.party.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.PartyMember;
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
	public int addParty(Party party) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("PartyMapper.addParty", party);
	}

	
	@Override
	public Party getParty(int partyNo, String partyFlag) throws Exception{
		// TODO Auto-generated method stub
		/*Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("partyNo", partyNo);
		map.put("partyFlag", partyFlag);
		System.out.println("getPartyDAO :: map :: "+ map.get("partyNo") +" :: "+ map.get("partyFlag"));*/
		
		return sqlSession.selectOne("PartyMapper.getParty", partyNo);
	}


	@Override
	public int updateParty(Party party) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("PartyMapper.updateParty", party);
	}


	@Override
	public void deleteParty(int partyNo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("PartyMapper.updateDeleteFlag", partyNo);
	}


	@Override
	public List<Party> getPartyList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("PartyMapper.getPartyList", search);
	}


	@Override
	public List<Party> getMyPartyList(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		Map<String , Object>  map = new HashMap<String, Object>();
		
		map.put("userId", userId);
		map.put("search", search);
		
		return sqlSession.selectList("PartyMapper.getMyPartyList", map);
	}


	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PartyMapper.getTotalCount", search);
	}

	
	@Override
	public int getMyTotalCount(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		Map<String , Object>  map = new HashMap<String, Object>();
		
		map.put("userId", userId);
		map.put("search", search);
		
		return sqlSession.selectOne("PartyMapper.getMyTotalCount", map);
	}
	
	///////////////////////////////////////////////////////////////////////////

	@Override
	public int joinParty(PartyMember partyMember) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("PartyMapper.joinParty", partyMember);
	}

	@Override
	public List<PartyMember> getPartyMemberList(int partyNo, Search search) throws Exception{
		
		Map<String , Object>  map = new HashMap<String, Object>();
			
		map.put("partyNo", partyNo);
		map.put("search", search);
		
		List<PartyMember> list = sqlSession.selectList("PartyMapper.getPartyMemberList", map); 
			
		return list;
	}


	@Override
	public int getCurrentMemberCount(int partyNo, Search search) throws Exception {
		// TODO Auto-generated method stub
		Map<String , Object>  map = new HashMap<String, Object>();
		
		map.put("partyNo", partyNo);
		map.put("search", search);
		
		return sqlSession.selectOne("PartyMapper.getCurrentMemberCount", map);
		
	}


	@Override
	public void cancelParty(int partyNo, String userId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("partyNo", partyNo);
		map.put("userId", userId);
		
		sqlSession.delete("PartyMapper.cancelParty", map);
	}


	@Override
	public void deletePartyMember(int partyNo, String userId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("partyNo", partyNo);
		map.put("userId", userId);
		
		sqlSession.delete("PartyMapper.deletePartyMember", map);
	}
	
	

}
