package com.codebrew.moana.service.party.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.PartyMember;
import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.party.PartyDAO;
import com.codebrew.moana.service.party.PartyService;
import com.codebrew.moana.service.ticket.TicketDAO;

@Service("partyServiceImpl")
public class PartyServiceImpl implements PartyService {
	
	///Field///
	@Autowired
	@Qualifier("partyDAOImpl")
	private PartyDAO partyDAO;
	
	public void setPartyDAO(PartyDAO partyDAO) {
		this.partyDAO = partyDAO;
	}
	
	@Autowired
	@Qualifier("ticketDAOImpl")
	private TicketDAO ticketDAO;
	
	public void setTicketDAO(TicketDAO ticketDAO) {
		this.ticketDAO = ticketDAO;
	}
	

	///Constructor///
	public PartyServiceImpl() {
		super();
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	
	///Method///
	@Override
	public Party addParty(Party party) throws Exception {
		// TODO Auto-generated method stub
		int result = partyDAO.addParty(party);
		
		int partyNo = party.getPartyNo();
		
		if(result == 1) {
			return partyDAO.getParty(partyNo, "");
		}else {
			return null;
		}
	}


	@Override
	public Party getParty(int partyNo, String partyFlag) throws Exception{
		// TODO Auto-generated method stub
		return partyDAO.getParty(partyNo, partyFlag);
	}

	
	@Override
	public Party updateParty(Party party) throws Exception {
		// TODO Auto-generated method stub
		int result = partyDAO.updateParty(party);
		
		int partyNo = party.getPartyNo();
		
		if(result == 1) {
			return partyDAO.getParty(partyNo, "");
		}else {
			return null;
		}
	
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
		int totalCount = partyDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}


	@Override
	public Map<String, Object> getMyPartyList(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		List<Party> list = partyDAO.getMyPartyList(search, userId);
		int totalCount = partyDAO.getMyTotalCount(search, userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	/////////////////////////////////////////////////////////////////////////////////
	
	@Override
	public Party joinParty(PartyMember partyMember) throws Exception {
	//public Map<String, Object> joinParty(PartyMember partyMember) throws Exception {
		// TODO Auto-generated method stub
		int result = partyDAO.joinParty(partyMember);
		
		int partyNo = partyMember.getParty().getPartyNo();
		//Search search = new Search();
		
		if(result == 1) {
			
			Party party = partyDAO.getParty(partyNo, "");
			
			/*Ticket ticket = new Ticket();
			ticket.setParty(party);
			Ticket dbTicket = ticketDAO.getTicket(ticket);
			
			party.setTicketCount(dbTicket.getTicketCount());
			party.setTicketPrice(dbTicket.getTicketPrice());*/
			
			return party;
			
			/*List<PartyMember> list = partyDAO.getPartyMemberList(partyNo, search);
			int currentMemberCount = partyDAO.getCurrentMemberCount(partyNo, search);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list );
			map.put("currentMemberCount", currentMemberCount);
			
			return map;*/
		}else {
			return null;
		}
	}


	@Override
	public Map<String, Object> getPartyMemberList(int partyNo, Search search) throws Exception {
		// TODO Auto-generated method stub
		List<PartyMember> list =  partyDAO.getPartyMemberList(partyNo, search);
		int currentMemberCount = partyDAO.getCurrentMemberCount(partyNo, search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("currentMemberCount", currentMemberCount);
		
		return map;
	}


	@Override
	public Party cancelParty(int partyNo, String userId) throws Exception {
		// TODO Auto-generated method stub
		int result = partyDAO.cancelParty(partyNo, userId);
		
		if(result == 1) {
			
			Party party = partyDAO.getParty(partyNo, "");
			
			/*Ticket ticket = new Ticket();
			ticket.setParty(party);
			Ticket dbTicket = ticketDAO.getTicket(ticket);
			
			party.setTicketCount(dbTicket.getTicketCount());
			party.setTicketPrice(dbTicket.getTicketPrice());*/
			
			return party;
			
			/*List<PartyMember> list = partyDAO.getPartyMemberList(partyNo, search);
			int currentMemberCount = partyDAO.getCurrentMemberCount(partyNo, search);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list );
			map.put("currentMemberCount", currentMemberCount);
			
			return map;*/
		}else {
			return null;
		}
	}
	
	
	@Override
	public void deletePartyMember(int partyNo, String userId) throws Exception {
		// TODO Auto-generated method stub
		partyDAO.deletePartyMember(partyNo, userId);
	}


	@Override
	public Party getGenderRatio(int partyNo) throws Exception {
		// TODO Auto-generated method stub
		Search search = new Search();
		search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	
		List<PartyMember> list =  partyDAO.getPartyMemberList(partyNo, search);
		int currentMemberCount = partyDAO.getCurrentMemberCount(partyNo, search);
		
		System.out.println("현재 참여중인 멤버 수 :: "+currentMemberCount);
		
		// GenderRatio, AgeAverage 계산 수행
		float femaleCount = 0;
		float maleCount = 0;
		
		int femaleAge = 0;
		int maleAge = 0;
		
		float femalePercentage;
		float malePercentage;
		int femaleAgeAverage;
		int maleAgeAverage;
		
		for(PartyMember partyMember : list) {
			System.out.println("성별확인 =========> "+partyMember.getGender());
			if(partyMember.getGender().equals("f")) {
				femaleCount += 1;
				femaleAge += partyMember.getAge();
				System.out.println("female :: count ==> "+ femaleCount + " :: age ==> "+ femaleAge);
			}else {
				maleCount += 1;
				maleAge += partyMember.getAge();
				System.out.println("male :: count ==> "+ maleCount + " :: age ==> "+ maleAge);
			}
		}
		
		
		System.out.println("female :: count ==> "+ femaleCount + " :: age ==> "+ femaleAge);
		System.out.println("male :: count ==> "+ maleCount + " :: age ==> "+ maleAge);
		
		femalePercentage = (femaleCount/currentMemberCount)*100;
		malePercentage = (maleCount/currentMemberCount)*100;
		
		femaleAgeAverage = Math.round(femaleAge/femaleCount);
		maleAgeAverage = Math.round(maleAge/maleCount);
		
		Party party = new Party();
		party.setPartyNo(partyNo);
		party.setFemalePercentage(femalePercentage);
		party.setMalePercentage(malePercentage);
		party.setFemaleAgeAverage(femaleAgeAverage);
		party.setMaleAgeAverage(maleAgeAverage);
		party.setPartyName(list.get(0).getParty().getPartyName());
		
		return party;
	}
	
	
	
}
