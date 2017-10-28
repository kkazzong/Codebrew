package com.codebrew.moana.service.purchase;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Bank;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.QRCode;

public interface PurchaseDAO {
	
	public Purchase readyPayment(Purchase purchase);
	public Purchase approvePayment(String pgToken);
	public int cancelPayment(Purchase purchase);
	
	public Purchase approvePayment(Purchase purchase, String token); //imp
	
	public Purchase readyTransfer(Purchase purchase); //kftc
	public Purchase transferMoney(Bank bank, Purchase purchase);
	public Map<String, Object> getTransferResult(Bank bank, Purchase purchase);
	
	public int addPurchase(Purchase purchase, String path) throws Exception; 
	public Purchase getPurchase(int purchaseNo);
	public int getPurchaseNo(String userId, int partyNo);
	public List<Purchase> getPurchaseList(String userId, String purchaseFlag, Search search);
	public List<Purchase> getSaleList(Search search);
	public int updatePurchaseTranCode(Purchase purchase) throws Exception;
	public int deletePurchase(int purchaseNo);
	public QRCode createQRCode(String path, int purchaseNo);
	public int getTotalCount(String userId, Search search);
	
}
