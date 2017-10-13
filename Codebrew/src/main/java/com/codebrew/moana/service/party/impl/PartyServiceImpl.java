package com.codebrew.moana.service.party.impl;

import org.springframework.stereotype.Service;

import com.codebrew.moana.service.party.PartyService;

@Service("partyServiceImpl")
public class PartyServiceImpl implements PartyService {

	public PartyServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

}
