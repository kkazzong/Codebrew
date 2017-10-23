package com.codebrew.moana.service.party;

import java.util.List;
import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.PartyMember;

public interface PartyDAO {

	// INSERT
	public int addParty(Party party) throws Exception ;
	
	// SELECT ONE
	public Party getParty(int partyNo, String partyFlag) throws Exception;
	
	// UPDATE
	public int updateParty(Party party) throws Exception;
	
	// UPDATE
	public void deleteParty(int partyNo) throws Exception;

	// SELECT LIST
	public List<Party> getPartyList(Search search) throws Exception;
	
	// SELECT LIST
	public List<Party> getMyPartyList(Search search, String userId) throws Exception;
	
	// SELECT ONE
	public int getTotalCount(Search search) throws Exception ;
	
	// SELECT ONE
	public int getMyTotalCount(Search search, String userId) throws Exception ;
	
	/////////////////////////////////////////////////////////////////////////
	
	// INSERT
	public int joinParty(PartyMember partyMember) throws Exception ;
	
	// SELECT LIST
	public List<PartyMember> getPartyMemberList(int partyNo, Search search) throws Exception;

	// SELECT ONE
	public int getCurrentMemberCount(int partyNo, Search search) throws Exception ;
	
	// DELETE
	public void cancelParty(int partyNo, String userId) throws Exception ;
	
	// UPDATE
	public void deletePartyMember(int partyNo, String userId) throws Exception ;
}

