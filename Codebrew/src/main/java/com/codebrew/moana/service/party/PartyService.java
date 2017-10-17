package com.codebrew.moana.service.party;

import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Party;

public interface PartyService {
	
	public void addParty(Party party) throws Exception;
	
	public Party getParty(int partyNo) throws Exception;
	
	public void updateParty(Party party) throws Exception;
	
	public void deleteParty(int partyNo) throws Exception;
	
	public Map<String, Object> getPartyList(Search search) throws Exception;
 }
