package com.codebrew.moana.service.party;

import com.codebrew.moana.service.domain.Party;

public interface PartyService {
	
	public void addParty(Party party) throws Exception;
	
	public Party getParty(int partyNo);
}
