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
	public Party getParty(int partyNo, String partyFlag) throws Exception{
		// TODO Auto-generated method stub
		return partyDAO.getParty(partyNo, partyFlag);
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
		int totalCount = partyDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	/////////////////////////////////////////////////////////////////////////////////
	
	@Override
	public void joinParty(PartyMember partyMember) throws Exception {
		// TODO Auto-generated method stub
		partyDAO.joinParty(partyMember);
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
	public void cancelParty(int partyNo, String userId) throws Exception {
		// TODO Auto-generated method stub
		partyDAO.cancelParty(partyNo, userId);
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
		
		return party;
	}
	
	
	
}
