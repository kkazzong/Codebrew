package com.codebrew.moana.service.party;

import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.PartyMember;

public interface PartyService {
	
	public void addParty(Party party) throws Exception;
	
	public Party getParty(int partyNo, String partyFlag) throws Exception;
	
	public void updateParty(Party party) throws Exception;
	
	public void deleteParty(int partyNo) throws Exception;
	
	public Map<String, Object> getPartyList(Search search) throws Exception;
	
	public Map<String, Object> getMyPartyList(Search search, String userId) throws Exception;
	
	/////////////////////////////////////////////////////////////////////////////
	
	public void joinParty(PartyMember partyMember) throws Exception;
	
	public Map<String, Object> getPartyMemberList(int partyNo, Search search) throws Exception;
	
	public void cancelParty(int partyNo, String userId) throws Exception;
	
	public Party getGenderRatio(int partyNo) throws Exception;
 }
