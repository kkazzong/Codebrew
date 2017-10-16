package com.codebrew.moana.service.party;

import com.codebrew.moana.service.domain.Party;

public interface PartyDAO {

	// INSERT
	public void addParty(Party party) throws Exception ;
	
	// SELECT
	public Party getParty(int partyNo);
}
