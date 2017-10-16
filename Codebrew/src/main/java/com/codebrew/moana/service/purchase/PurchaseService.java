package com.codebrew.moana.service.purchase;

import java.util.Map;

import com.codebrew.moana.service.domain.Purchase;

public interface PurchaseService {

	public Purchase readyPayment(Purchase purchase);
	public Purchase approvePayment(String pgToken);
	public Purchase addPurchase(Purchase purchase);
	public Map<String, Object> getPurchaseList(String userId, String purchaseFlag);
	public Map<String, Object> getSaleList();
	public Purchase getPurchase(int purchaseNo);
	public void cancelPayment(int purchaseNo);
	
}
