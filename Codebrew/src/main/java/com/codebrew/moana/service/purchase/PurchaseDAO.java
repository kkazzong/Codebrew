package com.codebrew.moana.service.purchase;

import java.util.List;

import com.codebrew.moana.service.domain.Purchase;

public interface PurchaseDAO {
	
	public int addPurchase(Purchase purchase); 
	public Purchase getPurchase(int purchaseNo);
	public List<Purchase> getPurchaseList(String userId, String purchaseFlag);
	public List<Purchase> getSaleList();
	public int updatePurchaseTranCode(Purchase purchase);
	public int deletePurchase(int purchaseNo);
	public Purchase readyPayment(Purchase purchase);
	public Purchase approvePayment(String pgToken);
	public void cancelPayment(Purchase purchase);
	
}
