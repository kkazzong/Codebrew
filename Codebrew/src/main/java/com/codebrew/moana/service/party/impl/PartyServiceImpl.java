package com.codebrew.moana.service.party.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

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
	public Party getParty(int partyNo) {
		// TODO Auto-generated method stub
		return partyDAO.getParty(partyNo);
	}

}
