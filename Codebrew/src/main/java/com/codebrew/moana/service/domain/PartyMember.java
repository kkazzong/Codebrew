package com.codebrew.moana.service.domain;

public class PartyMember {
   
	///Field///
	private int partyMemberNo;
	private Party party;
	private User user;
	private String role;
	private int age;
	private String gender;
	
	
	///Constructor///
	public PartyMember() {
		super();
		// TODO Auto-generated constructor stub
	}


	///Method///
	public int getPartyMemberNo() {
		return partyMemberNo;
	}


	public Party getParty() {
		return party;
	}


	public User getUser() {
		return user;
	}


	public String getRole() {
		return role;
	}


	public int getAge() {
		return age;
	}


	public String getGender() {
		return gender;
	}


	public void setPartyMemberNo(int partyMemberNo) {
		this.partyMemberNo = partyMemberNo;
	}


	public void setParty(Party party) {
		this.party = party;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public void setRole(String role) {
		this.role = role;
	}


	public void setAge(int age) {
		this.age = age;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	@Override
	public String toString() {
		return "PartyMember [partyMemberNo=" + partyMemberNo + ", party=" + party + ", user=" + user + ", role=" + role
				+ ", age=" + age + ", gender=" + gender + "]";
	}


	

	
	
}
