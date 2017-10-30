package com.codebrew.moana.service.domain;

import java.util.Date;

public class Purchase {

	// Field
	private int purchaseNo; // 구매번호
	private String paymentNo; // 결제번호
	private User user; // 회원
	private Ticket ticket; // 티켓
	private String itemName; // 티켓이름(축제이름,파티이름)
	private int purchasePrice; // 구매가격
	private int purchaseCount; // 구매수량
	private String purchaseDate; // 구매날짜
	private String paymentMethodType; // 결제수단[CARD, MONEY]
	private String tranCode; // 구매상태[1 : 결제완료, 2 : 결제취소]
	private QRCode qrCode; // 큐알코드
	private String purchaseFlag; // 구매플래그[1 : 축제, 2 : 파티]
	private String tid; // KakaoPay tid
	private String nextRedirectPcUrl; // KakaoPay 결제준비 url
	private String nextRedirectMobileUrl;
	private String aid; // KakaoPay Request 고유번호, iamport 고유번호
	private String cid; // KakaoPay 가맹점 고유번호, iamport 가맹점 고유번호
	private String partnetOrderId;
	private String partnerUserId;
	private String token; //iamport 토큰
	private String bankAccount;
	private String bankName;
	private String userAccount;
	private String userBankName;
	private String userName;

	// Constructor
	public Purchase() {
		System.out.println("purchase default constructor");
	}

	// getter, setter
	public int getPurchaseNo() {
		return purchaseNo;
	}

	public void setPurchaseNo(int purchaseNo) {
		this.purchaseNo = purchaseNo;
	}

	public String getPaymentNo() {
		return paymentNo;
	}

	public void setPaymentNo(String paymentNo) {
		this.paymentNo = paymentNo;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Ticket getTicket() {
		return ticket;
	}

	public void setTicket(Ticket ticket) {
		this.ticket = ticket;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
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

	public String getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(String purchaseDate) {
		this.purchaseDate = purchaseDate;
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

	public QRCode getQrCode() {
		return qrCode;
	}

	public void setQrCode(QRCode qrCode) {
		this.qrCode = qrCode;
	}

	public String getPurchaseFlag() {
		return purchaseFlag;
	}

	public void setPurchaseFlag(String purchaseFlag) {
		this.purchaseFlag = purchaseFlag;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getNextRedirectPcUrl() {
		return nextRedirectPcUrl;
	}

	public void setNextRedirectPcUrl(String nextRedirectPcUrl) {
		this.nextRedirectPcUrl = nextRedirectPcUrl;
	}

	public String getAid() {
		return aid;
	}

	public void setAid(String aid) {
		this.aid = aid;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getPartnetOrderId() {
		return partnetOrderId;
	}

	public void setPartnetOrderId(String partnetOrderId) {
		this.partnetOrderId = partnetOrderId;
	}

	public String getPartnerUserId() {
		return partnerUserId;
	}

	public void setPartnerUserId(String partnerUserId) {
		this.partnerUserId = partnerUserId;
	}

	public String getNextRedirectMobileUrl() {
		return nextRedirectMobileUrl;
	}

	public void setNextRedirectMobileUrl(String nextRedirectMobileUrl) {
		this.nextRedirectMobileUrl = nextRedirectMobileUrl;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
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

	public String getUserBankName() {
		return userBankName;
	}

	public void setUserBankName(String userBankName) {
		this.userBankName = userBankName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Override
	public String toString() {
		return "% % % PURCHASE % % % [purchaseNo(구매번호)=" + purchaseNo + ", paymentNo(결제번호)=" + paymentNo + ", itemName(구매명)=" + itemName
				+ ", purchasePrice(결제금액)=" + purchasePrice + ", purchaseCount(결제수량)=" + purchaseCount + ", purchaseDate(결제일시)=" + purchaseDate 
				+ ", paymentMethodType(결제수단)=" + paymentMethodType + ", tranCode(결제코드)=" + tranCode 
				+ ", purchaseFlag(구매플래그)=" + purchaseFlag + ", tid(결제고유번호)=" + tid
				+ ", nextRedirectPcUrl=" + nextRedirectPcUrl + ", nextRedirectMobileUrl=" + nextRedirectMobileUrl
				+ ", aid=" + aid + ", cid=" + cid + ", partnetOrderId=" + partnetOrderId + ", partnerUserId="
				+ partnerUserId + ", token=" + token + ", bankAccount=" + bankAccount + ", bankName=" + bankName
				+ ", userAccount=" + userAccount + ", userBankName=" + userBankName + ", userName=" + userName 
				+ ", <<<user>>>  =" + user + ", <<<ticket>>> =" + ticket + ", <<<qrCode>>> =" + qrCode+ "]";
	}


}
