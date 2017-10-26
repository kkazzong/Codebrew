package com.codebrew.moana.service.domain;

public class Bank {

	// Field
	private String token;
	private String tranNo;
	private String tranDate;
	private String authCode;
	private String redirectUri;

	// Constructor
	public Bank() {
	}

	// getter,setter
	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getTranNo() {
		return tranNo;
	}

	public void setTranNo(String tranNo) {
		this.tranNo = tranNo;
	}

	public String getTranDate() {
		return tranDate;
	}

	public void setTranDate(String tranDate) {
		this.tranDate = tranDate;
	}

	public String getAuthCode() {
		return authCode;
	}

	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}

	public String getRedirectUri() {
		return redirectUri;
	}

	public void setRedirectUri(String redirectUri) {
		this.redirectUri = redirectUri;
	}

	@Override
	public String toString() {
		return "Bank [token=" + token + ", tranNo=" + tranNo + ", tranDate=" + tranDate + ", authCode=" + authCode
				+ "]";
	}

}
