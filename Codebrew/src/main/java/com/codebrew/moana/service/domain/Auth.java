package com.codebrew.moana.service.domain;

public class Auth {
	
	private String authId;//이메일
	private String authCode;//인증코드
	
	
	public Auth() {
	
	}


	public String getAuthId() {
		return authId;
	}


	public void setAuthId(String authId) {
		this.authId = authId;
	}


	public String getAuthCode() {
		return authCode;
	}


	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}


	@Override
	public String toString() {
		return "Auth [authId=" + authId + ", authCode=" + authCode + "]";
	}
	
	
	
	
	
}
