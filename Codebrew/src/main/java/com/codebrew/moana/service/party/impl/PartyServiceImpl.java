package com.codebrew.moana.service.party.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.party.PartyDAO;
import com.codebrew.moana.service.party.PartyService;

@Service("partyServiceImpl")
public class PartyServiceImpl implements PartyService {
	
	///Field///
	@Autowired
	@Qualifier("partyDAOImpl")
	private PartyDAO partyDAO;
	
	public void setPartDAO(PartyDAO partyDAO) {
		this.partyDAO = partyDAO;
	}
	

	///Constructor///
	public PartyServiceImpl() {
		super();
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	
	///Method///
	@Override
	public void addParty(Party party) throws Exception {
		// TODO Auto-generated method stub
		partyDAO.addParty(party);
		
	}


	@Override
	public Party getParty(int partyNo) throws Exception{
		// TODO Auto-generated method stub
		return partyDAO.getParty(partyNo);
	}

	
	@Override
	public void updateParty(Party party) throws Exception {
		// TODO Auto-generated method stub
		partyDAO.updateParty(party);
	}


	@Override
	public void deleteParty(int partyNo) throws Exception {
		// TODO Auto-generated method stub
		partyDAO.deleteParty(partyNo);
	}


	@Override
	public Map<String, Object> getPartyList(Search search) throws Exception {
		// TODO Auto-generated method stub
		List<Party> list = partyDAO.getPartyList(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		
		return map;
	}
	
	
}
