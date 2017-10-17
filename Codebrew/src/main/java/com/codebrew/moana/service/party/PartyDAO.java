package com.codebrew.moana.service.party;

import java.util.List;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Party;

public interface PartyDAO {

	// INSERT
	public void addParty(Party party) throws Exception ;
	
	// SELECT ONE
	public Party getParty(int partyNo) throws Exception;
	
	// UPDATE
	public void updateParty(Party party) throws Exception;
	
	// UPDATE
	public void deleteParty(int partyNo) throws Exception;

	// SELECT LIST
	public List<Party> getPartyList(Search search) throws Exception;
}

