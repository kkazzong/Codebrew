package com.codebrew.moana.service.domain;

public class Bank {

	// Field
	private String token;
	private String tranNo;
	private String tranDate;
	private String authCode;
	private String redirectUri;
	private String bankAccount;
	private String bankName;
	private String userAccount;
	private String userBankName;
	private String userName;

	private int purchaseNo;
	private int purchasePrice;
	private int purchaseCount;
	private String paymentMethodType;
	private String tranCode;
	private String qrCodeImage;
	private String purchaseFlag;
	
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

	public String getBankAccount() {
		return bankAccount;
	}

	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserBankName() {
		return userBankName;
	}

	public void setUserBankName(String userBankName) {
		this.userBankName = userBankName;
	}

	public int getPurchaseNo() {
		return purchaseNo;
	}

	public void setPurchaseNo(int purchaseNo) {
		this.purchaseNo = purchaseNo;
	}

	public int getPurchasePrice() {
		return purchasePrice;
	}

	public void setPurchasePrice(int purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public int getPurchaseCount() {
		return purchaseCount;
	}

	public void setPurchaseCount(int purchaseCount) {
		this.purchaseCount = purchaseCount;
	}

	public String getPaymentMethodType() {
		return paymentMethodType;
	}

	public void setPaymentMethodType(String paymentMethodType) {
		this.paymentMethodType = paymentMethodType;
	}

	public String getTranCode() {
		return tranCode;
	}

	public void setTranCode(String tranCode) {
		this.tranCode = tranCode;
	}

	public String getQrCodeImage() {
		return qrCodeImage;
	}

	public void setQrCodeImage(String qrCodeImage) {
		this.qrCodeImage = qrCodeImage;
	}

	public String getPurchaseFlag() {
		return purchaseFlag;
	}

	public void setPurchaseFlag(String purchaseFlag) {
		this.purchaseFlag = purchaseFlag;
	}

	@Override
	public String toString() {
		return "Bank [token=" + token + ", tranNo=" + tranNo + ", tranDate=" + tranDate + ", authCode=" + authCode
				+ ", redirectUri=" + redirectUri + ", bankAccount=" + bankAccount + ", bankName=" + bankName
				+ ", userAccount=" + userAccount + ", userBankName=" + userBankName + ", userName=" + userName
				+ ", purchaseNo=" + purchaseNo + ", purchasePrice=" + purchasePrice + ", purchaseCount=" + purchaseCount
				+ ", paymentMethodType=" + paymentMethodType + ", tranCode=" + tranCode + ", qrCodeImage=" + qrCodeImage
				+ ", purchaseFlag=" + purchaseFlag + "]";
	}



}
